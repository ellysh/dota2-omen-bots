package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local buyback = require("buyback")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_do_buyback_1_succeed()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_HAS_BUYBACK] = 1,
    [gs.BOT_RESPAWN_TIME] = 1,
  })

  luaunit.assertTrue(buyback.pre_do_buyback())
end

function test_pre_do_buyback_1_fails()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_HAS_BUYBACK] = 1,
    [gs.BOT_RESPAWN_TIME] = 1,
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_2_fails()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_HAS_BUYBACK] = 0,
    [gs.BOT_RESPAWN_TIME] = 1,
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_3_fails()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_HAS_BUYBACK] = 1,
    [gs.BOT_RESPAWN_TIME] = 0,
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_4_fails()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_HAS_BUYBACK] = 0,
    [gs.BOT_RESPAWN_TIME] = 1,
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_5_fails()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_HAS_BUYBACK] = 0,
    [gs.BOT_RESPAWN_TIME] = 0,
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_6_fails()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_HAS_BUYBACK] = 1,
    [gs.BOT_RESPAWN_TIME] = 0,
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_7_fails()
  buyback.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_HAS_BUYBACK] = 0,
    [gs.BOT_RESPAWN_TIME] = 0,
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

os.exit(luaunit.LuaUnit.run())
