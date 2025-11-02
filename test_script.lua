-- Debug/test launch script
dofile("mw_runner.lua")

local testFrame = { args = { product = "Crystalized Dew", building = "Brickyard", ingredient = "", display = "" } }
local p = require("Module:RecipeView")
print(p.main(testFrame))
