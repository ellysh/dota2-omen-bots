local map = require(
  GetScriptDirectory() .."/utility/map")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_positioning()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = -0.5,
    [gs.AC_BACK_PRESENT] = -1,
    [gs.AC_FRONT_PRESENT] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_tp_mid_tower()
  local weights = {
    [gs.BOT_CASTABLE_TP_SCROLL] = 0.5,
    [gs.BOT_IS_BASE_RECOVERY] = -1,
    [gs.BOT_IN_MID_TP_DISTANCE] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.tp_mid_tower()
  local item = algorithms.GetItem(env.BOT_DATA, "item_tpscroll")

  env.BOT:Action_UseAbilityOnLocation(
    item,
    map.GetAllySpot("tp_tower_tier_1"))

  action_timing.SetNextActionDelay(item:GetChannelTime())
end

---------------------------------

function M.pre_increase_creeps_distance()
  local weights = {
    [gs.EAC_PRE_LAST_HIT_PRESENT] = -1,
    [gs.AC_FRONT_PRESENT] = 0.6,
    [gs.EH_HAS_BETTER_POSITION] = 0.4,
    [gs.EC_IN_MIN_BASE_DISTANCE] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.increase_creeps_distance()
  env.BOT:Action_MoveDirectly(env.FARM_SPOT)
end

---------------------------------

function M.pre_decrease_creeps_distance_base()
  local base_creep_distance = GetBaseCreepDistance()

  return not algorithms.AreEnemyCreepsInRadius(
                env.BOT_DATA,
                base_creep_distance)

         and not algorithms.AreAllyCreepsInRadius(
                  env.BOT_DATA,
                  base_creep_distance)

         and not env.IS_FOCUSED_BY_CREEPS

         and not map.IsUnitInEnemyTowerAttackRange(env.BOT_DATA)

         and env.ALLY_CREEP_FRONT_DATA ~= nil
end

local function GetClosestCreep()
  return functions.ternary(
          env.ENEMY_CREEP_FRONT_DATA ~= nil,
          env.ENEMY_CREEP_FRONT_DATA,
          env.ALLY_CREEP_FRONT_DATA)
end

function M.decrease_creeps_distance_base()
  local target_data = GetClosestCreep()

  env.BOT:Action_MoveDirectly(target_data.location)
end

---------------------------------

function M.pre_decrease_creeps_distance_aggro()
  local last_hit_creep = GetPreLastHitCreep()

  return env.ENEMY_HERO_DATA ~= nil
         and env.ENEMY_HERO_DATA.is_visible
         and env.ALLY_CREEP_FRONT_DATA ~= nil
         and last_hit_creep ~= nil

         and constants.LASTHIT_CREEP_DISTANCE
               < functions.GetUnitDistance(
                   env.BOT_DATA,
               last_hit_creep)

         and not env.IS_FOCUSED_BY_CREEPS

         and not map.IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
end

function M.decrease_creeps_distance_aggro()
  local target_data = GetPreLastHitCreep()

  env.BOT:Action_MoveDirectly(target_data.location)
end

---------------------------------

function M.pre_turn()
  local last_hit_creep = GetPreLastHitCreep()
  local enemy_hero = env.ENEMY_HERO_DATA
  local target_data = functions.ternary(
                        last_hit_creep ~= nil,
                        last_hit_creep,
                        enemy_hero)

  return target_data ~= nil

         and env.ALLY_CREEP_FRONT_DATA ~= nil

         and not functions.IsFacingLocation(
                   env.BOT_DATA,
                   target_data.location,
                   constants.TURN_TARGET_MAX_DEGREE)

         and not map.IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
end

function M.turn()
  local last_hit_creep = GetPreLastHitCreep()
  local enemy_hero = env.ENEMY_HERO_DATA
  local target_data = functions.ternary(
                        last_hit_creep ~= nil,
                        last_hit_creep,
                        enemy_hero)

  env.BOT:Action_AttackUnit(all_units.GetUnit(target_data), true)

  action_timing.SetNextActionDelay(constants.NEVERMORE_TURN_TIME)
end

function M.stop_attack_and_move()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
