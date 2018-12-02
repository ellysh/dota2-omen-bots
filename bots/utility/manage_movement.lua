local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

---------------------------------

function M.pre_manage_movement()
  return moves.pre_interrupt_cast_objective()
end

---------------------------------

function M.pre_cancel_movement()
  local weights = {
    [gs.BOT_IS_MOVING_WAYPOINTS] = 1,
    [gs.BOT_MOVING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.cancel_movement()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_wait_movement()
  local weights = {
    [gs.BOT_IS_MOVING_WAYPOINTS] = 0.5,
    [gs.BOT_MOVING] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.wait_movement()
end

---------------------------------
-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
