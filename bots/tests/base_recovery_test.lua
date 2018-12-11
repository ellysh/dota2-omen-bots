package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local base_recovery = require("base_recovery")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_base_recovery_1_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_2_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_3_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_4_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end


function test_pre_base_recovery_1_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_2_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_3_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_4_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_5_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_6_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IS_CASTING] = 1,
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

---------------------------------

function test_pre_restore_hp_on_base_1_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_HP_RATE] = 0.84,
  })

  luaunit.assertTrue(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_2_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_HP_RATE] = 0.5,
  })

  luaunit.assertTrue(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_1_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_HP_RATE] = 0.86,
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_2_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_HP_RATE] = 0.84,
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_3_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_HP_RATE] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_4_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_HP_RATE] = 1,
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

---------------------------------

function test_pre_restore_mp_on_base_1_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_MP_RATE] = 0.81,
  })

  luaunit.assertTrue(base_recovery.pre_restore_mp_on_base())
end

function test_pre_restore_mp_on_base_2_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_MP_RATE] = 0.5,
  })

  luaunit.assertTrue(base_recovery.pre_restore_mp_on_base())
end

function test_pre_restore_mp_on_base_1_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_MP_RATE] = 0.83,
  })

  luaunit.assertFalse(base_recovery.pre_restore_mp_on_base())
end

function test_pre_restore_mp_on_base_2_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_MP_RATE] = 0.84,
  })

  luaunit.assertFalse(base_recovery.pre_restore_mp_on_base())
end

function test_pre_restore_mp_on_base_3_fails()
  base_recovery.test_SetGameState({})

  luaunit.assertFalse(base_recovery.pre_restore_mp_on_base())
end

function test_pre_restore_mp_on_base_4_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_MP_RATE] = 1,
  })

  luaunit.assertFalse(base_recovery.pre_restore_mp_on_base())
end

---------------------------------

function test_pre_move_base_1_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertTrue(base_recovery.pre_move_base())
end

function test_pre_move_base_2_succeed()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
  })

  luaunit.assertTrue(base_recovery.pre_move_base())
end

function test_pre_move_base_1_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_move_base())
end

function test_pre_move_base_2_fails()
  base_recovery.test_SetGameState({
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(base_recovery.pre_move_base())
end

os.exit(luaunit.LuaUnit.run())
