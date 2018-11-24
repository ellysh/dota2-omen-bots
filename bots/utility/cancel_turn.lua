local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_cancel_turn()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_stop_attack_and_move()
  local weights = {
    [gs.BOT_IS_MOVE_TURNING] = 1,
    [gs.BOT_HAS_ANIM_TURN] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.stop_attack_and_move()
  env.BOT:Action_ClearActions(true)
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
