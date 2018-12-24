package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local swap_items = require("swap_items")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_swap_items_1_succeed()
  swap_items.test_SetGameState({
    [gs.BOT_IS_INACTIVE] = 0,
    [gs.BOT_IS_ALIVE] = 1,
  })

  luaunit.assertTrue(swap_items.pre_swap_items())
end

function test_pre_swap_items_1_fails()
  swap_items.test_SetGameState({
    [gs.BOT_IS_INACTIVE] = 0,
    [gs.BOT_IS_ALIVE] = 0,
  })

  luaunit.assertFalse(swap_items.pre_swap_items())
end

function test_pre_swap_items_2_fails()
  swap_items.test_SetGameState({
    [gs.BOT_IS_INACTIVE] = 1,
    [gs.BOT_IS_ALIVE] = 1,
  })

  luaunit.assertFalse(swap_items.pre_swap_items())
end

os.exit(luaunit.LuaUnit.run())
