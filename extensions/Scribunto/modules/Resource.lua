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
  Trade = "Trade Goods"
}

--#region Dependencies


local Wiki_Utility = require("Module:Wiki_Utility")
local icon = Wiki_Utility.renderIcon
local nowrap = Wiki_Utility.surroundWithNoWrap
local classes = Wiki_Utility.surroundWithClasses
local link = Wiki_Utility.renderWikiLink
local NBSP = Wiki_Utility.NBSP

--#endregion Dependencies

--#region Private Members

---@type Resource[]
local resourceData = nil


local function data()
  if not resourceData then
    resourceData = mw.loadData("Module:Resource/resources_data")
  end
  return resourceData
end

-- Finds a resource by its display name.
---@param resourceName string display name of the resource
---@return Resource|nil foundResource or nil if not found
local function findName(resourceName)
  local foundResource = nil
  for _, resource in pairs(data()) do
    if resource._displayName == resourceName then
      foundResource = resource
      break
    end
  end
  return foundResource
end

-- Renders a link to the given resource's wiki page.
---@param resource Resource must not be nil
---@param iconSize string size of the icon including units, e.g., "x16px"
---@param needsIcon boolean
---@param needsText boolean
---@return Wikitext wikitext
---@private
function Resource.resourceLink(resource, iconSize, needsIcon, needsText)
  local wikitext = ""
  if needsIcon then
    wikitext = wikitext .. classes(icon(resource._iconFilename, iconSize, resource._displayName, resource._displayName), "ats-link-resource")
  end
  if needsIcon and needsText then
    wikitext = wikitext .. NBSP
  end
  if needsText then
    wikitext = wikitext .. link(resource._displayName, resource._displayName)
  end
  return nowrap(wikitext)
end

--#endregion Private Methods

--#region Public Methods

-- Resource_link template invokes this method from MediaWiki.
---@param frame Frame MediaWiki template context
---@return Wikitext wikitext wikitext markup to link to the resource's wiki page
function Resource.link(frame)
  local name = frame.args.name or ""
  if name == "" then
    return "[Resource Link needs resource name]"
  end
  local standardizedSizes = {
    ["small"] = "x16px",
    ["medium"] = "x30px",
    ["large"] = "x60px",
    ["huge"] = "x84px"
  }
  local iconSize = standardizedSizes[frame.args.icon] or frame.args.icon or ""
  local needsIcon = iconSize ~= "none"
  if needsIcon and not iconSize:match("^x[0-9]+px$") then
    return "[Resource Link size not valid: " .. iconSize .. "]"
  end
  local display = frame.args.display or ""
  if display ~= "" and display ~= "notext" then
    return "[Resource Link display override not supported: " .. display .. "]"
  end
  local needsText = display ~= "notext"
  local resource = findName(name)
  if not resource then
    return "[Resource not found: " .. name .. "]"
  end
  return Resource.resourceLink(resource, iconSize, needsIcon, needsText)
end

--#endregion Public Methods

return Resource