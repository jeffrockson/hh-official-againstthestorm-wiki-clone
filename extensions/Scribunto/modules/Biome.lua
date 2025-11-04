-- Provides an interface standard way of interacting with data about biomes.
local Biome = {}

-- A biome in the world that defines the environmental attributes of the areas in which settlements can be founded.
---@class Biome
---@field _id BiomeID Unique identifier of the biome.
---@field _displayName string The name displayed in-game.
---@field _description string The in-game descriptive text, including sprite icons, newlines, and escape characters.
---@field _iconFilename Filename The file name for the icon, including its extension.
---@field _dlc DLCName The expansion required to play the biomes or the base game.
---@field _soilGrade BiomeSoilType The amount of fertile soil in the biome.
---@field _deposits DepositID[] The deposits that can appear in the biome's glades.
---@field _trees TreeID[] The trees that can grow.
---@field _ores OreID[] The ores that can appear in the biome's glades.
---@field _effects EffectID[] The permanent biome effects or perks.
---@field _townType string The descriptive name of the type of town founded in the biome, as seen in trade routes.
---@field _tradeRouteResources ResourceID[] The possible resources that other towns in this biome want, which you can sell via trade routes to them.

-- The unique ID code for a biome.
---@alias BiomeID string

-- The expansion and base game identifiers that govern access to game content.
---@enum DLCName
local DLC_NAME = {
  "None",
  "Frogs",
  "Bats"
}

-- The amount of fertile soil in the biome.
---@enum BiomeSoilType
local BIOME_SOIL_TYPE = {
  None = "None",
  Small = "Small Amount",
  Average = "Average Amount"
}




