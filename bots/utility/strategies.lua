local base_recovery = require(
  GetScriptDirectory() .."/utility/base_recovery")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_buy()
  local weights = {
    [gs.BOT_IS_ALIVE] = 0.5,
    [gs.DOES_CREEP_MEET] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_recovery()
  local weights_1 = {
    [gs.DOES_CREEP_MEET] = 1,
  }

  local weights_2 = {
    [gs.BOT_IS_ALIVE] = -1,
  }

  local weights_3 = {
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_BASE_RECOVERY] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         and (gs.EvaluateFrom(1, gs.GAME_STATE, weights_2)
              or gs.Evaluate(gs.GAME_STATE, weights_3)
              or base_recovery.pre_restore_hp_on_base()
              or base_recovery.pre_restore_mp_on_base())
end

---------------------------------

function M.pre_assault_enemy_tower()
  local weights = {
    [gs.BOT_IS_LOW_HP] = -1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.3,
    [gs.EH_PRESENT] = -0.3,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0.3,
    [gs.ET_ATTACK_AC] = 0.3,
    [gs.AC_FRONT_PRESENT] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_fight()
  local weights = {
    [gs.BOT_IS_ALIVE] = 0.4,
    [gs.EH_PRESENT] = 0.4,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.2,
    [gs.EH_ATTACK_BOT] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_combo()
  local weights = {
    [gs.BOT_IS_ALIVE] = 0.5,
    [gs.EH_PRESENT] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_farm()
  return true
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
