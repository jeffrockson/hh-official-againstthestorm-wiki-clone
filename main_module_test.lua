local module = require("Module:RecipeController")
local frame = mw_runner.setFrame({ ["product"] = "Biscuits" })

print(module.main(frame))
