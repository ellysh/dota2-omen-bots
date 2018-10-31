package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local farm = require("farm")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_farm_1_succeed()
  farm.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(farm.pre_farm())
end

function test_pre_farm_1_fails()
  farm.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(farm.pre_farm())
end

function test_pre_farm_2_fails()
  farm.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(farm.pre_farm())
end

function test_pre_farm_3_fails()
  farm.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(farm.pre_farm())
end

---------------------------------

function test_pre_lasthit_enemy_creep_1_succeed()
  farm.test_SetGameState({
    [gs.EC_LAST_HIT_PRESENT] = 1,
    [gs.EC_LAST_HIT_IS_TOWER_PROTECTED] = 0,
  })

  luaunit.assertTrue(farm.pre_lasthit_enemy_creep())
end

function test_pre_lasthit_enemy_creep_1_fails()
  farm.test_SetGameState({
    [gs.EC_LAST_HIT_PRESENT] = 0,
    [gs.EC_LAST_HIT_IS_TOWER_PROTECTED] = 0,
  })

  luaunit.assertFalse(farm.pre_lasthit_enemy_creep())
end

function test_pre_lasthit_enemy_creep_2_fails()
  farm.test_SetGameState({
    [gs.EC_LAST_HIT_PRESENT] = 1,
    [gs.EC_LAST_HIT_IS_TOWER_PROTECTED] = 1,
  })

  luaunit.assertFalse(farm.pre_lasthit_enemy_creep())
end

function test_pre_lasthit_enemy_creep_3_fails()
  farm.test_SetGameState({
    [gs.EC_LAST_HIT_PRESENT] = 0,
    [gs.EC_LAST_HIT_IS_TOWER_PROTECTED] = 1,
  })

  luaunit.assertFalse(farm.pre_lasthit_enemy_creep())
end

---------------------------------

function test_pre_deny_ally_creep_1_succeed()
  farm.test_SetGameState({
    [gs.AC_LAST_HIT_PRESENT] = 1,
    [gs.AC_LAST_HIT_IS_TOWER_PROTECTED] = 0,
    [gs.AC_LAST_HIT_HP_RATE] = 0.4,
  })

  luaunit.assertTrue(farm.pre_deny_ally_creep())
end

function test_pre_deny_ally_creep_1_fails()
  farm.test_SetGameState({
    [gs.AC_LAST_HIT_PRESENT] = 1,
    [gs.AC_LAST_HIT_IS_TOWER_PROTECTED] = 0,
    [gs.AC_LAST_HIT_HP_RATE] = 0.6,
  })

  luaunit.assertFalse(farm.pre_deny_ally_creep())
end

function test_pre_deny_ally_creep_2_fails()
  farm.test_SetGameState({
    [gs.AC_LAST_HIT_PRESENT] = 1,
    [gs.AC_LAST_HIT_IS_TOWER_PROTECTED] = 1,
    [gs.AC_LAST_HIT_HP_RATE] = 0.4,
  })

  luaunit.assertFalse(farm.pre_deny_ally_creep())
end

function test_pre_deny_ally_creep_3_fails()
  farm.test_SetGameState({
    [gs.AC_LAST_HIT_PRESENT] = 0,
    [gs.AC_LAST_HIT_IS_TOWER_PROTECTED] = 0,
    [gs.AC_LAST_HIT_HP_RATE] = 0,
  })

  luaunit.assertFalse(farm.pre_deny_ally_creep())
end

os.exit(luaunit.LuaUnit.run())
