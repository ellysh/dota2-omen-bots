local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

M.STATE = {}

function M.UpdateState()
  M.STATE = {
    env.ENEMY_HERO_DATA ~= nil,
    env.IS_BOT_LOW_HP,
    env.IS_ENEMY_HERO_LOW_HP,
    env.ENEMY_CREEP_FRONT_DATA ~= nil,
    env.ENEMY_CREEP_BACK_DATA ~= nil,
    env.ALLY_CREEP_FRONT_DATA ~= nil,
    env.ALLY_CREEP_BACK_DATA ~= nil,
    env.ENEMY_TOWER_DATA ~= nil,
    env.ENEMY_TOWER_DISTANCE,
    env.ALLY_TOWER_DATA ~= nil,
    env.PRE_LAST_HIT_ENEMY_CREEP ~= nil,
    env.PRE_LAST_HIT_ALLY_CREEP ~= nil,
    env.LAST_HIT_ENEMY_CREEP ~= nil,
    env.LAST_HIT_ALLY_CREEP ~= nil,
    env.ALLY_CREEPS_HP,
    env.ENEMY_CREEPS_HP,
    env.DOES_TOWER_PROTECT_ENEMY,
    env.ENEMY_HERO_DISTANCE,
    env.DOES_BOT_HAVE_ADVANTAGE,
    env.DOES_ENEMY_HERO_HAVE_ADVANTAGE,
    env.IS_FOCUSED_BY_CREEPS,
    env.IS_FOCUSED_BY_ENEMY_HERO,
    env.IS_FOCUSED_BY_UNKNOWN_UNIT,
    env.IS_FOCUSED_BY_TOWER,
    env.IS_BASE_RECOVERY
  }
end

-- Provide an access to local functions for unit tests only

return M
