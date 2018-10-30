package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local glyph = require("glyph")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_do_glyph_1_succeed()
  glyph.test_SetGameState({
    [gs.AT_PRESENT] = 1,
    [gs.AT_GLYPH_READY] = 1,
    [gs.AT_INCOMING_DAMAGE] = 1,
    [gs.AT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(glyph.pre_do_glyph())
end

function test_pre_do_glyph_2_succeed()
  glyph.test_SetGameState({
    [gs.AT_PRESENT] = 1,
    [gs.AT_GLYPH_READY] = 1,
    [gs.AT_INCOMING_DAMAGE] = 0.16,
    [gs.AT_IS_LOW_HP] = 1,
  })

  luaunit.assertTrue(glyph.pre_do_glyph())
end

function test_pre_do_glyph_1_fails()
  glyph.test_SetGameState({
    [gs.AT_PRESENT] = 1,
    [gs.AT_GLYPH_READY] = 1,
    [gs.AT_INCOMING_DAMAGE] = 0.9,
    [gs.AT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_2_fails()
  glyph.test_SetGameState({
    [gs.AT_PRESENT] = 1,
    [gs.AT_GLYPH_READY] = 1,
    [gs.AT_INCOMING_DAMAGE] = 0.14,
    [gs.AT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_3_fails()
  glyph.test_SetGameState({
    [gs.AT_PRESENT] = 0,
    [gs.AT_GLYPH_READY] = 1,
    [gs.AT_INCOMING_DAMAGE] = 1,
    [gs.AT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_4_fails()
  glyph.test_SetGameState({
    [gs.AT_PRESENT] = 1,
    [gs.AT_GLYPH_READY] = 0,
    [gs.AT_INCOMING_DAMAGE] = 1,
    [gs.AT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_5_fails()
  glyph.test_SetGameState({
    [gs.AT_PRESENT] = 1,
    [gs.AT_GLYPH_READY] = 1,
    [gs.AT_INCOMING_DAMAGE] = 0,
    [gs.AT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

os.exit(luaunit.LuaUnit.run())
