-- Makes beautiful displays for recipes.
local RecipeView = {}



--#region Dependencies

local Recipe = require("Module:Recipe")
local Building = require("Module:Building")
local isBuilding = Building.isBuilding
local Resource = require("Module:Resource")
local isGood = Resource.isGood
local Need = require("Module:Need")
local isNeed = Need.isNeed

local Wiki_Utility = require("Module:Wiki_Utility")
local divWrap = Wiki_Utility.surroundWithDiv
local NBSP = Wiki_Utility.NBSP
local standards = Wiki_Utility.StandardizedSizes
local gradeStars = Wiki_Utility.GradeStars

--#endregion Dependencies



--#region Private Methods

-- Sorts the product IDs in the recipeBook by their corresponding display names.
---@param recipeBook RecipeBook
---@return ProductID[] productIDs sorted, but by display name
local function sortRecipeBookByProductIDs(recipeBook)
  local products = {}
  for id, _ in pairs(recipeBook) do
		local pName = (isGood(id) and Resource.getName(id)) or (isNeed(id) and Need.getName(id)) or nil
		if not pName then error("RecipeView cannot sort invalid product ID: " .. id) end
    table.insert(products, {id = id, name = pName})
  end
  table.sort(products, function(a, b) return a.name < b.name end)
  local productIDs = {}
  for i, prod in ipairs(products) do
    productIDs[i] = prod.id
  end
  return productIDs
end

-- Sorts the grades in reverse order, since higher grade is better.
---@param recipeListByGrade RecipeListByGrade
---@return Grade[] grades sorted
local function sortRecipeListByGrade(recipeListByGrade)
	local grades = {}
	for g, _ in pairs(recipeListByGrade) do
		table.insert(grades, g)
	end
	table.sort(grades, function(a, b) return a > b end)
	return grades
end

-- Sorts the stack sizes in reverse order, since larger stacks are better.
---@param recipeSublistByStacksize RecipeSublistByStacksize
---@return Amount[] amounts sorted
local function sortRecipeSublistByAmount(recipeSublistByStacksize)
	local amounts = {}
	for a, _ in pairs(recipeSublistByStacksize) do
		table.insert(amounts, a)
	end
	table.sort(amounts, function(a, b) return a > b end)
	return amounts
end

-- Sorts the building IDs in the recipe by their corresponding display names.
---@param recipe Recipe
---@return BuildingID[] buildingIDs sorted, but by display name
local function sortBuildingIDs(recipe)
	local buildings = {}
	for _, id in pairs(Recipe.getBuildings(recipe)) do
		table.insert(buildings, {id = id, name = Building.getName(id)})
	end
	table.sort(buildings, function(a, b) return a.name < b.name end)
	local buildingIDs = {}
	for i, building in ipairs(buildings) do
		buildingIDs[i] = building.id
	end
	return buildingIDs
end

-- Shortcut to make a link to a resource, building, or need. Validates the ID first or throws an error if it's invalid, beacuse that shouldn't happen in working code.<br>
-- In this module, this requires no unnecessary data loading.
---@param id ResourceID|BuildingID|NeedID
---@param iconSize string
---@param needsIcon boolean
---@param needsText boolean
---@param targetElementID string|nil #name or #id of the DOM element to link directly to, if any
---@return Wikitext wikitext
local function makeLink(id, iconSize, needsIcon, needsText, targetElementID)
	if isGood(id) then
		return Resource.resourceLinkByID(id, iconSize, needsIcon, needsText, targetElementID)
	elseif isBuilding(id) then
		return Building.buildingLinkByID(id, iconSize, needsIcon, needsText)
	elseif isNeed(id) then
		return Need.needLinkByID(id, iconSize, needsIcon, needsText)
	end
	error("RecipeView cannot make link to invalid ID:" .. id)
end

-- Makes the caption for the view of recipes.<br>
-- "# Recipe[s] for [requiredProduct] using [requiredIngredient] in the [requiredBuilding]."
---@param recipeCount integer number of recipes shown
---@param requiredProduct ResourceName|nil display name of the product, or nil if none required
---@param requiredBuilding BuildingName|nil display name of the building, or nil if none required
---@param requiredIngredient ResourceName|nil display name of the ingredient, or nil if none required
---@return string # caption
local function makeCaption(recipeCount, requiredProduct, requiredBuilding, requiredIngredient)
	return recipeCount .. " Recipe" .. (recipeCount ~= 1 and "s" or "")
		.. (requiredProduct and (" for " .. requiredProduct) or "")
		.. (requiredIngredient and (" using " .. requiredIngredient) or "")
		.. (requiredBuilding and (" in the " .. requiredBuilding) or "")
end

