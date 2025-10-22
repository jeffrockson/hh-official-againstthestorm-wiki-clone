---@class BaseDataModel
---
---@alias buildingIDString string the unique identifier for a building
---@alias buildingRecordTable table a full record for one building
---@alias recipePairTable table a record for one recipe-building pair
---@alias constructionGoodsTable table an array of construction goods' IDs and amounts
---
---I. Provides a standard set of getters for building data and permits overrides from derived classes to specialize the building data, to allow for exceptions, etc. The schema used for these getters is based on the biggest data file, the Workshops JSON data structure.
---
---II. Provides a standard set of getters for recipe queries. All queries return an array of pairs of building IDs and recipes, pulled straight from JSON. Data from those pairs needs to be retrieved with the third interface.
---
---III. Provides a standard set of getters for data within individual recipes, to allow derived classes to specialize based on how their data is structured. Recipe data should not be accessed directly because of these differences.
---
---
---@field getID function building interface method
---@field getCategory function building interface method
---@field getSecondCategory function building interface method
---@field getCityScore function building interface method
---@field getConstructionCosts function building interface method
---@field getConstructionTime function building interface method
---@field getDescription function building interface method
---@field getIcon function building interface method
---@field isMovable function building interface method
---@field getName function building interface method
---@field getNumberOfWorkplaces function building interface method
---@field getSize function building interface method
---@field getStorage function building interface method
---@field isServiceBuilding function building interface method
---
---@field _ --- --- ---
---
---@field getIDsAndRecipesWhereProductID function query interface method
---@field getIDsAndRecipesWhereBuildingID function query interface method
---@field getIDsAndRecipesWhereIngredientID function query interface method
---@field getIDsAndRecipesWhereProductIDAndBuildingID function query interface method
---@field getIDsAndRecipesWhereProductIDAndIngredientID function query interface method
---@field getIDsAndRecipesWhereIngredientIDAndBuildingID function query interface method
---
---@field _ --- --- ---
---
---@field getRecipeBuildingID function recipe interface method
---@field getRecipeGrade function recipe interface method
---@field getRecipeTime function recipe interface method
---@field isRecipeProvidingService function recipe interface method
---@field getRecipeProductID function recipe interface method
---@field getRecipeProductAmount function recipe interface method
---@field getRecipeNumIngredientSlots function recipe interface method
---@field getRecipeIngredientNumOptions function recipe interface method
---@field getRecipeIngredientOptionIDAt function recipe interface method
---@field getRecipeIngredientOptionAmountAt function recipe interface method
---
---@field _ --- --- ---
---
---@field dataTable table Primary data table of _buildingRecordTables_, keyed by _buildingIDString_
---@field mapNamesToIDs table Lookup table, returns a _buildingIDString_ from a building's display name
---@field schema table data schema, with field names and subtables of field names
local BaseDataModel = {}



--region Dependencies
local JsonUtils = require("Module:JsonUtils")
--endregion



--region Protected data schema

---@protected
---Protected data schema defining Json field names for accessing data.
BaseDataModel.schema = {
	ID = "id",
	NAME = "displayName",
	CATEGORY1 = "category",
	CITY_SCORE = "cityScore",
	CONSTRUCTION_TIME = "constructionTime",

	CONSTRUCTION_GOODS = "requiredGoods",
	CONSTRUCTION = {
		ID = "name",
		AMOUNT = "amount",
	},

	DESCRIPTION = "description",
	IS_ESSENTIAL = "initiallyEssential",
	IS_MOVABLE = "movable",
	SIZE_X = "sizeX",
	SIZE_Y = "sizeY",
	STORAGE_CAP = "storage",
	WORKPLACES = "workplaces",

	RECIPES = "recipes",
	RECIPE = {
		GRADE = "grade",
		PRODUCTION_TIME = "productionTime",

		PRODUCTS = "product",
		PRODUCT = {
			ID = "name",
			AMOUNT = "amount",
		},

		INGREDIENTS = "ingredients",
		INGREDIENT = {
			OPTION = {
				ID = "name",
				AMOUNT = "amount",
			},
		},
	},

	SACRIFICES = "sacrifices",
	SACRIFICE = {
		NAME = "name",
		DESCRIPTION = "desc",
		MAX_LEVEL = "maxLevel",

		COSTS = "costPerMin",
		COST = {
			ID = "name",
			AMOUNT = "amount",
		},
	},
}

