package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local base_recovery = require("base_recovery")
local luaunit = require("luaunit")

function test_pre_base_recovery_when_low_hp_and_no_healing_succeed()
  base_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [5] = 0,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_when_base_recovery_succeed()
  base_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [5] = 1,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_when_low_hp_and_base_recovery_succeed()
  base_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [5] = 1,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_when_low_hp_and_healing_and_base_recovery_succeed()
  base_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 1,  -- env.BOT_DATA.is_healing
    [5] = 1,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertTrue(base_recovery.pre_base_recovery())
end


function test_pre_base_recovery_when_bot_dead_1_fails()
  base_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [5] = 0,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_when_bot_dead_2_fails()
  base_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [5] = 1,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_when_bot_dead_3_fails()
  base_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 1,  -- env.BOT_DATA.is_healing
    [5] = 1,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_when_bot_dead_4_fails()
  base_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 1,  -- env.BOT_DATA.is_healing
    [5] = 0,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

function test_pre_base_recovery_when_low_hp_and_healing_fails()
  base_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 1,  -- env.BOT_DATA.is_healing
    [5] = 0,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end

---------------------------------

function test_pre_restore_hp_on_base_1_succeed()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0.85,  -- health / max_health
    [13] = 0.82,  -- mana / max_mana
  })

  luaunit.assertTrue(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_2_succeed()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0.85,  -- health / max_health
    [13] = 0.9,  -- mana / max_mana
  })

  luaunit.assertTrue(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_3_succeed()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0.9,  -- health / max_health
    [13] = 0.82,  -- mana / max_mana
  })

  luaunit.assertTrue(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_1_fails()
  base_recovery.test_SetBotState({
    [11] = 0,  -- modifier_fountain_aura_buff
    [12] = 0.85,  -- health / max_health
    [13] = 0,  -- mana / max_mana
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_2_fails()
  base_recovery.test_SetBotState({
    [11] = 0,  -- modifier_fountain_aura_buff
    [12] = 0,  -- health / max_health
    [13] = 0.85,  -- mana / max_mana
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_3_fails()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0.5,  -- health / max_health
    [13] = 0,  -- mana / max_mana
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_4_fails()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0,  -- health / max_health
    [13] = 0.5,  -- mana / max_mana
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_5_fails()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0.5,  -- health / max_health
    [13] = 0.5,  -- mana / max_mana
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_6_fails()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0.85,  -- health / max_health
    [13] = 0.5,  -- mana / max_mana
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

function test_pre_restore_hp_on_base_7_fails()
  base_recovery.test_SetBotState({
    [11] = 1,  -- modifier_fountain_aura_buff
    [12] = 0.5,  -- health / max_health
    [13] = 0.82,  -- mana / max_mana
  })

  luaunit.assertFalse(base_recovery.pre_restore_hp_on_base())
end

os.exit(luaunit.LuaUnit.run())
