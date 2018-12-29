package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local nuke_enemy_hero = require("nuke_enemy_hero")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_nuke_enemy_hero_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.BOT_HAS_LEVEL_FOR_NUKES] = 1,
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_nuke_enemy_hero())
end

function test_pre_nuke_enemy_hero_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.BOT_HAS_LEVEL_FOR_NUKES] = 0,
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_nuke_enemy_hero())
end

---------------------------------

function test_pre_turn_near_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_turn_near_shadowraze())
end

function test_pre_turn_near_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_near_shadowraze())
end

function test_pre_turn_near_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_near_shadowraze())
end

function test_pre_turn_near_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_near_shadowraze())
end

function test_pre_turn_near_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 1,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_near_shadowraze())
end

function test_pre_turn_near_shadowraze_5_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 0,
    [gs.BOT_IS_TURNING] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_near_shadowraze())
end

---------------------------------

function test_pre_turn_medium_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_turn_medium_shadowraze())
end

function test_pre_turn_medium_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_medium_shadowraze())
end

function test_pre_turn_medium_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_medium_shadowraze())
end

function test_pre_turn_medium_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_medium_shadowraze())
end

function test_pre_turn_medium_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_medium_shadowraze())
end

function test_pre_turn_medium_shadowraze_5_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_medium_shadowraze())
end

---------------------------------

function test_pre_turn_far_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_turn_far_shadowraze())
end

function test_pre_turn_far_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_far_shadowraze())
end

function test_pre_turn_far_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_far_shadowraze())
end

function test_pre_turn_far_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_far_shadowraze())
end

function test_pre_turn_far_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
    [gs.BOT_IS_TURNING] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_far_shadowraze())
end

function test_pre_turn_far_shadowraze_5_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
    [gs.BOT_IS_TURNING] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn_far_shadowraze())
end

---------------------------------

function test_pre_near_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 1,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

---------------------------------

function test_pre_medium_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

---------------------------------

function test_pre_far_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

---------------------------------

function test_pre_requiem_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_REQUIEM ] = 1,
    [gs.EH_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.EH_CAN_EVADE_REQUIEM] = 0,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_requiem())
end

function test_pre_requiem_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_REQUIEM ] = 1,
    [gs.EH_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.EH_CAN_EVADE_REQUIEM] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_requiem())
end

function test_pre_requiem_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_REQUIEM ] = 0,
    [gs.EH_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.EH_CAN_EVADE_REQUIEM] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_requiem())
end

function test_pre_requiem_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_REQUIEM ] = 1,
    [gs.EH_HAS_HP_FOR_REQUIEM] = 0,
    [gs.BOT_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.EH_CAN_EVADE_REQUIEM] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_requiem())
end

function test_pre_requiem_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_REQUIEM ] = 1,
    [gs.EH_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_HP_FOR_REQUIEM] = 0,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.EH_CAN_EVADE_REQUIEM] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_requiem())
end

function test_pre_requiem_5_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_REQUIEM ] = 1,
    [gs.EH_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 0,
    [gs.EH_CAN_EVADE_REQUIEM] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_requiem())
end

function test_pre_requiem_6_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_REQUIEM ] = 1,
    [gs.EH_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_HP_FOR_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.EH_CAN_EVADE_REQUIEM] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_requiem())
end

os.exit(luaunit.LuaUnit.run())
