local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local map = require(
  GetScriptDirectory() .."/utility/map")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_close_fight()
  -- TODO: Consider general attack preconditions here

  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_kill_enemy_hero()
  -- TODO: Consider hits here

  return moves.pre_attack_enemy_hero()
end

function M.kill_enemy_hero()
  moves.attack_enemy_hero()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
