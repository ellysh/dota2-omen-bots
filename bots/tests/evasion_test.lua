package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local evasion = require("evasion")
local luaunit = require("luaunit")

function test_pre_move_safe_recovery_1_succeed()
  evasion.test_SetBotState({
    [3] = 1,  -- env.BOT_DATA.is_flask_healing
    [11] = 0,  -- HasModifier("modifier_fountain_aura_buff")
    [20] = 0.09,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
    [28] = 0,  -- IsUnitInSpot(env.BOT_DATA, env.SAFE_SPOT)
  })

  luaunit.assertTrue(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_1_fails()
  evasion.test_SetBotState({
    [3] = 1,  -- env.BOT_DATA.is_flask_healing
    [11] = 0,  -- HasModifier("modifier_fountain_aura_buff")
    [20] = 0.07,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
    [28] = 0,  -- IsUnitInSpot(env.BOT_DATA, env.SAFE_SPOT)
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_2_fails()
  evasion.test_SetBotState({
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [11] = 0,  -- HasModifier("modifier_fountain_aura_buff")
    [20] = 1,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
    [28] = 0,  -- IsUnitInSpot(env.BOT_DATA, env.SAFE_SPOT)
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_3_fails()
  evasion.test_SetBotState({
    [3] = 1,  -- env.BOT_DATA.is_flask_healing
    [11] = 1,  -- HasModifier("modifier_fountain_aura_buff")
    [20] = 0.1,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
    [28] = 0,  -- IsUnitInSpot(env.BOT_DATA, env.SAFE_SPOT)
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_4_fails()
  evasion.test_SetBotState({
    [3] = 1,  -- env.BOT_DATA.is_flask_healing
    [11] = 0,  -- HasModifier("modifier_fountain_aura_buff")
    [20] = 0.1,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
    [28] = 1,  -- IsUnitInSpot(env.BOT_DATA, env.SAFE_SPOT)
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

os.exit(luaunit.LuaUnit.run())
