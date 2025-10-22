---@module FarmsData.lua
---
---This module does not define an _actual_ derived class, but it creates an instance of one via prototyping patterns. Understand this file as a big procedure, top-to-bottom, rather than a class definition.
---
---Initializes a BaseDataModel with the data file associated with this module. Makes necessary modifications to the basic data, including schema and method overrides, to permit the exceptions associated with data in this model.



--Create instance
local BaseDataModel = require("Module:BaseDataModel")
local DATA_FILE = "Module:FarmsData/Farms.json"

---@type BaseDataModel
local farmsDataModel = BaseDataModel.new(DATA_FILE)



--Begin instance overrides
for _, building in pairs(farmsDataModel.dataTable) do
    building[farmsDataModel.schema.CATEGORY2] = "Farm"
    building[farmsDataModel.schema.IS_PROVIDING_SERVICES] = false
end

--The other time will be added in overridden getter method.
farmsDataModel.schema.RECIPE.PRODUCTION_TIME = "harvestingTime"
farmsDataModel.schema.RECIPE.PRODUCTION_TIME2 = "plantingTime"



--/** Function definitions follow. **/
--Collapse the regions in the IDE to see the procedure pick up with the assignments of these functions to override the associated member methods of BaseDataModel.
--region Public building interface
--no overrides!
--endregion

--region Public building recipe query interface
--no overrides!
--endregion

--region Public recipe data retrieval interface

---@public
---`Overrides BaseDataModel`
---
---Gets the total planting and harvesting time from the provided recipe.
---
---@param self BaseDataModel this instance, with specific data
---@param recipeData recipePairTable
---@return number seconds
function getRecipeTime(self, recipeData)

    return recipeData.recipe[self.schema.RECIPE.PRODUCTION_TIME] + recipeData.recipe[self.schema.RECIPE.PRODUCTION_TIME2]
end

--endregion
--/** End Function definitions. Procedure resumes. **/



--Override recipe data retrieval interface
farmsDataModel.getRecipeTime = getRecipeTime



return farmsDataModel