package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local moves = require("moves")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_attack_enemy_creep_1_succeed()
  moves.test_SetGameState({
    [gs.EC_TARGETABLE_PRESENT] = 1,
    [gs.EC_TARGETABLE_IS_TOWER_PROTECTED] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(moves.pre_attack_enemy_creep())
end

function test_pre_attack_enemy_creep_1_fails()
  moves.test_SetGameState({
    [gs.EC_TARGETABLE_PRESENT] = 0,
    [gs.EC_TARGETABLE_IS_TOWER_PROTECTED] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_creep())
end

function test_pre_attack_enemy_creep_2_fails()
  moves.test_SetGameState({
    [gs.EC_TARGETABLE_PRESENT] = 1,
    [gs.EC_TARGETABLE_IS_TOWER_PROTECTED] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_creep())
end

function test_pre_attack_enemy_creep_4_fails()
  moves.test_SetGameState({
    [gs.EC_TARGETABLE_PRESENT] = 1,
    [gs.EC_TARGETABLE_IS_TOWER_PROTECTED] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_creep())
end

---------------------------------

function test_pre_attack_enemy_hero_1_succeed()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_2_succeed()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 1,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_3_succeed()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 1,
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_4_succeed()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 1,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 1,
  })

  luaunit.assertTrue(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_1_fails()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_2_fails()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_3_fails()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_4_fails()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 1,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_5_fails()
  moves.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 1,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 1,
  })

  luaunit.assertFalse(moves.pre_attack_enemy_hero())
end

os.exit(luaunit.LuaUnit.run())
