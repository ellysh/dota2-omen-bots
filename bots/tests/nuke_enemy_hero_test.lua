package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local nuke_enemy_hero = require("nuke_enemy_hero")
local luaunit = require("luaunit")

os.exit(luaunit.LuaUnit.run())
