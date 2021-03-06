package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local close_fight = require("close_fight")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_close_fight_1_succeed()
  close_fight.test_SetGameState({
    [gs.BOT_IS_CASTING] = 0,
    [gs.EH_IS_VISIBLE] = 1,
  })

  luaunit.assertTrue(close_fight.pre_close_fight())
end

function test_pre_close_fight_1_fails()
  close_fight.test_SetGameState({
    [gs.BOT_IS_CASTING] = 0,
    [gs.EH_IS_VISIBLE] = 0,
  })

  luaunit.assertFalse(close_fight.pre_close_fight())
end

function test_pre_close_fight_2_fails()
  close_fight.test_SetGameState({
    [gs.BOT_IS_CASTING] = 1,
    [gs.EH_IS_VISIBLE] = 1,
  })

  luaunit.assertFalse(close_fight.pre_close_fight())
end

---------------------------------

function test_pre_kill_enemy_hero_1_succeed()
  close_fight.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 1,
    [gs.BOT_ATTACK_EH] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
  })

  luaunit.assertTrue(close_fight.pre_kill_enemy_hero())
end

function test_pre_kill_enemy_hero_2_succeed()
  close_fight.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 1,
    [gs.BOT_ATTACK_EH] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
  })

  luaunit.assertTrue(close_fight.pre_kill_enemy_hero())
end

function test_pre_kill_enemy_hero_3_succeed()
  close_fight.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 1,
    [gs.BOT_ATTACK_EH] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
  })

  luaunit.assertTrue(close_fight.pre_kill_enemy_hero())
end

function test_pre_kill_enemy_hero_1_fails()
  close_fight.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 0,
    [gs.BOT_ATTACK_EH] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(close_fight.pre_kill_enemy_hero())
end

function test_pre_kill_enemy_hero_2_fails()
  close_fight.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 1,
    [gs.BOT_ATTACK_EH] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 1,
  })

  luaunit.assertFalse(close_fight.pre_kill_enemy_hero())
end

function test_pre_kill_enemy_hero_3_fails()
  close_fight.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 0,
    [gs.BOT_ATTACK_EH] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(close_fight.pre_kill_enemy_hero())
end

function test_pre_kill_enemy_hero_4_fails()
  close_fight.test_SetGameState({
    [gs.EH_HAS_LESS_HTD] = 1,
    [gs.BOT_ATTACK_EH] = 0,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = 1,
  })

  luaunit.assertFalse(close_fight.pre_kill_enemy_hero())
end

os.exit(luaunit.LuaUnit.run())
