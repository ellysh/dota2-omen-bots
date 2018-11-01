local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local map = require(
  GetScriptDirectory() .."/utility/map")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

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
    [gs.EC_IN_AGRO_RADIUS] = -0.5,
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
  return env.ENEMY_TOWER_DATA ~= nil
         and env.ALLY_CREEP_FRONT_DATA ~= nil
         and algorithms.HasLevelForAggression(env.BOT_DATA)
         and algorithms.DoesEnemyTowerAttackAllyCreep(
               env.BOT_DATA,
               env.ENEMY_TOWER_DATA)

         and not env.IS_FOCUSED_BY_TOWER

         and (env.ENEMY_HERO_DATA == nil

              or (constants.MIN_HERO_DISTANCE < env.ENEMY_HERO_DISTANCE

                  and constants.UNIT_HALF_HEALTH_LEVEL
                      <= functions.GetRate(
                           env.BOT_DATA.health,
                           env.BOT_DATA.max_health)))
end

function M.attack_enemy_tower()
  algorithms.AttackUnit(env.BOT_DATA, env.ENEMY_TOWER_DATA)
end

--------------------------------

function M.stop_attack()
  moves.stop_attack()
end

---------------------------------

function M.pre_move_safe()
  return env.ENEMY_HERO_DATA ~= nil
         and env.BOT_DATA.attack_target == env.ENEMY_HERO_DATA
         and not algorithms.IsUnitMoving(env.BOT_DATA)
end

function M.move_safe()
  env.BOT:Action_MoveDirectly(env.FARM_SPOT)

  action_timing.SetNextActionDelay(0.4)
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
