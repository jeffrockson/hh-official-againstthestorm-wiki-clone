-- Debug/test launch script
dofile("mw_runner.lua")

local testFrame = { args = { name = "Furnace", icon = "x20px" } }
local Building = require("Module:Building")
print(Building.link(testFrame))
