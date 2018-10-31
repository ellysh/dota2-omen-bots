package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local attack_with_better_position = require("attack_with_better_position")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_attack_with_better_position_1_succeed()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_1_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_2_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_3_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

---------------------------------

function test_pre_attack_enemy_hero_from_hg_1_succeed()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.BOT_HAS_BETTER_POSITION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

function test_pre_attack_enemy_hero_from_hg_2_succeed()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.BOT_HAS_BETTER_POSITION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

function test_pre_attack_enemy_hero_from_hg_1_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.BOT_HAS_BETTER_POSITION] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

function test_pre_attack_enemy_hero_from_hg_2_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.BOT_HAS_BETTER_POSITION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

function test_pre_attack_enemy_hero_from_hg_3_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.BOT_HAS_BETTER_POSITION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

function test_pre_attack_enemy_hero_from_hg_4_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.BOT_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

function test_pre_attack_enemy_hero_from_hg_5_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.7,
    [gs.BOT_HAS_BETTER_POSITION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_from_hg())
end

---------------------------------

function test_pre_attack_enemy_hero_with_incoming_damage_1_succeed()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.EH_INCOMING_DAMAGE] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

function test_pre_attack_enemy_hero_with_incoming_damage_2_succeed()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.EH_INCOMING_DAMAGE] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

function test_pre_attack_enemy_hero_with_incoming_damage_1_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.6,
    [gs.EH_INCOMING_DAMAGE] = 0.5,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

function test_pre_attack_enemy_hero_with_incoming_damage_2_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.EH_INCOMING_DAMAGE] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

function test_pre_attack_enemy_hero_with_incoming_damage_3_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.EH_INCOMING_DAMAGE] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

function test_pre_attack_enemy_hero_with_incoming_damage_4_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.EH_INCOMING_DAMAGE] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

function test_pre_attack_enemy_hero_with_incoming_damage_5_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.EH_INCOMING_DAMAGE] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

function test_pre_attack_enemy_hero_with_incoming_damage_6_fails()
  attack_with_better_position.test_SetGameState({
    [gs.BOT_INCOMING_DAMAGE] = 0.5,
    [gs.EH_INCOMING_DAMAGE] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_enemy_hero_with_incoming_damage())
end

os.exit(luaunit.LuaUnit.run())
