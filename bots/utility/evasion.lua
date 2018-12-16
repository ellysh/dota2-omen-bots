local moves = require(
  GetScriptDirectory() .."/utility/moves")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_evasion()
  return moves.pre_interrupt_cast_objective()
end

---------------------------------

local function GetFlaskHealingRemainingDuration()
  local modifier = env.BOT:GetModifierByName("modifier_flask_healing")
  return env.BOT:GetModifierRemainingDuration(modifier)
end

function M.pre_move_safe_recovery()
  local weights = {
    [gs.BOT_IS_FLASK_HEALING] = 0.924,
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = -1,
    [gs.BOT_HP_MAX_DELTA] = 0.95,
    [gs.BOT_IN_SAFE_SPOT] = -1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_move_safe_recovery()
  return M.pre_move_safe_recovery()
end

function M.pre_cancel_move_safe_recovery()
  return not M.pre_move_safe_recovery()
         or moves.pre_cancel_move_safe_spot()
end

function M.move_safe_spot()
  moves.move_safe_spot()
end

---------------------------------

function M.pre_evade_enemy_hero()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_enemy_hero()
  return M.pre_evade_enemy_hero()
end

function M.pre_cancel_evade_enemy_hero()
  return not M.pre_evade_enemy_hero()
         or moves.pre_cancel_move_safe_spot()
end

---------------------------------

function M.pre_evade_enemy_creeps()
  local weights = {
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 1,
    [gs.EC_IN_MELEE_ATTACK_RANGE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_enemy_creeps()
  return M.pre_evade_enemy_creeps()
end

function M.pre_cancel_evade_enemy_creeps()
  return not M.pre_evade_enemy_creeps()
         or moves.pre_cancel_move_safe_spot()
end

---------------------------------

function M.pre_evade_enemy_tower()
  local weights_1 = {
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 1,
    [gs.BOT_IN_ET_MIN_DISTANCE] = 1,
  }

  local weights_2 = {
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = -1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         or gs.Evaluate(gs.GAME_STATE, weights_2)
end

function M.pre_wait_evade_enemy_tower()
  return M.pre_evade_enemy_tower()
end

function M.pre_cancel_evade_enemy_tower()
  return not M.pre_evade_enemy_tower()
         or moves.pre_cancel_move_safe_spot()
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
