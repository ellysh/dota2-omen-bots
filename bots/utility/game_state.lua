local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local map = require(
  GetScriptDirectory() .."/utility/map")

local logger = require(
  GetScriptDirectory() .."/utility/logger")

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

local function PrintState(name, state)
  logger.Print(name .. " team = " .. GetTeam())

  functions.DoWithKeysAndElements(
    state,
    function(key, value)
      if state[key] ~= nil then
        logger.Print(tostring(key) .. " = " .. tostring(value))
      end
    end)

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

    [16] = NormalizeValue(
             env.FOUNTAIN_DISTANCE,
             0,
             constants.BASE_RADIUS),

    [17] = BOOL_TO_NUMBER[
             algorithms.IsItemCastable(env.BOT_DATA, "item_flask")],
    [18] = BOOL_TO_NUMBER[
             algorithms.IsItemCastable(env.BOT_DATA, "item_faerie_fire")],
    [19] = BOOL_TO_NUMBER[
             algorithms.IsItemCastable(env.BOT_DATA, "item_tango")],

    [20] = NormalizeValue(
             env.BOT_DATA.max_health - env.BOT_DATA.health,
             0,
             env.BOT_DATA.max_health),

    [21] = BOOL_TO_NUMBER[
             algorithms.IsItemCastable(env.BOT_DATA, "item_tpscroll")],

    [22] = BOOL_TO_NUMBER[env.BOT_DATA.gold < constants.RESERVED_GOLD],

    [23] = NormalizeValue(
             env.FOUNTAIN_DISTANCE,
             0,
             constants.MIN_TP_BASE_RADIUS),

    [24] = BOOL_TO_NUMBER[
             algorithms.DoesBotOrCourierHaveItem("item_faerie_fire")],
    [25] = BOOL_TO_NUMBER[
             algorithms.DoesBotOrCourierHaveItem("item_flask")],
    [26] = BOOL_TO_NUMBER[
             algorithms.DoesBotOrCourierHaveItem("item_tango")],

    [27] = BOOL_TO_NUMBER[
             map.IsUnitInEnemyTowerAttackRange(env.BOT_DATA)],

    [28] = BOOL_TO_NUMBER[map.IsUnitInSpot(env.BOT_DATA, env.SAFE_SPOT)],

    [29] = BOOL_TO_NUMBER[algorithms.AreEnemyCreepsInRadius(
                            env.BOT_DATA,
                            constants.CREEP_MAX_AGGRO_RADIUS)],

    [30] = BOOL_TO_NUMBER[algorithms.HasLevelForAggression(env.BOT_DATA)],

    [31] = BOOL_TO_NUMBER[map.IsUnitInEnemyTowerAttackRange(
                            env.BOT_DATA)],
  }

  PrintState("M.BOT_STATE", M.BOT_STATE)

  M.ENEMY_HERO_STATE = {
    [1] = BOOL_TO_NUMBER[env.ENEMY_HERO_DATA ~= nil],
    [2] = BOOL_TO_NUMBER[env.IS_ENEMY_HERO_LOW_HP],
    [3] = BOOL_TO_NUMBER[env.DOES_TOWER_PROTECT_ENEMY],

    [4] = NormalizeValue(
            env.ENEMY_HERO_DISTANCE,
            0,
            constants.SAFE_HERO_DISTANCE),

    [5] = BOOL_TO_NUMBER[env.DOES_ENEMY_HERO_HAVE_ADVANTAGE],
    [6] = BOOL_TO_NUMBER[true],
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

  if env.ENEMY_TOWER_DATA ~= nil then
    M.ENEMY_TOWER_STATE = {
      [1] = BOOL_TO_NUMBER[env.ENEMY_TOWER_DATA ~= nil],
      [2] = NormalizeValue(
              env.ENEMY_TOWER_DISTANCE,
              0,
              constants.MIN_TOWER_DISTANCE)
    }
  else
    M.ENEMY_TOWER_STATE = {}
  end

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

  if env.NEARBY_TREE ~= nil then
    M.NEARBY_TREE_STATE = {
      [1] = BOOL_TO_NUMBER[env.NEARBY_TREE ~= nil],

      [2] = NormalizeValue(
              functions.GetDistance(
                GetTreeLocation(env.NEARBY_TREE),
                env.ENEMY_TOWER_DATA.location),
              0,
              constants.TOWER_ATTACK_RANGE
              + constants.MOTION_BUFFER_RANGE),

      [3] = BOOL_TO_NUMBER[env.ENEMY_TOWER_DATA ~= nil],
    }
  else
    M.NEARBY_TREE_STATE = {}
  end
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
