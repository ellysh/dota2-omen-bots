local map = require(
  GetScriptDirectory() .."/utility/map")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local game_state = require(
  GetScriptDirectory() .."/utility/game_state")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local M = {}

---------------------------------

function M.pre_evasion()
  return algorithms.IsBotAlive()
end

---------------------------------

local function GetFlaskHealingRemainingDuration()
  local modifier = env.BOT:GetModifierByName("modifier_flask_healing")
  return env.BOT:GetModifierRemainingDuration(modifier)
end

function M.pre_move_safe_recovery()
  local weights = {
    [3] = 0.924, -- env.BOT_DATA.is_flask_healing
    [11] = -1,  -- HasModifier("modifier_fountain_aura_buff")
    [20] = 0.95,   -- env.BOT_DATA.max_health - env.BOT_DATA.health
    [28] = -1,  -- IsUnitInSpot(env.BOT_DATA, env.SAFE_SPOT)
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

function M.move_safe_recovery()
  env.BOT:Action_MoveDirectly(env.SAFE_SPOT)

  action_timing.SetNextActionDelay(0.1)
end

---------------------------------

function M.pre_evade_enemy_hero()
  local weights = {
    [2] = 1, -- env.IS_BOT_LOW_HP
    [8] = 0.5,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0.5,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [29] = 0.5, -- AreEnemyCreepsInRadius(CREEP_MAX_AGGRO_RADIUS)
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

function M.evade_enemy_hero()
  env.BOT:Action_MoveDirectly(env.SAFE_SPOT)
end

---------------------------------

function M.pre_evade_enemy_creeps()
  local weights = {
    [7] = 1,  -- env.IS_FOCUSED_BY_CREEPS
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

function M.evade_enemy_creeps()
  env.BOT:Action_MoveDirectly(env.SAFE_SPOT)
end

---------------------------------

function M.pre_evade_enemy_tower()
  local weights_bot_state = {
    [10] = 1.2,  -- env.IS_FOCUSED_BY_TOWER
    [30] = -0.2, -- algorithms.HasLevelForAggression
    [31] = 1.1, -- map.IsUnitInEnemyTowerAttackRange
  }

  local weights_enemy_tower_state = {
    [1] = 1.99,  -- env.ENEMY_TOWER_DATA ~= nil
    [2] = -1,  -- env.ENEMY_TOWER_DISTANCE / constants.MIN_TOWER_DISTANCE
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights_bot_state)
         or game_state.Evaluate(
              game_state.ENEMY_TOWER_STATE,
              weights_enemy_tower_state)
end

function M.evade_enemy_tower()
  env.BOT:Action_MoveDirectly(env.SAFE_SPOT)
end

-- Provide an access to local functions for unit tests only

function M.test_SetBotState(state)
  game_state.BOT_STATE = state
end

function M.test_SetEnemyHeroState(state)
  game_state.ENEMY_HERO_STATE = state
end

function M.test_SetEnemyTowerState(state)
  game_state.ENEMY_TOWER_STATE = state
end

return M