---Secondary category, to be defined by derived classes.
BaseDataModel.schema.CATEGORY2 = "category2"
BaseDataModel.schema.IS_PROVIDING_SERVICES = "isServiceBuilding"

-- This section is deprecated. These should be handled by derived classes, not here.
local INDEX_RECIPE_GRADE_ALT = "gradeId" -- alt for service buildings
local INDEX_RECIPE_INGREDIENT_OPTION_AMOUNT = "amount"
local INDEX_RECIPE_INGREDIENT_OPTION_ID = "name"
local INDEX_RECIPE_ING_SERVICE_GOODS = "goods" -- alt to ingredients for service buildings
local INDEX_RECIPE_PRO_DEPOSITS = "seekedDeposits" -- alt to product for huts and camps
local INDEX_RECIPE_PRO_SERVICE = "servedNeed" -- alt to product for service buildings
local INDEX_RECIPE_PLANTING_TIME = "plantingTime"
local INDEX_RECIPE_HARVESTING_TIME = "harvestingTime"
local INDEX_RECIPE_GATHERING_TIME = "gatheringTime"
local INDEX_STORAGE_TANK = "baseTankCapacity"

local INDEX_PAIR_BUILDING_ID = "buildingID"
local INDEX_PAIR_RECIPE = "recipe"

--endregion



--region Private constants

local RESOURCE_FUEL_ID = "[Crafting] Sea Marrow"

---Enum converts grade strings (keys) to numbers (values).
local LOOKUP_CONVERT_GRADE_TO_NUMBER = {
	["Grade0"] = 0,
	["Grade1"] = 1,
	["Grade2"] = 2,
	["Grade3"] = 3,
	["Grade0 - institution"] = 0,
	["Grade1 - institution"] = 1,
}

--endregion



--region Localization string constants

local ERROR_MESSAGE_INSTANCE_NOT_INITIALIZED = "This instance's data table was never initialized. Please check how and where this method was called to diagnose the problem"

--endregion



--region Private member variables
--defined as @fields above in class definition
--endregion



--region Private methods

---Loads the JSON data into the two structured member variables for data access.
---
---(Benchmarking 2024-11-04:  ~0.018 seconds for biggest data file)
---
---@param instance BaseDataModel
---@param dataFile string filename of Json data to load into this instance
---@return table, table instance's data structures --when uncommented for debugging
local function load(instance, dataFile)

	--Utility module loads the data from JSON.
	local rawTable = JsonUtils.convertJSONToLuaTable(dataFile)

	--Do lightweight (no deep copying) restructuring for faster look-ups.
	instance.dataTable = {}
	instance.mapNamesToIDs = {}
	for _, record in ipairs(rawTable) do

		--Initialize the extra values not in the data.
		record[instance.schema.CATEGORY2] = "Building"
		record[instance.schema.IS_PROVIDING_SERVICES] = false

		--Transform the data from array to KV table, and store the name lookup map.
		local id = record[instance.schema.ID]
		local name = record[instance.schema.NAME]
		instance.dataTable[id] = record
		instance.mapNamesToIDs[name] = id
	end
	--return instance.dataTable, instance.mapNamesToIDs --uncomment when debugging
end

---Gets the record with that ID from the instance's data table.
---
---(Benchmarking 2024-11-04:  ~0 seconds for biggest data file)
---
---@param instance BaseDataModel
---@param id buildingIDString
---@return buildingRecordTable or nil if not found
local function findID(instance, id)

	if not instance.dataTable then
		error(ERROR_MESSAGE_INSTANCE_NOT_INITIALIZED)
	end

	return instance.dataTable[id] or nil
end

