package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local cancel_turn = require("cancel_turn")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

os.exit(luaunit.LuaUnit.run())
