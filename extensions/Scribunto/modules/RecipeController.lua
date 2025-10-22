--- @module RecipeController
local RecipeController = {}

--region Dependencies

local BuildingDataProxy = require("Module:BuildingDataProxy")

local DataModelsWithRecipes = {
	require("Module:ExtractorsData"),
	require("Module:MinesData"),
	require("Module:CampsData"),
	require("Module:FarmsData"),
	require("Module:FishingData"),
	require("Module:GatheringData"),
	require("Module:InstitutionsData"),
	require("Module:RainCollectorsData"),
	require("Module:WorkshopsData"),
	require("Module:BlightPostsData")
}

local GoodsData = require("Module:GoodsData")
--For looking up services
local InstitutionsData = require("Module:InstitutionsData")

local VIEW_TEMPLATE_START = "Recipe/view"
local VIEW_TEMPLATE_ROW = "Recipe/view/row"
local VIEW_TEMPLATE_END = "Recipe/view/end"

local VIEW_BUILDING_LINK = "Building_link/view"
local VIEW_RESOURCE_LINK = "Resource_link/view"
--This doesn't use the view version because we don't want to hardcode the icon filename.
local TEMPLATE_SERVICE_LINK = "Service_link"

--endregion



--region Private constants

local ARG_DISPLAY_OVERRIDE_LIST = "list"

local INDEX_RECIPE_BUILDINGS_ARRAY = "buildingsArray"
local INDEX_RECIPE_GRADE = "grade"
local INDEX_RECIPE_TIME = "time"
local INDEX_RECIPE_PRODUCT_NAME = "productName"
local INDEX_RECIPE_PRODUCT_AMOUNT = "productAmount"
local INDEX_RECIPE_IS_SERVICE = "isRecipeService"
local INDEX_RECIPE_INGREDIENTS = "ingredientsTable"

local INDEX_OPTION_ID = "name" -- this is for backwards compatibility, it's actually an ID
local INDEX_OPTION_AMOUNT = "amount"

local VIEW_TABLE_BUILDING_SINGLE_ICON_SIZE = "huge"
local VIEW_TABLE_BUILDING_MULTIPLE_ICON_SIZE = "large"
local VIEW_TABLE_INGREDIENT_ICON_SIZE = "medium"
local VIEW_TABLE_PRODUCT_ICON_SIZE = "huge"

local VIEW_CLASS_TABLE_INGREDIENTS_SINGLE_ICON = 'class=ats-single-ingredient-icon'
local VIEW_CLASS_TABLE_INGREDIENTS_SWAPPABLE_ICON = 'class=ats-swappable-ingredient-icon'

local VIEW_GRADES = {
	[0] = '0Star',
	[1] = '1Star',
	[2] = '2Star',
	[3] = '3Star',
}

--- Transform the grade only when using the value as an index, to help it sort better whenever possible.
local STORE_GRADES = {
	[0] = 1,
	[1] = 2,
	[2] = 3,
	[3] = 4,
}

local MARKUP_NEWLINE_FORCED = "\n<!-- -->\n"

local ERROR_MESSAGE_EMPTY_PARAMETERS = "You must specify a product, building, or ingredient. Please see the template documentation for how to use the parameters"

--endregion



--region Private member variables
--none!
--endregion



--region Private methods

---getFlatRecipeValues
---Extracts a handful of values from the provided recipe pair.
---
---@param DataModel BaseDataModel a data model that implements the recipe query interface
---@param recipeData table pair of recipe data retrieved from a data model
---@return string, number, number, string, number building ID, efficiency grade, production time, product ID, and product amount (respectively)
local function getFlatRecipeValues(DataModel, recipeData)

	local buildingID = DataModel:getRecipeBuildingID(recipeData)
	local grade = DataModel:getRecipeGrade(recipeData)
	local time = DataModel:getRecipeTime(recipeData)
	local productID = DataModel:getRecipeProductID(recipeData)
	local productAmount = DataModel:getRecipeProductAmount(recipeData)

	return buildingID, grade, time, productID, productAmount
end

