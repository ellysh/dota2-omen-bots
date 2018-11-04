package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local nuke_enemy_hero = require("nuke_enemy_hero")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_turn_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_2_succeed()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_3_succeed()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_1_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_2_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_3_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_4_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_5_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_6_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_7_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_8_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

function test_pre_turn_9_fails()
  nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,

    -- weights_3
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_turn())
end

---------------------------------

function test_pre_near_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

function test_pre_near_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_near_shadowraze())
end

---------------------------------

function test_pre_medium_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

function test_pre_medium_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_medium_shadowraze())
end

---------------------------------

function test_pre_far_shadowraze_1_succeed()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertTrue(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_1_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_2_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_3_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

function test_pre_far_shadowraze_4_fails()
  nuke_enemy_hero.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,
  })

  luaunit.assertFalse(nuke_enemy_hero.pre_far_shadowraze())
end

os.exit(luaunit.LuaUnit.run())