---Gets the record with that display name from the instance's data table. If the data model has multiple buildings with the same name, this will return only one of them.
---
---(Benchmarking 2024-11-04:  ~0.0000 seconds for biggest data file)
---
---@param instance BaseDataModel
---@param name string the display name
---@return buildingRecordTable or nil if not found
local function findName(instance, name)

	if not instance.dataTable or not instance.mapNamesToIDs then
		error(ERROR_MESSAGE_INSTANCE_NOT_INITIALIZED)
	end

	local id = instance.mapNamesToIDs[name]
	if not id then
		return nil
	end
	return instance.dataTable[id] or nil
end

---Deeply copies the provided table and returns the copy. Does not modify the original.
---
---@param original table to copy
---@return table the copy
local function deepCopy(original)
	local copy
	if type(original) == "table" then
		copy = {}
		for key, value in pairs(original) do
			copy[key] = deepCopy(value)
		end
	else
		copy = original
	end
	return copy
end

--endregion



--region Public constructor

---@public
---@constructor
---Instantiates a new BaseDataModel by loading the specified data file into the instance.
---
---(Benchmarking 2024-11-04: ~0.0170 seconds with largest data file.)
---
---@param dataFile string filename of Json data to load into this instance
---@return BaseDataModel a new instance storing the specified data
function BaseDataModel.new(dataFile)

	local instance = {}

	setmetatable(instance, { __index = BaseDataModel })

	instance.schema = deepCopy(BaseDataModel.schema)

	load(instance, dataFile)

	return instance
end

--endregion



--region Public building interface

---@public
---Gets the ID associated with the specified name in this instance's data.
---
---@param name string the display name
---@return buildingIDString or nil if not found
function BaseDataModel:getID(name)

	local building = findName(self, name)
	if building then
		return building[self.schema.ID]
	else
		return nil
	end
end

---@public
---Gets the category for the specified ID from this instance's data.
---
---@param id buildingIDString
---@return string category, or nil if not found
function BaseDataModel:getCategory(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.CATEGORY1]
	else
		return nil
	end
end

---@public
---Gets the secondary category for the specified ID from this instance's data.
---
---@param id buildingIDString
---@return string secondary category, or nil if not found
function BaseDataModel:getSecondCategory(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.CATEGORY2]
	else
		return nil
	end
end



---@public
---Gets the city score for the specified ID from this instance's data.
---
---@param id buildingIDString
---@return number city score, or nil if not found
function BaseDataModel:getCityScore(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.CITY_SCORE]
	else
		return nil
	end
end

---@public
---Gets the construction goods for the specified ID from this instance's data.
---Returns the array of construction goods, straight from the table, in subtables of IDs and amounts.
---
---See the data schema for details.
---
---@param id buildingIDString
---@return constructionGoodsTable an array of construction goods' IDs and amounts, or nil if not found
function BaseDataModel:getConstructionCosts(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.CONSTRUCTION_GOODS]
	else
		return nil
	end
end

---@public
---Gets the time required for construction for the specified ID from this instance's data.
---
---@param id buildingIDString
---@return number the number of seconds, or nil if not found
function BaseDataModel:getConstructionTime(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.CONSTRUCTION_TIME]
	else
		return nil
	end
end

---@public
---Gets the description for the specified ID from this instance's data.
---
---@param id buildingIDString
---@return string the description including sprite markup, or nil if not found
function BaseDataModel:getDescription(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.DESCRIPTION]
	else
		return nil
	end
end

---@public
---Gets the icon filename for the specified ID from this instance's data.
---
---**Likely overridden by derived classes.**
---
---@param id buildingIDString
---@return string the icon filename, or nil if not found
function BaseDataModel:getIcon(id)
	local building = findID(self, id)
	if building then
		return id .. "_icon.png"
	else
		return nil
	end
end

---@public
---Checks whether the specified ID is movable from this instance's data.
---
---@param id buildingIDString
---@return boolean _true_ if the building can be moved, _false_ if not (or nil if not found)
function BaseDataModel:isMovable(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.IS_MOVABLE]
	else
		return nil
	end
end

---@public
---Gets the name for the specified ID from this instance's data.
---
---@param id buildingIDString
---@return string the name, or nil if not found
function BaseDataModel:getName(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.NAME]
	else
		return nil
	end
end

