local moves = require(
  GetScriptDirectory() .."/utility/moves")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local env = require(
  GetScriptDirectory() .."/utility/environment")

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
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0.3,
    [gs.EH_PRESENT] = 0.3,
    [gs.EH_IS_VISIBLE] = 0.2,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = -1,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0.2,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.aggro_last_hit()
  env.BOT:Action_AttackUnit(all_units.GetUnit(env.ENEMY_HERO_DATA), true)

  env.LAST_AGGRO_CONTROL = GameTime()
end

---------------------------------

function M.pre_aggro_hg()
  local weights = {
    [gs.EH_PRESENT] = 0.3,
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.EC_FRONT_PRESENT] = 0.2,
    [gs.EC_BACK_PRESENT] = -1,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.BOT_IN_RIVER] = 0.1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 0.1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.aggro_hg()
  env.BOT:Action_AttackUnit(all_units.GetUnit(env.ENEMY_HERO_DATA), true)

  env.LAST_AGGRO_CONTROL = GameTime()
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
