package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local keep_equilibrium = require("keep_equilibrium")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_keep_equilibrium_1_succeed()
  keep_equilibrium.test_SetGameState({
    -- pre_keep_equilibrium
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(keep_equilibrium.pre_keep_equilibrium())
end

function test_pre_keep_equilibrium_1_fails()
  keep_equilibrium.test_SetGameState({
    -- pre_keep_equilibrium
    [gs.EC_BACK_PRESENT] = 1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(keep_equilibrium.pre_keep_equilibrium())
end

function test_pre_keep_equilibrium_2_fails()
  keep_equilibrium.test_SetGameState({
    -- pre_keep_equilibrium
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.AC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(keep_equilibrium.pre_keep_equilibrium())
end

function test_pre_keep_equilibrium_3_fails()
  keep_equilibrium.test_SetGameState({
    -- pre_keep_equilibrium
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(keep_equilibrium.pre_keep_equilibrium())
end

function test_pre_keep_equilibrium_4_fails()
  keep_equilibrium.test_SetGameState({
    -- pre_keep_equilibrium
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(keep_equilibrium.pre_keep_equilibrium())
end

function test_pre_keep_equilibrium_5_fails()
  keep_equilibrium.test_SetGameState({
    -- pre_keep_equilibrium
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
  })

  luaunit.assertFalse(keep_equilibrium.pre_keep_equilibrium())
end

function test_pre_keep_equilibrium_6_fails()
  keep_equilibrium.test_SetGameState({
    -- pre_keep_equilibrium
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.AC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(keep_equilibrium.pre_keep_equilibrium())
end

os.exit(luaunit.LuaUnit.run())
