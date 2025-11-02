-- Provides a standard way of interacting with recipe data.
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
---@alias IngredientOption ResourcePair

-- Recipes sorted by [productID][grade][stackSize].
---@alias RecipeBook table<ProductID, RecipeListByGrade>
-- Subset of recipes sorted by [grade][stackSize] (sparse: only existing grades present).<br>
-- Use `pairs()` to iterate, not `ipairs()`.<br>
-- For sorting, extract keys, then sort, then iterate.
---@alias RecipeListByGrade table<Grade, RecipeSublistByStacksize>
-- Subsubset of recipes sorted by [stackSize] (sparse: only existing stack sizes present).<br>
-- Use `pairs()` to iterate, not `ipairs()`.<br>
-- For sorting, extract keys, then sort, then iterate.
---@alias RecipeSublistByStacksize table<integer, Recipe>

-- The ID and amount of a good or service made.
---@alias ProductPair ResourcePair

-- The ID, amount, and probability of an extra product.
---@alias ExtraProductChance {_id: ProductID, _amount: integer, _chance: number}

-- The ID of a good or service produced.
---@alias ProductID ResourceID

-- A number 0, 1, 2, or 3 (worst to best) of a recipe indicating its efficiency, effectiveness, or capability.
---@alias Grade 0|1|2|3



--#region Public Methods

-- Adds the given building ID to the recipe's list of buildings that can make it.
---@param recipe Recipe
---@param buildingID BuildingID
---@return BuildingID[] buildings
function Recipe.addBuilding(recipe, buildingID)
	table.insert(recipe._buildings, buildingID)
	return recipe._buildings
end

-- Checks if the given ingredient is anywhere in the recipe's ingredient options.
---@param recipe Recipe
---@param ingredientID ResourceID
---@return boolean
---@return integer|nil slotIndex
---@return integer|nil optionIndex
function Recipe.isIngredientInOptions(recipe, ingredientID)
	if not recipe then error("Cannot find ingredient in nil recipe") end
	if not ingredientID then error("Cannot find ingredient using nil ingredientID") end
	for slotIndex, slot in ipairs(recipe._ingredients) do
		for optionIndex, option in ipairs(slot) do
			if option._id == ingredientID then
				return true, slotIndex, optionIndex
			end
		end
	end
	return false, nil, nil
end

-- Gets the array of ingredient options for the given slot.
---@param recipe Recipe
---@param slotIndex integer
---@return IngredientOption[]
function Recipe.getIngredientOptions(recipe, slotIndex)
	return recipe._ingredients[slotIndex]
end

-- Gets the ingredient at the given slot and option index, both the ID and amount.
---@param recipe Recipe
---@param slotIndex integer
---@param optionIndex integer
---@return ResourceID
---@return integer # amount
function Recipe.getIngredient(recipe, slotIndex, optionIndex)
	local ingredientPair = recipe._ingredients[slotIndex][optionIndex]
	return ingredientPair._id, ingredientPair._amount
end

-- Gets the product of the recipe, both the ID and amount.
---@param recipe Recipe
---@return ProductID
---@return integer # amount
function Recipe.getProduct(recipe)
	return recipe._productPair._id, recipe._productPair._amount
end

-- Gets the number of ingredient slots in the recipe.
---@param recipe Recipe
---@return integer
function Recipe.getNumIngredients(recipe)
	if not recipe._ingredients then
		error("Recipe.getNumIngredients cannot work with nil array.")
	end
	local count = 0
	for _ in ipairs(recipe._ingredients) do
		count = count + 1
	end
	return count
end

-- Gets the number of options for the given ingredient slot.
---@param recipe Recipe
---@param slotIndex integer
---@return integer
function Recipe.getNumOptions(recipe, slotIndex)
	if not recipe._ingredients then
		error("Recipe.getNumOptions cannot work with nil array.")
	end
	local count = 0
	for _ in ipairs(recipe._ingredients[slotIndex]) do
		count = count + 1
	end
	return count
end

-- Gets the array of buildings that can make the recipe.
---@param recipe Recipe
---@return BuildingID[]
function Recipe.getBuildings(recipe)
	return recipe._buildings
end

-- Gets the production time of the recipe.
---@param recipe Recipe
---@return number
function Recipe.getTime(recipe)
	return recipe._time
end

-- Gets the production time of the recipe in a clock format.
---@param recipe Recipe
---@return string # formatted as "M:SS"
function Recipe.getTimeClock(recipe)
	local minutes = math.floor((recipe._time or 0) / 60)
	local seconds = (recipe._time or 0) % 60
	return string.format("%d:%02d", minutes, seconds)
end

--#endregion Public Methods



return Recipe
