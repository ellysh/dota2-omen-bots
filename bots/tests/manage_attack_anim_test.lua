package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local manage_attack_anim = require("manage_attack_anim")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_cancel_attack_1_succeed()
  manage_attack_anim.test_SetGameState({
    [gs.BOT_DOES_BACKSWING] = 1,
    [gs.BOT_HAS_PIKE_MODIFIER] = 0,
  })

  luaunit.assertTrue(manage_attack_anim.pre_cancel_attack())
end

function test_pre_cancel_attack_1_fails()
  manage_attack_anim.test_SetGameState({
    [gs.BOT_DOES_BACKSWING] = 0,
    [gs.BOT_HAS_PIKE_MODIFIER] = 0,
  })

  luaunit.assertFalse(manage_attack_anim.pre_cancel_attack())
end

function test_pre_cancel_attack_2_fails()
  manage_attack_anim.test_SetGameState({
    [gs.BOT_DOES_BACKSWING] = 1,
    [gs.BOT_HAS_PIKE_MODIFIER] = 1,
  })

  luaunit.assertFalse(manage_attack_anim.pre_cancel_attack())
end

---------------------------------

function test_pre_wait_attack_1_succeed()
  manage_attack_anim.test_SetGameState({
    [gs.BOT_IS_ATTACKING] = 1,
  })

  luaunit.assertTrue(manage_attack_anim.pre_wait_attack())
end

function test_pre_wait_attack_1_fails()
  manage_attack_anim.test_SetGameState({
    [gs.BOT_IS_ATTACKING] = 0,
  })

  luaunit.assertFalse(manage_attack_anim.pre_wait_attack())
end

---------------------------------

os.exit(luaunit.LuaUnit.run())
