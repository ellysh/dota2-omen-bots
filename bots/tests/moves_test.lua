package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local moves = require("moves")
local luaunit = require("luaunit")

function test_pre_attack_enemy_hero_1_succeed()
  moves.test_SetEnemyHeroState({
    [1] = 1, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 0, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 0, -- IsAttackUnderTowerSafe
    [11] = 0, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_2_succeed()
  moves.test_SetEnemyHeroState({
    [1] = 1, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 1, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 1, -- IsAttackUnderTowerSafe
    [11] = 0, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_3_succeed()
  moves.test_SetEnemyHeroState({
    [1] = 1, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 1, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 0, -- IsAttackUnderTowerSafe
    [11] = 1, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_4_succeed()
  moves.test_SetEnemyHeroState({
    [1] = 1, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 1, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 1, -- IsAttackUnderTowerSafe
    [11] = 1, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_1_fails()
  moves.test_SetEnemyHeroState({
    [1] = 1, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 1, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 0, -- IsAttackUnderTowerSafe
    [11] = 0, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_2_fails()
  moves.test_SetEnemyHeroState({
    [1] = 1, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 0, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 0, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 0, -- IsAttackUnderTowerSafe
    [11] = 0, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_3_fails()
  moves.test_SetEnemyHeroState({
    [1] = 0, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 0, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 0, -- IsAttackUnderTowerSafe
    [11] = 0, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_4_fails()
  moves.test_SetEnemyHeroState({
    [1] = 0, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 0, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 1, -- IsAttackUnderTowerSafe
    [11] = 0, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_5_fails()
  moves.test_SetEnemyHeroState({
    [1] = 0, -- env.ENEMY_HERO_DATA ~= nil
    [9] = 1, -- env.ENEMY_HERO_DATA.is_visible
    [3] = 0, -- env.DOES_TOWER_PROTECT_ENEMY
    [10] = 1, -- IsAttackUnderTowerSafe
    [11] = 1, -- algorithms.IsTowerDiveReasonable
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

os.exit(luaunit.LuaUnit.run())
