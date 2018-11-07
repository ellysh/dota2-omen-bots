package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local item_mp_recovery = require("item_mp_recovery")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_item_mp_recovery_1_succeed()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
  })

  luaunit.assertTrue(item_mp_recovery.pre_item_mp_recovery())
end

function test_pre_item_mp_recovery_1_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
  })

  luaunit.assertFalse(item_mp_recovery.pre_item_mp_recovery())
end

function test_pre_item_mp_recovery_2_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_item_mp_recovery())
end

function test_pre_item_mp_recovery_3_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_item_mp_recovery())
end

---------------------------------

function test_pre_use_enchanted_mango_1_succeed()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
  })

  luaunit.assertTrue(item_mp_recovery.pre_use_enchanted_mango())
end

function test_pre_use_enchanted_mango_1_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 1,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_enchanted_mango())
end

function test_pre_use_enchanted_mango_2_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_enchanted_mango())
end

function test_pre_use_enchanted_mango_3_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_enchanted_mango())
end

os.exit(luaunit.LuaUnit.run())
