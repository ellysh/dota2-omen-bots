local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_cancel_nuke_enemy_hero()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_cancel_near_shadowraze()
  local weights_1 = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0.3,
    [gs.BOT_IS_FACING_EH] = 0.4,
  }

  local weights_2 = {
    [gs.BOT_IS_CASTING_NEAR_SHADOWRAZE] = 1,
  }

  return not gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.Evaluate(gs.GAME_STATE, weights_2)
end

---------------------------------

function M.pre_cancel_medium_shadowraze()
  local weights_1 = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0.3,
    [gs.BOT_IS_FACING_EH] = 0.4,
  }

  local weights_2 = {
    [gs.BOT_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
  }

  return not gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.Evaluate(gs.GAME_STATE, weights_2)
end

---------------------------------

function M.pre_cancel_far_shadowraze()
  local weights_1 = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0.3,
    [gs.BOT_IS_FACING_EH] = 0.4,
  }

  local weights_2 = {
    [gs.BOT_IS_CASTING_FAR_SHADOWRAZE] = 1,
  }

  return not gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.Evaluate(gs.GAME_STATE, weights_2)
end

function M.stop_attack_and_move()
  env.BOT:Action_ClearActions(true)
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
