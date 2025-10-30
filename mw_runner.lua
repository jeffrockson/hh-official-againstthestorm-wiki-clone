-- mw_runner.lua
-- Local Scribunto-like environment bootstrap for VSCode debugging
-- In global container
_G.mw_runner = {}
local mw_runner = _G.mw_runner

-- Read environment variables from launch.json
local MW_PATH = os.getenv("MW_PATH")
local LUA_LIB_PATH = os.getenv("LUA_LIB_PATH")
local MODULES_PATH = os.getenv("MODULE_PATH")

if not MW_PATH or not LUA_LIB_PATH or not MODULES_PATH then
    error("MW_PATH and LUA_LIB_PATH and MODULE_PATH must be set in your launch.json env block")
end

-- Extend package path so 'mw.*' libraries resolve
package.path = table.concat({
    LUA_LIB_PATH .. "/?.lua",
    LUA_LIB_PATH .. "/ustring/?.lua",
    MODULES_PATH .. "/?.lua",
    package.path
}, ";")

-- Accommodate mediawiki's 5.1 lua environment that has unpack as a global instead of in the table library
unpack = unpack or table.unpack

-- Preload MediaWiki modules manually
package.preload["mw"]        = function() return dofile(LUA_LIB_PATH .. "/mw.lua") end
package.preload["mw.title"]  = function() return dofile(LUA_LIB_PATH .. "/mw.title.lua") end
package.preload["mw.text"]   = function() return dofile(LUA_LIB_PATH .. "/mw.text.lua") end
package.preload["mw.html"]   = function() return dofile(LUA_LIB_PATH .. "/mw.html.lua") end
package.preload["mw.ustring"] = function() return dofile(LUA_LIB_PATH .. "/mw.ustring.lua") end
-- Require the MediaWiki core Lua library
mw = require("mw")
mw.title = require("mw.title")
mw.ustring = require("mw.ustring")
mw.text = require("mw.text")
mw.html = require("mw.html")

-- Override require() to simulate MediaWiki’s Module:Name resolution
local real_require = require
function require(name)
    -- Attempt normal require first (for standard libraries)
    local ok, result = pcall(real_require, name)
    if ok then return result end

    -- Strip "Module:" prefix for MediaWiki-style requires
    local moduleName = name:gsub("^Module:", "")
    local path = MODULES_PATH .. "/" .. moduleName .. ".lua"

    local file = io.open(path, "r")
    if file then
        file:close()
        return dofile(path)
    else
        error("Cannot find module: " .. name .. " at path: " .. path)
    end
end

-- Override mw.title.new to work with local modules/subpages (simplified)
local original_mw_title_new = mw.title and mw.title.new
function mw.title.new(title)
    -- Delegate if not a Module: or Template: title
    if not (title:match("^Module:") or title:match("^Template:")) then
        return original_mw_title_new and original_mw_title_new(title) or { exists = false, getContent = function() return nil end }
    end

    -- Determine base path
    local base
    if title:match("^Template:") then
        base = MW_PATH .. "/templates/" .. title:gsub("^Template:", "")
    else
        base = MODULES_PATH .. "/" .. title:gsub("^Module:", "")
    end

    -- If an explicit or implicit extension is present, load directly
    if base:match("%.[^/]+$") or base:match("_csv$") then
        local file = io.open(base, "r")
        if file then
            local content = file:read("*a")
            file:close()
            return { exists = true, getContent = function() return content end }
        end
    else
        -- Default to .lua extension for everything else (which will be modules or data tables)
        local luaPath = base .. ".lua"
        local file = io.open(luaPath, "r")
        if file then
            local content = file:read("*a")
            file:close()
            return { exists = true, getContent = function() return content end }
        end
    end

    -- Not found
    return { exists = false, getContent = function() return nil end }
end

-- Override loadData to do the same path-redirection as mw.title.new but return it as code instead of a string
local original_loadData = mw.loadData
function mw.loadData(title)
    local page = mw.title.new(title)
    if page.exists then
        local chunk, err = load("return (function() " .. page:getContent() .. " end)()")
        if chunk then
            local ok, result = pcall(chunk)
            if ok then return result end
        end
    end
    return {}
end

-- Replace php.decodeJSON with this lua library
local json = require("dkjson")
mw.text.jsonDecode = function(str)
    return json.decode(str)
end

-- Load simulated frame arguments
mw.getCurrentFrame = function() return { args = {}, expandTemplate = function() return "" end } end
function mw_runner.setFrame(args)
    local frame = { args = args or {}, expandTemplate = function() return "" end }
    mw.getCurrentFrame = function() return frame end
    return frame
end

-- Load the target module passed from launch.json (the current file)
local TARGET_FILE = os.getenv("TARGET_FILE")
if not TARGET_FILE or TARGET_FILE == "" then
    print("Usage: open a Module file or test script and press F5 to debug it.")
    os.exit(1)
end
print("[mw_runner] Loading target file: " .. TARGET_FILE)

-- dofile(TARGET_FILE)