---@public
---Gets the number of workplaces for the specified ID from this instance's data.
---
---@param id buildingIDString
---@return number how many worker slots, or nil if not found
function BaseDataModel:getNumberOfWorkplaces(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.WORKPLACES]
	else
		return nil
	end
end

---@public
---Gets the size for ths specified ID from this instance's data, expressed as an X-by-Y string.
---
---@param id buildingIDString
---@return string as x-by-y, or nil if not found
function BaseDataModel:getSize(id)
	local building = findID(self, id)
	if building then
		return building[self.schema.SIZE_X] .. " × " .. building[self.schema.SIZE_Y]
	else
		return nil
	end
end

---@public
---Gets the storage capacity for the specified ID from this instance's data.
---
---**Likely overridden by derived classes.**
---
---@param id buildingIDString
---@return number the storage capacity, or nil if not found
function BaseDataModel:getStorage(id)
	local building = findID(self, id)
	if building then
		if building[self.schema.STORAGE_CAP] then
			return building[self.schema.STORAGE_CAP]
		elseif building[INDEX_STORAGE_TANK] then
			return building[INDEX_STORAGE_TANK]
		end
	else
		return nil
	end
end

---@public
---Checks whether the specified ID is a service-type building from this instance's data.
---
---**Likely overridden by derived classes.**
---
---@param id buildingIDString
---@return boolean _true_ if a service building, _false_ if not, or nil if not found
function BaseDataModel:isServiceBuilding(id)
	-- The retrieval isn't used, but it performs necessary error checking.
	local building = findID(self, id)
	if building then
		return building[self.schema.IS_PROVIDING_SERVICES]
	else
		return nil
	end
end

--endregion



--region Public building recipe query interface

---@public
---Gets all this instance's buildings' recipes that have the specified product. Returns an array of pairs of building IDs and recipe data.
---
---**Likely overridden by derived classes.**
---
---(Benchmarking 2024-11-06: ~0.0002 seconds with largest data file.)
---
---@param productID string the product
---@return table array of pairs of building IDs and recipe data, or {} if none found
function BaseDataModel:getIDsAndRecipesWhereProductID(productID)

	if not self.dataTable then
		error(ERROR_MESSAGE_INSTANCE_NOT_INITIALIZED)
	end

	local ret = {}
	for id, building in pairs(self.dataTable) do

		if building[self.schema.RECIPES] then

			for _, recipe in ipairs(building[self.schema.RECIPES]) do

				--If there's a product subtable with an amount.
				if recipe[self.schema.RECIPE.PRODUCTS] then
					if recipe[self.schema.RECIPE.PRODUCTS][self.schema.RECIPE.PRODUCT.ID] == productID then
						--Add as an buildingID-recipe pair
						table.insert(ret, {
							[INDEX_PAIR_BUILDING_ID] = id,
							[INDEX_PAIR_RECIPE] = recipe,
						})
					end

					--There may also be seeked deposits.
				elseif recipe[INDEX_RECIPE_PRO_DEPOSITS] then
					if recipe[INDEX_RECIPE_PRO_DEPOSITS] == productID then
						--Add as an buildingID-recipe pair
						table.insert(ret, {
							[INDEX_PAIR_BUILDING_ID] = id,
							[INDEX_PAIR_RECIPE] = recipe,
						})
					end

					--Or a service provided
				elseif recipe[INDEX_RECIPE_PRO_SERVICE] then
					if recipe[INDEX_RECIPE_PRO_SERVICE] == productID then
						--Add as an buildingID-recipe pair
						table.insert(ret, {
							[INDEX_PAIR_BUILDING_ID] = id,
							[INDEX_PAIR_RECIPE] = recipe,
						})
					end
				end
			end
		end
	end
	return ret
end

