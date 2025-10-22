---
---Uses mw.text.jsonDecode to convert the specified JSON file on the wiki into a Lua table.
---
---The page must contain properly formatted JSON data and only the JSON data, without any explanation, wiki markup, or other content.
---
---The table returned may have missing fields where they would otherwise be expected if the JSON data contained nil values for those fields.
---
---@module JsonUtils
local JsonUtils = {}



--region Dependencies
-- none
--endregion



--region Private constants

local ERROR_MESSAGE_PARAMETER_MISSING = "JsonUtils requires as its parameter that you provide the name of a page on the wiki that contains valid JSON data. Call the main function with a parameter that is the name of the desired page, like this:\n  `JsonUtils.main('Template:Data_json`)`"

local ERROR_PREFIX_TITLE_INVALID_NAME = "JsonUtils failed to create a Mediawiki title object with the page name you provided. Double-check that the page name you provided is a properly formatted string and valid page title: "
local ERROR_PREFIX_TITLE_PAGE_DOES_NOT_EXIST = "JsonUtils checked the page name you provided, and the page does not exist. Double-check that the page name you provided is correct: "

local ERROR_PREFIX_CONTENT_NOT_FOUND = "JsonUtils did not find content on the page whose name you provided. Double check that the page exists and that it contains content: "
local ERROR_PREFIX_CONTENT_NOT_LONG_ENOUGH = "JsonUtils found content on the page whose name you provided, but it is too short to be useful. Double-check that you provided the correct name, and that there is content on the page: "

local ERROR_PREFIX_JSON_DATA_NOT_USABLE = "JsonUtils loaded the content on the page, but parsing it as JSON data was not successful. Double-check that the page you provided contains properly formatted JSON data: "
local ERROR_PREFIX_JSON_NO_DATA = "JsonUtils loaded and parsed the content on the page you provided, but parsing it as JSON data yielded an empty table. Double-check that the page you provided contains more than one JSON record: "

local MINIMUM_LENGTH_THAT_SUGGESTS_VALID_CONTENT = 4

--endregion



--region Private member variables
-- none
--endregion



--region Private methods
-- none
--endregion



--region Public methods

---Loads JSON data from the specified page on the wiki into a Lua table.
---@param wikiPageName string the title of the wiki page, including
---@return table
function JsonUtils.convertJSONToLuaTable(wikiPageName)

    -- Verify the parameter.
    if not wikiPageName or "" == wikiPageName then
        error(ERROR_MESSAGE_PARAMETER_MISSING)
    end

    -- Verify that the name is valid and that the page exists.
    local titleObject = mw.title.new(wikiPageName)
    if not titleObject then
        error(ERROR_PREFIX_TITLE_INVALID_NAME .. wikiPageName)
    end
    if not titleObject.exists then
        error(ERROR_PREFIX_TITLE_PAGE_DOES_NOT_EXIST .. wikiPageName)
    end

    -- Verify that the page content can be loaded and that there is something there to use.
    local unparsedContent = titleObject:getContent()
    if not unparsedContent then
        error(ERROR_PREFIX_CONTENT_NOT_FOUND .. wikiPageName)
    end
    if #unparsedContent < MINIMUM_LENGTH_THAT_SUGGESTS_VALID_CONTENT then
        error(ERROR_PREFIX_CONTENT_NOT_LONG_ENOUGH .. wikiPageName)
    end

    -- Verify that the data is valid and useful JSON.
    local success, decodedTable = pcall(mw.text.jsonDecode, unparsedContent)
    if not success or not decodedTable then
        error(ERROR_PREFIX_JSON_DATA_NOT_USABLE .. wikiPageName)
    end
    if #decodedTable < 1 then
        error(ERROR_PREFIX_JSON_NO_DATA .. wikiPageName)
    end

    return decodedTable
end

--endregion

return JsonUtils