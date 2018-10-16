package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local game_state = require("game_state")
local luaunit = require("luaunit")

os.exit(luaunit.LuaUnit.run())
