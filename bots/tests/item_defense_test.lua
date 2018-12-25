package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local item_defense = require("item_defense")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

os.exit(luaunit.LuaUnit.run())
