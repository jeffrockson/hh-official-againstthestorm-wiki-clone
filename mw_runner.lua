-- mw_runner.lua
-- Local Scribunto-like environment bootstrap for VSCode debugging

-- Read environment variables from launch.json
local mw_path = os.getenv("MW_PATH")
local lua_lib_path = os.getenv("LUA_LIB_PATH")

if not mw_path or not lua_lib_path then
    error("MW_PATH and LUA_LIB_PATH must be set in your launch.json env block")
end

-- Extend package path so 'mw.*' libraries resolve
package.path = table.concat({
    lua_lib_path .. "/includes/Engines/LuaCommon/lualib/?.lua",
    package.path
}, ";")

-- Require the MediaWiki core Lua library
mw = require("mw")

-- Override require() to simulate MediaWiki’s Module:Name resolution
local real_require = require
function require(name)
    -- Translate "Module:Recipe" → "Module.Recipe"
    local modname = name:gsub("^Module:", "Module.")
    local ok, result = pcall(real_require, modname)
    if ok then return result end

    -- Try to resolve directly from file if not in package.path
    local path = mw_path .. "/modules/" .. name:gsub("^Module:", "") .. ".lua"
    local file = io.open(path, "r")
    if file then
        file:close()
        return dofile(path)
    else
        error("Cannot find module: " .. name)
    end
end

-- Load the target module passed from launch.json (the current file)
local target = os.getenv("MODULE_FILE")
if not target or target == "" then
    print("Usage: open a Lua file and press F5 to debug it.")
    os.exit(1)
end

print("[mw_runner] Debugging module:", target)
dofile(target)
