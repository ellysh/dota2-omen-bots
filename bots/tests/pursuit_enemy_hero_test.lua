package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local pursuit_enemy_hero = require("pursuit_enemy_hero")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_pursuit_enemy_hero_1_succeed()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_2_succeed()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_3_succeed()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 0,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_1_fails()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_2_fails()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_3_fails()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_4_fails()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 0,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_5_fails()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_6_fails()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 1,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

function test_pre_pursuit_enemy_hero_7_fails()
  pursuit_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,

    -- weights_2
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(pursuit_enemy_hero.pre_pursuit_enemy_hero())
end

---------------------------------

function test_pre_move_enemy_hero_with_force_staff_1_succeed()
  pursuit_enemy_hero.test_SetGameState({
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertTrue(
    pursuit_enemy_hero.pre_move_enemy_hero_with_force_staff())
end

function test_pre_move_enemy_hero_with_force_staff_1_fails()
  pursuit_enemy_hero.test_SetGameState({
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(
    pursuit_enemy_hero.pre_move_enemy_hero_with_force_staff())
end

function test_pre_move_enemy_hero_with_force_staff_2_fails()
  pursuit_enemy_hero.test_SetGameState({
    [gs.BOT_CASTABLE_FORCE_STAFF] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
  })

  luaunit.assertFalse(
    pursuit_enemy_hero.pre_move_enemy_hero_with_force_staff())
end

---------------------------------

function test_pre_move_enemy_hero_with_pike_1_succeed()
  pursuit_enemy_hero.test_SetGameState({
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertTrue(
    pursuit_enemy_hero.pre_move_enemy_hero_with_pike())
end

function test_pre_move_enemy_hero_with_pike_1_fails()
  pursuit_enemy_hero.test_SetGameState({
    [gs.BOT_CASTABLE_PIKE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(
    pursuit_enemy_hero.pre_move_enemy_hero_with_pike())
end

function test_pre_move_enemy_hero_with_pike_2_fails()
  pursuit_enemy_hero.test_SetGameState({
    [gs.BOT_CASTABLE_PIKE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
  })

  luaunit.assertFalse(
    pursuit_enemy_hero.pre_move_enemy_hero_with_pike())
end

os.exit(luaunit.LuaUnit.run())
