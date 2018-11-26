local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

---------------------------------

function M.pre_manage_attack_anim()
  return moves.pre_interrupt_cast_objective()
end

---------------------------------

function M.pre_cancel_attack()
  local weights = {
    [gs.BOT_DOES_BACKSWING] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.cancel_attack()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_wait_attack()
  local weights = {
    [gs.BOT_IS_ATTACKING] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.wait_attack()
end

---------------------------------
-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
