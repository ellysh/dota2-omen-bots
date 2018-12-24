package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local buy_items = require("buy_items")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_buy_items_1_succeed()
  buy_items.test_SetGameState({
    [gs.BOT_IS_INACTIVE] = 0,
    [gs.BOT_IS_ALIVE] = 1,
    [gs.COURIER_IS_AVAILABLE] = 1,
  })

  luaunit.assertTrue(buy_items.pre_buy_items())
end

function test_pre_buy_items_1_fails()
  buy_items.test_SetGameState({
    [gs.BOT_IS_INACTIVE] = 0,
    [gs.BOT_IS_ALIVE] = 0,
    [gs.COURIER_IS_AVAILABLE] = 1,
  })

  luaunit.assertFalse(buy_items.pre_buy_items())
end

function test_pre_buy_items_2_fails()
  buy_items.test_SetGameState({
    [gs.BOT_IS_INACTIVE] = 0,
    [gs.BOT_IS_ALIVE] = 1,
    [gs.COURIER_IS_AVAILABLE] = 0,
  })

  luaunit.assertFalse(buy_items.pre_buy_items())
end

function test_pre_buy_items_3_fails()
  buy_items.test_SetGameState({
    [gs.BOT_IS_INACTIVE] = 1,
    [gs.BOT_IS_ALIVE] = 1,
    [gs.COURIER_IS_AVAILABLE] = 1,
  })

  luaunit.assertFalse(buy_items.pre_buy_items())
end

os.exit(luaunit.LuaUnit.run())
