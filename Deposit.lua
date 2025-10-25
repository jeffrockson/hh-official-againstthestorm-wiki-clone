-- Provides a standard way of interacting with data about glade deposits.
local Deposit = {}

-- A deposit of one type of resource in a glade.
---@class Deposit
---@field _id DepositID Unique ID of the deposit itself.
---@field _displayName string The display name in-game.
---@field _description string The in-game descriptive text, including sprite icons, newlines, and escape characters.
---@field _iconFilename Filename The file name for the icon, including its extension.
---@field _label string Type of deposit as displayed in-game.
---@field _sizeX? integer Width of the deposit.
---@field _sizeY? integer Length of the deposit.
---@field _type DepositType The category of the deposit.
---@field _requiredGrade Grade The minimum grade of building required to harvest from the deposit.
---@field _charges integer Number of times from which the deposit can be harvested before it is depleted.
---@field _chargesAddedPerLevel integer[] When the extracting building is upgraded, this number of charges is added at each level.
---@field _chargesAddedByBonusUpgrade integer[] When the upgrade chosen adds bonus charges only, this number of charges is added *in addition to* `_chargesAddedPerLevel`.
---@field _productPair ProductPair The product and amount of it harvested.
---@field _extraProductChances ExtraProductChance[] Possible extra products that can be harvested.

-- The ID code of a deposit in a glade.
---@alias DepositID string
-- The ID code of a tree (when represented as a deposit).
---@alias TreeID DepositID
-- The ID code of an ore deposit.
---@alias OreID DepositID

-- A number 0, 1, or 2 (smallest to largest) identifying the type of deposit.
---@alias DepositType integer



