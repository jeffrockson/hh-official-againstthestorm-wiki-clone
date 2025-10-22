---
--- Module for compiling goods (or resources as some call them) information
--- from wiki data sources. Restructures the flat data tables that are produced
--- from CsvUtils to make them more conducive to Lua methods that need to
--- display the information.
---
--- The standard way of using this module is a call like the following:
---
--- iconFilename = GoodsData.getGoodIcon(goodName)
---
--- This will return a string corresponding to the filename of the good. It is
--- preferable to call the getter methods with the name of the good rather than
--- retrieving the entire record for the good, so that your code stays
--- protected from any variations in this module. These getter methods are all
--- called with the plain-language name of the good, as spelled in the game.
---
--- * longDescription = GoodsData.getGoodDescription(goodName)
--- * inventoryCategory = GoodsData.getGoodCategory(goodName)
--- * isEatable = GoodsData.isGoodEatable(goodName)
--- * isBurnable = GoodsData.isGoodBurnable(goodName)
--- * burnSeconds = GoodsData.getGoodBurnTime(goodName)
--- * amberSellValue, amberBuyValue = GoodsData.getGoodValue(goodName)
--- * iconFilename = GoodsData.getGoodIcon(goodName)
---
--- And these getter methods are all called with the good's ID. You will have
--- an ID instead of a display name when dealing with other game data like
--- recipes, workshops, etc.
--- * name = GoodsData.getGoodNameByID(goodID)
--- * iconFilename = GoodsData.getGoodIconByID(goodID)
---
--- As a last resort, or if you need to transform the data structure, you can
--- call the method getAllDataForGood(displayName) or
--- getAllDataForGoodByID(goodID). This returns a whole record from the data
--- table corresponding to the requested display name.
---
--- The data table for goods has the following structure:
---
--- goodsTable = {
---		["good1_ID"] = {
--- 		["id"] = "good1_ID",
--- 		["displayName"] = "Plain Language Name",
--- 		["description"] = "A long string with some HTML entities too.",
--- 		["category"] = "Inventory category",
--- 		["eatable"] = true or false if food
---			["canBeBurned"] = true or false if fuel and sacrifice
---			["burningTime"] = 99, number of seconds
--- 		["tradingSellValue"] = 99.99, in amber
--- 		["tradingBuyValue"] = 99.99, in amber
--- 		["iconName"] = "Icon_Resource_filename.png" including PNG extension
---		},
--- 	["good2_ID"] = {
---			...
--- 	},
--- 	["good3_ID"] = {
---			...
--- 	},
--- 	...
--- }
---
--- @module GoodsData
local GoodsData = {}



local CsvUtils = require("Module:CsvUtils")



--region Private member variables

--- Main data table, like this: table[ID] = table containing data for that ID.
--- This needs to be indexed by ID because IDs are guaranteed to be unique.
local goodsTable

--- Lookup map. Built once and reused on all subsequent calls within this
--- session, like this: table[displayName] = goodID
local mapNamesToIDs

--endregion



--region Private constants

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

--endregion



--region Private methods

---
--- Since the goods information is already flat and well structured, all this has
--- to do is swap out the integer keys for the good IDs and only return the data
--- rows, without the header row.
---
--- @param originalGoodsTable table of CSV-based data, with header row, data rows
--- @return table with new structure with IDs as keys
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

	mapNamesToIDs = {}

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



---
--- Data loader function that uses the utility module and restructures the data
--- to be easier to access for invoking methods and later method calls. This
--- method is automatically called by all public member functions if the main
--- data table has not yet been populated in the current session.
local function loadData()
	
	-- Utility module retrieves the data as basic, flat lua tables. We don't
	-- need to use the header lookup table that's returned with the data table.
	--local originalGoodsTable, _ = CsvUtils.extractTables(DATA_TEMPLATE_NAME)
	
	-- Now restructure to be more conducive for data about goods.
	local allTables = mw.loadData("Module:GoodsData/Data")
	goodsTable = allTables[1]
	mapNamesToIDs = allTables[2]
	
	
end

local function load()

	if not goodsTable then
		loadData()
	end
end



---
--- Uses the display name, which people are more familiar with, to find the
--- encoded ID of the good. Useful for retrieving good data that is indexed by
--- ID.
---
--- Returns nil if the good with the specified name is not found.
---
--- @param displayName string plain-language name of the good to find
--- @return string ID of the good found, or nil if not found
local function findGoodIDByName(displayName)

	-- At runtime, this should never be nil or empty, so throw an error.
	if not displayName or displayName == "" then
		error("Parameter is nil or empty for the good's name: " .. displayName .. ".")
	end

	if not goodsTable then
		loadData()
	end

	return mapNamesToIDs[displayName]
end

--endregion



--region Public methods

---
--- Retrieve the whole table of data for the specified good. Instead of this,
--- you should probably be calling the individual getter methods.
---
--- Throws an error if called with nil or empty string. Returns nil if the
--- specified good cannot be found.
---
--- @param goodID string the ID of the good
--- @return table containing the data for the specified good with key-value pairs, or nil if not found
function GoodsData.getAllDataForGoodByID(goodID)

	-- At runtime, this should never be nil or empty.
	if not goodID or goodID == "" then
		error("Parameter is nil or empty for the good's ID.")
	end

	if not goodsTable then
		loadData()
	end

	return goodsTable[goodID]
