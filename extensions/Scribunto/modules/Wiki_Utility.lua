-- Defines some utility functions for working with, among other things, mw library functions.
local Wiki_Utility = {}

-- The non-breaking space character.
Wiki_Utility.NBSP = "&nbsp;"

Wiki_Utility.StandardizedSizes = {
  ["small"] = "x16px",
  ["medium"] = "x30px",
  ["large"] = "x60px",
  ["huge"] = "x84px"
}

-- Surrounds the given wikitext with no-wrap tags.
---@param wikitext Wikitext wikitext to surround
---@return Wikitext wikitext same wikitext, surrounded with no-wrap tags
function Wiki_Utility.surroundWithNoWrap(wikitext)
  return "<span style=\"white-space: nowrap;\">" .. wikitext .. "</span>"
end

-- Surrounds the given wikitext with the given classes.
---@param wikitext Wikitext wikitext to surround
---@param ... string classes to surround the wikitext with
---@return Wikitext wikitext same wikitext, surrounded with the given classes
function Wiki_Utility.surroundWithClasses(wikitext, ...)
  return "<span class=\"" .. table.concat({...}, " ") .. "\">" .. wikitext .. "</span>"
end

-- Checks if the given icon size is valid, both as a number and within usable bounds as an icon.
---@param iconSize string size of the icon including units, e.g., "20em" or "x16px"
---@return boolean # `true` if the size string is a valid size
---@return number|nil sizeN the number part of the specified size
function Wiki_Utility.isValidIconSize(iconSize)
  local sizeN = tonumber(iconSize:match("^x?(%d+)"))
  return sizeN and sizeN >= 0 and sizeN <= 300 or false, sizeN
end

-- Renders an icon with the given filename, size, link, and alt text.
---@param filename string filename of the icon
---@param size string size of the icon including units, e.g., "x16px"
---@param link string link to the icon
---@param alt string alt text for the icon
---@return Wikitext wikitext wikitext markup for the icon
function Wiki_Utility.renderIcon(filename, size, link, alt)
  local wikitext = "[[File:" .. filename
  if size then
    wikitext = wikitext .. "|" .. size
  end
  if link then
    wikitext = wikitext .. "|link=" .. link
  end
  if alt then
    wikitext = wikitext .. "|" .. alt
  end
  return wikitext .. "]]"
end

-- Renders a link to the given page name with the given text.
---@param pageName string name of the page
---@param text string text to display for the link
---@return Wikitext wikitext wikitext markup for the link
function Wiki_Utility.renderWikiLink(pageName, text)
  return "[[" .. pageName .. "|" .. text .. "]]"
end

return Wiki_Utility
