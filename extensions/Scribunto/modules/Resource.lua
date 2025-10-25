-- Provides a standard way of interacting with data about goods, resources, and metaresources.
local Resource = {}

-- A single resource with attributes like ID, name, category, etc.
---@class Resource
---@field _id ResourceID Unique ID code of the resource.
---@field _displayName string The display name in-game.
---@field _description string The in-game descriptive text, including sprite icons, newlines, and escape characters.
---@field _iconFilename Filename The file name of the icon for this resource.
---@field _category CategoryResource Resource type from the info bar.
---@field _isEatable boolean `true` if the resource satisfies s villager's need for food.
---@field _isBurnable boolean `true` if the resource can be burned or sacrificed in a hearth.
---@field _burningTime integer Base number of seconds the item burns, or zero if it is not burnable, before any upgrades.
---@field _tradingSellValue Amber Base value when selling to traders, before any upgrades.
---@field _tradingBuyValue Amber Base cost when buying from traders, before any upgrades.

-- The ID code of a good or resource.
---@alias ResourceID string

-- Currency in-game.
---@alias Amber number

-- The resource category based on the info bar.<br>
-- Metaresources are categorized with trade goods.
---@enum CategoryResource
local CATEGORY_RESOURCE = {
  -- Resources in the info bar.
  Building = "Building Materials",
  Consumable = "Consumable Items",
  Crafting = "Crafting Resources",
  Food = "Food",
  Fuel = "Fuel & Exploration",
  Trade = "Trade Goods",
}



local resourceData
function load()
  if not resourceData then
    resourceData = mw.loadData("resources_data.lua")
  end
  return resourceData
end




-- Resource_link template invokes this method from MediaWiki.
---@param frame Frame calling context
---@return string wikitext
function Resource.link(frame)

  local wikitext = Resource.makeLink(resourceID, iconSize, displayMode)
end

-- Generates a link to the 
function Resource.makeLink(resourceID, iconSize, displayMode)
  local resource = load()[resourceID]
  print(resource)
end

Resource.makeLink("")