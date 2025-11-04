-- Debug/test launch script
dofile("mw_runner.lua")

local testFrame = { args = { product = "", building = "", ingredient = "Wood", display = "" } }
local p = require("Module:RecipeView")
print(p.main(testFrame))



-- local testFrame = { args = { product = "", building = "", ingredient = "Wood", display = "" } }
-- -- local p = require("Module:RecipeView")
-- mw.log(p.main(testFrame))
