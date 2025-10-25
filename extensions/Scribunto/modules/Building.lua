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
  "Alchemy",
  "Animals",
  "Brewing",
  "Cloth",
  "Farming",
  "FoxesCooperation",
  "Metallurgy",
  "Rainwater",
  "Stone",
  "Tech",
  "Warmth",
  "Wood"
}

