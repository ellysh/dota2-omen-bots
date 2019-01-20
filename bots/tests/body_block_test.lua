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
    [gs.EH_BLOCKS_BODY_BLOCK_SPOT] = 0,
  })

  luaunit.assertTrue(body_block.pre_move_start_position())
end

function test_pre_move_start_position_1_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 0,
    [gs.EH_BLOCKS_BODY_BLOCK_SPOT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_start_position())
end

function test_pre_move_start_position_2_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
    [gs.EH_BLOCKS_BODY_BLOCK_SPOT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_start_position())
end

function test_pre_move_start_position_3_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
    [gs.EH_BLOCKS_BODY_BLOCK_SPOT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_start_position())
end

function test_pre_move_start_position_4_fails()
  body_block.test_SetGameState({
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 0,
    [gs.EH_BLOCKS_BODY_BLOCK_SPOT] = 1,
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

---------------------------------

function test_pre_move_and_block_1_succeed()
  body_block.test_SetGameState({
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 1,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.EC_IN_BOT_ATTACK_RANGE] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertTrue(body_block.pre_move_and_block())
end

function test_pre_move_and_block_1_fails()
  body_block.test_SetGameState({
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 0,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.EC_IN_BOT_ATTACK_RANGE] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_and_block())
end

function test_pre_move_and_block_2_fails()
  body_block.test_SetGameState({
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 1,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.EC_IN_BOT_ATTACK_RANGE] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_and_block())
end

function test_pre_move_and_block_3_fails()
  body_block.test_SetGameState({
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 1,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.EC_IN_BOT_ATTACK_RANGE] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_and_block())
end

function test_pre_move_and_block_4_fails()
  body_block.test_SetGameState({
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 1,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 1,
    [gs.EC_IN_BOT_ATTACK_RANGE] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_and_block())
end

function test_pre_move_and_block_5_fails()
  body_block.test_SetGameState({
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 1,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.EC_IN_BOT_ATTACK_RANGE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
  })

  luaunit.assertFalse(body_block.pre_move_and_block())
end

function test_pre_move_and_block_6_fails()
  body_block.test_SetGameState({
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 1,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
    [gs.EC_IN_BOT_ATTACK_RANGE] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
  })

  luaunit.assertFalse(body_block.pre_move_and_block())
end

os.exit(luaunit.LuaUnit.run())
