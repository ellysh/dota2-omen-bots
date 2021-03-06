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

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_positioning()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.IS_FIRST_WAVE] = -0.5,
    [gs.AC_FRONT_PRESENT] = 0.5,
    [gs.BOT_IS_CASTING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_tp_mid_tower()
  local weights = {
    [gs.BOT_CASTABLE_TP_SCROLL] = 0.5,
    [gs.BOT_IS_BASE_RECOVERY] = -1,
    [gs.BOT_IN_MID_TP_DISTANCE] = 0.5,
    [gs.BOT_IS_MOVING_BASE] = -1,
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
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_increase_creeps_distance()
  return not M.pre_increase_creeps_distance()
end

function M.increase_creeps_distance()
  env.BOT:Action_MoveDirectly(env.FARM_SPOT)
end

---------------------------------

function M.pre_increase_creeps_distance_aggro()
  local weights = {
    [gs.EAC_PRE_LAST_HIT_PRESENT] = -1,
    [gs.AC_FRONT_PRESENT] = 0.3,
    [gs.EC_IN_AGGRO_RADIUS] = 0.4,
    [gs.EC_AGGRO_COOLDOWN] = -0.4,
    [gs.EH_ATTACK_BOT] = 0.3,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_increase_creeps_distance_aggro()
  return not M.pre_increase_creeps_distance_aggro()
end

function M.increase_creeps_distance_aggro()
  env.BOT:Action_MoveDirectly(env.FARM_SPOT)
end

---------------------------------

function M.pre_decrease_creeps_distance_base()
  local weights = {
    [gs.EC_IN_MAX_BASE_DISTANCE] = -1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = -1,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = -1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
         and not M.pre_increase_creeps_distance()
end

function M.pre_cancel_decrease_creeps_distance_base()
  return not M.pre_decrease_creeps_distance_base()
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
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.AC_FRONT_PRESENT] = 0.3,
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0.2,
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = -1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = -1,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = -1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_decrease_creeps_distance_aggro()
  return not M.pre_decrease_creeps_distance_aggro()
end

function M.decrease_creeps_distance_aggro()
  env.BOT:Action_MoveDirectly(env.PRE_LAST_HIT_ENEMY_CREEP.location)
end

---------------------------------

function M.pre_turn()
  local weights = {
    [gs.AC_FRONT_PRESENT] = 0.5,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = -1,
    [gs.TURN_TARGET_PRESENT] = 0.5,
    [gs.BOT_IS_FACING_TURN_TARGET] = -1,
    [gs.BOT_IS_TURNING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_turn()
  return not M.pre_turn()
end

function M.turn()
  env.BOT:Action_AttackUnit(env.TURN_TARGET_DATA.handle, true)
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
