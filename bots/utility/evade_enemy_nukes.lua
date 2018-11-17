local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.evade_enemy_nukes()
  return moves.pre_interrupt_cast_objective()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
