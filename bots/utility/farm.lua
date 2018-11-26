local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_farm()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_lasthit_enemy_creep()
  local weights = {
    [gs.EC_LAST_HIT_PRESENT] = 1,
    [gs.EC_LAST_HIT_IS_TOWER_PROTECTED] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.lasthit_enemy_creep()
  algorithms.AttackUnit(env.BOT_DATA, env.LAST_HIT_ENEMY_CREEP)
end

---------------------------------

function M.pre_deny_ally_creep()
  local weights = {
    [gs.AC_LAST_HIT_PRESENT] = 1.5,
    [gs.AC_LAST_HIT_IS_TOWER_PROTECTED] = -1,
    [gs.AC_LAST_HIT_HP_RATE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.deny_ally_creep()
  algorithms.AttackUnit(env.BOT_DATA, env.LAST_HIT_ALLY_CREEP)
end

--------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
