local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

local BOOL_TO_NUMBER = {  [true] = 1, [false] = 0 }

M.BOT_STATE = {}
M.ENEMY_HERO_STATE = {}
M.ALLY_TOWER_STATE = {}
M.ENEMY_TOWER_STATE = {}
M.CREEPS_STATE = {}

local function GetAllyTowerIncomingDamage()
  return algorithms.GetTotalIncomingDamage(env.ALLY_TOWER_DATA)
           * functions.GetDamageMultiplier(env.ALLY_TOWER_DATA.armor)
end

local function NormalizeValue(value, min, max)
  local result = (value - min) / (max - min)

  if result < 0 then
    return 0 end

  if 1 < result then
    return 1 end

  return result
end

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
    [10] = BOOL_TO_NUMBER[env.IS_FOCUSED_BY_TOWER],
    [11] = BOOL_TO_NUMBER[algorithms.HasModifier(
                            env.BOT_DATA,
                            "modifier_fountain_aura_buff")],
    [12] = functions.GetRate(
             env.BOT_DATA.health,
             env.BOT_DATA.max_health),
    [13] = functions.GetRate(
             env.BOT_DATA.mana,
             env.BOT_DATA.max_mana),

    [14] = BOOL_TO_NUMBER[env.BOT:HasBuyback()],

    [15] = NormalizeValue(
             env.BOT:GetRespawnTime(),
             0,
             constants.MIN_BOT_RESPAWN_TIME),
    [16] = NormalizeValue(env.FOUNTAIN_DISTANCE, 0, constants.BASE_RADIUS)
  }

  M.ENEMY_HERO_STATE = {
    [1] = BOOL_TO_NUMBER[env.ENEMY_HERO_DATA ~= nil],
    [2] = BOOL_TO_NUMBER[env.IS_ENEMY_HERO_LOW_HP],
    [3] = BOOL_TO_NUMBER[env.DOES_TOWER_PROTECT_ENEMY],
    [4] = env.ENEMY_HERO_DISTANCE,
    [5] = BOOL_TO_NUMBER[env.DOES_ENEMY_HERO_HAVE_ADVANTAGE],
  }

  if env.ALLY_TOWER_DATA ~= nil then
    M.ALLY_TOWER_STATE = {
      [1] = BOOL_TO_NUMBER[env.ALLY_TOWER_DATA ~= nil],
      [2] = BOOL_TO_NUMBER[GetGlyphCooldown() == 0],
      [3] = NormalizeValue(GetAllyTowerIncomingDamage(),
              0,
              constants.MAX_INCOMING_TOWER_DAMAGE),
      [4] = BOOL_TO_NUMBER[algorithms.IsUnitLowHp(env.ALLY_TOWER_DATA)]
    }
  else
    M.ALLY_TOWER_STATE = {}
  end

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
