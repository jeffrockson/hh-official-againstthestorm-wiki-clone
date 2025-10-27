

-- A frame object provided by MediaWiki when invoking a module.<br>
-- See [Official MediaWiki doc on frame objects](https://www.mediawiki.org/wiki/Extension:Scribunto/Lua_reference_manual#Frame_object)
---@class Frame : table
---@field args table<string, string> Template arguments passed to the module (all values are strings).
---@field getParent fun(self: Frame): Frame|nil Returns the parent frame, or nil if none.
---@field getTitle fun(self: Frame): string Returns the title of the frame.
---@field preprocess fun(self: Frame, options: {text: string}): string Preprocesses wikitext.
---@field extensionTag fun(self: Frame, options: {name: string, content: string, args: table<string, string>}): string Creates an extension tag.
---@field expandTemplate fun(self: Frame, options: {title: string, args: table<string, string>}): string Expands a template with the given arguments.
---@field callParserFunction fun(self: Frame, options: {name: string, args: table|string}): string Calls a parser function.
---@field argumentPairs fun(self: Frame): fun(): string, string Iterator for frame arguments.
---@field getArgument fun(self: Frame, name: string|number): {expand: fun(): string}|nil Gets a specific argument object.

-- The name of a file, including its extension, but not its full path.
---@alias Filename string

-- MediaWiki wikitext markup.
---@alias Wikitext string


-- TODO
---@alias EffectID string