---@public
---Gets all this instance's building's recipes from the specified building ID. Returns an array of pairs of building IDs and recipe data.
---
---**Likely overridden by derived classes.**
---
---(Benchmarking 2024-11-05: ~0.0001 seconds with largest data file.)
---
---@param buildingID buildingIDString
---@return table array of pairs of building IDs and recipe data, or {} if none found
function BaseDataModel:getIDsAndRecipesWhereBuildingID(buildingID)

	local building = findID(self, buildingID)
	if not building then
		return {}
	end

	local ret = {}
	if building[self.schema.RECIPES] then
		for _, recipe in ipairs(building[self.schema.RECIPES]) do
			-- Add as an buildingID-recipe pair
			table.insert(ret, {
				[INDEX_PAIR_BUILDING_ID] = buildingID,
				[INDEX_PAIR_RECIPE] = recipe,
			})
		end
	end
	return ret
end

---@public
---Gets all this instance's buildings' recipes that use the specified ingredients. Returns an array of pairs of building IDs and recipe data.
---
---**Likely overridden by derived classes.**
---
---(Benchmarking 2024-11-05: ~0.0004 seconds with largest data file.)
---
---@param ingredientID string the ingredient
---@return table array of pairs of building IDs and recipe data, or {} if none found
function BaseDataModel:getIDsAndRecipesWhereIngredientID(ingredientID)

	if not self.dataTable then
		error(ERROR_MESSAGE_INSTANCE_NOT_INITIALIZED)
	end

	local ret = {}
	for id, building in pairs(self.dataTable) do

		if building[self.schema.RECIPES] then

			for _, recipe in ipairs(building[self.schema.RECIPES]) do

				local ingredientsList = {}
				-- Some recipes don't have ingredients; skip them obviously.
				if recipe[self.schema.RECIPE.INGREDIENTS] then
					ingredientsList = recipe[self.schema.RECIPE.INGREDIENTS]
				elseif recipe[INDEX_RECIPE_ING_SERVICE_GOODS] then
					ingredientsList = { recipe[INDEX_RECIPE_ING_SERVICE_GOODS] }
				end

				for _, ingredientSlot in ipairs(ingredientsList) do
					for _, option in ipairs(ingredientSlot) do
						if option[self.schema.RECIPE.INGREDIENT.OPTION.ID] == ingredientID then
							-- Add as an buildingID-recipe pair
							table.insert(ret, {
								[INDEX_PAIR_BUILDING_ID] = id,
								[INDEX_PAIR_RECIPE] = recipe,
							})
							break
						end
					end
				end
			end
		end
	end
	return ret
end

---@public
---Gets all this instance's specified building's recipes that produce the specified product. Returns an array of pairs of building IDs and recipe data.
---
---**Likely overridden by derived classes.**
---
---(Benchmarking 2024-11-05: ~0.0000 seconds with largest data file)
---
---@param productID string the product
---@param buildingID buildingIDString
---@return table array of pairs of building IDs and recipe data, or {} if none found
function BaseDataModel:getIDsAndRecipesWhereProductIDAndBuildingID(productID, buildingID)

	local building = findID(self, buildingID)
	if not building then
		return {}
	end

	local ret = {}
	if building[self.schema.RECIPES] then
		for _, recipe in ipairs(building[self.schema.RECIPES]) do

			-- If there's a product subtable with an amount.
			if recipe[self.schema.RECIPE.PRODUCTS] then
				if recipe[self.schema.RECIPE.PRODUCTS][self.schema.RECIPE.PRODUCT.ID] == productID then
					-- Add as an buildingID-recipe pair
					table.insert(ret, {
						[INDEX_PAIR_BUILDING_ID] = buildingID,
						[INDEX_PAIR_RECIPE] = recipe,
					})
					-- Only one ever per building, so return now
					return ret
				end

				-- There could also be a seeked deposit.
			elseif recipe[INDEX_RECIPE_PRO_DEPOSITS] then
				if recipe[INDEX_RECIPE_PRO_DEPOSITS] == productID then
					-- Add as an buildingID-recipe pair
					table.insert(ret, {
						[INDEX_PAIR_BUILDING_ID] = buildingID,
						[INDEX_PAIR_RECIPE] = recipe,
					})
					-- Only one ever per building, so return now
					return ret
				end

				-- Or a service provided.
			elseif recipe[INDEX_RECIPE_PRO_SERVICE] then
				if recipe[INDEX_RECIPE_PRO_SERVICE] == productID then
					-- Add as an buildingID-recipe pair
					table.insert(ret, {
						[INDEX_PAIR_BUILDING_ID] = buildingID,
						[INDEX_PAIR_RECIPE] = recipe,
					})
					-- Only one ever per building, so return now
					return ret
				end
			end
		end
	end
	return {}
