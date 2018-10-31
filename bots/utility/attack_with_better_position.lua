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
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
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

function M.pre_attack_enemy_hero()
  return moves.pre_attack_enemy_hero()
         and (env.ALLY_CREEP_FRONT_DATA ~= nil
              or (env.ENEMY_CREEP_FRONT_DATA == nil
                  and env.ENEMY_CREEP_BACK_DATA == nil))

         and env.ENEMY_HERO_DISTANCE
             <= algorithms.GetAttackRange(
                  env.BOT_DATA,
                  env.ENEMY_HERO_DATA,
                  true)

         and not algorithms.AreEnemyCreepsInRadius(
                   env.BOT_DATA,
                   constants.MAX_MELEE_ATTACK_RANGE)

         and ((algorithms.IsUnitPositionBetter(
                 env.BOT_DATA,
                 env.ENEMY_HERO_DATA)
               and not IsUnitIncomingDamageMore(
                         env.BOT_DATA,
                         env.ENEMY_HERO_DATA))

              or (IsUnitIncomingDamageMore(
                    env.ENEMY_HERO_DATA,
                    env.BOT_DATA)
                  and not algorithms.IsUnitPositionBetter(
                            env.ENEMY_HERO_DATA,
                            env.BOT_DATA)))
end

function M.attack_enemy_hero()
  moves.attack_enemy_hero()
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
