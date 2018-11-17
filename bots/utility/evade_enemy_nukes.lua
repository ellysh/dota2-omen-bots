local constants = require(
  GetScriptDirectory() .."/utility/constants")

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

function M.pre_evade_near_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 0.5,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0.5,
    [gs.BOT_IS_FACING_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_evade_medium_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0.5,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0.5,
    [gs.BOT_IS_FACING_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_evade_far_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0.5,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0.5,
    [gs.BOT_IS_FACING_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.move_back()
  env.BOT:Action_MoveDirectly(env.SAFE_SPOT)

  action_timing.SetNextActionDelay(
    constants.NEVERMORE_SHADOWRAZE_CAST_TIME)
end

---------------------------------

function M.pre_evade_near_shadowraze_front()
  local weights = {
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 0.3,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0.3,
    [gs.BOT_IS_FACING_EH] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_evade_medium_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0.3,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0.3,
    [gs.BOT_IS_FACING_EH] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_evade_far_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0.3,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0.3,
    [gs.BOT_IS_FACING_EH] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.move_front()
  moves.move_enemy_hero()

  action_timing.SetNextActionDelay(
    constants.NEVERMORE_SHADOWRAZE_CAST_TIME)
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
