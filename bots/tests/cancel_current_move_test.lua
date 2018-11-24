package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local cancel_current_move = require("cancel_current_move")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

os.exit(luaunit.LuaUnit.run())
