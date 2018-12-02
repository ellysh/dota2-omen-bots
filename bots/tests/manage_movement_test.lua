package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local manage_movement = require("manage_movement")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

---------------------------------

os.exit(luaunit.LuaUnit.run())
