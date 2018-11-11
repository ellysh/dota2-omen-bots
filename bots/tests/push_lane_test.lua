package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local push_lane = require("push_lane")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_push_lane_1_succeed()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(push_lane.pre_push_lane())
end

function test_pre_push_lane_1_fails()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(push_lane.pre_push_lane())
end

function test_pre_push_lane_2_fails()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(push_lane.pre_push_lane())
end

function test_pre_push_lane_3_fails()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(push_lane.pre_push_lane())
end

---------------------------------

function test_pre_attack_enemy_creep_1_succeed()
  push_lane.test_SetGameState({
    -- pre_attack_enemy_creep
    [gs.EH_PRESENT] = 1,

    -- moves.pre_attack_enemy_creep
    [gs.EC_MAX_HP_TARGETABLE_PRESENT] = 1,
    [gs.EC_MAX_HP_TARGETABLE_IS_TOWER_PROTECTED] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(push_lane.pre_attack_enemy_creep())
end

function test_pre_attack_enemy_creep_1_fails()
  push_lane.test_SetGameState({
    -- pre_attack_enemy_creep
    [gs.EH_PRESENT] = 0,

    -- moves.pre_attack_enemy_creep
    [gs.EC_MAX_HP_TARGETABLE_PRESENT] = 1,
    [gs.EC_MAX_HP_TARGETABLE_IS_TOWER_PROTECTED] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(push_lane.pre_attack_enemy_creep())
end

function test_pre_attack_enemy_creep_2_fails()
  push_lane.test_SetGameState({
    -- pre_attack_enemy_creep
    [gs.EH_PRESENT] = 1,

    -- moves.pre_attack_enemy_creep
    [gs.EC_MAX_HP_TARGETABLE_PRESENT] = 0,
    [gs.EC_MAX_HP_TARGETABLE_IS_TOWER_PROTECTED] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(push_lane.pre_attack_enemy_creep())
end

---------------------------------

function test_pre_kill_enemy_creep_1_succeed()
  push_lane.test_SetGameState({
    [gs.EC_MIN_HP_TARGETABLE_PRESENT] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED] = 0,
  })

  luaunit.assertTrue(push_lane.pre_kill_enemy_creep())
end

function test_pre_kill_enemy_creep_1_fails()
  push_lane.test_SetGameState({
    [gs.EC_MIN_HP_TARGETABLE_PRESENT] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED] = 0,
  })

  luaunit.assertFalse(push_lane.pre_kill_enemy_creep())
end

function test_pre_kill_enemy_creep_2_fails()
  push_lane.test_SetGameState({
    [gs.EC_MIN_HP_TARGETABLE_PRESENT] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED] = 0,
  })

  luaunit.assertFalse(push_lane.pre_kill_enemy_creep())
end

function test_pre_kill_enemy_creep_3_fails()
  push_lane.test_SetGameState({
    [gs.EC_MIN_HP_TARGETABLE_PRESENT] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED] = 0,
  })

  luaunit.assertFalse(push_lane.pre_kill_enemy_creep())
end

function test_pre_kill_enemy_creep_4_fails()
  push_lane.test_SetGameState({
    [gs.EC_MIN_HP_TARGETABLE_PRESENT] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED] = 1,
  })

  luaunit.assertFalse(push_lane.pre_kill_enemy_creep())
end

---------------------------------

function test_pre_attack_enemy_tower_1_succeed()
  push_lane.test_SetGameState({
    [gs.ET_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.ET_ATTACK_AC] = 1,
  })

  luaunit.assertTrue(push_lane.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_1_fails()
  push_lane.test_SetGameState({
    [gs.ET_IS_VISIBLE] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.ET_ATTACK_AC] = 1,
  })

  luaunit.assertFalse(push_lane.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_2_fails()
  push_lane.test_SetGameState({
    [gs.ET_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.ET_ATTACK_AC] = 1,
  })

  luaunit.assertFalse(push_lane.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_3_fails()
  push_lane.test_SetGameState({
    [gs.ET_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 0,
    [gs.ET_ATTACK_AC] = 0,
  })

  luaunit.assertFalse(push_lane.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_4_fails()
  push_lane.test_SetGameState({
    [gs.ET_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 1,
    [gs.ET_ATTACK_AC] = 1,
  })

  luaunit.assertFalse(push_lane.pre_attack_enemy_tower())
end

---------------------------------

function test_pre_destroy_enemy_tower_1_succeed()
  push_lane.test_SetGameState({
    -- weights_1
    [gs.ET_IS_LOW_HP] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.ET_IS_VISIBLE] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.5,
  })

  luaunit.assertTrue(push_lane.pre_destroy_enemy_tower())
end

function test_pre_destroy_enemy_tower_2_succeed()
  push_lane.test_SetGameState({
    -- weights_1
    [gs.ET_IS_LOW_HP] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.ET_IS_VISIBLE] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.51,
  })

  luaunit.assertTrue(push_lane.pre_destroy_enemy_tower())
end

function test_pre_destroy_enemy_tower_1_fails()
  push_lane.test_SetGameState({
    -- weights_1
    [gs.ET_IS_LOW_HP] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.ET_IS_VISIBLE] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.5,
  })

  luaunit.assertFalse(push_lane.pre_destroy_enemy_tower())
end

function test_pre_destroy_enemy_tower_2_fails()
  push_lane.test_SetGameState({
    -- weights_1
    [gs.ET_IS_LOW_HP] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.ET_IS_VISIBLE] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.5,
  })

  luaunit.assertFalse(push_lane.pre_destroy_enemy_tower())
end

function test_pre_destroy_enemy_tower_3_fails()
  push_lane.test_SetGameState({
    -- weights_1
    [gs.ET_IS_LOW_HP] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.ET_IS_VISIBLE] = 0,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.5,
  })

  luaunit.assertFalse(push_lane.pre_destroy_enemy_tower())
end

function test_pre_destroy_enemy_tower_4_fails()
  push_lane.test_SetGameState({
    -- weights_1
    [gs.ET_IS_LOW_HP] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.ET_IS_VISIBLE] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 1,
    [gs.BOT_HP_RATE] = 1,
  })

  luaunit.assertFalse(push_lane.pre_destroy_enemy_tower())
end

function test_pre_destroy_enemy_tower_5_fails()
  push_lane.test_SetGameState({
    -- weights_1
    [gs.ET_IS_LOW_HP] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.ET_IS_VISIBLE] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.49,
  })

  luaunit.assertFalse(push_lane.pre_destroy_enemy_tower())
end

os.exit(luaunit.LuaUnit.run())
