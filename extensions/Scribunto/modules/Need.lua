-- Provides a standard way of interacting with data about needs and services.
local Need = {}

-- A single need with attributes like ID, name, category, etc.
---@class Need
---@field _id NeedID Unique ID code of the need.
---@field _displayName NeedName The display name in-game.
---@field _description string The in-game descriptive text, including sprite icons, newlines, and escape characters.
---@field _iconFilename Filename The file name of the icon for this resource.
---@field _category CategoryResource Resource type from the info bar.
---@field _isAtHearth boolean `true` if the need is fulfilled at the hearth.

-- The ID code of a need or service.
---@alias NeedID NeedID

-- The display name of a need or service.
---@alias NeedName string

-- The ID and amount of a need or service.
---@alias NeedPair {_id: NeedID, _amount: integer}

-- The ID code of a service, specifically.
---@alias ServiceID NeedID

-- The display name of a service.
---@alias ServiceName NeedName

-- The ID and amount of a service, although I can't imagine this being anything but 1.
---@alias ServicePair {_id: ServiceID, _amount: integer}


-- The need category based on the species needs.
---@enum CategoryNeed
local CATEGORY_NEED = {
  Housing = "Housing",
  Food = "Complex Food",
  Clothing = "Clothing",
  Services = "Services",
}



--#region Dependencies

local NEEDS_DATA_FILE = "Module:Need/needs_data"

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

---@type table<NeedID, Need>
local needData
---@type table<string, NeedID>
local mapNamesToIDs

local function data()
  if not needData then
    needData = mw.loadData(NEEDS_DATA_FILE)
    mapNamesToIDs = {}
    for id, need in pairs(needData) do
      mapNamesToIDs[need._displayName] = id
    end
  end
  return needData
end

-- Finds a need by its display name.
---@param needName NeedName display name of the need
---@return Need|nil foundNeed
local function findName(needName)
  data()
  local foundID = mapNamesToIDs[needName]
  return foundID and needData[foundID] or nil
end

-- Renders a link to the given need's wiki page.<br>
-- If the specified iconSize is too small, the icon will be ommitted instead of drawn so small as to be unrecognizable.
---@param need Need must not be nil
---@param iconSize string|nil size of the icon including any units, e.g., `20em` or `x16px`, or nil for default
---@param needsIcon boolean|nil or nil for default
---@param needsText boolean|nil or nil for default
---@return Wikitext wikitext
local function needLink(need, iconSize, needsIcon, needsText)
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
    wikitext = wikitext .. wrapClasses(icon(need._iconFilename, iconSize, need._displayName, need._displayName), "ats-link-resource", sizeN and sizeN < 23 and "ats-flag-small" or nil)
  end
  if (needsIcon and isValidSize and sizeN >= MIN_ICON_SIZE) and needsText then
    wikitext = wikitext .. NBSP
  end
  if needsText then
    wikitext = wikitext .. link(need._displayName, need._displayName)
  end
  return nowrap(wikitext)
end

--#endregion Private Members



--#region Public Methods

-- Checks if the given ID is a valid need ID.
---@param id NeedID
---@return boolean
function Need.isNeed(id)
  return data()[id] ~= nil
end

-- Finds a need's ID by its display name.<br>
-- Service buildings' recipes currently are indexed by name, not ID, so if the map returns nil, check 
---@param displayName NeedName
---@return NeedID|nil
function Need.getID(displayName)
  data()
  return mapNamesToIDs[displayName]
end

-- Gets the specified need's display name.
---@param id NeedID
---@return NeedName
function Need.getName(id)
  return data()[id]._displayName
end

-- Renders a link to a need using its ID.
---@param needID NeedID
---@param iconSize string|nil size of the icon including any units, e.g., `20em` or `x16px`, or nil for default
---@param needsIcon boolean|nil or nil for default
---@param needsText boolean|nil or nil for default
---@return Wikitext wikitext
function Need.needLinkByID(needID, iconSize, needsIcon, needsText)
  return needLink(data()[needID], iconSize, needsIcon, needsText)
end

-- Need_link template invokes this method from MediaWiki.
---@param frame Frame MediaWiki template context
---@return Wikitext wikitext wikitext markup to link to the need's wiki page
function Need.link(frame)
  local name = frame.args.name or ""
  if name == "" then
    return "[Need Link needs need name]"
  end
  local iconSize = standards[frame.args.icon] or frame.args.icon or ""
  local needsIcon = iconSize ~= "none"
  -- Check if the size string is valid and doesn't represent a negative or too-large number.
  if needsIcon and not isValidIconSize(iconSize) then
    return "[Need Link size not valid: " .. iconSize .. "]"
  end
  local display = frame.args.display or ""
  if display ~= "" and display ~= "notext" then
    return "[Need Link display override not supported: " .. display .. "]"
  end
  local needsText = display ~= "notext"
  local need = findName(name)
  if not need then
    return "[Need not found: " .. name .. "]"
  end
  return needLink(need, iconSize, needsIcon, needsText)
end

--#endregion Public Methods



return Need