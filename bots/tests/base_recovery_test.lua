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

function test_pre_base_recovery_when_low_hp_and_healing_fails()
  base_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 1,  -- env.BOT_DATA.is_healing
    [5] = 0,  -- env.IS_BASE_RECOVERY
  })

  luaunit.assertFalse(base_recovery.pre_base_recovery())
end


os.exit(luaunit.LuaUnit.run())
