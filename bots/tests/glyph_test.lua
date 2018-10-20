package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local glyph = require("glyph")
local luaunit = require("luaunit")

function test_pre_do_glyph_1_succeed()
  glyph.test_SetAllyTowerState({
    [1] = 1,  -- env.ALLY_TOWER_DATA ~= nil
    [2] = 1,  -- GetGlyphCooldown() == 0
    [3] = 1,  -- GetAllyTowerIncomingDamage()
    [4] = 0,  -- IsUnitLowHp(env.ALLY_TOWER_DATA)
  })

  luaunit.assertTrue(glyph.pre_do_glyph())
end

function test_pre_do_glyph_2_succeed()
  glyph.test_SetAllyTowerState({
    [1] = 1,  -- env.ALLY_TOWER_DATA ~= nil
    [2] = 1,  -- GetGlyphCooldown() == 0
    [3] = 0.16,  -- GetAllyTowerIncomingDamage()
    [4] = 1,  -- IsUnitLowHp(env.ALLY_TOWER_DATA)
  })

  luaunit.assertTrue(glyph.pre_do_glyph())
end

function test_pre_do_glyph_1_fails()
  glyph.test_SetAllyTowerState({
    [1] = 1,  -- env.ALLY_TOWER_DATA ~= nil
    [2] = 1,  -- GetGlyphCooldown() == 0
    [3] = 0.9,  -- GetAllyTowerIncomingDamage()
    [4] = 0,  -- IsUnitLowHp(env.ALLY_TOWER_DATA)
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_2_fails()
  glyph.test_SetAllyTowerState({
    [1] = 1,  -- env.ALLY_TOWER_DATA ~= nil
    [2] = 1,  -- GetGlyphCooldown() == 0
    [3] = 0.14,  -- GetAllyTowerIncomingDamage()
    [4] = 1,  -- IsUnitLowHp(env.ALLY_TOWER_DATA)
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_3_fails()
  glyph.test_SetAllyTowerState({
    [1] = 0,  -- env.ALLY_TOWER_DATA ~= nil
    [2] = 1,  -- GetGlyphCooldown() == 0
    [3] = 1,  -- GetAllyTowerIncomingDamage()
    [4] = 1,  -- IsUnitLowHp(env.ALLY_TOWER_DATA)
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_4_fails()
  glyph.test_SetAllyTowerState({
    [1] = 1,  -- env.ALLY_TOWER_DATA ~= nil
    [2] = 0,  -- GetGlyphCooldown() == 0
    [3] = 1,  -- GetAllyTowerIncomingDamage()
    [4] = 1,  -- IsUnitLowHp(env.ALLY_TOWER_DATA)
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

function test_pre_do_glyph_5_fails()
  glyph.test_SetAllyTowerState({
    [1] = 1,  -- env.ALLY_TOWER_DATA ~= nil
    [2] = 1,  -- GetGlyphCooldown() == 0
    [3] = 0,  -- GetAllyTowerIncomingDamage()
    [4] = 1,  -- IsUnitLowHp(env.ALLY_TOWER_DATA)
  })

  luaunit.assertFalse(glyph.pre_do_glyph())
end

os.exit(luaunit.LuaUnit.run())
