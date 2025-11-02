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
local sizes = Wiki_Utility.StandardizedSizes
local gradeStars = Wiki_Utility.GradeStars

--#endregion Dependencies



--#region Private Methods

-- Makes the caption for the view of recipes.
---@param recipeCount integer number of recipes shown
---@param requiredProduct string|nil name of the product, or nil if none required
---@param requiredBuilding string|nil name of the building, or nil if none required
---@param requiredIngredient string|nil name of the ingredient, or nil if none required
---@return string # caption
local function makeCaption(recipeCount, requiredProduct, requiredBuilding, requiredIngredient)
	return recipeCount .. " recipes" 
		.. (requiredProduct and " for " .. requiredProduct or "")
		.. (requiredIngredient and " using " .. requiredIngredient or "")
		.. (requiredBuilding and " in the " .. requiredBuilding or "")
		.. "."
end

-- Starts the table and sets the caption and header row.
---@param recipeCount integer number of recipes that will be in the table
---@param maxIngredients integer number of ingredients slots required to represent them all
---@param numBuildings integer total number of buildings that can make the recipes
---@param requiredProduct string|nil name of the product, or nil if none required
---@param requiredBuilding string|nil name of the building, or nil if none required
---@param requiredIngredient string|nil name of the ingredient, or nil if none required
---@return Wikitext wikitext
local function startTableHeader(recipeCount, maxIngredients, numBuildings, requiredProduct, requiredBuilding, requiredIngredient)
	local wikitext = "{| class=\"sortable mw-collapsible ats-table-recipe\n"
	wikitext = wikitext .. "|+ " .. makeCaption(recipeCount, requiredProduct, requiredBuilding, requiredIngredient) .."\n"
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
	wikitext = wikitext .. "! Product\n"
	return wikitext
end

-- Wraps the resource stack for a specified ingredient slot and the number of options.
---@param recipe Recipe
---@param slotIndex integer
---@return Wikitext wikitext
local function renderIngredientsInnerTable(recipe, slotIndex)
	local numOptions = Recipe.getNumOptions(recipe, slotIndex)
	return Resource.tableStack(Recipe.getIngredientOptions(recipe, slotIndex), ((numOptions > 1) and "ats-swappable-ingredient-icon" or "ats-single-ingredient-icon"))
end

-- Shortcut to make a link to a resource, building, or need. Validates the ID first or throws an error if it's invalid, beacuse that shouldn't happen in working code.<br>
-- In this module, this requires no unnecessary data loading.
---@param id ResourceID|BuildingID|NeedID
---@param iconSize string
---@param needsIcon boolean
---@param needsText boolean
---@return Wikitext wikitext
local function makeLink(id, iconSize, needsIcon, needsText)
	local isResource = isGood(id)
	if isResource then
		return Resource.resourceLinkByID(id, iconSize, needsIcon, needsText)
	elseif isBuilding(id) then
		return Building.buildingLinkByID(id, iconSize, needsIcon, needsText)
	elseif isNeed(id) then
		return Need.needLinkByID(id, iconSize, needsIcon, needsText)
	end
	error("RecipeView cannot make link to invalid ID:" .. id)
end

-- Renders a table view of the recipes.
---@param recipeBook RecipeBook
---@param recipeCount integer number of recipes in the RecipeBook
---@param maxIngredients integer number of ingredients slots required to represent them all
---@param numBuildings integer total number of buildings that can make the recipes
---@param requiredProduct string|nil name of the product, or nil if none required
---@param reqProductID ProductID|nil ID of the product, or nil if none required
---@param requiredBuilding string|nil name of the building, or nil if none required
---@param reqBuildingID BuildingID|nil ID of the building, or nil if none required
---@param requiredIngredient string|nil name of the ingredient, or nil if none required
---@return Wikitext wikitext markup that renders the recipe table
local function renderTableView(recipeBook, recipeCount, maxIngredients, numBuildings, requiredProduct, reqProductID, requiredBuilding, reqBuildingID, requiredIngredient)
	local wikitext = startTableHeader(recipeCount, maxIngredients, numBuildings, requiredProduct, requiredBuilding, requiredIngredient)
	if recipeCount == 0 then
		wikitext = wikitext .. "|-\n"
		wikitext = wikitext .. "| No recipes.\n"
	end
	for productID, recipeListByGrade in pairs(recipeBook) do
		for grade, recipesByStacksize in pairs(recipeListByGrade) do
			for stackSize, recipe in pairs(recipesByStacksize) do
				wikitext = wikitext .. "|- <!-- Recipe row -->\n"
				wikitext = wikitext .. "| "
				local buildings = Recipe.getBuildings(recipe)
				-- groups of buildings have smaller icons
				local iconSize = #buildings > 1 and sizes.large or sizes.huge
				for i, buildingID in ipairs(buildings) do
					wikitext = wikitext .. makeLink(buildingID, iconSize, true, buildingID ~= reqBuildingID)
					if i < #buildings then
						wikitext = wikitext .. "<br />"
					else
						wikitext = wikitext .. "\n"
					end
				end
				wikitext = wikitext .. "| " .. gradeStars[grade] .. "<br />" .. Recipe.getTimeClock(recipe) .. "\n"
				local numIngredients = Recipe.getNumIngredients(recipe)
				for _ = 1, maxIngredients - numIngredients do
					wikitext = wikitext .. "| &mdash;\n" -- empty cell filler
				end
				for j = 1, numIngredients do
					wikitext = wikitext .. "|class=ats-table-recipe-ingredients-options| \n" .. renderIngredientsInnerTable(recipe, j) .. "\n"
				end
				wikitext = wikitext .. "| " .. stackSize .. "\n"
				wikitext = wikitext .. "| " .. makeLink(productID, sizes.huge, true, productID ~= reqProductID) .. "\n"
				wikitext = wikitext .. "\n"
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
	for productID, recipeListByGrade in pairs(recipeBook) do
		for grade, recipesByStacksize in pairs(recipeListByGrade) do
			for _, recipe in pairs(recipesByStacksize) do
				if requiredProduct then
					for _, buildingID in ipairs(Recipe.getBuildings(recipe)) do
						wikitext = wikitext .. "* " .. makeLink(buildingID, "0", false, true) .. NBSP .. "(" .. gradeStars[grade] .. ")\n"
					end
				else
					wikitext = wikitext .. "* " .. makeLink(productID, sizes.small, true, true) .. NBSP .. "(" .. gradeStars[grade] .. ")\n"
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
