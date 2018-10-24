package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local attack_with_better_position = require("attack_with_better_position")
local luaunit = require("luaunit")

function test_pre_attack_with_better_position_1_succeed()
  attack_with_better_position.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_1_fails()
  attack_with_better_position.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_2_fails()
  attack_with_better_position.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_3_fails()
  attack_with_better_position.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

---------------------------------

function test_pre_attack_enemy_hero_from_hg_1_succeed()
  attack_with_better_position.test_SetBotState({
    [32] = 0.5, -- bot incoming damage
    [33] = 1, -- IsUnitPositionBetter(bot, enemy_hero)
  })

  attack_with_better_position.test_SetEnemyHeroState({
    [8] = 1,  -- env.ENEMY_HERO_DISTANCE < bot attack range
  })

  attack_with_better_position.test_SetCreepsState({
    [1] = 0, -- env.ENEMY_CREEP_FRONT_DATA ~= nil
    [2] = 0, -- env.ENEMY_CREEP_BACK_DATA ~= nil
    [3] = 1, -- env.ALLY_CREEP_FRONT_DATA ~= nil
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

os.exit(luaunit.LuaUnit.run())