---buildingIngredientsTable
---Extracts values from the provided recipe pair and builds an ingredients table for use in a Recipe object.
---
---@param DataModel BaseDataModel a data model that implements the recipe query interface
---@param recipeData table pair of recipe data retrieved from a data model
---@return table nested ingredients, options (ID and amount)
local function buildingIngredientsTable(DataModel, recipeData)

	local ingredientsTable = {}
	for i = 1, DataModel:getRecipeNumIngredientSlots(recipeData) do

		if not ingredientsTable[i] then
			ingredientsTable[i] = {}
		end
		for j = 1, DataModel:getRecipeIngredientNumOptions(recipeData, i) do
			ingredientsTable[i][j] = {
				[INDEX_OPTION_ID] = DataModel:getRecipeIngredientOptionIDAt(recipeData, i, j),
				[INDEX_OPTION_AMOUNT] = DataModel:getRecipeIngredientOptionAmountAt(recipeData, i, j),
			}
		end
	end

	return ingredientsTable
end

---getRawRecipes
---Queries the data models with the supplied parameters to construct an array of Recipe objects storing the recipes found in the data model.
---
---Benchmarking: ~0.0003 seconds
---
---@param DataModel BaseDataModel a data model that implements the recipe query interface
---@param productID string the ID of the product, or nil if any
---@param buildingID string the ID of the building, or nil if any
---@param ingredientID string the ID of an ingredient, or nil if any
---@return table array of pairs of buildingID and recipe data
local function getRawRecipes(DataModel, productID, buildingID, ingredientID)

	local rawRecipeList = {}
	-- Check for combos first
	if productID and buildingID then
		rawRecipeList = DataModel:getIDsAndRecipesWhereProductIDAndBuildingID(productID, buildingID)
	elseif productID and ingredientID then
		rawRecipeList = DataModel:getIDsAndRecipesWhereProductIDAndIngredientID(productID, ingredientID)
	elseif ingredientID and buildingID then
		rawRecipeList = DataModel:getIDsAndRecipesWhereIngredientIDAndBuildingID(ingredientID, buildingID)
	elseif productID then
		rawRecipeList = DataModel:getIDsAndRecipesWhereProductID(productID)
	elseif ingredientID then
		rawRecipeList = DataModel:getIDsAndRecipesWhereIngredientID(ingredientID)
	elseif buildingID then
		rawRecipeList = DataModel:getIDsAndRecipesWhereBuildingID(buildingID)
	else
		error(ERROR_MESSAGE_EMPTY_PARAMETERS)
	end

	return rawRecipeList
end

---compileRecipeLists
---Adds the second list to the first, but restructures into Recipe objects along the way.
---
---@param DataModel BaseDataModel a data model that implements the recipe query interface
---@param recipeObjectTable table 3-factor array of Recipe objects, by product, grade, amount
---@param rawRecipeTable table list of recipe pairs, as gotten from a data model
---@return table the same recipeObjectTable, but with new and updated entries
local function compileRecipeLists(DataModel, recipeObjectTable, rawRecipeTable)

	--Skip when nothing to add.
	if not rawRecipeTable or #rawRecipeTable < 1 then
		return recipeObjectTable
	end

	for _, pair in ipairs(rawRecipeTable) do

		local buildingID, grade, time, productID, productAmount = getFlatRecipeValues(DataModel, pair)
		local ingredientsTable = buildingIngredientsTable(DataModel, pair)

		local buildingName = BuildingDataProxy.getName(buildingID)

		--Services identify their need by name, but goods to not. If it's a service, this is a simple renaming.
		local productName = productID
		local isService = DataModel:isRecipeProvidingService(pair)
		if not isService then
			productName = GoodsData.getName(productID)
		end

		--Now that we have everything extracted from rawRecipeTable for this pair, load it into recipeObjectTable, whether as a new Recipe object or adding a building to an existing Recipe object if one already exists. Recipes are uniquely identified by the 3-way combination of product, grade, and product amount.
		if not recipeObjectTable[productName] then
			recipeObjectTable[productName] = {}
		end
		--Transform the grade values to store them in a natural order.
		if not recipeObjectTable[productName][STORE_GRADES[grade]] then
			recipeObjectTable[productName][STORE_GRADES[grade]] = {}
		end
		if not recipeObjectTable[productName][STORE_GRADES[grade]][productAmount] then
			--Create a new Recipe object at this place in the table.
			recipeObjectTable[productName][STORE_GRADES[grade]][productAmount] = RecipeController.Recipe.new( { buildingName }, grade, time, isService, productID, productAmount, ingredientsTable)
		else
			--Add the building to the existing Recipe object at this place in the table.
			recipeObjectTable[productName][STORE_GRADES[grade]][productAmount]:addBuilding(buildingName)
		end
	end

	return recipeObjectTable
