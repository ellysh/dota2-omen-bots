package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local body_block = require("body_block")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_move_start_position_1_succeed()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 0,
  })

  luaunit.assertTrue(body_block.pre_move_start_position())
end

function test_pre_move_start_position_1_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_start_position())
end

function test_pre_move_start_position_2_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
  })

  luaunit.assertFalse(body_block.pre_move_start_position())
end

function test_pre_move_start_position_3_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
  })

  luaunit.assertFalse(body_block.pre_move_start_position())
end

---------------------------------

function test_pre_turn_enemy_fountain_1_succeed()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.BOT_IS_FACING_ENEMY_FOUNTAIN] = 0,
  })

  luaunit.assertTrue(body_block.pre_turn_enemy_fountain())
end

function test_pre_turn_enemy_fountain_1_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.BOT_IS_FACING_ENEMY_FOUNTAIN] = 0,
  })

  luaunit.assertFalse(body_block.pre_turn_enemy_fountain())
end

function test_pre_turn_enemy_fountain_2_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.BOT_IS_FACING_ENEMY_FOUNTAIN] = 0,
  })

  luaunit.assertFalse(body_block.pre_turn_enemy_fountain())
end

function test_pre_turn_enemy_fountain_3_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 1,
    [gs.BOT_IS_FACING_ENEMY_FOUNTAIN] = 0,
  })

  luaunit.assertFalse(body_block.pre_turn_enemy_fountain())
end

function test_pre_turn_enemy_fountain_4_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.BOT_IS_FACING_ENEMY_FOUNTAIN] = 1,
  })

  luaunit.assertFalse(body_block.pre_turn_enemy_fountain())
end

os.exit(luaunit.LuaUnit.run())
