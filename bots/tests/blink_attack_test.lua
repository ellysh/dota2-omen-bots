package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local blink_attack = require("blink_attack")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_blink_attack_1_succeed()
  blink_attack.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 1,

    -- pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(blink_attack.pre_blink_attack())
end

function test_pre_blink_attack_1_fails()
  blink_attack.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 0,

    -- pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(blink_attack.pre_blink_attack())
end

---------------------------------

function test_pre_blink_1_succeed()
  blink_attack.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_BLINK] = 1,
    [gs.EH_IN_BLINK_RANGE] = 1,
    [gs.EH_HAS_HP_FOR_BLINK] = 1,
  })

  luaunit.assertTrue(blink_attack.pre_blink())
end

function test_pre_blink_1_fails()
  blink_attack.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_BLINK] = 1,
    [gs.EH_IN_BLINK_RANGE] = 1,
    [gs.EH_HAS_HP_FOR_BLINK] = 1,
  })

  luaunit.assertFalse(blink_attack.pre_blink())
end

function test_pre_blink_2_fails()
  blink_attack.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_BLINK] = 0,
    [gs.EH_IN_BLINK_RANGE] = 1,
    [gs.EH_HAS_HP_FOR_BLINK] = 1,
  })

  luaunit.assertFalse(blink_attack.pre_blink())
end

function test_pre_blink_3_fails()
  blink_attack.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_BLINK] = 1,
    [gs.EH_IN_BLINK_RANGE] = 0,
    [gs.EH_HAS_HP_FOR_BLINK] = 1,
  })

  luaunit.assertFalse(blink_attack.pre_blink())
end

function test_pre_blink_4_fails()
  blink_attack.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_BLINK] = 1,
    [gs.EH_IN_BLINK_RANGE] = 1,
    [gs.EH_HAS_HP_FOR_BLINK] = 0,
  })

  luaunit.assertFalse(blink_attack.pre_blink())
end

---------------------------------

function test_pre_use_gust_1_succeed()
  blink_attack.test_SetGameState({
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.BOT_IN_EH_LOCATION] = 1,
    [gs.BOT_IS_SILENCED] = 0,
  })

  luaunit.assertTrue(blink_attack.pre_use_gust())
end

function test_pre_use_gust_1_fails()
  blink_attack.test_SetGameState({
    [gs.BOT_CASTABLE_GUST] = 0,
    [gs.BOT_IN_EH_LOCATION] = 1,
    [gs.BOT_IS_SILENCED] = 0,
  })

  luaunit.assertFalse(blink_attack.pre_use_gust())
end

function test_pre_use_gust_2_fails()
  blink_attack.test_SetGameState({
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.BOT_IN_EH_LOCATION] = 0,
    [gs.BOT_IS_SILENCED] = 0,
  })

  luaunit.assertFalse(blink_attack.pre_use_gust())
end

function test_pre_use_gust_3_fails()
  blink_attack.test_SetGameState({
    [gs.BOT_CASTABLE_GUST] = 1,
    [gs.BOT_IN_EH_LOCATION] = 1,
    [gs.BOT_IS_SILENCED] = 1,
  })

  luaunit.assertFalse(blink_attack.pre_use_gust())
end

os.exit(luaunit.LuaUnit.run())
