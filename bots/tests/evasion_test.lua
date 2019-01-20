package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local evasion = require("evasion")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_move_safe_recovery_1_succeed()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.09,

    -- weights_2
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_IN_SAFE_SPOT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0,
  })

  luaunit.assertTrue(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_2_succeed()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.09,

    -- weights_2
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_IN_SAFE_SPOT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 1,
  })

  luaunit.assertTrue(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_1_fails()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.07,

    -- weights_2
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_IN_SAFE_SPOT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_2_fails()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_HP_MAX_DELTA] = 1,

    -- weights_2
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_IN_SAFE_SPOT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_3_fails()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.1,

    -- weights_2
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 1,
    [gs.BOT_IN_SAFE_SPOT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_4_fails()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.1,

    -- weights_2
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_IN_SAFE_SPOT] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

function test_pre_move_safe_recovery_5_fails()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.1,

    -- weights_2
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = 0,
    [gs.BOT_IN_SAFE_SPOT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_move_safe_recovery())
end

---------------------------------

function test_pre_evade_enemy_hero_low_hp_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero_low_hp())
end

function test_pre_evade_enemy_hero_low_hp_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_low_hp())
end

function test_pre_evade_enemy_hero_low_hp_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_low_hp())
end

function test_pre_evade_enemy_hero_low_hp_3_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_low_hp())
end

---------------------------------

function test_pre_evade_enemy_hero_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_2_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 1,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_3_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 1,
    [gs.EC_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_4_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

function test_pre_evade_enemy_hero_5_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.EC_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero())
end

---------------------------------

function test_pre_evade_invisible_enemy_hero_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_invisible_enemy_hero())
end

function test_pre_evade_invisible_enemy_hero_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_invisible_enemy_hero())
end

function test_pre_evade_invisible_enemy_hero_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_invisible_enemy_hero())
end

---------------------------------

function test_pre_evade_enemy_creeps_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 1,
    [gs.EC_IN_MELEE_ATTACK_RANGE] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_creeps())
end

function test_pre_evade_enemy_creeps_2_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.EC_IN_MELEE_ATTACK_RANGE] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_creeps())
end

function test_pre_evade_enemy_creeps_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.EC_IN_MELEE_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_creeps())
end

---------------------------------

function test_pre_evade_enemy_tower_1_succeed()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 1,
    [gs.BOT_IN_ET_MIN_DISTANCE] = 0,

    -- weights_2
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_2_succeed()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_IN_ET_MIN_DISTANCE] = 1,

    -- weights_2
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_3_succeed()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_IN_ET_MIN_DISTANCE] = 0,

    -- weights_2
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_1_fails()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_IN_ET_MIN_DISTANCE] = 0,

    -- weights_2
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_tower())
end

function test_pre_evade_enemy_tower_2_fails()
  evasion.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.BOT_IN_ET_MIN_DISTANCE] = 0,

    -- weights_2
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_tower())
end

---------------------------------

function test_pre_use_gust_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.EH_IN_GUST_RANGE] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IS_SILENCED] = 0,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
  })

  luaunit.assertTrue(evasion.pre_use_gust())
end

function test_pre_use_gust_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.EH_IN_GUST_RANGE] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IS_SILENCED] = 0,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
  })

  luaunit.assertFalse(evasion.pre_use_gust())
end

function test_pre_use_gust_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_GUST] = 0,
    [gs.EH_IN_GUST_RANGE] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IS_SILENCED] = 0,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
  })

  luaunit.assertFalse(evasion.pre_use_gust())
end

function test_pre_use_gust_3_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.EH_IN_GUST_RANGE] = 0,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IS_SILENCED] = 0,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
  })

  luaunit.assertFalse(evasion.pre_use_gust())
end

function test_pre_use_gust_4_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.EH_IN_GUST_RANGE] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 0,
    [gs.BOT_IS_SILENCED] = 0,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
  })

  luaunit.assertFalse(evasion.pre_use_gust())
end

function test_pre_use_gust_5_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.EH_IN_GUST_RANGE] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IS_SILENCED] = 1,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
  })

  luaunit.assertFalse(evasion.pre_use_gust())
end

function test_pre_use_gust_6_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.EH_IN_GUST_RANGE] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IS_SILENCED] = 0,
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
  })

  luaunit.assertFalse(evasion.pre_use_gust())
end

function test_pre_use_gust_7_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.EH_IN_GUST_RANGE] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IS_SILENCED] = 0,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
  })

  luaunit.assertFalse(evasion.pre_use_gust())
end

---------------------------------

function test_pre_evade_enemy_hero_with_force_staff_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero_with_force_staff())
end

function test_pre_evade_enemy_hero_with_force_staff_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_force_staff())
end

function test_pre_evade_enemy_hero_with_force_staff_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_force_staff())
end

function test_pre_evade_enemy_hero_with_force_staff_3_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 0,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_force_staff())
end

function test_pre_evade_enemy_hero_with_force_staff_4_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_force_staff())
end

function test_pre_evade_enemy_hero_with_force_staff_5_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_force_staff())
end

---------------------------------

function test_pre_evade_enemy_hero_with_pike_1_succeed()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertTrue(evasion.pre_evade_enemy_hero_with_pike())
end

function test_pre_evade_enemy_hero_with_pike_1_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_pike())
end

function test_pre_evade_enemy_hero_with_pike_2_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_pike())
end

function test_pre_evade_enemy_hero_with_pike_3_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 0,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_pike())
end

function test_pre_evade_enemy_hero_with_pike_4_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_pike())
end

function test_pre_evade_enemy_hero_with_pike_5_fails()
  evasion.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 1,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
  })

  luaunit.assertFalse(evasion.pre_evade_enemy_hero_with_pike())
end

os.exit(luaunit.LuaUnit.run())
