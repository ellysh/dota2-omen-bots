local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_attack_with_better_position()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_attack_enemy_hero_from_hg()
  local weights_1 = {
    [gs.BOT_INCOMING_DAMAGE] = -1,
    [gs.BOT_HAS_BETTER_POSITION] = 1.6,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = -1,
  }

  local weights_2 = {
    [gs.EC_FRONT_PRESENT] = -0.5,
    [gs.EC_BACK_PRESENT] = -0.5,
    [gs.AC_FRONT_PRESENT] = 1,
  }

  return moves.pre_attack_enemy_hero()
         and gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.EvaluateFrom(1, gs.GAME_STATE, weights_2)
end

function M.attack_enemy_hero_from_hg()
  moves.attack_enemy_hero()
end

---------------------------------

function M.pre_attack_enemy_hero_with_incoming_damage()
  local weights_1 = {
    [gs.BOT_INCOMING_DAMAGE] = -1,
    [gs.EH_INCOMING_DAMAGE] = 1,
    [gs.EH_HAS_BETTER_POSITION] = -1,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = -1,
  }

  local weights_2 = {
    [gs.EC_FRONT_PRESENT] = -0.5,
    [gs.EC_BACK_PRESENT] = -0.5,
    [gs.AC_FRONT_PRESENT] = 1,
  }

  return moves.pre_attack_enemy_hero()
         and gs.EvaluateFrom(1, gs.GAME_STATE, weights_1)
         and gs.EvaluateFrom(1, gs.GAME_STATE, weights_2)
end

function M.attack_enemy_hero_with_incoming_damage()
  moves.attack_enemy_hero()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
