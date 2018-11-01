package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local evasion = require("evasion")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_move_safe_recovery_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_HP_MAX_DELTA] = 0.09,
    [gs.BOT_IN_SAFE_SPOT] = 0,
  })

  luaunit.assertTrue(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_HP_MAX_DELTA] = 0.07,
    [gs.BOT_IN_SAFE_SPOT] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_HP_MAX_DELTA] = 1,
    [gs.BOT_IN_SAFE_SPOT] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_3_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.1,
    [gs.BOT_IN_SAFE_SPOT] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_4_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_HP_MAX_DELTA] = 0.1,
    [gs.BOT_IN_SAFE_SPOT] = 1,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

---------------------------------

function test_pre_evade_enemy_hero_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_2_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_3_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 1,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 1,
    [gs.EC_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_3_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

---------------------------------

function test_pre_evade_enemy_creeps_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_creeps())
end

function test_pre_evade_enemy_creeps_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_creeps())
end

---------------------------------

function test_pre_evade_enemy_tower_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.ET_PRESENT] = 0,
    [gs.ET_BOT_DISTANCE] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_2_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
    [gs.ET_PRESENT] = 0,
    [gs.ET_BOT_DISTANCE] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_3_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.ET_PRESENT] = 1,
    [gs.ET_BOT_DISTANCE] = 0.5,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.ET_PRESENT] = 1,
    [gs.ET_BOT_DISTANCE] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
    [gs.ET_PRESENT] = 0,
    [gs.ET_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_tower())
end

os.exit(luaunit.LuaUnit.run())