end

---@public
---Gets all this instance's buildings' recipes that result in the specified product and use the specified ingredient. Returns an array of pairs of building IDs and recipe data.
---
---**Likely overridden by derived classes.**
---
---(Benchmarking 2024-11-05: ~0.0001 seconds with largest data file.)
---
---@param productID string the product ID
---@param ingredientID string the ingredient ID
---@return table array of pairs of building IDs and recipe data, or {} if none found
function BaseDataModel:getIDsAndRecipesWhereProductIDAndIngredientID(productID, ingredientID)

	if not self.dataTable then
		error(ERROR_MESSAGE_INSTANCE_NOT_INITIALIZED)
	end

	local ret = {}
	for id, building in pairs(self.dataTable) do

		if building[self.schema.RECIPES] then

			for _, recipe in ipairs(building[self.schema.RECIPES]) do

				-- If there's a product subtable with an amount.
				if recipe[self.schema.RECIPE.PRODUCTS] then
					if recipe[self.schema.RECIPE.PRODUCTS][self.schema.RECIPE.PRODUCT.ID] == productID then
						-- Products have ingredients lists.
						if recipe[self.schema.RECIPE.INGREDIENTS] then
							for _, ingredientSlot in ipairs(recipe[self.schema.RECIPE.INGREDIENTS]) do
								for _, option in ipairs(ingredientSlot) do
									if option[self.schema.RECIPE.INGREDIENT.OPTION.ID] == ingredientID then
										-- Add as an buildingID-recipe pair
										table.insert(ret, {
											[INDEX_PAIR_BUILDING_ID] = id,
											[INDEX_PAIR_RECIPE] = recipe,
										})
										break
									end
								end
							end
						end
					end

					-- There may also be seeked deposits; these never have ingredients, so skip.
				elseif recipe[INDEX_RECIPE_PRO_DEPOSITS] then
					-- skip, but I want this to have the same structure as other methods.

					-- Or a service provided
				elseif recipe[INDEX_RECIPE_PRO_SERVICE] then
					if recipe[INDEX_RECIPE_PRO_SERVICE] == productID then
						-- Services have service goods.
						if recipe[INDEX_RECIPE_ING_SERVICE_GOODS] then
							for _, ingredientSlot in ipairs(recipe[INDEX_RECIPE_ING_SERVICE_GOODS]) do
								for _, option in ipairs(ingredientSlot) do
									if option[INDEX_RECIPE_INGREDIENT_OPTION_ID] == ingredientID then
										-- Add as an buildingID-recipe pair
										table.insert(ret, {
											[INDEX_PAIR_BUILDING_ID] = id,
											[INDEX_PAIR_RECIPE] = recipe,
										})
									end
								end
							end
						end
					end
				end
			end
		end
	end
	return ret
end

---@public
---Gets all this instance's specified building's recipes that use the specified ingredient. Returns an array of pairs of building IDs and recipe data.
---
---**Likely overridden by derived classes.**
---
---(Benchmarking 2024-11-05: ~0.0000 seconds with largest data file.)
---
---@param ingredientID string
---@param buildingID buildingIDString
---@return table array of pairs of building IDs and recipe data, or {} if none found
function BaseDataModel:getIDsAndRecipesWhereIngredientIDAndBuildingID(ingredientID, buildingID)

	local building = findID(self, buildingID)
	if not building then
		return {}
	end

	local ret = {}
	if building[self.schema.RECIPES] then
		for _, recipe in ipairs(building[self.schema.RECIPES]) do

			local ingredientsList = {}
			-- Some recipes don't have any ingredients; skip those obviously.
			if recipe[self.schema.RECIPE.INGREDIENTS] then
				ingredientsList = recipe[self.schema.RECIPE.INGREDIENTS]
			elseif recipe[INDEX_RECIPE_ING_SERVICE_GOODS] then
				ingredientsList = recipe[INDEX_RECIPE_ING_SERVICE_GOODS]
			end

			for _, ingredientSlot in ipairs(ingredientsList) do
				for _, option in ipairs(ingredientSlot) do
					if option[self.schema.RECIPE.INGREDIENT.OPTION.ID] == ingredientID then
						-- Add as an buildingID-recipe pair
						table.insert(ret, {
							[INDEX_PAIR_BUILDING_ID] = buildingID,
							[INDEX_PAIR_RECIPE] = recipe,
						})
						break
					end
				end
			end
		end
	end
	return ret
