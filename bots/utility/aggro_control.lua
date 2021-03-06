local moves = require(
  GetScriptDirectory() .."/utility/moves")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local hist = require(
  GetScriptDirectory() .."/utility/history")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_aggro_control()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_aggro_last_hit()
  local weights = {
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 0.2,
    [gs.EH_PRESENT] = 0.2,
    [gs.EH_IS_VISIBLE] = 0.2,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = -1,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0.2,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 0.2,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.aggro_last_hit()
  env.BOT:Action_AttackUnit(env.ENEMY_HERO_DATA.handle, true)

  hist.LAST_AGGRO_CONTROL = env.CURRENT_GAME_TIME
end

---------------------------------

function M.pre_aggro_hg()
  local weights = {
    [gs.EH_PRESENT] = 0.2,
    [gs.EH_IS_VISIBLE] = 0.2,
    [gs.EC_FRONT_PRESENT] = 0.2,
    [gs.EC_BACK_PRESENT] = -1,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.BOT_IN_RIVER] = 0.2,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 0.11,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 0.11,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.aggro_hg()
  env.BOT:Action_AttackUnit(env.ENEMY_HERO_DATA.handle, true)

  hist.LAST_AGGRO_CONTROL = env.CURRENT_GAME_TIME
end

---------------------------------

function M.stop_attack()
  moves.stop_attack()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
