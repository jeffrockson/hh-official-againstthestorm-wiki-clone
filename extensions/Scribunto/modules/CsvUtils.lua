---
--- The CsvUtils module loads, processes, and returns data that is stored in CSV
--- format in wiki templates.
---
--- There can be documentation in the template, and this module will
--- automatically remove it, provided it is enclosed in a <noinclude> block. The
--- CSV data itself must be wrapped in a <pre> block in order to protect line
--- breaks. The <pre> block will also be removed. This module also provides a
--- parsing method to convert well-structured CSV data into a Lua table.
---
--- The CSV data must be well structured. The header row cannot have empty names,
--- and all lines must end with a comma.
---
--- The standard way of using this module is a call like the following:
---
--- dataTable, headerLookupTable = CsvUtils.extractTables(DATA_TEMPLATE_NAME)
---
--- This is a shortcut method for the other two: extractCSV and luaTableFromCSV.
--- The extractCSV method loads the template and removes all surrounding
--- documentation. It returns a very long string of CSV data, including newlines.
--- The luaTableFromCSV method takes that string and parses it, splitting it
--- into a header row and data rows, and each row into fields. It returns the
--- data itself and a lookup table with header names, allowing constant time
--- lookup of indexes in the data table from string names of the headers. In
--- other words, if you know the column has the header "constructionTime", then
--- if the data at index 10 stores the value for constructionTime, 45s:
---
--- headerLookupTable["constructionTime"] = 10
--- dataTable[10] = 45
---
--- The data table has the following structure:
---
--- dataTable = {
--- 	[1] = {
--- 		[1] = "header1Name",
--- 		[2] = "header2Name",
--- 		[3] = "header3Name",
---			...
---		},
--- 	[2] = {
---			[1] = {
---				dataRow1field1,
---				dataRow1field2,
---				dataRow1field3,
---				...
--- 		},
---			[2] = {
---				dataRow2field1,
---				...
---			},
---			[3] = {
---				dataRow3field1,
---				...
---			},
---			...
---		}
--- }
---
--- The header lookup table has the following structure:
---
--- headerLookupTable = {
---		["header1Name"] = 1,
---		["header2Name"] = 2,
---		["header3Name"] = 3,
---		...
--- }
---
--- @module CsvUtils
local CsvUtils = {}



--region Private constants

local HTML_ENTITY_NEWLINE = "&#10;"
local HTML_ENTITY_COMMA = "&comma;"
local HTML_ENTITY_QUOTES = "&quot;"

--endregion



--region Private methods

---
--- Replaces newlines and commas between quotation marks with their HTML codes,
--- so that they aren't interpreted as newlines that separate records in the csv
--- data string.
---
--- @param stringToEncode string input to be processed.
--- @return string modified with special characters replaced.
local function encodeQuotations(stringToEncode)

	-- Sub out newlines with their HTML character code
	local encodedString = stringToEncode:gsub('[\r\n]+', HTML_ENTITY_NEWLINE)
	if encodedString == "" then
		error("Encoding newlines inside quoted descriptions resulted in no data left.")
	end

	-- Sub out commas within the matched quotation
	encodedString = encodedString:gsub(",", HTML_ENTITY_COMMA)
	if encodedString == "" then
		error("Encoding commas inside quoted descriptions resulted in no data left.")
	end

	return encodedString
end



---
--- Replaces apostrophes and double quotes in a string with their respective
--- HTML character codes.
---
--- @param stringToEncode string to be processed.
--- @return string modified with special characters replaced.
local function encodeCSV(stringToEncode)

	-- Call a function on quotations to replace newlines within them. Capture
	-- the entire quote, including the bounding quotation marks.
	local encodedString = stringToEncode:gsub("(\".-\")", encodeQuotations)

	-- Now that quotations are handled, sub double quotes for their HTML code.
	encodedString = encodedString:gsub("\"", HTML_ENTITY_QUOTES)
	if encodedString == "" then
		error("Encoding double quotation marks resulted in no data left.")
	end

	return encodedString
end

--endregion



--region Public methods

---
--- Shortcut method for the two main methods of this module.
---
--- @param dataPageName string name of the template page containing the CSV data, including the namespace, like this: "Template:Workshops_Recipes_csv"
--- @return table of data from CSV
--- @return table of header names for looking up indexes for the data table
function CsvUtils.extractTables(dataPageName)
	
	return CsvUtils.luaTableFromCSV(CsvUtils.extractCSV(dataPageName))
end



