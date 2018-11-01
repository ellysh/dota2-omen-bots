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

---------------------------------

function test_pre_attack_enemy_tower_1_succeed()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.ET_ATTACK_AC] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0,
  })

  luaunit.assertTrue(kite.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_2_succeed()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.ET_ATTACK_AC] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.6,
  })

  luaunit.assertTrue(kite.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_1_fails()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.ET_ATTACK_AC] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_2_fails()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.ET_ATTACK_AC] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_3_fails()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.ET_ATTACK_AC] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_4_fails()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.ET_ATTACK_AC] = 0,

    -- weights_2
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_5_fails()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.ET_ATTACK_AC] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 1,
    [gs.BOT_HP_RATE] = 1,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_tower())
end

function test_pre_attack_enemy_tower_6_fails()
  kite.test_SetGameState({
    -- weights_1
    [gs.ET_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.ET_ATTACK_AC] = 1,

    -- weights_2
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_EH_MIN_DISTANCE] = 0,
    [gs.BOT_HP_RATE] = 0.4,
  })

  luaunit.assertFalse(kite.pre_attack_enemy_tower())
end

---------------------------------

function test_pre_move_safe_1_succeed()
  kite.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_ATTACK_EH] = 1,
    [gs.BOT_MOVING] = 0,
  })

  luaunit.assertTrue(kite.pre_move_safe())
end

function test_pre_move_safe_1_fails()
  kite.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.BOT_ATTACK_EH] = 1,
    [gs.BOT_MOVING] = 0,
  })

  luaunit.assertFalse(kite.pre_move_safe())
end

function test_pre_move_safe_2_fails()
  kite.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_ATTACK_EH] = 0,
    [gs.BOT_MOVING] = 0,
  })

  luaunit.assertFalse(kite.pre_move_safe())
end

function test_pre_move_safe_3_fails()
  kite.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_ATTACK_EH] = 1,
    [gs.BOT_MOVING] = 1,
  })

  luaunit.assertFalse(kite.pre_move_safe())
end

os.exit(luaunit.LuaUnit.run())