end

--endregion



--region Public recipe data retrieval interface

---@public
---Gets the building ID from the provided recipe data.

---@param recipeData recipePairTable
---@return buildingIDString
function BaseDataModel:getRecipeBuildingID(recipeData)

	return recipeData.buildingID
end

---@public
---Gets the efficiency grade from the provided recipe.

---@param recipeData recipePairTable
---@return number efficiency grade
function BaseDataModel:getRecipeGrade(recipeData)

	if recipeData.recipe[self.schema.RECIPE.GRADE] then
		return LOOKUP_CONVERT_GRADE_TO_NUMBER[recipeData.recipe[self.schema.RECIPE.GRADE]]

	elseif recipeData.recipe[INDEX_RECIPE_GRADE_ALT] then
		return LOOKUP_CONVERT_GRADE_TO_NUMBER[recipeData.recipe[INDEX_RECIPE_GRADE_ALT]]

	else
		-- Default of grade zero.
		return 0
	end
end

---@public
---Gets the production time from the provided recipe.
---
---**Likely overridden by derived classes.**
---
---@param recipeData recipePairTable
---@return number seconds
function BaseDataModel:getRecipeTime(recipeData)

	if recipeData.recipe[self.schema.RECIPE.PRODUCTION_TIME] then
		return recipeData.recipe[self.schema.RECIPE.PRODUCTION_TIME]

	elseif recipeData.recipe[INDEX_RECIPE_PLANTING_TIME] and recipeData.recipe[INDEX_RECIPE_HARVESTING_TIME] then
		return recipeData.recipe[INDEX_RECIPE_PLANTING_TIME]
				+ recipeData.recipe[INDEX_RECIPE_HARVESTING_TIME]

	elseif recipeData.recipe[INDEX_RECIPE_GATHERING_TIME] then
		return recipeData.recipe[INDEX_RECIPE_GATHERING_TIME]

	else
		-- Services don't have a time.
		return 0
	end
end

---@public
---Checks whether the provided recipe results in a service.
---
---@param recipeData recipePairTable
---@return boolean _true_ if service, _false_ if product
function BaseDataModel:isRecipeProvidingService(recipeData)

	-- This is in the base data model a property of the whole building, not a specific recipe.
	local building = findID(self, recipeData.buildingID)

	if building then
		return building[self.schema.IS_PROVIDING_SERVICES]
	else
		return nil
	end
end

---@public
---Gets the product ID from the provided recipe.
---
---**Likely overridden by derived classes.**
---
---@param recipeData recipePairTable
---@return string product ID
function BaseDataModel:getRecipeProductID(recipeData)

	if recipeData.recipe[self.schema.RECIPE.PRODUCTS] then
		return recipeData.recipe[self.schema.RECIPE.PRODUCTS][self.schema.RECIPE.PRODUCT.ID]

	elseif recipeData.recipe[INDEX_RECIPE_PRO_DEPOSITS] then
		return recipeData.recipe[INDEX_RECIPE_PRO_DEPOSITS]

	elseif recipeData.recipe[INDEX_RECIPE_PRO_SERVICE] then
		return recipeData.recipe[INDEX_RECIPE_PRO_SERVICE]
	end
end

---@public
---Gets the amount of product produced by the provided recipe.

---@param recipeData recipePairTable
---@return number stack size
function BaseDataModel:getRecipeProductAmount(recipeData)

	if recipeData.recipe[self.schema.RECIPE.PRODUCTS] then
		return recipeData.recipe[self.schema.RECIPE.PRODUCTS][self.schema.RECIPE.PRODUCT.AMOUNT]

	else
		-- Default, for deposits, from which gatherers always bring home 1 and for services, which always provide 1
		return 1
	end
