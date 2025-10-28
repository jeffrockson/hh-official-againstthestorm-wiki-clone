-- Interface to Recipe static methods.
local Recipe = {}

-- A single recipe with one product, one grade, and one stack; possibly in more than one building.
---@class Recipe
---@field package _buildings BuildingID[] The ID codes of buildings that can make this recipe.
---@field package _grade Grade How many efficiency stars (0-3) the recipe has.
---@field package _time number Seconds to produce one product.
---@field package _productPair ProductPair The product and amount of it produced.
---@field package _isService boolean `true` if this recipe offers a service instead of a product.
---@field package _extraProductChances? ExtraProductChance[] Possible extra products for each cycle, if any, before any upgrades.
---@field package _ingredients IngredientSlot[] Ingredient slots (0-3, usually 1-2), each with multiple option choices.

-- Array of (usually 1-6, can be 8) interchangeable options for one ingredient slot in a recipe.
---@alias IngredientSlot IngredientOption[]
-- One acceptable option of good to use in the recipe.
---@alias IngredientOption {_id: ResourceID, _amount: integer}

-- Recipes sorted by [productID][grade][stackSize].
---@alias RecipeCatalog table<ProductID, RecipeListByGrade>
-- Subset of recipes sorted by [grade][stackSize] (sparse: only existing grades present).<br>
-- Use `pairs()` to iterate, not `ipairs()`.<br>
-- For sorting, extract keys, then sort, then iterate.
---@alias RecipeListByGrade table<Grade, RecipeSublistByStacksize>
-- Subsubset of recipes sorted by [stackSize] (sparse: only existing stack sizes present).<br>
-- Use `pairs()` to iterate, not `ipairs()`.<br>
-- For sorting, extract keys, then sort, then iterate.
---@alias RecipeSublistByStacksize table<integer, Recipe>

-- The ID and amount of a good or service made.
---@alias ProductPair {_id: ProductID, _amount: integer}

-- The ID, amount, and probability of an extra product.
---@alias ExtraProductChance {_id: ProductID, _amount: integer, _chance: number}

-- The ID of a good or service produced.
---@alias ProductID ResourceID

-- A number 0, 1, 2, or 3 (worst to best) of a recipe indicating its efficiency, effectiveness, or capability.
---@alias Grade 0|1|2|3





-- Constructs a new Recipe object with the provided data after running some error checking.
---@param buildingArray BuildingID[] array of building IDs where this recipe appears
---@param grade integer between 0 and 3
---@param time number in seconds
---@param productID ProductID the ID of the product or service made by this recipe
---@param isService boolean `true` if this recipe produces a service instead of a good
---@param productStackSize integer how many products are made by this recipe
---@param ingredientArray IngredientSlot[] array of slots (1-3), each an array of options (1-8)
---@return Recipe # the new Recipe object
function Recipe.new(buildingArray, grade, time, isService, productID, productStackSize, ingredientArray)

	-- Perform error checking.
	-- These would all be due to coding errors, not template use errors facing wiki authors.
	-- Therefore these messages are not extracted as strings for i18n.

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

	if not ingredientArray then
		error("[RecipeMaker/Recipe] constructor got empty ingredients array")
	elseif #ingredientArray > 3 then
		error("[RecipeMaker/Recipe] constructor got ingredients array larger than 3 slots")
	end

	for i, optionsArray in ipairs(ingredientArray) do
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
			if not option._id or option._id == "" then
				error("[RecipeMaker/Recipe] constructor got empty option ID at index " .. i .. ", " .. j)
			end
			if not option._amount then
				error("[RecipeMaker/Recipe] constructor got empty option amount at index " .. i .. ", " .. j)
			end
			if option._amount < 1 then
				error("[RecipeMaker/Recipe] constructor got invalid option amount at index" .. i .. ", " .. j)
			end
		end
	end

  ---@type Recipe
	return {
		_buildings = buildingArray,
		_grade = grade,
		_time = time,
		_productPair = {_id = productID, _amount = productStackSize},
		_isService = isService or false,
		_ingredients = ingredientArray
	}

end



-- Adds the specified building to this Recipe's list where the recipe is made.<br>
-- This is useful for when consolidating recipes across buildings.
---@param recipe Recipe the recipe to which to add the building
---@param newBuildingID BuildingID the ID code of the building to add to the Recipe
---@return Recipe # the same Recipe object
function Recipe.addBuilding(recipe, newBuildingID)
	if not recipe._buldingArray then
		recipe._buldingArray = { newBuildingID }
	else
		-- Skip duplicates. It shouldn't happen in 99% of cases, but just to be sure.
		for _, existingBuildingID in ipairs(recipe._buldingArray) do
			if existingBuildingID == newBuildingID then
				return recipe
			end
		end
		table.insert(recipe._buldingArray, newBuildingID)
	end
	return recipe
end



-- Gets the number of ingredient slots (between 0-3).
---@param recipe Recipe the recipe in question
---@return integer
function Recipe:getNumIngredients(recipe)
	return #recipe._ingredientsArray
end

return Recipe
