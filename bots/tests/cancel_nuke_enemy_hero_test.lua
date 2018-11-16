package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local cancel_nuke_enemy_hero = require("cancel_nuke_enemy_hero")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_cancel_near_shadowraze_1_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_NEAR_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_near_shadowraze())
end

function test_pre_cancel_near_shadowraze_2_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_NEAR_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_near_shadowraze())
end

function test_pre_cancel_near_shadowraze_3_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_IS_CASTING_NEAR_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_near_shadowraze())
end

function test_pre_cancel_near_shadowraze_1_fails()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_NEAR_SHADOWRAZE] = 1,
  })

  luaunit.assertFalse(cancel_nuke_enemy_hero.pre_cancel_near_shadowraze())
end

function test_pre_cancel_near_shadowraze_2_fails()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_NEAR_SHADOWRAZE] = 0,
  })

  luaunit.assertFalse(cancel_nuke_enemy_hero.pre_cancel_near_shadowraze())
end

---------------------------------

function test_pre_cancel_medium_shadowraze_1_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_medium_shadowraze())
end

function test_pre_cancel_medium_shadowraze_2_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_medium_shadowraze())
end

function test_pre_cancel_medium_shadowraze_3_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_medium_shadowraze())
end

function test_pre_cancel_medium_shadowraze_1_fails()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
  })

  luaunit.assertFalse(cancel_nuke_enemy_hero.pre_cancel_medium_shadowraze())
end

function test_pre_cancel_medium_shadowraze_2_fails()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_MEDIUM_SHADOWRAZE] = 0,
  })

  luaunit.assertFalse(cancel_nuke_enemy_hero.pre_cancel_medium_shadowraze())
end

---------------------------------

function test_pre_cancel_far_shadowraze_1_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_FAR_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_far_shadowraze())
end

function test_pre_cancel_far_shadowraze_2_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_FAR_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_far_shadowraze())
end

function test_pre_cancel_far_shadowraze_3_succeed()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 0,

    -- weights_2
    [gs.BOT_IS_CASTING_FAR_SHADOWRAZE] = 1,
  })

  luaunit.assertTrue(cancel_nuke_enemy_hero.pre_cancel_far_shadowraze())
end

function test_pre_cancel_far_shadowraze_1_fails()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_FAR_SHADOWRAZE] = 1,
  })

  luaunit.assertFalse(cancel_nuke_enemy_hero.pre_cancel_far_shadowraze())
end

function test_pre_cancel_far_shadowraze_2_fails()
  cancel_nuke_enemy_hero.test_SetGameState({
    -- weights_1
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.BOT_IS_FACING_EH] = 1,

    -- weights_2
    [gs.BOT_IS_CASTING_FAR_SHADOWRAZE] = 0,
  })

  luaunit.assertFalse(cancel_nuke_enemy_hero.pre_cancel_far_shadowraze())
end

os.exit(luaunit.LuaUnit.run())