end

---@public
---Gets the number of slots for ingredients for the provided recipe.
---
---If the recipe has no ingredients (like for farms and camps), this safely returns zero.
---
---@param recipeData recipePairTable
---@return number of ingredients slots of options
function BaseDataModel:getRecipeNumIngredientSlots(recipeData)

	if recipeData.recipe[self.schema.RECIPE.INGREDIENTS] then
		return #recipeData.recipe[self.schema.RECIPE.INGREDIENTS]

	elseif recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS] then
		return #recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS]

	else
		--Camps, for example, don't have ingredients.
		return 0
	end
end

---@public
---Checks whether the options for the specified ingredient slot are all fuel-type resources.
---
---This should never be called if the ingredients table doesn't exist.
---
---@param recipeData recipePairTable
---@param i number index of which ingredient slot
---@return boolean 'true' if the ingredient slot is for fuel resources
function BaseDataModel:isRecipeIngredientSlotFuel(recipeData, i)

	--Currently Sea Marrow as an ingredient option is ONLY present in fuel ingredient slots.
	local optionsList = recipeData.recipe[self.schema.RECIPE.INGREDIENTS][i]
	for _, optionPair in ipairs(optionsList) do
		if optionPair[INDEX_RECIPE_INGREDIENT_OPTION_ID] == RESOURCE_FUEL_ID then
			return true
		end
	end
	return false
end

---@public
---Gets the number of options for the specified ingredient slot in the provided recipe.
---
---This should never be called if the ingredients table doesn't exist.
---
---**Likely overridden by derived classes.**
---
---@param recipeData recipePairTable
---@param i number index of which ingredient slot
---@return number options for that ingredient slot
function BaseDataModel:getRecipeIngredientNumOptions(recipeData, i)

	if recipeData.recipe[self.schema.RECIPE.INGREDIENTS] then
		return #recipeData.recipe[self.schema.RECIPE.INGREDIENTS][i]

	elseif recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS] then
		-- Should always be 1, but let's not assume
		return #recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS]

	else
		-- Any other cases have no options at all, for example camps.
		return 0
	end
end

---@public
---Gets the good ID for the specified option for the specified ingredient slot in the provided recipe.
---
---This should never be called if the ingredients table doesn't exist.
---
---**Likely overridden by derived classes.**
---
---@param recipeData recipePairTable
---@param i number index of which ingredient slot
---@param j table index of which option at that slot
---@return string good ID
function BaseDataModel:getRecipeIngredientOptionIDAt(recipeData, i, j)

	if recipeData.recipe[self.schema.RECIPE.INGREDIENTS] then
		local optionsList = recipeData.recipe[self.schema.RECIPE.INGREDIENTS][i]
		return optionsList[j][self.schema.RECIPE.INGREDIENT.OPTION.ID]

	elseif recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS] then
		return recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS][i][INDEX_RECIPE_INGREDIENT_OPTION_ID]
	end
end

---@public
---Gets the good ID for the specified option for the specified ingredient slot in the provided recipe.
---
---This should never be called if the ingredients table doesn't exist.
---
---**Likely overridden by derived classes.**
---
---@param recipeData recipePairTable
---@param i number index of which ingredient slot
---@param j table index of which option at that slot
---@return number stack size
function BaseDataModel:getRecipeIngredientOptionAmountAt(recipeData, i, j)

	if recipeData.recipe[self.schema.RECIPE.INGREDIENTS] then
		local optionsList = recipeData.recipe[self.schema.RECIPE.INGREDIENTS][i]
		return optionsList[j][self.schema.RECIPE.INGREDIENT.OPTION.AMOUNT]

	elseif recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS] then
		return recipeData.recipe[INDEX_RECIPE_ING_SERVICE_GOODS][i][INDEX_RECIPE_INGREDIENT_OPTION_AMOUNT]

	else
		return 0
	end
end

--endregion

return BaseDataModel