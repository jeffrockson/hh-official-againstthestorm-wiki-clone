---@module InstitutionsData.lua
---
---This module does not define an _actual_ derived class, but it creates an instance of one via prototyping patterns. Understand this file as a big procedure, top-to-bottom, rather than a class definition.
---
---Initializes a BaseDataModel with the data file associated with this module. Makes necessary modifications to the basic data, including schema and method overrides, to permit the exceptions associated with data in this model.



--Create instance
local BaseDataModel = require("Module:BaseDataModel")
local DATA_FILE = "Module:InstitutionsData/Institutions.json"

---@type BaseDataModel
local institutionsDataModel = BaseDataModel.new(DATA_FILE)



--Begin instance overrides
for _, building in pairs(institutionsDataModel.dataTable) do
    building[institutionsDataModel.schema.CATEGORY2] = "Service Building"
    building[institutionsDataModel.schema.IS_PROVIDING_SERVICES] = true
end

institutionsDataModel.schema.RECIPE.GRADE = "gradeId"

--IMPORTANT: The data structure has one fewer levels, like RECIPE > PRODUCT_ID
institutionsDataModel.schema.RECIPE.PRODUCT.ID = "servedNeed"



--/** Function definitions follow. **/
--Collapse the regions in the IDE to see the procedure pick up with the assignments of these functions to override the associated member methods of BaseDataModel.
--region Public building interface
--no overrides!
--endregion

--region Public building recipe query interface

local INDEX_PAIR_BUILDING_ID = "buildingID"
local INDEX_PAIR_RECIPE = "recipe"

---@public
---`Overrides BaseDataModel`
---
---Gets all this instance's buildings' recipes that have the specified product. Returns an array of pairs of building IDs and recipe data.
---
---@param self BaseDataModel this instance, with specific data
---@param productID string the product
---@return table array of pairs of building IDs and recipe data, or {} if none found
function getIDsAndRecipesWhereProductID(self, productID)

    if not self.dataTable then
        error(ERROR_MESSAGE_INSTANCE_NOT_INITIALIZED)
    end

    local ret = {}
    for id, building in pairs(self.dataTable) do
        for _, recipe in ipairs(building[self.schema.RECIPES]) do

            --If there's a matching served need
            if recipe[self.schema.RECIPE.PRODUCT.ID] == productID then
                -- Add as an buildingID-recipe pair
                table.insert(ret, {
                    [INDEX_PAIR_BUILDING_ID] = id,
                    [INDEX_PAIR_RECIPE] = recipe,
                })
            end
        end
    end
    return ret
end

---@public
---`Overrides BaseDataModel`
---
---Gets all this instance's specified building's recipes that produce the specified product. Returns an array of pairs of building IDs and recipe data.
---
---@param self BaseDataModel this instance, with specific data
---@param productID string the product
---@param buildingID string the building
---@return table array of pairs of building IDs and recipe data, or {} if none found
function getIDsAndRecipesWhereProductIDAndBuildingID(self, productID, buildingID)

    --Can't findID from here, but that's okay, this is a small data file: just loop.
    local ret = {}
    for id, building in pairs(self.dataTable) do

        if building[self.schema.ID] == buildingID then

            for _, recipe in ipairs(building[self.schema.RECIPES]) do

                --If there's a matching seeked deposit
                if recipe[self.schema.RECIPE.PRODUCT.ID] == productID then
                    -- Add as an buildingID-recipe pair
                    table.insert(ret, {
                        [INDEX_PAIR_BUILDING_ID] = id,
                        [INDEX_PAIR_RECIPE] = recipe,
                    })
                end
            end

        end
    end
    return ret
end

--endregion

--region Public recipe data retrieval interface

---@public
---`Overrides BaseDataModel`
---
---Gets the product ID from the provided recipe.
---
---@param self BaseDataModel this instance, with specific data
---@param recipeData recipePairTable
---@return string product ID
function getRecipeProductID(self, recipeData)
    return recipeData.recipe[self.schema.RECIPE.PRODUCT.ID]
end

---@public
---`Overrides BaseDataModel`
---
---Gets the amount of product produced by the provided recipe.
---
---Parameters
---
---`self:BaseDataModel` - ignored
---
---`recipeData:recipePairTable` - ignored
---
---@return number stack size
function getRecipeProductAmount()
    return 1
end

--endregion
--/** End Function definitions. Procedure resumes. **/



--Override building recipe query interface
institutionsDataModel.getIDsAndRecipesWhereProductID = getIDsAndRecipesWhereProductID
institutionsDataModel.getIDsAndRecipesWhereProductIDAndBuildingID = getIDsAndRecipesWhereProductIDAndBuildingID

--Override recipe data retrieval interface
institutionsDataModel.getRecipeProductID = getRecipeProductID
institutionsDataModel.getRecipeProductAmount = getRecipeProductAmount



return institutionsDataModel