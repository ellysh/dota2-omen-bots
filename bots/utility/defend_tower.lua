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

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_defend_tower()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_pull_enemy_creep()
  local weights = {
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0.3,
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.AC_FRONT_PRESENT] = -1,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0.2,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0.1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pull_enemy_creep()
  env.BOT:Action_AttackUnit(all_units.GetUnit(env.ENEMY_HERO_DATA), true)

  env.LAST_AGGRO_CONTROL = GameTime()
end

---------------------------------

function M.pre_move_enemy_creep()
  local weights = {
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0.3,
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.AC_FRONT_PRESENT] = -1,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = -1,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0.2,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.move_enemy_creep()
  env.BOT:Action_MoveDirectly(env.ENEMY_CREEP_ATTACKING_TOWER.location)

  action_timing.SetNextActionDelay(0.4)
end

---------------------------------

function M.pre_move_safe()
  local closest_enemy_creep = functions.ternary(
                              env.ENEMY_CREEP_FRONT_DATA ~= nil,
                              env.ENEMY_CREEP_FRONT_DATA,
                              env.ENEMY_CREEP_BACK_DATA)


  return env.ENEMY_CREEP_ATTACKING_TOWER == nil
         and env.ALLY_CREEP_FRONT_DATA == nil
         and constants.MAX_CREEPS_HP_PULL < env.ENEMY_CREEPS_HP
         and (closest_enemy_creep ~= nil

               and (map.IsUnitBetweenEnemyTowers(
                      closest_enemy_creep)

                    or map.IsUnitInEnemyTowerAttackRange(
                        closest_enemy_creep)))
end

function M.move_safe()
  env.BOT:Action_MoveDirectly(env.FOUNTAIN_SPOT)

  action_timing.SetNextActionDelay(0.4)
end

---------------------------------

local function GetCreepAttackingBot()
  local creeps = algorithms.GetEnemyCreeps(
                   env.BOT_DATA,
                   constants.MAX_UNIT_TARGET_RADIUS)

  return functions.GetElementWith(
    creeps,
    algorithms.CompareMaxDamage,
    function(unit_data)
      return algorithms.IsUnitAttackTarget(
               unit_data,
               env.BOT_DATA)
             and functions.GetUnitDistance(
                   unit_data,
                   env.ALLY_TOWER_DATA)
                 <= constants.MIN_CREEP_DISTANCE
    end)
end

function M.pre_kill_enemy_creep()
  local target = env.ENEMY_CREEP_ATTACKING_TOWER

  if target == nil then
    target = GetCreepAttackingBot()
  end

  return target ~= nil
         and env.ALLY_CREEP_FRONT_DATA == nil
end

function M.kill_enemy_creep()
  local target = env.ENEMY_CREEP_ATTACKING_TOWER

  if target == nil then
    target = GetCreepAttackingBot()
  end

  algorithms.AttackUnit(env.BOT_DATA, target)
end

---------------------------------

function M.pre_attack_enemy_hero()
  return moves.pre_attack_enemy_hero()
         and env.ALLY_TOWER_DATA ~= nil
         and algorithms.IsUnitAttackTarget(
               env.ENEMY_HERO_DATA,
               env.ALLY_TOWER_DATA)
end

function M.attack_enemy_hero()
  moves.attack_enemy_hero()
end

--------------------------------

function M.stop_attack()
  moves.stop_attack()
end

--------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
