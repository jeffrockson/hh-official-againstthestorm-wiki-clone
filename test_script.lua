-- Debug/test launch script
dofile("mw_runner.lua")

-- local testFrame = { args = { product = "Scrolls", building = "", ingredient = "", display = "" } }
-- local p = require("Module:RecipeView")
-- print(p.main(testFrame))

local testFrame = { args = { [1] = "", [2] = " 4 Bricks", [3] = " 1 Parts   ", classes="wikitable"} }
testFrame.getParent = function() return testFrame end
local p = require("Module:Resource")
print(p.stack(testFrame))