end



---
--- Retrieve the whole table of data for the specified good. Instead of this,
--- you should probably be calling the individual getter methods.
---
--- Throws an error if called with nil or empty string. Returns nil if the
--- specified good cannot be found.
---
--- @param displayName string plain language name of the good
--- @return table containing the data for the specified good with key-value pairs, or nil if not found
function GoodsData.getAllDataForGood(displayName)

	-- At runtime, this should never be nil or empty.
	if not displayName or displayName == "" then
		error("Parameter is nil or empty for the good's name.")
	end

	if not goodsTable then
		loadData()
	end

	local goodID = findGoodIDByName(displayName)
	if not goodID then
		return nil
	end

	return goodsTable[goodID]
end



---
--- Retrieves the ID for the good specified by its plain language display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the plain language name of the good
---@return string the good's ID
function GoodsData.getGoodID(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_ID]
end



---
--- Retrieves the description for the good specified by its plain language
--- display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the plain language name of the good
---@return string the in-game description of the specified good
function GoodsData.getGoodDescription(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_DESCRIPTION]
end



---
--- Retrieves the inventory category for the good specified by its plain
--- language display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the plain language name of the good
---@return string the category
function GoodsData.getGoodCategory(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_CATEGORY]
end



---
--- Retrieves whether the good is eatable, specified by its plain language
--- display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the plain language name of the good
---@return boolean true if the good counts as food
function GoodsData.isGoodEatable(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_EATABLE]
end



---
--- Retrieves whether the good is burnable, specified by its plain language
--- display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the plain language name of the good
---@return boolean true if the good counts as fuel
function GoodsData.isGoodBurnable(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_BURNABLE]
end



---
--- Retrieves the burn time for the good specified by its plain language
--- display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the plain language name of the good
---@return number of seconds the good burns as fuel
function GoodsData.getGoodBurnTime(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_BURN_TIME]
end



---
--- Retrieves the trading value for the good specified by its plain language
--- display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the plain language name of the good
---@return number of amber the good sells for
---@return number of amber required to buy the good
function GoodsData.getGoodValue(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_SELL_VALUE], good[INDEX_BUY_VALUE]
end



---
--- Retrieves the icon filename for the good specified by its plain language
--- display name.
---
--- Returns nil if the good named was not found.
---
---@param displayName string the the plain language name of the good
---@return string the filename of the icon for the specified good
function GoodsData.getGoodIcon(displayName)

	local good = GoodsData.getAllDataForGood(displayName)

	if not good then
		return nil
	end

	return good[INDEX_ICON_FILENAME]
end



---
--- Retrieves the plain-language display name for the good specified by its ID.
---
--- Returns nil if the good named was not found.
---
---@param goodID string the ID of the good
---@return string the plain language name of the good
function GoodsData.getGoodNameByID(goodID)

	-- Rather than getting it directly from goodsTable here, get it via this
	-- other method that has additional error checking.
	local good = GoodsData.getAllDataForGoodByID(goodID)

	if not good then
		return nil
	end

	return good[INDEX_NAME]
end



---
--- Retrieves the icon filename for the good specified by its ID.
---
--- Returns nil if the good named was not found.
---
---@param goodID string the ID of the good
---@return string the filename of the icon for the specified good
function GoodsData.getGoodIconByID(goodID)

	-- Rather than getting it directly from goodsTable here, get it via this
	-- other method that has additional error checking.
	local good = GoodsData.getAllDataForGoodByID(goodID)

	if not good then
		return nil
	end

	return good[INDEX_ICON_FILENAME]
end




--Goods interface
-- getName
-- getCategory
-- getDescription
-- getIcon
-- getBurnTime
-- getSellValue
-- getSellValueAfterPrestigePenalty
-- getBuyValue
function GoodsData.getName(id)
	load()
	return goodsTable[id] ~= nil and goodsTable[id][INDEX_NAME]
end

function GoodsData.getCategory(id)
	load()
	return goodsTable[id] ~= nil and goodsTable[id][INDEX_CATEGORY]
end

function GoodsData.getDescription(id)
	load()
	return goodsTable[id] ~= nil and goodsTable[id][INDEX_DESCRIPTION]
end

function GoodsData.getIcon(id)
	load()
	return goodsTable[id] ~= nil and goodsTable[id][INDEX_ICON_FILENAME]
end

function GoodsData.getBurnTime(id)
	load()
	return goodsTable[id] ~= nil and goodsTable[id][INDEX_BURN_TIME]
end

function GoodsData.getSellValue(id)
	load()
	local value = goodsTable[id][INDEX_SELL_VALUE]
	return goodsTable[id] ~= nil and tonumber(string.format("%.2f", value))
end

function GoodsData.getSellValueAfterPrestigePenalty(id)
	load()
	local value = goodsTable[id][INDEX_SELL_VALUE] / 2
	return goodsTable[id] ~= nil and tonumber(string.format("%.2f", value))
end

function GoodsData.getBuyValue(id)
	load()
	local value = goodsTable[id][INDEX_BUY_VALUE]
	return goodsTable[id] ~= nil and tonumber(string.format("%.2f", value))
end



--endregion

return GoodsData
