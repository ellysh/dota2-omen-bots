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
    [gs.BOT_NEAR_FOUNTAIN] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(item_mp_recovery.pre_item_mp_recovery())
end

function test_pre_item_mp_recovery_1_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_NEAR_FOUNTAIN] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_item_mp_recovery())
end

function test_pre_item_mp_recovery_2_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_NEAR_FOUNTAIN] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_item_mp_recovery())
end

function test_pre_item_mp_recovery_3_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_NEAR_FOUNTAIN] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_item_mp_recovery())
end

function test_pre_item_mp_recovery_4_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_NEAR_FOUNTAIN] = 0,
    [gs.BOT_IS_CASTING] = 1,
  })

  luaunit.assertFalse(item_mp_recovery.pre_item_mp_recovery())
end

---------------------------------

function test_pre_use_enchanted_mango_1_succeed()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 1,
  })

  luaunit.assertTrue(item_mp_recovery.pre_use_enchanted_mango())
end

function test_pre_use_enchanted_mango_1_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 0,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 1,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_enchanted_mango())
end

function test_pre_use_enchanted_mango_2_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_enchanted_mango())
end

function test_pre_use_enchanted_mango_3_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_MP] = 0,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 0,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_enchanted_mango())
end

---------------------------------

function test_pre_use_enchanted_mango_with_cyclone_1_succeed()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_HAS_CYCLONE] = 1,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 1,
  })

  luaunit.assertTrue(
    item_mp_recovery.pre_use_enchanted_mango_with_cyclone())
end

function test_use_enchanted_mango_with_cyclone_1_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_HAS_CYCLONE] = 0,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 1,
  })

  luaunit.assertFalse(
    item_mp_recovery.pre_use_enchanted_mango_with_cyclone())
end

function test_use_enchanted_mango_with_cyclone_2_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_HAS_CYCLONE] = 1,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 0,
  })

  luaunit.assertFalse(
    item_mp_recovery.pre_use_enchanted_mango_with_cyclone())
end

function test_use_enchanted_mango_with_cyclone_4_fails()
  item_mp_recovery.test_SetGameState({
    [gs.BOT_HAS_CYCLONE] = 0,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 0,
  })

  luaunit.assertFalse(
    item_mp_recovery.pre_use_enchanted_mango_with_cyclone())
end

---------------------------------

os.exit(luaunit.LuaUnit.run())
