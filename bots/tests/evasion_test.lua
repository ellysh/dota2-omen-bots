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

---------------------------------

function test_pre_evade_enemy_hero_1_succeed()
  evasion.test_SetBotState({
    [2] = 1, -- env.IS_BOT_LOW_HP
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [29] = 0, -- AreEnemyCreepsInRadius(CREEP_MAX_AGGRO_RADIUS)
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_2_succeed()
  evasion.test_SetBotState({
    [2] = 0, -- env.IS_BOT_LOW_HP
    [8] = 1,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [29] = 1, -- AreEnemyCreepsInRadius(CREEP_MAX_AGGRO_RADIUS)
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_3_succeed()
  evasion.test_SetBotState({
    [2] = 0, -- env.IS_BOT_LOW_HP
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 1,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [29] = 1, -- AreEnemyCreepsInRadius(CREEP_MAX_AGGRO_RADIUS)
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_1_fails()
  evasion.test_SetBotState({
    [2] = 0, -- env.IS_BOT_LOW_HP
    [8] = 1,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [29] = 0, -- AreEnemyCreepsInRadius(CREEP_MAX_AGGRO_RADIUS)
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_2_fails()
  evasion.test_SetBotState({
    [2] = 0, -- env.IS_BOT_LOW_HP
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 1,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [29] = 0, -- AreEnemyCreepsInRadius(CREEP_MAX_AGGRO_RADIUS)
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_3_fails()
  evasion.test_SetBotState({
    [2] = 0, -- env.IS_BOT_LOW_HP
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [29] = 1, -- AreEnemyCreepsInRadius(CREEP_MAX_AGGRO_RADIUS)
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

---------------------------------

function test_pre_evade_enemy_creeps_1_succeed()
  evasion.test_SetBotState({
    [7] = 1,  -- env.IS_FOCUSED_BY_CREEPS
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_creeps())
end

function test_pre_evade_enemy_creeps_1_fails()
  evasion.test_SetBotState({
    [7] = 0,  -- env.IS_FOCUSED_BY_CREEPS
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_creeps())
end

---------------------------------

function test_pre_evade_enemy_tower_1_succeed()
  evasion.test_SetBotState({
    [10] = 1,  -- env.IS_FOCUSED_BY_TOWER
    [30] = 0, -- algorithms.HasLevelForAggression
    [31] = 0, -- map.IsUnitInEnemyTowerAttackRange
  })

  evasion.test_SetEnemyTowerState({
    [1] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
    [2] = 0,  -- env.ENEMY_TOWER_DISTANCE / constants.MIN_TOWER_DISTANCE
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_2_succeed()
  evasion.test_SetBotState({
    [10] = 0,  -- env.IS_FOCUSED_BY_TOWER
    [30] = 0, -- algorithms.HasLevelForAggression
    [31] = 1, -- map.IsUnitInEnemyTowerAttackRange
  })

  evasion.test_SetEnemyTowerState({
    [1] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
    [2] = 0,  -- env.ENEMY_TOWER_DISTANCE / constants.MIN_TOWER_DISTANCE
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_3_succeed()
  evasion.test_SetBotState({
    [10] = 0,  -- env.IS_FOCUSED_BY_TOWER
    [30] = 0, -- algorithms.HasLevelForAggression
    [31] = 0, -- map.IsUnitInEnemyTowerAttackRange
  })

  evasion.test_SetEnemyTowerState({
    [1] = 1,  -- env.ENEMY_TOWER_DATA ~= nil
    [2] = 0.5,  -- env.ENEMY_TOWER_DISTANCE / constants.MIN_TOWER_DISTANCE
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_1_fails()
  evasion.test_SetBotState({
    [10] = 0,  -- env.IS_FOCUSED_BY_TOWER
    [30] = 0, -- algorithms.HasLevelForAggression
    [31] = 0, -- map.IsUnitInEnemyTowerAttackRange
  })

  evasion.test_SetEnemyTowerState({
    [1] = 1,  -- env.ENEMY_TOWER_DATA ~= nil
    [2] = 1,  -- env.ENEMY_TOWER_DISTANCE / constants.MIN_TOWER_DISTANCE
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_2_fails()
  evasion.test_SetBotState({
    [10] = 0,  -- env.IS_FOCUSED_BY_TOWER
    [30] = 1, -- algorithms.HasLevelForAggression
    [31] = 1, -- map.IsUnitInEnemyTowerAttackRange
  })

  evasion.test_SetEnemyTowerState({
    [1] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
    [2] = 0,  -- env.ENEMY_TOWER_DISTANCE / constants.MIN_TOWER_DISTANCE
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_tower())
end

os.exit(luaunit.LuaUnit.run())
