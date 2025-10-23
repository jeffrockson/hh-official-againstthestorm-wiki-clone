-- Makes beautiful displays for recipes.
local RecipeMaker = {}

-- A frame object provided by MediaWiki when invoking a module.<br>
-- See [Official MediaWiki doc on frame objects](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Frame_object)
---@class Frame : table
---@field args table Template arguments in the frame passed to the module.
---@field expandTemplate fun(self: Frame, options: {title: string, args: table}): string function to call the titled MediaWiki template with the specified args.

-- A single recipe with one product, one grade, and one stack; possibly in more than one building.
---@class Recipe : table
---@field private buildingArray BuildingID[] The ID codes of buildings that can make this recipe.
---@field private grade integer How many efficiency stars (0-3) the recipe has.
---@field private time number Seconds to produce one product.
---@field private productID ProductID The ID code of what is produced.
---@field private isService boolean `true` if this recipe offers a service instead of a product.
---@field private productStackSize integer Quantity of goods produced each cycle.
---@field private ingredientsArray IngredientsArray Several ingredients slots of several options each.
---@field public new fun(buildingArray: BuildingID[], grade: integer, time: number, productID, ProductID, isService: boolean, productStackSize: integer, ingredientsArray: IngredientsArray): Recipe Constructor.
---@field public getNumIngredients fun(self: Recipe): integer Gets the number of slots in `ingredientsArray`

-- Array of (usually 1-2, can be 0 or 3) ingredient slots to make the recipe.
---@alias IngredientsArray IngredientSlot[]
-- Array of (usually 1-6, can be 8) interchangeable options for one ingredient slot in a recipe.
---@alias IngredientSlot IngredientOption[]
-- One acceptable option of good to use in the recipe.
---@alias IngredientOption {id: GoodID, amount: integer}

-- Recipes sorted by [productID][grade][stackSize].
---@alias RecipeList table<ProductID, RecipeSublistByGrade>
-- Subset of recipes sorted by [grade][stackSize].
---@alias RecipeSublistByGrade table<integer, RecipeSublistByStacksize>
-- Subsubset of recipes sorted by [stackSize].
---@alias RecipeSublistByStacksize table<integer, Recipe>

-- The ID code of a building that makes a recipe.
---@alias BuildingID string
-- The ID code of a good or service made by a recipe.
---@alias ProductID string
-- The ID code of a good.
---@alias GoodID string



--region dependencies

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
local InstitutionsData = require("Module:InstitutionsData")

local VIEW_TEMPLATE_START_REFACTOR_ME = "Recipe/view"
local VIEW_TEMPLATE_ROW_REFACTOR_ME = "Recipe/view/row"
local VIEW_TEMPLATE_END_REFACTOR_ME = "Recipe/view/end"

local VIEW_BUILDING_LINK = "Building_link/view"
local VIEW_RESOURCE_LINK = "Resource_link/view"
--This doesn't use the view version because we don't want to hardcode the icon filename.
local TEMPLATE_SERVICE_LINK = "Service_link"

--endregion



--region package-private class

---@class Recipe
local Recipe = {}

-- Constructs a new Recipe object with the provided data.
---@param buildingArray BuildingID[] array of building IDs where this recipe appears
---@param grade integer between 0 and 3
---@param time number in seconds
---@param productID ProductID the ID of the product or service made by this recipe
---@param isService boolean `true` if this recipe produces a service instead of a good
---@param productStackSize integer how many products are made by this recipe
---@param ingredientsArray IngredientsArray array of slots (1-3), each an array of options (1-8)
---@return Recipe # the new Recipe object
---@package
function Recipe.new(buildingArray, grade, time, isService, productID, productStackSize, ingredientsArray)

	---@type Recipe
	local instance = {
		buildingArray = buildingArray,
		grade = grade,
		time = time,
		productID = productID,
		isService = isService or false,
		productStackSize = productStackSize,
		ingredientsArray = ingredientsArray
	}
	-- Allow this instance to use Recipe class methods.
	setmetatable(instance, { __index = Recipe} )

	-- Perform error checking.
	-- These would all be due to coding errors, not template use errors facing wiki authors, so these messages are not extracted as internationalizable strings.

	if not buildingArray or #buildingArray < 1 then
		error("[RecipeMaker/Recipe] constructor got empty array of building IDs")
	end

	if not grade then
		error("[RecipeMaker/Recipe] constructor got empty grade")
	elseif grade > 4 or grade < 0 then
		error ("[RecipeMaker/Recipe] constructor got invalid grade number")
	end

	if not time then
		error ("[RecipeMaker/Recipe] constructor got empty time")
	elseif time < 0 then
		error ("[RecipeMaker/Recipe] constructor got invalid time number")
	end

	if not productID or productID == "" then
		error ("[RecipeMaker/Recipe] constructor got empty product ID")
	end

	if not productStackSize then
		error("[RecipeMaker/Recipe] constructor got empty amount")
	elseif productStackSize < 1 then
		error("[RecipeMaker/Recipe] constructor got invalid amount number")
	end

	if not ingredientsArray then
		error("[RecipeMaker/Recipe] constructor got empty ingredients array")
	elseif #ingredientsArray > 3 then
		error("[RecipeMaker/Recipe] constructor got ingredients array larger than 3 slots")
	end

	for i, optionsArray in ipairs(ingredientsArray) do
		if not optionsArray or #optionsArray < 1 then
			error("[RecipeMaker/Recipe] constructor got empty slot at index " .. i)
		end
		if #optionsArray > 8 then
			error("[RecipeMaker/Recipe] constructor got options array larger than 8 at index " .. i)
		end
		for j, option in ipairs(optionsArray) do
			if not option then
				error("[RecipeMaker/Recipe] constructor got empty option at index " .. i .. ", " .. j)
			end
			if not option.id or option.id == "" then
				error("[RecipeMaker/Recipe] constructor got empty option ID at index " .. i .. ", " .. j)
			end
			if not option.amount then
				error("[RecipeMaker/Recipe] constructor got empty option amount at index " .. i .. ", " .. j)
			end
			if option.amount < 1 then
				error("[RecipeMaker/Recipe] constructor got invalid option amount at index" .. i .. ", " .. j)
			end
		end
	end

	return instance