end

---getRecipesFromAllDataModels
---Goes through all data models and compiles the results into a single 3-factor table of Recipe objects, [product][grade][amount]. This table will be sparse, and note sometimes the grade is harder to spot in the console if it starts at 1 and is followed by 2 (because the console interprets it as an un-keyed array.
---
---For example, finding the recipe for Biscuits in the Field Kitchen: recipeObjectArray["Biscuits"][0][10]
---
---@param requiredProduct string the name of the product, or nil if any
---@param requiredBuilding string the name of the building, or nil if any
---@param requiredIngredient string the name of the ingredient, or nil if any
---@return table a 3-factor compiled table of Recipe objects, [product][grade][amount]
local function getRecipesFromAllDataModels(requiredProduct, requiredBuilding, requiredIngredient)

	--Resolve names to IDs, start them all as nil as wildcards.
	local productID
	local buildingID
	local ingredientID

	if requiredProduct then
		productID = GoodsData.getGoodID(requiredProduct)
		-- If it's not a good, then it might be a service, which has ID == name, so set it directly to the name if it's a valid service name
		local list = InstitutionsData:getIDsAndRecipesWhereProductID(requiredProduct)
		if not productID and #list > 0 then
			productID = requiredProduct
		end
	end

	if requiredBuilding then
		buildingID = BuildingDataProxy.getID(requiredBuilding)
	end

	-- Ingredients are always goods, never services.
	if requiredIngredient then
		ingredientID = GoodsData.getGoodID(requiredIngredient)
	end

	recipeObjectTable = {}
	for _, dataModel in ipairs(DataModelsWithRecipes) do
		local newRecipeList = getRawRecipes(dataModel, productID, buildingID, ingredientID)
		recipeObjectTable = compileRecipeLists(dataModel, recipeObjectTable, newRecipeList)
	end

	return recipeObjectTable
end

---countMaxIngredients
---Scans through the provided table of Recipe objects to count them.
---
---@param recipeList table 3-factor table of Recipe objects
---@return number of recipe objects
local function countRecipes(recipeList)

	local count = 0
	for _, product in pairs(recipeList) do
		for _, grade in pairs(product) do
			for _, _ in pairs(grade) do
				count = count + 1
			end
		end
	end
	return count
end

---countMaxIngredients
---Scans through the provided table of Recipe objects to find the recipe with the maximum number of ingredients slots (not options, whole slots of options).
---
---@param recipeList table 3-factor table of Recipe objects
---@return number of ingredients slots required to represent them all
local function countMaxIngredients(recipeList)

	local max = 0
	for _, product in pairs(recipeList) do
		for _, grade in pairs(product) do
			for _, recipe in pairs(grade) do
				local num = recipe:getNumIngredients()
				if max < num then
					max = num
				end
			end
		end
	end
	return max
end

---calculateCaption
---Simple cascading of rewriting the author requirements into the caption and how many were returned.
---
---@param requiredProduct string name of product, or nil if any
---@param requiredBuilding string name of building, or nil if any
---@param requiredIngredient string name of ingredient, or nil if any
---@param numRecipes number of recipes
---@return string the caption
local function calculateCaption(requiredProduct, requiredBuilding, requiredIngredient, numRecipes)

	local caption = numRecipes .. " recipes"

	if requiredProduct then
		caption = caption .. " for " .. requiredProduct
	end

	if requiredIngredient then
		caption = caption .. " using " .. requiredIngredient
	end

	if requiredBuilding then
		return caption .. " in the " .. requiredBuilding .. "."
	else
		return caption  .. "."
	end
end


---addBuildingLinks
---Assistant to buildMiddle.
---
---@param frame table
---@param recipe table
---@param requiredBuilding string
---@return string
local function addBuildingLinks(frame, recipe, requiredBuilding)

	local ret = ""
	local numBuildings = #recipe[INDEX_RECIPE_BUILDINGS_ARRAY]

	for _, buildingName in ipairs(recipe[INDEX_RECIPE_BUILDINGS_ARRAY]) do

		local buildingLinkArgs = {}

		buildingLinkArgs["name"] = buildingName
		buildingLinkArgs["iconfilename"] = BuildingDataProxy.getIcon(BuildingDataProxy.getID(buildingName))

		buildingLinkArgs["iconsize"] = (numBuildings < 2) and VIEW_TABLE_BUILDING_SINGLE_ICON_SIZE or VIEW_TABLE_BUILDING_MULTIPLE_ICON_SIZE

		-- Redundant to label the building if the author required it--the image alt-text and link still work with name.
		if requiredBuilding then
			buildingLinkArgs["display"] = "notext"
		end

		ret = ret .. "\n|-\n| " .. frame:expandTemplate{
			title = VIEW_BUILDING_LINK,
			args = buildingLinkArgs,
		}
	end

	return ret
end



---addIngredientSlot
---Assistant to buildMiddle.
---
---@param frame table
---@param ingredientSlot table
---@return string
local function addIngredientSlot(frame, ingredientSlot)

	local innerTable = MARKUP_NEWLINE_FORCED .. "{|" --all table markup has to start on its own line; this html comment accomplishes this
	local numOptions = #ingredientSlot

	if numOptions > 1 then
		innerTable = innerTable .. VIEW_CLASS_TABLE_INGREDIENTS_SWAPPABLE_ICON
	else
		innerTable = innerTable .. VIEW_CLASS_TABLE_INGREDIENTS_SINGLE_ICON
	end

	for _, option in ipairs(ingredientSlot) do
		local rlArgs = {}
		rlArgs["name"] = GoodsData.getName(option[INDEX_OPTION_ID])
		rlArgs["iconfilename"] = GoodsData.getIcon(option[INDEX_OPTION_ID])
		rlArgs["iconsize"] = VIEW_TABLE_INGREDIENT_ICON_SIZE

		innerTable = innerTable .. "\n|-\n| " .. option[INDEX_OPTION_AMOUNT] .. " |"
				.. "| " .. frame:expandTemplate{
			title = VIEW_RESOURCE_LINK,
			args = rlArgs,
		}
	end

	return innerTable .. "\n|}\n"
end



---addProductLinks
---Assistant to buildMiddle.
---
---@param frame table
---@param recipe table
---@param requiredProduct string
---@return string
local function addProductLinks(frame, recipe, requiredProduct)

	local link = ""
	if recipe[INDEX_RECIPE_IS_SERVICE] then
		local serviceLinkArgs = {}
		serviceLinkArgs["name"] = recipe[INDEX_RECIPE_PRODUCT_NAME]
		serviceLinkArgs["size"] = VIEW_TABLE_PRODUCT_ICON_SIZE
		-- Redundant to label the resource if the author required it--the image alt-text and link still work with name.
		if requiredProduct then
			serviceLinkArgs["display"] = "notext"
		end

		link = frame:expandTemplate{
			title = TEMPLATE_SERVICE_LINK,
			args = serviceLinkArgs,
		}
	else

		local resourceLinkArgs = {}
		resourceLinkArgs["name"] = GoodsData.getName(recipe[INDEX_RECIPE_PRODUCT_NAME])
		resourceLinkArgs["iconfilename"] = GoodsData.getIcon(recipe[INDEX_RECIPE_PRODUCT_NAME])
		resourceLinkArgs["iconsize"] = VIEW_TABLE_PRODUCT_ICON_SIZE
		-- Redundant to label the resource if the author required it--the image alt-text and link still work with name.
		if requiredProduct then
			resourceLinkArgs["display"] = "notext"
		end

		link = frame:expandTemplate{
			title = VIEW_RESOURCE_LINK,
			args = resourceLinkArgs,
		}
	end

	return link
end



---buildMiddle
---Calls the view to render table rows for each Recipe object and links to buildings and resources within the table rows.
---
---Benchmarking: ~0.005 seconds
---
---@param frame table MediaWiki template context
---@param recipeList table 3-factor list of Recipe objects, by [product][grade][amount]
---@param maxIngredients number of ingredients the largest Recipe has
---@param requiredProduct string name of product, or nil if any
---@param requiredBuilding string name of building, or nil if any
---@param _ string name of ingredient, or nil if any
---@return string a long string of wiki markup
local function buildMiddle(frame, recipeList, maxIngredients, requiredProduct, requiredBuilding, _)

	local ret = ""

	for _, recipeProductSubtable in pairs(recipeList) do
		for _, recipeGradeSubtable in pairs(recipeProductSubtable) do
			for _, recipe in pairs(recipeGradeSubtable) do

				local rowArgs = {}
				rowArgs["maxingredients"] = maxIngredients

				rowArgs["building"] = MARKUP_NEWLINE_FORCED .. "{|" --all table markup has to start on its own line; this html comment accomplishes this

				rowArgs["building"] = rowArgs["building"]
						.. addBuildingLinks(frame, recipe, requiredBuilding) .. "\n|}"

				rowArgs["grade"] = frame:expandTemplate{
					title = VIEW_GRADES[recipe[INDEX_RECIPE_GRADE]],
					args = {},
				}
				local minutes = math.floor(recipe[INDEX_RECIPE_TIME] / 60)
				local seconds = recipe[INDEX_RECIPE_TIME] % 60
				rowArgs["grade"] = rowArgs["grade"] .. "<br>"
						.. string.format("%d:%02d", minutes, seconds)

				for i, ingredientSlot in ipairs(recipe[INDEX_RECIPE_INGREDIENTS]) do
					rowArgs["ingredient" .. i] = addIngredientSlot(frame, ingredientSlot)
				end

				rowArgs["product"] = recipe[INDEX_RECIPE_PRODUCT_AMOUNT] .. "&nbsp;"
						.. addProductLinks(frame, recipe, requiredProduct)

				ret = ret .. frame:expandTemplate{
					title = VIEW_TEMPLATE_ROW,
					args = rowArgs,
				}
				ret = ret .. "\n"
			end
		end
	end

	return ret
end

---renderListView
---Takes the table of recipes gathered from the data models and returns a markup-unordered-list of the recipes. Buildings are shown when the author requested the product, otherwise the products are shown.
---
---@param frame table the Mediawiki context for the template
---@param recipeList table 3-factor table of Recipe objects in [product][grade][amount]
---@param requiredProduct string name of the product, or nil if any
---@param _ string name of the building, or nil if any (unused)
---@param _ string name of the ingredient, or nil if any (unused)
local function renderListView(frame, recipeList, requiredProduct, _, _)

	local ret = ""
	for _, recipeProductSubtable in pairs(recipeList) do
		for _, recipeGradeSubtable in pairs(recipeProductSubtable) do
			for _, recipe in pairs(recipeGradeSubtable) do
				for buildingCount, buildingName in ipairs(recipe[INDEX_RECIPE_BUILDINGS_ARRAY]) do

					local rowText = '\n*<span class="nowrap">'

					if requiredProduct then
						-- When queried by product, show the building name
						rowText = rowText .. frame:expandTemplate{
							title = VIEW_BUILDING_LINK,
							args = {
								["name"] = buildingName,
								["iconsize"] = "none",
							},
						}
					else
						-- If past the first building and we're not showing building names, then this will create duplicate entries.
						if buildingCount > 1 then
							break
						end

						-- When queried by building or ingredient, show the product name
						if recipe[INDEX_RECIPE_IS_SERVICE] then
							rowText = rowText .. frame:expandTemplate{
								title = TEMPLATE_SERVICE_LINK,
								args = {
									["name"] = recipe[INDEX_RECIPE_PRODUCT_NAME],
									["size"] = "small",
								}
							}
						else
							rowText = rowText .. frame:expandTemplate{
								title = VIEW_RESOURCE_LINK,
								args = {
									["name"] = GoodsData.getName(recipe[INDEX_RECIPE_PRODUCT_NAME]),
									["iconfilename"] = GoodsData.getIcon(recipe[INDEX_RECIPE_PRODUCT_NAME]),
									["iconsize"] = "small",
								},
							}
						end
					end

					rowText = rowText .. "&nbsp;("
					rowText = rowText .. frame:expandTemplate{
						title = VIEW_GRADES[recipe[INDEX_RECIPE_GRADE]],
						args = {},
					}

					rowText = rowText .. ")</span>"

					ret = ret .. rowText
				end
			end
		end
	end

	return ret
end

--endregion



--region Public classes

local Recipe = {}

-- This class available outside for read-only access
RecipeController.Recipe = Recipe
RecipeController.Recipe.OPTION_ID = INDEX_OPTION_ID
RecipeController.Recipe.OPTION_AMOUNT = INDEX_OPTION_AMOUNT

---new
---constructs a new Recipe instance from the provided data.
---
---the ingredientsTable must follow this format:
---ingredientsTable = {
---		--ingredient slots in recipe, between 1 and 3
---		[1] = {
---			--options for that slot, between 1 and 6
---			[1] = {
---				--each option's ID and amount
---				[Recipe.OPTION_ID] = string,
---				[Recipe.OPTION_STACK_SIZE] = number,
---			},
---			[2] = ...
---		},
---		[2] = ...
---}
---
---@param buildingArray table array of the names of buildings that make this recipe
---@param grade number of stars, between 0 and 3
---@param time number of seconds to produce
---@param productName string name of the good produced
---@param isService boolean true if this recipe offers a service instead of a product
---@param productStackSize number of goods produced each cycle
---@param ingredientsTable table array of 1-3 ingredient slots, each with 1-6 options, each with name and amount (see doc above)
function Recipe.new(buildingArray, grade, time, isService, productName, productStackSize, ingredientsTable)

	local instance = {}
	setmetatable(instance, { __index = Recipe} ) -- allow this instance to use Recipe class methods

	if not buildingArray or type(buildingArray) ~= "table" or #buildingArray < 1 then
		error("Cannot construct new Recipe with an empty building list")
	end
	instance[INDEX_RECIPE_BUILDINGS_ARRAY] = buildingArray

	if not grade or grade == "" then
		error("Cannot construct new Recipe with an empty grade.")
	elseif type(grade) ~= "number" or grade > 4 or grade < 0 then
		error ("Cannot construct new Recipe with an invalid grade value")
	end
	instance[INDEX_RECIPE_GRADE] = grade

	if not time or time == "" then
		error ("Cannot construct new Recipe with an empty production time")
	elseif type(time) ~= "number" or time < 0 then
		error ("Cannot construct new Recipe with an invalid production time value")
	end
	instance[INDEX_RECIPE_TIME] = time

	if type(isService) ~= "boolean" then
		error("Cannot construct new Recipe with an invalid service flag")
	end
	instance[INDEX_RECIPE_IS_SERVICE] = isService

	if not productName or productionName == "" then
		error ("Cannot construct new Recipe with an empty product name")
	end
	instance[INDEX_RECIPE_PRODUCT_NAME] = productName

	if not productStackSize or productStackSize == "" then
		error("Cannot construct new Recipe with an empty product amount")
	elseif type(productStackSize) ~= "number" or productStackSize < 1 then
		error("Cannot construct new Recipe with an invalid product amount value")
	end
	instance[INDEX_RECIPE_PRODUCT_AMOUNT] = productStackSize

	if not ingredientsTable or type(ingredientsTable) ~= "table" then
		error("Cannot construct new Recipe with an invalid ingredients table")
	end
	if #ingredientsTable > 3 then
		error("Cannot construct new Recipe with an ingredients table larger than 3 subtables")
	end
	for i, optionsArray in ipairs(ingredientsTable) do
		if not optionsArray or type(optionsArray) ~= "table" or #optionsArray < 1 then
			error("Cannot construct new Recipe with an empty options list (at index " .. i .. ")")
		end
		if #optionsArray > 8 then
			error("Cannot construct new Recipe with an options array larger than 8 subtables (at index " .. i .. ")")
		end
		for j, option in ipairs(optionsArray) do
			if not option or type(option) ~= "table" then
				error("Cannot construct new Recipe with an empty option (at index " .. i .. ", " .. j .. ")")
			end
			if not option[INDEX_OPTION_ID] or option[INDEX_OPTION_ID] == "" then
				error("Cannot construct a new Recipe with an empty option ID (at index " .. i .. ", " .. j .. ")")
			end
			if not option[INDEX_OPTION_AMOUNT] or type(option[INDEX_OPTION_AMOUNT]) ~= "number" then
				error("Cannot construct a new Recipe with an empty option amount (at index " .. i .. ", " .. j .. ")")
			end
			if option[INDEX_OPTION_AMOUNT] < 1 then
				error("Cannot construct a new Recipe with an invalid option amount (at index" .. i .. ", " .. j .. ")")
			end
		end
	end
	instance[INDEX_RECIPE_INGREDIENTS] = ingredientsTable

	return instance
end

---addBuilding
---Adds the provided building to this Recipe object's list of buildings where the recipe is made.
---
---@param buildingName string name
function Recipe:addBuilding(buildingName)

	if not self[INDEX_RECIPE_BUILDINGS_ARRAY] then
		self[INDEX_RECIPE_BUILDINGS_ARRAY] = { buildingName }
	else
		-- Skip duplicates. It shouldn't happen in 99% of cases, but just to be sure.
		for _, existingBuilding in ipairs(self[INDEX_RECIPE_BUILDINGS_ARRAY]) do
			if existingBuilding == buildingName then
				return
			end
		end
		table.insert(self[INDEX_RECIPE_BUILDINGS_ARRAY], buildingName)
	end
end

---getNumIngredients
---The number of ingredient slots (0-3) in the Recipe object.
---
---@return number of ingredients slots
function Recipe:getNumIngredients()

	if not self[INDEX_RECIPE_INGREDIENTS] then
		return 0
	end

	return #self[INDEX_RECIPE_INGREDIENTS]
end

--endregion



--region Public methods

---main
---Called from Template:Recipe. Returns markup text for display by using external view templates.
---
---@param frame table the Mediawiki calling context for the template
---@return string wiki markup
function RecipeController.main(frame)

	local requiredProduct = frame.args.product
	local requiredBuilding = frame.args.building
	local requiredIngredient = frame.args.ingredient
	local displayOverride = frame.args.display

	--Unset blanks back to nil
	if requiredProduct == "" then
		requiredProduct = nil
	end
	if requiredBuilding == "" then
		requiredBuilding = nil
	end
	if requiredIngredient == "" then
		requiredIngredient = nil
	end

	-- recipeList is a 3-factor array of Recipe objects, by [product][grade][stackSize]
	local recipeList = getRecipesFromAllDataModels(requiredProduct, requiredBuilding, requiredIngredient)

	if displayOverride == ARG_DISPLAY_OVERRIDE_LIST then
		return renderListView(frame, recipeList, requiredProduct, requiredBuilding, requiredIngredient)
	end

	local numRecipes = countRecipes(recipeList)
	local maxIngredients = countMaxIngredients(recipeList)
	local caption = calculateCaption(requiredProduct, requiredBuilding, requiredIngredient, numRecipes)

	local retStart = frame:expandTemplate{
		title = VIEW_TEMPLATE_START,
		args = {
			["maxingredients"] = maxIngredients,
			["caption"] = caption,
			["numrecipes"] = numRecipes,
		}
	}

	local retMiddle = buildMiddle(frame, recipeList, maxIngredients, requiredProduct, requiredBuilding, requiredIngredient)

	local retEnd = frame:expandTemplate{
		title = VIEW_TEMPLATE_END,
		args = {},
	}

	return retStart .. retMiddle .. retEnd
end

--endregion

return RecipeController
