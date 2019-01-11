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

function M.pre_kite()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_attack_enemy_hero()
  local weights = {
    [gs.BOT_ATTACK_EH] = -1,
    [gs.EC_BACK_PRESENT] = -1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EH_IN_REAR_SPOT] = -1,
    [gs.EC_IN_AGGRO_RADIUS] = -0.5,
    [gs.EC_AGGRO_COOLDOWN] = 0.5,
  }

  return moves.pre_attack_enemy_hero()
         and gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_hero()
  moves.attack_enemy_hero()
end

--------------------------------

function M.pre_attack_enemy_tower()
  local weights_1 = {
    [gs.ET_IS_VISIBLE] = 0.3,
    [gs.AC_FRONT_PRESENT] = 0.3,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.2,
    [gs.ET_ATTACK_AC] = 0.2,
    [gs.BOT_IN_ET_MIN_DISTANCE] = -1,
  }

  local weights_2 = {
    [gs.EH_PRESENT] = -0.5,
    [gs.BOT_IN_EH_MIN_DISTANCE] = -1,
    [gs.BOT_HP_RATE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.EvaluateFrom(1, gs.GAME_STATE, weights_2)
end

function M.attack_enemy_tower()
  algorithms.AttackUnit(env.BOT_DATA, env.ENEMY_TOWER_DATA)
end

--------------------------------

function M.pre_move_safe()
  local weights = {
    [gs.EH_PRESENT] = 0.4,
    [gs.BOT_SHOOT_EH] = 0.3,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0.3,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_move_safe()
  return not M.pre_move_safe()
end

function M.move_safe()
  env.BOT:Action_MoveDirectly(env.FARM_SPOT)
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
