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

function test_pre_use_magic_stick_1_succeed()
  item_mp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_MAGIC_STICK] = 1,
    [gs.BOT_CASTABLE_MAGIC_WAND] = 0,

    -- weights_2
    [gs.BOT_HP_MAX_DELTA] = 0.31,
  })

  luaunit.assertTrue(item_mp_recovery.pre_use_magic_stick())
end

function test_pre_use_magic_stick_2_succeed()
  item_mp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_MAGIC_STICK] = 0,
    [gs.BOT_CASTABLE_MAGIC_WAND] = 1,

    -- weights_2
    [gs.BOT_HP_MAX_DELTA] = 0.31,
  })

  luaunit.assertTrue(item_mp_recovery.pre_use_magic_stick())
end

function test_pre_use_magic_stick_1_fails()
  item_mp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_LOW_MP] = 0,
    [gs.BOT_CASTABLE_MAGIC_STICK] = 1,
    [gs.BOT_CASTABLE_MAGIC_WAND] = 0,

    -- weights_2
    [gs.BOT_HP_MAX_DELTA] = 0.31,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_magic_stick())
end

function test_pre_use_magic_stick_2_fails()
  item_mp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_MAGIC_STICK] = 0,
    [gs.BOT_CASTABLE_MAGIC_WAND] = 0,

    -- weights_2
    [gs.BOT_HP_MAX_DELTA] = 0.31,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_magic_stick())
end

function test_pre_use_magic_stick_3_fails()
  item_mp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_LOW_MP] = 1,
    [gs.BOT_CASTABLE_MAGIC_STICK] = 1,
    [gs.BOT_CASTABLE_MAGIC_WAND] = 0,

    -- weights_2
    [gs.BOT_HP_MAX_DELTA] = 0.29,
  })

  luaunit.assertFalse(item_mp_recovery.pre_use_magic_stick())
end

os.exit(luaunit.LuaUnit.run())
