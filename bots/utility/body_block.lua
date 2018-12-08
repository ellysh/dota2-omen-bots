local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local map = require(
  GetScriptDirectory() .."/utility/map")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_body_block()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_move_start_position()
  local weights = {
    [gs.AC_FRONT_PRESENT] = -1,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = -1,
  }

  return gs.EvaluateFrom(1, gs.GAME_STATE, weights)
end

function M.move_start_position()
  env.BOT:Action_MoveDirectly(env.BODY_BLOCK_SPOT)

  action_timing.SetNextActionDelay(0.1)
end

---------------------------------

function M.pre_turn_enemy_fountain()
  local weights = {
    [gs.AC_FRONT_PRESENT] = -1,
    [gs.BOT_IN_BODY_BLOCK_SPOT] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = -1,
    [gs.BOT_IS_FACING_ENEMY_FOUNTAIN] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.turn_enemy_fountain()
  env.BOT:Action_MoveDirectly(
    map.GetEnemySpot("high_ground"))
end

function M.stop_turn()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_move_and_block()
  local weights = {
    [gs.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] = 0.5,
    [gs.AC_IN_MELEE_ATTACK_RANGE] = 0.5,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = -1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = -1,
    [gs.EC_IN_BOT_ATTACK_RANGE] = -1,
    [gs.AC_FRONT_PRESENT] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

local function CompareMinHgDistance(t, a, b)
  local high_ground_spot = map.GetAllySpot("high_ground")

  return functions.GetDistance(high_ground_spot, t[a].location)
         < functions.GetDistance(high_ground_spot, t[b].location)
end

local function GetFirstMovingCreep()
  local creeps = algorithms.GetAllyCreeps(
                   env.BOT_DATA,
                   constants.MAX_UNIT_TARGET_RADIUS)

  return functions.GetElementWith(
           creeps,
           CompareMinHgDistance)
end

function M.move_and_block()
  local creep = all_units.GetUnit(GetFirstMovingCreep())
  local target_location = creep:GetExtrapolatedLocation(1.0)

  if algorithms.GetDistanceFromFountain(env.BOT_DATA, target_location)
     < algorithms.GetUnitDistanceFromFountain(env.BOT_DATA) then

     return
  end

  env.BOT:Action_MoveDirectly(target_location)

  local distance = functions.GetDistance(
                     env.BOT_DATA.location,
                     target_location)
                   - env.BOT_DATA.collision_size

  local multiplier = functions.ternary(algorithms.IsFirstWave(), 0.8, 0.7)

  action_timing.SetNextActionDelay(
    (distance/env.BOT_DATA.speed) * multiplier)
end

function M.stop_attack_and_move()
  local creep_data = GetFirstMovingCreep()

  local collision_size = env.BOT_DATA.collision_size
                         + creep_data.collision_size

  local distance = functions.GetDistance(
                     env.BOT_DATA.location,
                     creep_data.location)
                   - collision_size

  env.BOT:Action_ClearActions(true)

  local multiplier = functions.ternary(algorithms.IsFirstWave(), 0.2, 0.35)

  action_timing.SetNextActionDelay(
    (distance/creep_data.speed) * multiplier)
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
