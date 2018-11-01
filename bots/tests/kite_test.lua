package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local kite = require("kite")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_attack_enemy_hero_1_succeed()
  kite.test_SetGameState({
    -- pre_attack_enemy_hero
    [gs.BOT_ATTACK_EH] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,
    [gs.EC_IN_AGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,

    -- pre_attack_enemy_hero
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertTrue(kite.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_2_succeed()
  kite.test_SetGameState({
    -- pre_attack_enemy_hero
    [gs.BOT_ATTACK_EH] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,
    [gs.EC_IN_AGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 1,

    -- pre_attack_enemy_hero
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertTrue(kite.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_1_fails()
  kite.test_SetGameState({
    -- pre_attack_enemy_hero
    [gs.BOT_ATTACK_EH] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,
    [gs.EC_IN_AGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,

    -- pre_attack_enemy_hero
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_2_fails()
  kite.test_SetGameState({
    -- pre_attack_enemy_hero
    [gs.BOT_ATTACK_EH] = 0,
    [gs.EC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,
    [gs.EC_IN_AGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,

    -- pre_attack_enemy_hero
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_3_fails()
  kite.test_SetGameState({
    -- pre_attack_enemy_hero
    [gs.BOT_ATTACK_EH] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = 1,
    [gs.EC_IN_AGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,

    -- pre_attack_enemy_hero
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_4_fails()
  kite.test_SetGameState({
    -- pre_attack_enemy_hero
    [gs.BOT_ATTACK_EH] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,
    [gs.EC_IN_AGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,

    -- pre_attack_enemy_hero
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 0,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_hero())
end

function test_pre_attack_enemy_hero_5_fails()
  kite.test_SetGameState({
    -- pre_attack_enemy_hero
    [gs.BOT_ATTACK_EH] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = 0,
    [gs.EC_IN_AGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,

    -- pre_attack_enemy_hero
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = 1,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_hero())
end

os.exit(luaunit.LuaUnit.run())
