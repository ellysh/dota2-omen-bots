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

M.GAME_STATE = {}

local function GetAllyTowerIncomingDamage()
  return algorithms.GetTotalIncomingDamage(env.ALLY_TOWER_DATA)
           * functions.GetDamageMultiplier(env.ALLY_TOWER_DATA.armor)
end

local function IsAttackHeroUnderTowerSafe()
  return env.ALLY_CREEP_FRONT_DATA ~= nil
         and constants.TOWER_AGGRO_RADIUS < env.ENEMY_TOWER_DISTANCE
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
  M.GAME_STATE = {
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

    [32] = NormalizeValue(
             (env.BOT_DATA.incoming_damage_from_creeps
              + env.BOT_DATA.incoming_damage_from_towers),
             0,
             constants.MAX_INCOMING_ATTACK_DAMAGE),

    [33] = BOOL_TO_NUMBER[algorithms.IsUnitPositionBetter(
                            env.BOT_DATA,
                            env.ENEMY_HERO_DATA)]
  }

  logger.PrintState("M.GAME_STATE", M.GAME_STATE)

  M.GAME_STATE[100] = BOOL_TO_NUMBER[env.ENEMY_HERO_DATA ~= nil]

  if env.ENEMY_HERO_DATA ~= nil then
    M.GAME_STATE[101] = BOOL_TO_NUMBER[env.IS_ENEMY_HERO_LOW_HP]
    M.GAME_STATE[102] = BOOL_TO_NUMBER[env.DOES_TOWER_PROTECT_ENEMY]

    M.GAME_STATE[103] = NormalizeValue(
                          env.ENEMY_HERO_DISTANCE,
                          0,
                          constants.SAFE_HERO_DISTANCE)

    M.GAME_STATE[104] = BOOL_TO_NUMBER[
                          env.DOES_ENEMY_HERO_HAVE_ADVANTAGE]

    M.GAME_STATE[105] = NormalizeValue(
            (env.ENEMY_HERO_DATA.incoming_damage_from_creeps
             + env.ENEMY_HERO_DATA.incoming_damage_from_towers),
            0,
            constants.MAX_INCOMING_ATTACK_DAMAGE)

    M.GAME_STATE[106] = BOOL_TO_NUMBER[
                          env.ENEMY_HERO_DISTANCE
                          < algorithms.GetAttackRange(
                              env.BOT_DATA,
                              env.ENEMY_HERO_DATA,
                              true)]

    M.GAME_STATE[107] = BOOL_TO_NUMBER[env.ENEMY_HERO_DATA.is_visible]
    M.GAME_STATE[108] = BOOL_TO_NUMBER[IsAttackHeroUnderTowerSafe()]
    M.GAME_STATE[109] = BOOL_TO_NUMBER[algorithms.IsTowerDiveReasonable(
                                         env.BOT_DATA,
                                         env.ENEMY_HERO_DATA)]
  end

  M.GAME_STATE[200] = BOOL_TO_NUMBER[env.ALLY_TOWER_DATA ~= nil]

  if env.ALLY_TOWER_DATA ~= nil then
    M.GAME_STATE[201] = BOOL_TO_NUMBER[GetGlyphCooldown() == 0]
    M.GAME_STATE[202] = NormalizeValue(GetAllyTowerIncomingDamage(),
                          0,
                          constants.MAX_INCOMING_TOWER_DAMAGE)
    M.GAME_STATE[203] = BOOL_TO_NUMBER[
                          algorithms.IsUnitLowHp(env.ALLY_TOWER_DATA)]
  end

  M.GAME_STATE[300] = BOOL_TO_NUMBER[env.ENEMY_TOWER_DATA ~= nil]

  if env.ENEMY_TOWER_DATA ~= nil then
    M.GAME_STATE[301] = NormalizeValue(
                          env.ENEMY_TOWER_DISTANCE,
                          0,
                          constants.MIN_TOWER_DISTANCE)
  end

  M.GAME_STATE[400] = BOOL_TO_NUMBER[env.ENEMY_CREEP_FRONT_DATA ~= nil]
  M.GAME_STATE[401] = BOOL_TO_NUMBER[env.ENEMY_CREEP_BACK_DATA ~= nil]
  M.GAME_STATE[402] = BOOL_TO_NUMBER[env.ALLY_CREEP_FRONT_DATA ~= nil]
  M.GAME_STATE[403] = BOOL_TO_NUMBER[env.ALLY_CREEP_BACK_DATA ~= nil]
  M.GAME_STATE[404] = BOOL_TO_NUMBER[env.PRE_LAST_HIT_ENEMY_CREEP ~= nil]
  M.GAME_STATE[405] = BOOL_TO_NUMBER[env.PRE_LAST_HIT_ALLY_CREEP ~= nil]
  M.GAME_STATE[406] = BOOL_TO_NUMBER[env.LAST_HIT_ENEMY_CREEP ~= nil]
  M.GAME_STATE[407] = BOOL_TO_NUMBER[env.LAST_HIT_ALLY_CREEP ~= nil]

  if env.LAST_HIT_ENEMY_CREEP ~= nil then
    M.GAME_STATE[408] = BOOL_TO_NUMBER[algorithms.DoesTowerProtectUnit(
                                         env.LAST_HIT_ENEMY_CREEP)]
  end

  if env.LAST_HIT_ALLY_CREEP ~= nil then
    M.GAME_STATE[409] = BOOL_TO_NUMBER[algorithms.DoesTowerProtectUnit(
                                         env.LAST_HIT_ALLY_CREEP)]

    M.GAME_STATE[410] = functions.GetRate(
                          env.LAST_HIT_ALLY_CREEP.health,
                          env.LAST_HIT_ALLY_CREEP.max_health)
  end

  M.GAME_STATE[500] = BOOL_TO_NUMBER[env.NEARBY_TREE ~= nil]

  if env.NEARBY_TREE ~= nil then
    M.GAME_STATE[501] = NormalizeValue(
                          functions.GetDistance(
                            GetTreeLocation(env.NEARBY_TREE),
                            env.ENEMY_TOWER_DATA.location),
                          0,
                          constants.TOWER_ATTACK_RANGE
                          + constants.MOTION_BUFFER_RANGE)

    M.GAME_STATE[502] = BOOL_TO_NUMBER[env.ENEMY_TOWER_DATA ~= nil]
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
