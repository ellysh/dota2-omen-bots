package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local positioning = require("positioning")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_positioning_1_succeed()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertTrue(positioning.pre_positioning())
end

function test_pre_positioning_2_succeed()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(positioning.pre_positioning())
end

function test_pre_positioning_3_succeed()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 1,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(positioning.pre_positioning())
end

function test_pre_positioning_1_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 1,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

function test_pre_positioning_2_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

function test_pre_positioning_3_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 1,
    [gs.AC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

function test_pre_positioning_4_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

---------------------------------

function test_pre_tp_mid_tower_1_succeed()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IN_MID_TP_DISTANCE] = 1,
  })

  luaunit.assertTrue(positioning.pre_tp_mid_tower())
end

function test_pre_tp_mid_tower_1_fails()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
    [gs.BOT_IN_MID_TP_DISTANCE] = 1,
  })

  luaunit.assertFalse(positioning.pre_tp_mid_tower())
end

function test_pre_tp_mid_tower_2_fails()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IN_MID_TP_DISTANCE] = 1,
  })

  luaunit.assertFalse(positioning.pre_tp_mid_tower())
end

function test_pre_tp_mid_tower_3_fails()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IN_MID_TP_DISTANCE] = 0,
  })

  luaunit.assertFalse(positioning.pre_tp_mid_tower())
end

---------------------------------

function test_pre_increase_creeps_distance_1_succeed()
  positioning.test_SetGameState({
    [gs.EAC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_HAS_BETTER_POSITION] = 1,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 0,
  })

  luaunit.assertTrue(positioning.pre_increase_creeps_distance())
end

function test_pre_increase_creeps_distance_2_succeed()
  positioning.test_SetGameState({
    [gs.EAC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 1,
  })

  luaunit.assertTrue(positioning.pre_increase_creeps_distance())
end

function test_pre_increase_creeps_distance_3_succeed()
  positioning.test_SetGameState({
    [gs.EAC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_HAS_BETTER_POSITION] = 1,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 1,
  })

  luaunit.assertTrue(positioning.pre_increase_creeps_distance())
end

function test_pre_increase_creeps_distance_1_fails()
  positioning.test_SetGameState({
    [gs.EAC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EH_HAS_BETTER_POSITION] = 1,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(positioning.pre_increase_creeps_distance())
end

function test_pre_increase_creeps_distance_2_fails()
  positioning.test_SetGameState({
    [gs.EAC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 0,
  })

  luaunit.assertFalse(positioning.pre_increase_creeps_distance())
end

function test_pre_increase_creeps_distance_3_fails()
  positioning.test_SetGameState({
    [gs.EAC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_HAS_BETTER_POSITION] = 1,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(positioning.pre_increase_creeps_distance())
end

function test_pre_increase_creeps_distance_4_fails()
  positioning.test_SetGameState({
    [gs.EAC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 0,
  })

  luaunit.assertFalse(positioning.pre_increase_creeps_distance())
end

---------------------------------

function test_pre_decrease_creeps_distance_base_1_succeed()
  positioning.test_SetGameState({
    [gs.EC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.AC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
  })

  luaunit.assertTrue(positioning.pre_decrease_creeps_distance_base())
end

function test_pre_decrease_creeps_distance_base_1_fails()
  positioning.test_SetGameState({
    [gs.EC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.AC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_base())
end

function test_pre_decrease_creeps_distance_base_2_fails()
  positioning.test_SetGameState({
    [gs.EC_IN_MAX_BASE_DISTANCE] = 1,
    [gs.AC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_base())
end

function test_pre_decrease_creeps_distance_base_3_fails()
  positioning.test_SetGameState({
    [gs.EC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.AC_IN_MAX_BASE_DISTANCE] = 1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_base())
end

function test_pre_decrease_creeps_distance_base_4_fails()
  positioning.test_SetGameState({
    [gs.EC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.AC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_base())
end

function test_pre_decrease_creeps_distance_base_5_fails()
  positioning.test_SetGameState({
    [gs.EC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.AC_IN_MAX_BASE_DISTANCE] = 0,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 1,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_base())
end

---------------------------------

function test_pre_decrease_creeps_distance_aggro_1_succeed()
  positioning.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertTrue(positioning.pre_decrease_creeps_distance_aggro())
end

function test_pre_decrease_creeps_distance_aggro_1_fails()
  positioning.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_aggro())
end

function test_pre_decrease_creeps_distance_aggro_2_fails()
  positioning.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_aggro())
end

function test_pre_decrease_creeps_distance_aggro_3_fails()
  positioning.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_aggro())
end

function test_pre_decrease_creeps_distance_aggro_4_fails()
  positioning.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_aggro())
end

function test_pre_decrease_creeps_distance_aggro_5_fails()
  positioning.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 1,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_aggro())
end

function test_pre_decrease_creeps_distance_aggro_6_fails()
  positioning.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
  })

  luaunit.assertFalse(positioning.pre_decrease_creeps_distance_aggro())
end

os.exit(luaunit.LuaUnit.run())
