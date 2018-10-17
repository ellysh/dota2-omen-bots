local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

local BOOL_TO_NUMBER = {  [true] = 1, [false] = 0 }

M.BOT_STATE = {}
M.ENEMY_HERO_STATE = {}
M.ALLY_TOWER_STATE = {}
M.ENEMY_TOWER_STATE = {}
M.CREEPS_STATE = {}

function M.UpdateState()
  M.BOT_STATE = {
    [1] = BOOL_TO_NUMBER[algorithms.IsBotAlive()],
    [2] = BOOL_TO_NUMBER[env.IS_BOT_LOW_HP],
    [3] = BOOL_TO_NUMBER[env.BOT_DATA.is_flask_healing],
    [4] = BOOL_TO_NUMBER[env.BOT_DATA.is_healing],
    [5] = BOOL_TO_NUMBER[env.IS_BASE_RECOVERY],
    [6] = BOOL_TO_NUMBER[env.DOES_BOT_HAVE_ADVANTAGE],
    [7] = BOOL_TO_NUMBER[env.IS_FOCUSED_BY_CREEPS],
    [8] = BOOL_TO_NUMBER[env.IS_FOCUSED_BY_ENEMY_HERO],
    [9] = BOOL_TO_NUMBER[env.IS_FOCUSED_BY_UNKNOWN_UNIT],
    [10] = BOOL_TO_NUMBER[env.IS_FOCUSED_BY_TOWER]
  }

  M.ENEMY_HERO_STATE = {
    [1] = BOOL_TO_NUMBER[env.ENEMY_HERO_DATA ~= nil],
    [2] = BOOL_TO_NUMBER[env.IS_ENEMY_HERO_LOW_HP],
    [3] = BOOL_TO_NUMBER[env.DOES_TOWER_PROTECT_ENEMY],
    [4] = env.ENEMY_HERO_DISTANCE,
    [5] = BOOL_TO_NUMBER[env.DOES_ENEMY_HERO_HAVE_ADVANTAGE],
  }

  M.ALLY_TOWER_STATE = {
    [1] = BOOL_TO_NUMBER[env.ALLY_TOWER_DATA ~= nil],
  }

  M.ENEMY_TOWER_STATE = {
    [1] = BOOL_TO_NUMBER[env.ENEMY_TOWER_DATA ~= nil],
    [2] = env.ENEMY_TOWER_DISTANCE,
  }

  M.CREEPS_STATE = {
    [1] = BOOL_TO_NUMBER[env.ENEMY_CREEP_FRONT_DATA ~= nil],
    [2] = BOOL_TO_NUMBER[env.ENEMY_CREEP_BACK_DATA ~= nil],
    [3] = BOOL_TO_NUMBER[env.ALLY_CREEP_FRONT_DATA ~= nil],
    [4] = BOOL_TO_NUMBER[env.ALLY_CREEP_BACK_DATA ~= nil],
    [5] = BOOL_TO_NUMBER[env.PRE_LAST_HIT_ENEMY_CREEP ~= nil],
    [6] = BOOL_TO_NUMBER[env.PRE_LAST_HIT_ALLY_CREEP ~= nil],
    [7] = BOOL_TO_NUMBER[env.LAST_HIT_ENEMY_CREEP ~= nil],
    [8] = BOOL_TO_NUMBER[env.LAST_HIT_ALLY_CREEP ~= nil],
    [9] = env.ALLY_CREEPS_HP,
    [10] = env.ENEMY_CREEPS_HP,
  }
end

function M.Evaluate(state, weights)
  local result = 0

  functions.DoWithKeysAndElements(
    weights,
    function(key, weight)
      if state[key] ~= nil then
        result = result + state[key] * weight
      end
    end)

  return 1 <= result
end

-- Provide an access to local functions for unit tests only

return M