-- Starts the table and sets the caption and header row.<br>
-- `{| [classes]`<br>
-- `|+ [caption]`<br>
-- `|-`<br>
-- `! Building[s] !! Grade !! Ingredient[s] !! # !! Product`
---@param recipeCount integer number of recipes that will be in the table
---@param maxIngredients integer number of ingredients slots required to represent them all
---@param numBuildings integer total number of buildings that can make the recipes
---@param requiredProduct ResourceName|nil for the caption
---@param requiredBuilding BuildingName|nil for the caption
---@param requiredIngredient ResourceName|nil for the caption
---@return Wikitext wikitext
local function makeTableHeader(recipeCount, maxIngredients, numBuildings, requiredProduct, requiredBuilding, requiredIngredient)
	local wikitext = "|+ " .. makeCaption(recipeCount, requiredProduct, requiredBuilding, requiredIngredient) .."\n"
	wikitext = wikitext .. "|-\n"
	wikitext = wikitext .. "! Building" .. (numBuildings > 1 and "s" or "") .. "\n"
	wikitext = wikitext .. "! Grade" .. "\n"
	wikitext = wikitext .. "! "
	-- draw this column even if there are no ingredients
	if maxIngredients < 2 then
		wikitext = wikitext .. "Ingredient"
	else
		for i = 1, maxIngredients do
			wikitext = wikitext .. "Ingredient #" .. i
			if i < maxIngredients then
				wikitext = wikitext .. " !! "
			end
		end
	end
	wikitext = wikitext .. "\n"
	wikitext = wikitext .. "! #\n"
	wikitext = wikitext .. "! Product"
	return wikitext
end

-- Renders the buildings that can make the recipe.
---@param recipe Recipe
---@param reqBuildingID BuildingID|nil ID of the required building, or nil if none required
---@return Wikitext wikitext
local function renderBuildingsInner(recipe, reqBuildingID)
	local wikitext = ""
	local buildingIDs = sortBuildingIDs(recipe)
	-- groups of buildings have smaller icons (and btw always show their names)
	if #buildingIDs > 1 then
		wikitext = wikitext .. Building.tableStack(buildingIDs, standards.large, "ats-table-recipe-multiple-buildings")
	else
		local onlyBuildingID = buildingIDs[1]
		wikitext = wikitext .. Building.buildingLinkByID(onlyBuildingID, standards.huge, true, onlyBuildingID ~= reqBuildingID)
	end
	return wikitext
end

-- Wraps the resource stack for a specified ingredient slot and the number of options.
---@param recipe Recipe
---@param slotIndex integer
---@return Wikitext wikitext
local function renderIngredientsInnerTable(recipe, slotIndex)
	local numOptions = Recipe.getNumOptions(recipe, slotIndex)
	return Resource.tableStack(Recipe.getIngredientOptions(recipe, slotIndex), standards.medium, ((numOptions > 1) and "ats-swappable-ingredient-icon" or "ats-single-ingredient-icon"))
end

-- Renders a table view of the recipes.
---@param recipeBook RecipeBook
---@param recipeCount integer number of recipes in the RecipeBook
---@param maxIngredients integer number of ingredients slots required to represent them all
---@param numBuildings integer total number of buildings that can make the recipes
---@param requiredProduct ProductName|nil name of the product, or nil if none required
---@param reqProductID ProductID|nil ID of the product, or nil if none required
---@param requiredBuilding BuildingName|nil name of the building, or nil if none required
---@param reqBuildingID BuildingID|nil ID of the building, or nil if none required
---@param requiredIngredient ResourceName|nil name of the ingredient, or nil if none required
---@return Wikitext wikitext markup that renders the recipe table
local function renderTableView(recipeBook, recipeCount, maxIngredients, numBuildings, requiredProduct, reqProductID, requiredBuilding, reqBuildingID, requiredIngredient)
	local wikitext = "{| class=\"sortable mw-collapsible ats-table-recipe\"\n" .. makeTableHeader(recipeCount, maxIngredients, numBuildings, requiredProduct, requiredBuilding, requiredIngredient) .. "\n"
	if recipeCount == 0 then
		return divWrap("\n" .. wikitext .. "|-\n| No recipes.\n|}\n", "ats-container-recipe")
	end
	for _, productID in ipairs(sortRecipeBookByProductIDs(recipeBook)) do
		for _, grade in ipairs(sortRecipeListByGrade(recipeBook[productID])) do
			for _, stacksize in ipairs(sortRecipeSublistByAmount(recipeBook[productID][grade])) do
				local recipe = recipeBook[productID][grade][stacksize]
				wikitext = wikitext .. "|- <!-- Recipe row -->\n"
				-- Building(s), grade, and production time
				wikitext = wikitext .. (Recipe.getNumBuildings(recipe) > 1 and "| \n" or "| ") .. renderBuildingsInner(recipe, reqBuildingID) .. "\n"
				wikitext = wikitext .. "|data-sort-value=" .. grade .. "| " .. gradeStars[grade] .. "<br />" .. Recipe.getTimeClock(recipe) .. "\n"
				-- Ingredients (at least one empty); first pad with empties then fill real slots
				local numIngredients = Recipe.getNumIngredients(recipe)
				if numIngredients == 0 and maxIngredients == 0 then
					wikitext = wikitext .. "| &mdash;\n"
				else
					for _ = 1, maxIngredients - numIngredients do
						wikitext = wikitext .. "| &mdash;\n"
					end
					for j = 1, numIngredients do
						wikitext = wikitext .. "|class=ats-table-recipe-ingredients-options| \n" .. renderIngredientsInnerTable(recipe, j) .. "\n"
					end
				end
				-- Amount and product
				wikitext = wikitext .. "| " .. stacksize .. "\n"
				wikitext = wikitext .. "| " .. makeLink(productID, standards.huge, true, productID ~= reqProductID, "#Ingredient") .. "\n"
			end
		end
	end
	wikitext = wikitext .. "|}\n"
	return divWrap("\n" .. wikitext, "ats-container-recipe")
