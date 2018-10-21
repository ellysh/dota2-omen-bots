local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local map = require(
  GetScriptDirectory() .."/utility/map")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local game_state = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_farm()
  local weights = {
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = -1, -- env.IS_BOT_LOW_HP
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

---------------------------------

function M.pre_lasthit_enemy_creep()
  local weights = {
    [7] = 1, -- env.LAST_HIT_ENEMY_CREEP
    [9] = -1, -- DoesTowerProtectUnit(env.LAST_HIT_ENEMY_CREEP)
  }

  return game_state.Evaluate(game_state.CREEPS_STATE, weights)
end

function M.lasthit_enemy_creep()
  algorithms.AttackUnit(env.BOT_DATA, env.LAST_HIT_ENEMY_CREEP)
end

---------------------------------

function M.pre_deny_ally_creep()
  local weights = {
    [8] = 1.5, -- env.LAST_HIT_ALLY_CREEP
    [10] = -1, -- DoesTowerProtectUnit(env.LAST_HIT_ALLY_CREEP)
    [11] = -1, -- LAST_HIT_ALLY_CREEP.health / LAST_HIT_ALLY_CREEP.max_health
  }

  return game_state.Evaluate(game_state.CREEPS_STATE, weights)
end

function M.deny_ally_creep()
  algorithms.AttackUnit(env.BOT_DATA, env.LAST_HIT_ALLY_CREEP)
end

--------------------------------

function M.stop_attack()
  moves.stop_attack()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetBotState(state)
  game_state.BOT_STATE = state
end

function M.test_SetCreepsState(state)
  game_state.CREEPS_STATE = state
end

return M
