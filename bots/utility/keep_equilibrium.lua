local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_keep_equilibrium()
  local weights = {
    [gs.EC_BACK_PRESENT] = -1,
    [gs.EC_PRE_LAST_HIT_PRESENT] = -1,
    [gs.AC_PRE_LAST_HIT_PRESENT] = -1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = -1,
  }

  return moves.pre_attack_objective()
         and gs.EvaluateFrom(1, gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_attack_enemy_creep()
  local weights = {
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
  }

  return moves.pre_attack_enemy_creep()
         and gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_creep()
  moves.attack_enemy_creep()
end

--------------------------------

function M.pre_attack_ally_creep()
  local weights = {
    [gs.AC_HAVE_HP_ADVANTAGE] = 1,
  }

  return moves.pre_attack_ally_creep()
         and gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_ally_creep()
  moves.attack_ally_creep()
end

--------------------------------

function M.stop_attack()
  moves.stop_attack()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
