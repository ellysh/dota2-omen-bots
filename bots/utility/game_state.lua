local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

M.BOT_STATE = {}
M.ENEMY_HERO_STATE = {}
M.ALLY_TOWER_STATE = {}
M.ENEMY_TOWER_STATE = {}
M.CREEPS_STATE = {}

function M.UpdateState()
  M.BOT_STATE = {
    [1] = algorithms.IsBotAlive(),
    [2] = env.IS_BOT_LOW_HP,
    [3] = env.BOT_DATA.is_flask_healing,
    [4] = env.BOT_DATA.is_healing,
    [5] = env.IS_BASE_RECOVERY,
    [6] = env.DOES_BOT_HAVE_ADVANTAGE,
    [7] = env.IS_FOCUSED_BY_CREEPS,
    [8] = env.IS_FOCUSED_BY_ENEMY_HERO,
    [9] = env.IS_FOCUSED_BY_UNKNOWN_UNIT,
    [10] = env.IS_FOCUSED_BY_TOWER
  }

  M.ENEMY_HERO_STATE = {
    env.ENEMY_HERO_DATA ~= nil,
    env.IS_ENEMY_HERO_LOW_HP,
    env.DOES_TOWER_PROTECT_ENEMY,
    env.ENEMY_HERO_DISTANCE,
    env.DOES_ENEMY_HERO_HAVE_ADVANTAGE,
  }

  M.ALLY_TOWER_STATE = {
    env.ALLY_TOWER_DATA ~= nil,
  }

  M.ENEMY_TOWER_STATE = {
    env.ENEMY_TOWER_DATA ~= nil,
    env.ENEMY_TOWER_DISTANCE,
  }

  M.CREEPS_STATE = {
    env.ENEMY_CREEP_FRONT_DATA ~= nil,
    env.ENEMY_CREEP_BACK_DATA ~= nil,
    env.ALLY_CREEP_FRONT_DATA ~= nil,
    env.ALLY_CREEP_BACK_DATA ~= nil,
    env.PRE_LAST_HIT_ENEMY_CREEP ~= nil,
    env.PRE_LAST_HIT_ALLY_CREEP ~= nil,
    env.LAST_HIT_ENEMY_CREEP ~= nil,
    env.LAST_HIT_ALLY_CREEP ~= nil,
    env.ALLY_CREEPS_HP,
    env.ENEMY_CREEPS_HP,
  }
end

function M.Evaluate(state, weights)
  local result = 0

  functions.DoWithKeysAndElements(
    weights,
    function(key, weight)
      if state[key] ~= nil and state[key] then
        result = result + weight
      end
    end)

  return 1 <= result
end

-- Provide an access to local functions for unit tests only

return M
