package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local strategies = require("strategies")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_assault_enemy_tower_1_succeed()
  strategies.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.ET_ATTACK_AC] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(strategies.pre_assault_enemy_tower())
end

function test_pre_assault_enemy_tower_2_succeed()
  strategies.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
    [gs.ET_ATTACK_AC] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertTrue(strategies.pre_assault_enemy_tower())
end

function test_pre_assault_enemy_tower_1_fails()
  strategies.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.ET_ATTACK_AC] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(strategies.pre_assault_enemy_tower())
end

function test_pre_assault_enemy_tower_2_fails()
  strategies.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.ET_ATTACK_AC] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(strategies.pre_assault_enemy_tower())
end

function test_pre_assault_enemy_tower_3_fails()
  strategies.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.ET_ATTACK_AC] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(strategies.pre_assault_enemy_tower())
end

function test_pre_assault_enemy_tower_4_fails()
  strategies.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.ET_ATTACK_AC] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(strategies.pre_assault_enemy_tower())
end

function test_pre_assault_enemy_tower_4_fails()
  strategies.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0,
    [gs.ET_ATTACK_AC] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(strategies.pre_assault_enemy_tower())
end

os.exit(luaunit.LuaUnit.run())