end

-- Adds the specified building to this Recipe's list where the recipe is made.<br>
-- This is useful for when consolidating recipes across buildings.
---@param newBuildingID BuildingID the ID code of the building to add to the Recipe
---@return Recipe # the same Recipe object
---@package
function Recipe:addBuilding(newBuildingID)
	if not self.buildingArray then
		self.buildingArray = { newBuildingID }
	else
		-- Skip duplicates. It shouldn't happen in 99% of cases, but just to be sure.
		for _, existingBuildingID in ipairs(self.buildingArray) do
			if existingBuildingID == newBuildingID then
				return self
			end
		end
		table.insert(self.buildingArray, newBuildingID)
	end
	return self
end

-- Gets the number of ingredient slots (between 0-3).
---@return integer
---@package
function Recipe:getNumIngredients()
	return #self.ingredientsArray
end

--endregion



--region i18n

local ERROR_MESSAGE_EMPTY_PARAMETERS = "Template:Recipe requires at least a product, building, or ingredient. Please see the template documentation for how to use the parameters"

--endregion



--region private constants

local VIEW_TABLE_BUILDING_SINGLE_ICON_SIZE = "huge"
local VIEW_TABLE_BUILDING_MULTIPLE_ICON_SIZE = "large"
local VIEW_TABLE_INGREDIENT_ICON_SIZE = "medium"
local VIEW_TABLE_PRODUCT_ICON_SIZE = "huge"

local CLASSNAME_FRAME_INGREDIENT_SINGLE = 'class=ats-single-ingredient-icon'
local CLASSNAME_FRAME_INGREDIENT_SWAP = 'class=ats-swappable-ingredient-icon'

---@enum GRADES_VIEW
local GRADES_VIEW = {
	[0] = '0Star',
	[1] = '1Star',
	[2] = '2Star',
	[3] = '3Star',
}
-- Transforms when using the grade as an index to sort things whenever possible.
---@enum GRADES
local GRADES = {
	[0] = 1,
	[1] = 2,
	[2] = 3,
	[3] = 4,
}

local NEWLINE_REFACTOR_ME = "\n<!-- -->\n"

--endregion



--region private member variables
--none!
--endregion



--region private methods

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
		if not recipeObjectTable[productName][GRADES[grade]] then
			recipeObjectTable[productName][GRADES[grade]] = {}
		end
		if not recipeObjectTable[productName][GRADES[grade]][productAmount] then
			--Create a new Recipe object at this place in the table.
			recipeObjectTable[productName][GRADES[grade]][productAmount] = RecipeMaker.Recipe.new( { buildingName }, grade, time, isService, productID, productAmount, ingredientsTable)
		else
			--Add the building to the existing Recipe object at this place in the table.
			recipeObjectTable[productName][GRADES[grade]][productAmount]:addBuilding(buildingName)
		end
	end

	return recipeObjectTable
end

