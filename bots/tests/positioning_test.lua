package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local positioning = require("positioning")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_positioning_1_succeed()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertTrue(positioning.pre_positioning())
end

function test_pre_positioning_2_succeed()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(positioning.pre_positioning())
end

function test_pre_positioning_3_succeed()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 1,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(positioning.pre_positioning())
end

function test_pre_positioning_1_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 1,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

function test_pre_positioning_2_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

function test_pre_positioning_3_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 1,
    [gs.AC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

function test_pre_positioning_4_fails()
  positioning.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = 0,
    [gs.AC_BACK_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(positioning.pre_positioning())
end

---------------------------------

function test_pre_tp_mid_tower_1_succeed()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IN_MID_TP_DISTANCE] = 1,
  })

  luaunit.assertTrue(positioning.pre_tp_mid_tower())
end

function test_pre_tp_mid_tower_1_fails()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
    [gs.BOT_IN_MID_TP_DISTANCE] = 1,
  })

  luaunit.assertFalse(positioning.pre_tp_mid_tower())
end

function test_pre_tp_mid_tower_2_fails()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 0,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IN_MID_TP_DISTANCE] = 1,
  })

  luaunit.assertFalse(positioning.pre_tp_mid_tower())
end

function test_pre_tp_mid_tower_3_fails()
  positioning.test_SetGameState({
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 0,
    [gs.BOT_IN_MID_TP_DISTANCE] = 0,
  })

  luaunit.assertFalse(positioning.pre_tp_mid_tower())
end

os.exit(luaunit.LuaUnit.run())
