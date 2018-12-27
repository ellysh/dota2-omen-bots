local constants = require(
  GetScriptDirectory() .."/utility/constants")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_evade_enemy_nukes()
  return moves.pre_interrupt_cast_objective()
end

---------------------------------

function M.pre_evade_near_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 0.4,
    [gs.BOT_CAN_EVADE_NEAR_SHADOWRAZE_BACK] = 0.3,
    [gs.EH_IS_FACING_BOT_MELEE_RANGE] = 0.3,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_near_shadowraze_back()
  return M.pre_evade_near_shadowraze_back()
end

function M.pre_cancel_evade_near_shadowraze_back()
  return not M.pre_evade_near_shadowraze_back()
end

---------------------------------

function M.pre_evade_medium_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0.4,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_BACK] = 0.3,
    [gs.EH_IS_FACING_BOT] = 0.3,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_medium_shadowraze_back()
  return M.pre_evade_medium_shadowraze_back()
end

function M.pre_cancel_evade_medium_shadowraze_back()
  return not M.pre_evade_medium_shadowraze_back()
end

---------------------------------

function M.pre_evade_far_shadowraze_back()
  local weights = {
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0.4,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_BACK] = 0.3,
    [gs.EH_IS_FACING_BOT] = 0.3,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_far_shadowraze_back()
  return M.pre_evade_far_shadowraze_back()
end

function M.pre_cancel_evade_far_shadowraze_back()
  return not M.pre_evade_far_shadowraze_back()
end

function M.move_back()
  env.BOT:Action_MoveDirectly(env.SAFE_SPOT)
end

---------------------------------

function M.pre_evade_medium_shadowraze_front()
  local weights = {
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0.4,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_FRONT] = 0.3,
    [gs.EH_IS_FACING_BOT] = 0.3,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_medium_shadowraze_front()
  return M.pre_evade_medium_shadowraze_front()
end

function M.pre_cancel_evade_medium_shadowraze_front()
  return not M.pre_evade_medium_shadowraze_front()
end

---------------------------------

function M.pre_evade_far_shadowraze_front()
  local weights = {
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0.4,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_FRONT] = 0.3,
    [gs.EH_IS_FACING_BOT] = 0.3,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_far_shadowraze_front()
  return M.pre_evade_far_shadowraze_front()
end

function M.pre_cancel_evade_far_shadowraze_front()
  return not M.pre_evade_far_shadowraze_front()
end

function M.move_front()
  moves.move_enemy_hero()
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
