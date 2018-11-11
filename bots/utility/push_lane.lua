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

function M.pre_push_lane()
  local weights = {
    [gs.EC_BACK_PRESENT] = -1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  }

  return moves.pre_attack_objective()
         and gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_attack_enemy_creep()
  local weights = {
    [gs.EH_PRESENT] = 1,
  }

  return moves.pre_attack_enemy_creep()
         and gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_creep()
  moves.attack_enemy_creep()
end

--------------------------------

function M.pre_kill_enemy_creep()
  local weights = {
    [gs.EC_MIN_HP_TARGETABLE_PRESENT] = 0.5,
    [gs.EH_PRESENT] = -1,
    [gs.AC_FRONT_PRESENT] = 0.5,
    [gs.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.kill_enemy_creep()
  algorithms.AttackUnit(
    env.BOT_DATA,
    env.ENEMY_CREEP_MIN_HP_TARGETABLE_DATA)
end

--------------------------------

function M.pre_attack_enemy_tower()
  local weights = {
    [gs.ET_PRESENT] = 0.3,
    [gs.AC_FRONT_PRESENT] = 0.3,
    [gs.BOT_IS_FOCUSED_BY_TOWER] = -1,
    [gs.ET_ATTACK_AC] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_tower()
  algorithms.AttackUnit(env.BOT_DATA, env.ENEMY_TOWER_DATA)
end

--------------------------------

function M.pre_destroy_enemy_tower()
  local weights_1 = {
    [gs.ET_IS_LOW_HP] = 0.4,
    [gs.AC_FRONT_PRESENT] = 0.3,
    [gs.ET_IS_VISIBLE] = 0.3,
  }

  local weights_2 = {
    [gs.EH_PRESENT] = -0.5,
    [gs.BOT_IN_EH_MIN_DISTANCE] = -1,
    [gs.BOT_HP_RATE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.EvaluateFrom(1, gs.GAME_STATE, weights_2)
end

function M.destroy_enemy_tower()
  algorithms.AttackUnit(env.BOT_DATA, env.ENEMY_TOWER_DATA)
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
