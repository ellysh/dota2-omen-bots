package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local close_fight = require("close_fight")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

os.exit(luaunit.LuaUnit.run())
