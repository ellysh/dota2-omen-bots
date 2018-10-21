package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local farm = require("farm")
local luaunit = require("luaunit")

function test_pre_farm_1_succeed()
  farm.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertTrue(farm.pre_farm())
end

function test_pre_farm_1_fails()
  farm.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(farm.pre_farm())
end

function test_pre_farm_2_fails()
  farm.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(farm.pre_farm())
end

function test_pre_farm_3_fails()
  farm.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(farm.pre_farm())
end

---------------------------------

function test_pre_lasthit_enemy_creep_1_succeed()
  farm.test_SetCreepsState({
    [7] = 1, -- env.LAST_HIT_ENEMY_CREEP
    [9] = 0, -- DoesTowerProtectUnit(env.LAST_HIT_ENEMY_CREEP)
  })

  luaunit.assertTrue(farm.pre_lasthit_enemy_creep())
end

function test_pre_lasthit_enemy_creep_1_fails()
  farm.test_SetCreepsState({
    [7] = 0, -- env.LAST_HIT_ENEMY_CREEP
    [9] = 0, -- DoesTowerProtectUnit(env.LAST_HIT_ENEMY_CREEP)
  })

  luaunit.assertFalse(farm.pre_lasthit_enemy_creep())
end

function test_pre_lasthit_enemy_creep_2_fails()
  farm.test_SetCreepsState({
    [7] = 1, -- env.LAST_HIT_ENEMY_CREEP
    [9] = 1, -- DoesTowerProtectUnit(env.LAST_HIT_ENEMY_CREEP)
  })

  luaunit.assertFalse(farm.pre_lasthit_enemy_creep())
end

function test_pre_lasthit_enemy_creep_3_fails()
  farm.test_SetCreepsState({
    [7] = 0, -- env.LAST_HIT_ENEMY_CREEP
    [9] = 1, -- DoesTowerProtectUnit(env.LAST_HIT_ENEMY_CREEP)
  })

  luaunit.assertFalse(farm.pre_lasthit_enemy_creep())
end

os.exit(luaunit.LuaUnit.run())
