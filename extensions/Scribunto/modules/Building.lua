-- Provides a standard way of interacting with common building data.<br>
-- This means that every building *must* contain the underlying data accessed by these getters, and getting anything specific to the different kinds of buildings is not available from this module.<br>
local Building = {}

-- A single building with generic attributes like ID, name, category, etc.
---@class Building
---@field _id BuildingID Unique ID code of the building.
---@field _displayName string The display name in-game.
---@field _description string The in-game descriptive text, including sprite icons, newlines, and escape characters.
---@field _iconFilename Filename The file name of the icon, including its extension.
---@field _category CategoryConstruction Construction type from the construction toolbar, or non-buildable type.
---@field _categoryDisplay CategoryDisplay Type of building displayed in the in-game info box.
---@field _sizeX integer Width of the building.
---@field _sizeY integer Length of the building.
---@field _constructionCost RequiredGoodPair[] List of goods required for construction (array may be empty if it's free).
---@field _constructionTime integer Seconds.
---@field _cityScore integer Points awarded for each building in the settlement.
---@field _isMovable boolean `true` if the building can be moved after being built.
---@field _isInitiallyEssential boolean `false` for everything that isn't unlocked on a new profile, which is almost everything.
---@field _workerCapacity integer Max number of workers (may be zero).
---@field _tags Specialization[] List of any specializations (array may be empty).
---@field _storage? integer Number of goods that can be temporarily stored, if any, before any perks.
---@field _waterUsed? WaterID Type of water used in the building, if any.
---@field _levels? Level[] List of upgrades, if any.
---@field _recipes? Recipe[] Recipes available, if any.

-- A unique identifier for a building.
---@alias BuildingID string

-- An ID and amount of a good (e.g., for construction or upgrades).
---@alias RequiredGoodPair {_id: ResourceID, _amount: integer}

-- An ID of a water type.
---@alias WaterID ResourceID

-- An upgrade level for a building.
---@alias Level {_upgradeCostOptions: UpgradeCost[], _upgrades: UpgradeID[]}
-- An ID of an upgrade.
---@alias UpgradeID string
-- One payment option for an upgrade (player chooses one from multiple UpgradeCosts).
---@alias UpgradeCost RequiredGoodPair[]

-- The construction category of the building from the construction toolbar.<br>
-- This is a complete list for coding/IDE purposes, because the `Building` interface provides access to the category field.<br>
-- However, the `Building` interface *does not* provides access to data for buildings of all categories.
---@enum CategoryConstruction
local CATEGORY_CONSTRUCTION = {
  -- Buildings with recipes and workers
  City = "City Buildings",
  Food = "Food Production",
  Industry = "Industry",
  Resource = "Resource Acquisition",
  -- Buildings without recipes
  Decorations = "Decorations",
  Housing = "Housing",
  Roads = "Roads",
  -- Non-buildable
  Glade = "Glade Event",
  Lore1 = "Lore Tablet I",
  Lore2 = "Lore Tablet II",
  Lore3 = "Lore Tablet III",
  Lore4 = "Lore Tablet IV",
  Lore5 = "Lore Tablet V",
  Lore6 = "Lore Tablet VI",
  Lore7 = "Lore Tablet VII",
  Relic = "Ancient Relic",
}

-- The type of building displayed in the game in the info box.<br>
-- These are assigned based on which data file the building is loaded from, by its respective preprocessor script.
---@enum CategoryDisplay
local CATEGORY_DISPLAY = { -- for all buildings from...
  "Decoration", -- decorations
  "Extraction Building", -- extractors, rain catchers
  "Farm", -- farms
  "Fishing Hut", -- fishing huts
  "Gathering Camp", -- camps, gathering huts
  "Hearth", -- hearths
  "Production Building", -- workshops
  "Service Building", -- institutions
  "Storage Building" -- storages
}

-- The affinity of the building for different species. Probably should be separated into its own module.
---@enum Specialization
local SPECIALIZATION = {
  Alchemy = "Alchemy",
  Animals = "Animals",
  Brewing = "Brewing",
  Cooperation = "FoxesCooperation",
  Engineering = "Tech",
  Farming = "Farming",
  Forest = "Forest",
  Masonry = "Stone",
  Metallurgy = "Metallurgy",
  Rainwater = "Rainwater",
  Tailoring = "Cloth",
  Warmth = "Warmth",
  Woodworking = "Woodworking",
}

--#region Dependencies

-- List of data filenames, in order of likelihood of use.
local BUILDING_DATA_FILES = {
  "Module:Workshop/workshops_data",
  "Module:ServiceBuilding/service_buildings_data",
  "Module:Farm/farms_data",
  "Module:Camp/gathering_huts_data",
  "Module:Camp/camps_data",
  "Module:House/houses_data",
  "Module:FishingHut/fishing_huts_data",
  "Module:Mine/mines_data",
  "Module:BlightPost/blight_posts_data",
  "Module:RainCollector/rain_collectors_data",
  "Module:Pump/pumps_data",
  "Module:Hearth/hearths_data",
  "Module:Warehouse/warehouses_data",
  "Module:Farm/farm_fields_data",
  "Module:Glade/glade_events_data",
}

local Wiki_Utility = require("Module:Wiki_Utility")
local icon = Wiki_Utility.renderIcon
local nowrap = Wiki_Utility.surroundWithNoWrap
local classes = Wiki_Utility.surroundWithClasses
local link = Wiki_Utility.renderWikiLink
local NBSP = Wiki_Utility.NBSP
local standards = Wiki_Utility.StandardizedSizes
local isValidIconSize = Wiki_Utility.isValidIconSize

--#endregion Dependencies

--#region Constants

local MIN_ICON_SIZE = 20

--#endregion Constants

--#region Private Members

---@type table<BuildingID, Building>
local buildingData
---@type table<string, BuildingID>
local mapNamesToIDs

-- Loads the building data from the data files in sequence.<br>
-- Also populates the map of display names to IDs.<br>
-- I attempted to do this by lazy loading, but it would have required stateful code that would have been a lot more difficult to understand, troubleshoot, and maintain. If there is a noticeable performance issue, that would be a good first place to start.
---@return table<BuildingID, Building> buildingData
---@return table<string, BuildingID> mapNamesToIDs
local function data()
  if not buildingData then
    buildingData = {}
    mapNamesToIDs = {}
    for _, datafile in ipairs(BUILDING_DATA_FILES) do
      local dataTable = mw.loadData(datafile)
      for id, building in pairs(dataTable) do
        buildingData[id] = building
        mapNamesToIDs[building._displayName] = id
      end
    end
  end
  return buildingData, mapNamesToIDs
end

-- Finds a building by its display name.
---@param buildingName string display name of the building
---@return Building|nil foundBuilding
local function findName(buildingName)
  data()
  local foundID = mapNamesToIDs[buildingName]
  return foundID and buildingData[foundID]
end

-- Renders a link to the given building's wiki page.<br>
-- The size of the icon will be used as the *height* of the icon.<br>
-- If the specified iconSize is too small, the icon will be ommitted instead of drawn so small as to be unrecognizable.
---@param building Building must not be nil
---@param iconSize string size of the icon including any units, e.g., `20em` or `x16px` or assumes `px` if no units
---@param needsIcon boolean
---@param needsText boolean
---@param needsPlural boolean
---@param pluralForm string|nil the plural form specified by the author, or nil if `needsPlural` is false
---@return Wikitext wikitext
function Building.buildingLink(building, iconSize, needsIcon, needsText, needsPlural, pluralForm)
  local wikitext = ""
  local isValidSize, sizeN = isValidIconSize(iconSize)
  if needsIcon and isValidSize and sizeN >= MIN_ICON_SIZE then
    -- Make it a height if it's not already.
    if not iconSize:match("^x") then
      iconSize = "x" .. iconSize
    end
    wikitext = wikitext .. classes(icon(building._iconFilename, iconSize, building._displayName, building._displayName), "ats-link-building", sizeN and sizeN < 23 and "ats-flag-small" or nil)
  end
  if (needsIcon and isValidSize and sizeN >= MIN_ICON_SIZE) and needsText then
    wikitext = wikitext .. NBSP
  end
  if needsText then
    local displayName = building._displayName
    if needsPlural then
      if pluralForm == "s" or pluralForm == "es" then
        displayName = displayName .. pluralForm
      else
        displayName = displayName:gsub("y$", "ies")
      end
    end
    wikitext = wikitext .. link(building._displayName, displayName)
  end
  return nowrap(wikitext)
end

-- Looks at the arguments to the original template to see if the author asked for a plural form.
---@param frame Frame MediaWiki template context
---@return boolean needsPlural
---@return string|nil pluralForm the plural form specified by the author
local function checkPlural(frame)
  if not frame:getParent() then return false end
  local parentArgs = frame:getParent().args
  for _, arg in pairs(parentArgs) do
    -- All we need is whether one of them is exactly "s" or "es" or "ies".
    if arg == "s" then return true, arg end
    if arg == "es" then return true, arg end
    if arg == "ies" then return true, arg end
  end
  return false
end

--#endregion Private Members

--#region Public Methods

-- Building_link template invokes this method from MediaWiki.
---@param frame Frame MediaWiki template context
---@return Wikitext wikitext wikitext markup to link to the building's wiki page
function Building.link(frame)
  local name = frame.args.name or ""
  if name == "" then
    return "[Building Link needs building name]"
  end
  local iconSize = standards[frame.args.icon] or frame.args.icon or ""
  local needsIcon = iconSize ~= "none"
  -- If one of these was assigned into icon arg it was meant as the plural arg.
  -- Unset needsIcon because buildings get no icon by default.
  if iconSize == "s" or iconSize == "es" or iconSize == "ies" then
    needsIcon = false
  end
  -- Check if the size string is valid and doesn't represent a negative or too-large number.
  if needsIcon and not isValidIconSize(iconSize) then
    return "[Building Link size not valid: " .. iconSize .. "]"
  end
  local display = frame.args.display or ""
  if display ~= "" and display ~= "notext" then
    return "[Building Link display override not supported: " .. display .. "]"
  end
  local needsText = display ~= "notext"
  local needsPlural, pluralForm = checkPlural(frame)
  local building = findName(name)
  if not building then
    return "[Building not found: " .. name .. "]"
  end
  return Building.buildingLink(building, iconSize, needsIcon, needsText, needsPlural, pluralForm)
end

--#endregion Public Methods

return Building
