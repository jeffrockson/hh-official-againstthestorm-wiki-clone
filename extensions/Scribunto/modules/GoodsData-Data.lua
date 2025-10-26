local CsvUtils = require("Module:CsvUtils")
local DATA_TEMPLATE_NAME = "Template:Goods_csv"

local VALUE_DIVISOR = 12

local INDEX_ID = "id"
local INDEX_NAME = "displayName"
local INDEX_DESCRIPTION = "description"
local INDEX_CATEGORY = "category"
local INDEX_EATABLE = "eatable"
local INDEX_BURNABLE = "canBeBurned"
local INDEX_BURN_TIME = "burningTime"
local INDEX_SELL_VALUE = "tradingSellValue"
local INDEX_BUY_VALUE = "tradingBuyValue"
local INDEX_ICON_FILENAME = "iconName"

local PATTERN_TUTORIAL = "tutorial"
mapNamesToIDs = {}

local function restructureGoodsTable(originalGoodsTable)

	-- A few constants we'll need only within this function.
	local DATA_ROWS = 2
	local INDEX_ORIGINAL_ID = 1
	local INDEX_ORIGINAL_NAME = 2
	local INDEX_ORIGINAL_DESCRIPTION= 3
	local INDEX_ORIGINAL_CATEGORY = 4
	local INDEX_ORIGINAL_EATABLE = 5
	local INDEX_ORIGINAL_BURNABLE = 6
	local INDEX_ORIGINAL_BURN_TIME = 7
	local INDEX_ORIGINAL_SELL_VALUE = 8
	local INDEX_ORIGINAL_BUY_VALUE = 9
	local INDEX_ORIGINAL_ICON_FILENAME = 10

	local newGoodsTable = {}
	for _, originalGood in ipairs(originalGoodsTable[DATA_ROWS]) do

		-- Skip over any rows where the ID contains the tutorial term.
		if not string.find(originalGood[INDEX_ORIGINAL_ID], PATTERN_TUTORIAL) then
			-- Copy over the content, mapping unhelpful indexes into headers keys.
			local newGood = {}
			newGood[INDEX_ID] = originalGood[INDEX_ORIGINAL_ID]
			newGood[INDEX_NAME] = originalGood[INDEX_ORIGINAL_NAME]
			newGood[INDEX_DESCRIPTION] = originalGood[INDEX_ORIGINAL_DESCRIPTION]
			newGood[INDEX_CATEGORY] = originalGood[INDEX_ORIGINAL_CATEGORY]
			newGood[INDEX_EATABLE] = originalGood[INDEX_ORIGINAL_EATABLE] == "True"
			newGood[INDEX_BURNABLE] = originalGood[INDEX_ORIGINAL_BURNABLE] == "True"
			if newGood[INDEX_BURNABLE] then
				newGood[INDEX_BURN_TIME] = tonumber(originalGood[INDEX_ORIGINAL_BURN_TIME])
			else
				newGood[INDEX_BURN_TIME] = 0
			end
			newGood[INDEX_SELL_VALUE] = tonumber(originalGood[INDEX_ORIGINAL_SELL_VALUE]) / VALUE_DIVISOR
			newGood[INDEX_BUY_VALUE] = tonumber(originalGood[INDEX_ORIGINAL_BUY_VALUE]) / VALUE_DIVISOR
			newGood[INDEX_ICON_FILENAME] = originalGood[INDEX_ORIGINAL_ICON_FILENAME] .. ".png"

			-- Also populate the map for looking up IDs with display names
			mapNamesToIDs[newGood[INDEX_NAME]] = newGood[INDEX_ID]

			newGoodsTable[newGood[INDEX_ID]] = newGood
		end
	end

	return newGoodsTable
end

-- Utility module retrieves the data as basic, flat lua tables. We don't
-- need to use the header lookup table that's returned with the data table.
local originalGoodsTable, _ = CsvUtils.extractTables(DATA_TEMPLATE_NAME)

-- Now restructure to be more conducive for data about goods.
goodsTable = restructureGoodsTable(originalGoodsTable)

return {goodsTable, mapNamesToIDs}