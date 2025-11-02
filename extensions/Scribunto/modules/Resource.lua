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

-- The ID and amount of a good or service.
---@alias ResourcePair {_id: ResourceID, _amount: integer}

-- The resource category based on the info bar.<br>
-- Metaresources are categorized with trade goods.
---@enum CategoryResource
local CATEGORY_RESOURCE = {
  Building = "Building Materials",
  Consumable = "Consumable Items",
  Crafting = "Crafting Resources",
  Food = "Food",
  Fuel = "Fuel & Exploration",
  Trade = "Trade Goods"
}



--#region Dependencies

local RESOURCES_DATA_FILE = "Module:Resource/resources_data"

local Wiki_Utility = require("Module:Wiki_Utility")
local icon = Wiki_Utility.renderIcon
local nowrap = Wiki_Utility.surroundWithNoWrap
local wrapClasses = Wiki_Utility.surroundWithClasses
local link = Wiki_Utility.renderWikiLink
local NBSP = Wiki_Utility.NBSP
local standards = Wiki_Utility.StandardizedSizes
local isValidIconSize = Wiki_Utility.isValidIconSize

--#endregion Dependencies



--#region Constants

local MIN_ICON_SIZE = 16

--#endregion Constants



--#region Private Members

---@type Resource[]
local resourceData
---@type table<string, ResourceID>
local mapNamesToIDs

local function data()
  if not resourceData then
    mapNamesToIDs = {}
    resourceData = mw.loadData(RESOURCES_DATA_FILE)
    for id, building in pairs(resourceData) do
      mapNamesToIDs[building._displayName] = id
    end
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

-- Renders a link to the given resource's wiki page.<br>
-- If the specified iconSize is too small, the icon will be ommitted instead of drawn so small as to be unrecognizable.
---@param resource Resource must not be nil
---@param iconSize string|nil size of the icon including units, e.g., "x16px", or nil for default
---@param needsIcon boolean|nil or nil for default
---@param needsText boolean|nil or nil for default
---@return Wikitext wikitext
local function resourceLink(resource, iconSize, needsIcon, needsText)
  iconSize = iconSize or standards.small
  needsIcon = needsIcon or (needsIcon == nil and true)
  needsText = needsText or (needsText == nil and true)
  local wikitext = ""
  local isValidSize, sizeN = isValidIconSize(iconSize)
  if needsIcon and isValidSize and sizeN >= MIN_ICON_SIZE then
    -- Make it a height if it's not already.
    if not iconSize:match("^x") then
      iconSize = "x" .. iconSize
    end
    wikitext = wikitext .. wrapClasses(icon(resource._iconFilename, iconSize, resource._displayName, resource._displayName), "ats-link-resource", sizeN and sizeN < 23 and "ats-flag-small" or nil)
  end
  if (needsIcon and isValidSize and sizeN >= MIN_ICON_SIZE) and needsText then
    wikitext = wikitext .. NBSP
  end
  if needsText then
    wikitext = wikitext .. link(resource._displayName, resource._displayName)
  end
  return nowrap(wikitext)
end

--#endregion Private Methods



--#region Public Methods

-- Checks if the given ID is a valid resource ID.
---@param id ResourceID
---@return boolean
function Resource.isGood(id)
  return data()[id] ~= nil
end

-- Finds a resource's ID by its display name.
---@param displayName string
---@return ResourceID|nil
function Resource.getID(displayName)
  data()
  return mapNamesToIDs[displayName]
end

-- Renders a table of pairs of resource IDs and amounts.
---@param pairsList ResourcePair[] array of pairs of resource IDs and amounts
---@vararg string additional classes to add to the table, if any
---@return Wikitext wikitext
function Resource.tableStack(pairsList, ...)
  local classes = {...}
  local wikitext = "{|" .. ((#classes > 0) and ("class=" .. table.concat(classes, " ")) or "") .. "\n"
  for _, pair in ipairs(pairsList) do
    local resource = data()[pair._id]
    if not resource then return "[Resource table stack ID not found: " .. pair._id .. "]" end
    wikitext = wikitext .. "|-\n"
    wikitext = wikitext .. "| " .. pair._amount .. "\n"
    wikitext = wikitext .. "|style=\"text-align:left;\"| " .. resourceLink(resource, standards.medium, true, true) .. "\n"
  end
  return wikitext .. "|}"
end

-- Renders a link to the given resource's wiki page by its ID.
---@param resourceID ResourceID
---@param iconSize string size of the icon including units, e.g., "x16px"
---@param needsIcon boolean
---@param needsText boolean
---@return Wikitext wikitext
function Resource.resourceLinkByID(resourceID, iconSize, needsIcon, needsText)
  return resourceLink(data()[resourceID], iconSize, needsIcon, needsText)
end

-- Resource_link template invokes this method from MediaWiki.
---@param frame Frame MediaWiki template context
---@return Wikitext wikitext wikitext markup to link to the resource's wiki page
function Resource.link(frame)
  local name = frame.args.name or ""
  if name == "" then
    return "[Resource Link needs resource name]"
  end
  local iconSize = standards[frame.args.icon] or frame.args.icon or ""
  local needsIcon = iconSize ~= "none"
  -- Check if the size string is valid and doesn't represent a negative or too-large number.
  if needsIcon and not isValidIconSize(iconSize) then
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
  return resourceLink(resource, iconSize, needsIcon, needsText)
end

--#endregion Public Methods



return Resource