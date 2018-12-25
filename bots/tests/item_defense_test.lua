package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local item_defense = require("item_defense")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_item_defense_1_succeed()
  item_defense.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_NEAR_FOUNTAIN] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(item_defense.pre_item_defense())
end

function test_pre_item_defense_1_fails()
  item_defense.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_NEAR_FOUNTAIN] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(item_defense.pre_item_defense())
end

function test_pre_item_defense_2_fails()
  item_defense.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_NEAR_FOUNTAIN] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(item_defense.pre_item_defense())
end

function test_pre_item_defense_3_fails()
  item_defense.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_NEAR_FOUNTAIN] = 0,
    [gs.BOT_IS_CASTING] = 1,
  })

  luaunit.assertFalse(item_defense.pre_item_defense())
end

---------------------------------

function test_pre_use_hood_vs_near_shadowraze_1_succeed()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IS_FACING_BOT_MELEE_RANGE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
  })

  luaunit.assertTrue(item_defense.pre_use_hood_vs_near_shadowraze())
end

function test_pre_use_hood_vs_near_shadowraze_1_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 0,
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IS_FACING_BOT_MELEE_RANGE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_near_shadowraze())
end

function test_pre_use_hood_vs_near_shadowraze_2_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 0,
    [gs.EH_IS_FACING_BOT_MELEE_RANGE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_near_shadowraze())
end

function test_pre_use_hood_vs_near_shadowraze_3_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IS_FACING_BOT_MELEE_RANGE] = 0,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_near_shadowraze())
end

function test_pre_use_hood_vs_near_shadowraze_4_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 1,
    [gs.EH_IS_FACING_BOT_MELEE_RANGE] = 1,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_near_shadowraze())
end

---------------------------------

function test_pre_use_hood_vs_medium_shadowraze_1_succeed()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertTrue(item_defense.pre_use_hood_vs_medium_shadowraze())
end

function test_pre_use_hood_vs_medium_shadowraze_1_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 0,
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_medium_shadowraze())
end

function test_pre_use_hood_vs_medium_shadowraze_2_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_medium_shadowraze())
end

function test_pre_use_hood_vs_medium_shadowraze_3_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_medium_shadowraze())
end

function test_pre_use_hood_vs_medium_shadowraze_4_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 0,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_medium_shadowraze())
end

---------------------------------

function test_pre_use_hood_vs_far_shadowraze_1_succeed()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertTrue(item_defense.pre_use_hood_vs_far_shadowraze())
end

function test_pre_use_hood_vs_far_shadowraze_1_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 0,
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_far_shadowraze())
end

function test_pre_use_hood_vs_far_shadowraze_2_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_far_shadowraze())
end

function test_pre_use_hood_vs_far_shadowraze_3_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0,
    [gs.EH_IS_FACING_BOT] = 1,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_far_shadowraze())
end

function test_pre_use_hood_vs_far_shadowraze_4_fails()
  item_defense.test_SetGameState({
    [gs.BOT_CASTABLE_HOOD] = 1,
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 1,
    [gs.EH_IS_FACING_BOT] = 0,
  })

  luaunit.assertFalse(item_defense.pre_use_hood_vs_far_shadowraze())
end

---------------------------------

os.exit(luaunit.LuaUnit.run())