end

-- Renders a list view of the recipes.<br>
-- When a product is specified, the list shows the buildings that can make it, otherwise for buildings and ingredients it shows the products.
---@param recipeBook RecipeBook
---@param recipeCount integer number of recipes in the RecipeBook
---@param requiredProduct string|nil name of the product, or nil if none required
---@param requiredBuilding string|nil name of the building, or nil if none required
---@param requiredIngredient string|nil name of the ingredient, or nil if none required
---@return Wikitext wikitext
local function renderListView(recipeBook, recipeCount, requiredProduct, requiredBuilding, requiredIngredient)
	local wikitext = ""
	if recipeCount == 0 then
		return "No recipes" .. (requiredProduct and (" for " .. requiredProduct) or "") .. (requiredBuilding and (" in the " .. requiredBuilding) or "") .. (requiredIngredient and (" using " .. requiredIngredient) or "") .. "."
	end
	for _, productID in ipairs(sortRecipeBookByProductIDs(recipeBook)) do
		for _, grade in ipairs(sortRecipeListByGrade(recipeBook[productID])) do
			for _, stacksize in ipairs(sortRecipeSublistByAmount(recipeBook[productID][grade])) do
				local recipe = recipeBook[productID][grade][stacksize]
				-- When a product is specified, the list shows the buildings that can make it, otherwise for buildings and ingredients list the products
				if requiredProduct then
					for _, buildingID in ipairs(sortBuildingIDs(recipe)) do
						wikitext = wikitext .. "* " .. makeLink(buildingID, "0", false, true) .. NBSP .. "(" .. gradeStars[grade] .. ")\n"
					end
				else
					wikitext = wikitext .. "* " .. makeLink(productID, standards.small, true, true, "#Product") .. NBSP .. "(" .. gradeStars[grade] .. ")\n"
				end
			end
		end
	end
	return wikitext
end

--#endregion Private Methods



--#region Public Methods

-- Recipe template invokes this method from MediaWiki.<br>
-- At least one filter argument (product, building, or ingredient) must be provided.<br>
-- Empty filter arguments will allow more results to be returned.
---@param frame Frame MediaWiki template context
---@return Wikitext wikitext wikitext markup to render the recipe table
function RecipeView.main(frame)

	-- nil is allowed as a wildcard ("no required product"), so unset unallowed blank strings to nil.
	-- An empty args list is not allowed and deserves an error.

	local requiredProduct = frame.args.product ~= "" and frame.args.product or nil
	local requiredBuilding = frame.args.building ~= "" and frame.args.building or nil
	local requiredIngredient = frame.args.ingredient ~= "" and frame.args.ingredient or nil
	
	if not requiredProduct and not requiredBuilding and not requiredIngredient then
		return "[Recipe needs at least a product, building, or ingredient]"
	end

	local reqProductID = requiredProduct and (Resource.getID(requiredProduct) or Need.getID(requiredProduct)) or nil
	if not reqProductID and requiredProduct then
		return "[Recipe product not found: " .. requiredProduct .. "]"
	end
	local reqBuildingID = requiredBuilding and Building.getID(requiredBuilding) or nil
	if not reqBuildingID and requiredBuilding then
		return "[Recipe building not found: " .. requiredBuilding .. "]"
	end
  local reqIngredientID = requiredIngredient and Resource.getID(requiredIngredient) or nil
	if not reqIngredientID and requiredIngredient then
		return "[Recipe ingredient not found: " .. requiredIngredient .. "]"
	end

	-- complete list of recipes populated from data models
	---@type RecipeBook
	local recipeBook, recipeCount, maxIngredients, numBuildings = Building.compileRecipeBook(reqProductID, reqBuildingID, reqIngredientID)
	
	if frame.args.display == "list" then
		return renderListView(recipeBook, recipeCount, requiredProduct, requiredBuilding, requiredIngredient)
	else
		return renderTableView(recipeBook, recipeCount, maxIngredients, numBuildings, requiredProduct, reqProductID, requiredBuilding, reqBuildingID, requiredIngredient)
	end
end

--endregion Public Methods



return RecipeView