---
--- Loads the data from a wiki template page, removing all surrounding
--- documentation.
---
--- Throws an error if the page could not be loaded or if there was a problem
--- processing the page content, so that invoking methods can debug. (This
--- should never cause an error at runtime.)
---
--- @param dataPageName string name of the template page containing the CSV data, including the namespace, like this: "Template:Workshops_Recipes_csv"
--- @return table raw CSV data
function CsvUtils.extractCSV(dataPageName)
	
	-- Load the page and verify something returned correctly. If the page was 
	-- not found, then the page will be nil or the site will tell us that the
	-- page doesn't exist.
    local csvPage = mw.title.new(dataPageName)
    if not csvPage or not csvPage.exists then
        error("Site could not find data page: " .. dataPageName)
    end
    
	-- Get the content of the page, or it will be nil if there is no page. We
	-- can also expect there's a problem if there's an empty string.
    local pageContent = csvPage:getContent()
	if not pageContent or pageContent == "" then
		error("Content does not exist on data page: " .. dataPageName)
	end
	
	-- Remove everything within and including the <noinclude> tags. If this
	-- results in an empty string, there was a problem.
	-- Since we're still dealing with mediawiki content, use MW library instead
	-- of Lua string library.
	local trimmedText = mw.ustring.gsub(pageContent, "<noinclude>.-</noinclude>", "")
	if trimmedText == "" then
		error("Trimming content resulted in no data left on data page: " .. dataPageName)
	end
    
    -- Extract the data from the enclosing <pre> block, leaving only the csv
	-- data. If this results in an empty string, there was a problem.
    local rawCSV = trimmedText:match("<pre>(.-)</pre>")
	if rawCSV == "" then
		error("Final extraction of content resulted in no data left on data page: " .. dataPageName)
	end
    
    return rawCSV
end



---
--- Converts a CSV data string into a Lua table. The CSV data should have a
--- header row with field names. Each row represents a new record, and each
--- column contains specific data for that record. The resulting Lua table has
--- sub-tables for each row. Indices can be used or the names of the header row
--- will be usable as keys to access the fields.
---
--- For example:
---
--- row[1] is the same as row["id"] (if the first header in the header row
--- contains the string "id")
---
--- @param csvString (string) The CSV data as a string.
--- @return table, table of data from CSV, of header names for looking up indexes for the data table
function CsvUtils.luaTableFromCSV(csvString)
	
	-- Top level lua table, its header row, and its data rows (table of rows)
    local luaTable = {}
    local luaTableHeader = {}
    local luaTableDataRows = {}
	-- Lookup table for header names
	local headerLookup = {}
	
	-- Start by encoding any special characters in the string before processing.
	local encodedString = encodeCSV(csvString)
	if not encodedString or encodedString == "" then
		error("Encoding the csv data string removed all information.")
	end
	
    -- Separate the csv data into lines/rows by gmatch on carriage returns
	-- and/or newlines. Then make each line a new row (or the header row).
    for line in encodedString:gmatch("[^\r\n]+") do
		if not line or line == "" then
			error("Splitting csv data into rows failed.")
		end
		
		-- Only build the header once.
		if #luaTableHeader == 0 then
		
			-- Count the headers to use to populate the lookup table
			local i = 1
			
			-- Separate the header row into fields by gmatch this line again,
			-- this time on commas. We can use plus here because there
			-- are no empty header cells in well-structured CSV.
			for headerField in line:gmatch("([^,]+)") do
				if not headerField or headerField == "" then
					error("Splitting row into fields failed on header row.")
				end
				
				-- Then append each field to the header row and the inverse to
				-- the lookup table.
				luaTableHeader[i] = headerField
				headerLookup[headerField] = i
				i = i + 1
			end
			
			if #luaTableHeader == 0 then
				error("Adding fields was not successful to header row.")
			end
			
			-- Header row done; wait to incorporate it until the end.
		else
			-- Build each data row separately as a new table.
			local row = {}
			
			-- Increment a counter to align fields with their headers.
			local j = 1
			
			-- Separate the line into fields by gmatch on commas again. Use an
			-- asterisk here instead of a plus because there are empty cells
			-- with zero length. The rows must end in a comma to do this 
			-- correctly or there will be empty strings added between every
			-- field in the resulting table.
			for field in line:gmatch("([^,]*),") do
				-- Empty strings are allowed here.
				if not field then
					error("Splitting row into fields failed on field number: " .. i 
						.. " on non-header row number: " .. #luaTableDataRows+1)
				end
				
				-- Append each field to the row.
				row[j] = field
				j = j + 1
			end
			
			if #row == 0 then
				error("Adding fields was not successful to row number: " .. #luaTableDataRows+1)
			end
			
			-- Row done. Append to the bigger table.
			table.insert(luaTableDataRows, row)
		end
	end
	
	if #luaTableDataRows == 0 then
		error("There are no rows to add to the table.")
	end
	
	-- Assemble the table to return.
	table.insert(luaTable, luaTableHeader)
	table.insert(luaTable, luaTableDataRows)
	
    return luaTable, headerLookup
end

--endregion

return CsvUtils