---Goes through all data models and compiles the results into a single 3-factor table of Recipe objects, [product][grade][amount]. This table will be sparse, and note sometimes the grade is harder to spot in the console if it starts at 1 and is followed by 2 (because the console interprets it as an un-keyed array.
---
---For example, finding the recipe for Biscuits in the Field Kitchen: recipeObjectArray["Biscuits"][0][10]
---
---@param requiredProduct string|nil the name of the product, or nil if any
---@param requiredBuilding string|nil the name of the building, or nil if any
---@param requiredIngredient string|nil the name of the ingredient, or nil if any
---@return RecipeList a 3-factor compiled table of Recipe objects, [product][grade][amount]
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
---@param requiredProduct string|nil name of product, or nil if any
---@param requiredBuilding string|nil name of building, or nil if any
---@param requiredIngredient string|nil name of ingredient, or nil if any
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

	local innerTable = NEWLINE_REFACTOR_ME .. "{|" --all table markup has to start on its own line; this html comment accomplishes this
	local numOptions = #ingredientSlot

	if numOptions > 1 then
		innerTable = innerTable .. CLASSNAME_FRAME_INGREDIENT_SWAP
	else
		innerTable = innerTable .. CLASSNAME_FRAME_INGREDIENT_SINGLE
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
---@param requiredProduct string|nil name of product, or nil if any
---@param requiredBuilding string|nil name of building, or nil if any
---@param _ string name of ingredient, or nil if any (unused)
---@return string a long string of wiki markup
local function buildMiddle(frame, recipeList, maxIngredients, requiredProduct, requiredBuilding, _)

	local ret = ""

	for _, recipeProductSubtable in pairs(recipeList) do
		for _, recipeGradeSubtable in pairs(recipeProductSubtable) do
			for _, recipe in pairs(recipeGradeSubtable) do

				local rowArgs = {}
				rowArgs["maxingredients"] = maxIngredients

				rowArgs["building"] = NEWLINE_REFACTOR_ME .. "{|" --all table markup has to start on its own line; this html comment accomplishes this

				rowArgs["building"] = rowArgs["building"]
						.. addBuildingLinks(frame, recipe, requiredBuilding) .. "\n|}"

				rowArgs["grade"] = frame:expandTemplate{
					title = GRADES_VIEW[recipe[INDEX_RECIPE_GRADE]],
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
					title = VIEW_TEMPLATE_ROW_REFACTOR_ME,
					args = rowArgs,
				}
				ret = ret .. "\n"
			end
		end
	end

	return ret
end

local function renderTableView(recipeList, requiredProduct, requiredBuilding, requiredIngredient)
	local numRecipes = countRecipes(recipeList)
	local maxIngredients = countMaxIngredients(recipeList)
	local caption = calculateCaption(requiredProduct, requiredBuilding, requiredIngredient, numRecipes)

	local retStart = frame:expandTemplate{
		title = VIEW_TEMPLATE_START_REFACTOR_ME,
		args = {
			["maxingredients"] = maxIngredients,
			["caption"] = caption,
			["numrecipes"] = numRecipes,
		}
	}

	local retMiddle = buildMiddle(frame, recipeList, maxIngredients, requiredProduct, requiredBuilding, requiredIngredient)

	local retEnd = frame:expandTemplate{
		title = VIEW_TEMPLATE_END_REFACTOR_ME,
		args = {},
	}

	return retStart .. retMiddle .. retEnd
end

---renderListView
---Takes the table of recipes gathered from the data models and returns a markup-unordered-list of the recipes. Buildings are shown when the author requested the product, otherwise the products are shown.
---
---@param frame table the Mediawiki context for the template
---@param recipeList table 3-factor table of Recipe objects in [product][grade][amount]
---@param requiredProduct string|nil name of the product, or nil if any
local function renderListView(frame, recipeList, requiredProduct)

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
						title = GRADES_VIEW[recipe[INDEX_RECIPE_GRADE]],
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



--region Public methods

-- Main function invoked externally from *Template:Recipe*.
-- At least one filter parameter (product, building, or ingredient) must be provided.
-- Empty filter parameters are treated as wildcards.
---@param frame Frame the current MediaWiki frame
---@return string wiki_markup formatted wikitable containing matching recipes
function RecipeMaker.main(frame)

	-- nil is allowed as a wildcard ("no required product"), so unset unallowed blank strings to nil.
	-- An empty args list is not allowed and deserves an error.

	local requiredProduct = frame.args.product ~= "" and frame.args.product or nil
	local requiredBuilding = frame.args.building ~= "" and frame.args.building or nil
	local requiredIngredient = frame.args.ingredient ~= "" and frame.args.ingredient or nil

	if not requiredProduct and not requiredBuilding and not requiredIngredient then
		error(ERROR_MESSAGE_EMPTY_PARAMETERS)
	end

	-- complete list of recipes populated from data models
	---@type RecipeList
	local recipeList = getRecipesFromAllDataModels(requiredProduct, requiredBuilding, requiredIngredient)

	if frame.args.display == "list" then
		return renderListView(recipeList, requiredProduct, requiredBuilding, requiredIngredient)
	else
		return renderTableView(recipeList, requiredProduct, requiredBuilding, requiredIngredient)
	end
end

--endregion

return RecipeMaker
