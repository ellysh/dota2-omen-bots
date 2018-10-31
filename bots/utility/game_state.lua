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

local NUM = {  [true] = 1, [false] = 0 }

M.GAME_STATE = {}

-- GAME_STATE indexes
-- BOT state
M.BOT_IS_ALIVE = 1
M.BOT_IS_LOW_HP = 2
M.BOT_IS_FLASK_HEALING = 3
M.BOT_IS_HEALING = 4
M.BOT_IS_BASE_RECOVERY = 5
M.BOT_HAS_ADVANTAGE = 6
M.BOT_IS_FOCUSED_BY_CREEPS = 7
M.BOT_IS_FOCUSED_BY_ENEMY_HERO = 8
M.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT = 9
M.BOT_IS_FOCUSED_BY_TOWER = 10
M.BOT_HAS_MODIFIER_FOUNTAIN = 11
M.BOT_HP_RATE = 12
M.BOT_HP_MAX_DELTA = 13
M.BOT_MP_RATE = 14
M.BOT_HAS_BUYBACK = 15
M.BOT_RESPAWN_TIME = 16
M.BOT_FOUNTAIN_DISTANCE = 17
M.BOT_CASTABLE_FLASK = 18
M.BOT_CASTABLE_FAERIE_FIRE = 19
M.BOT_CASTABLE_TANGO = 20
M.BOT_CASTABLE_TP_SCROLL = 21
M.BOT_GOLD = 22
M.BOT_HAS_FLASK = 23
M.BOT_HAS_FAERIE_FIRE = 24
M.BOT_HAS_TANGO = 25
M.BOT_IN_ENEMY_TOWER_RANGE = 26
M.BOT_IN_SAFE_SPOT = 27
M.BOT_HAS_LEVEL_FOR_AGRESSION = 28
M.BOT_INCOMING_DAMAGE = 29
M.BOT_HAS_BETTER_POSITION = 30

-- ENEMY_HERO state
M.EH_PRESENT = 100
M.EH_IS_LOW_HP = 101
M.EH_IS_TOWER_PROTECTED = 102
M.EH_BOT_DISTANCE = 103
M.EH_HAS_ADVANTAGE = 104
M.EH_INCOMING_DAMAGE = 105
M.EH_IN_BOT_ATTACK_RANGE = 106
M.BOT_IN_EH_ATTACK_RANGE = 107
M.EH_IS_VISIBLE = 108
M.EH_CAN_BE_ATTACKED_UNDER_TOWER = 109
M.EH_CAN_BE_FOLLOWED_UNDER_TOWER = 110

-- ALLY_TOWER state
M.AT_PRESENT = 200
M.AT_IS_LOW_HP = 201
M.AT_INCOMING_DAMAGE = 202
M.AT_GLYPH_READY = 203

-- ENEMY_TOWER state
M.ET_PRESENT = 300
M.ET_BOT_DISTANCE = 301

-- Creeps state
M.EC_FRONT_PRESENT = 400
M.EC_BACK_PRESENT = 401
M.AC_FRONT_PRESENT = 402
M.AC_BACK_PRESENT = 403
M.EC_PRE_LAST_HIT_PRESENT = 404
M.AC_PRE_LAST_HIT_PRESENT = 405
M.EC_LAST_HIT_PRESENT = 406
M.AC_LAST_HIT_PRESENT = 407
M.EC_IN_AGRO_RADIUS = 408
M.EC_LAST_HIT_IS_TOWER_PROTECTED = 409
M.AC_LAST_HIT_IS_TOWER_PROTECTED = 410
M.AC_LAST_HIT_HP_RATE = 411

-- Tree state
M.NO_TREE_PRESENT = 500
M.TREE_ET_UNSAFE_DISTANCE = 501

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
    [M.BOT_IS_ALIVE] = NUM[algorithms.IsBotAlive()],
    [M.BOT_IS_LOW_HP] = NUM[env.IS_BOT_LOW_HP],
    [M.BOT_IS_FLASK_HEALING] = NUM[env.BOT_DATA.is_flask_healing],
    [M.BOT_IS_HEALING] = NUM[env.BOT_DATA.is_healing],
    [M.BOT_IS_BASE_RECOVERY] = NUM[env.IS_BASE_RECOVERY],
    [M.BOT_HAS_ADVANTAGE] = NUM[env.DOES_BOT_HAVE_ADVANTAGE],
    [M.BOT_IS_FOCUSED_BY_CREEPS] = NUM[env.IS_FOCUSED_BY_CREEPS],
    [M.BOT_IS_FOCUSED_BY_ENEMY_HERO] = NUM[env.IS_FOCUSED_BY_ENEMY_HERO],
    [M.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = NUM[env.IS_FOCUSED_BY_UNKNOWN_UNIT],
    [M.BOT_IS_FOCUSED_BY_TOWER] = NUM[env.IS_FOCUSED_BY_TOWER],

    [M.BOT_HAS_MODIFIER_FOUNTAIN] = NUM[algorithms.HasModifier(
                                          env.BOT_DATA,
                                          "modifier_fountain_aura_buff")],
    [M.BOT_HP_RATE] = functions.GetRate(
             env.BOT_DATA.health,
             env.BOT_DATA.max_health),

    [M.BOT_HP_MAX_DELTA] = NormalizeValue(
             env.BOT_DATA.max_health - env.BOT_DATA.health,
             0,
             env.BOT_DATA.max_health),

    [M.BOT_MP_RATE] = functions.GetRate(
             env.BOT_DATA.mana,
             env.BOT_DATA.max_mana),

    [M.BOT_HAS_BUYBACK] = NUM[env.BOT:HasBuyback()],

    [M.BOT_RESPAWN_TIME] = NormalizeValue(
                             env.BOT:GetRespawnTime(),
                             0,
                             constants.MIN_BOT_RESPAWN_TIME),

    [M.BOT_FOUNTAIN_DISTANCE] = NormalizeValue(
                                  env.FOUNTAIN_DISTANCE,
                                  0,
                                  constants.BASE_RADIUS),

    [M.BOT_CASTABLE_FLASK] = NUM[
             algorithms.IsItemCastable(env.BOT_DATA, "item_flask")],
    [M.BOT_CASTABLE_FAERIE_FIRE] = NUM[
             algorithms.IsItemCastable(env.BOT_DATA, "item_faerie_fire")],
    [M.BOT_CASTABLE_TANGO] = NUM[
             algorithms.IsItemCastable(env.BOT_DATA, "item_tango")],
    [M.BOT_CASTABLE_TP_SCROLL] = NUM[
             algorithms.IsItemCastable(env.BOT_DATA, "item_tpscroll")],

    [M.BOT_GOLD] = NUM[env.BOT_DATA.gold < constants.RESERVED_GOLD],

    [M.BOT_HAS_FLASK] = NUM[
             algorithms.DoesBotOrCourierHaveItem("item_flask")],
    [M.BOT_HAS_FAERIE_FIRE] = NUM[
             algorithms.DoesBotOrCourierHaveItem("item_faerie_fire")],
    [M.BOT_HAS_TANGO] = NUM[
             algorithms.DoesBotOrCourierHaveItem("item_tango")],

    [M.BOT_IN_ENEMY_TOWER_RANGE] = NUM[
             map.IsUnitInEnemyTowerAttackRange(env.BOT_DATA)],

    [M.BOT_IN_SAFE_SPOT] = NUM[map.IsUnitInSpot(
                                 env.BOT_DATA,
                                 env.SAFE_SPOT)],

    [M.BOT_HAS_LEVEL_FOR_AGRESSION] = NUM[
      algorithms.HasLevelForAggression(env.BOT_DATA)],

    [M.BOT_INCOMING_DAMAGE] = NormalizeValue(
             (env.BOT_DATA.incoming_damage_from_creeps
              + env.BOT_DATA.incoming_damage_from_towers),
             0,
             constants.MAX_INCOMING_ATTACK_DAMAGE),

    [M.BOT_HAS_BETTER_POSITION] = NUM[algorithms.IsUnitPositionBetter(
                                        env.BOT_DATA,
                                        env.ENEMY_HERO_DATA)]
  }

  M.GAME_STATE[M.EH_PRESENT] = NUM[env.ENEMY_HERO_DATA ~= nil]

  if env.ENEMY_HERO_DATA ~= nil then
    M.GAME_STATE[M.EH_IS_LOW_HP] = NUM[env.IS_ENEMY_HERO_LOW_HP]
    M.GAME_STATE[M.EH_IS_TOWER_PROTECTED] =
      NUM[env.DOES_TOWER_PROTECT_ENEMY]

    M.GAME_STATE[M.EH_BOT_DISTANCE] = NormalizeValue(
                                        env.ENEMY_HERO_DISTANCE,
                                        0,
                                        constants.SAFE_HERO_DISTANCE)

    M.GAME_STATE[M.EH_HAS_ADVANTAGE] =
      NUM[env.DOES_ENEMY_HERO_HAVE_ADVANTAGE]

    M.GAME_STATE[M.EH_INCOMING_DAMAGE] = NormalizeValue(
            (env.ENEMY_HERO_DATA.incoming_damage_from_creeps
             + env.ENEMY_HERO_DATA.incoming_damage_from_towers),
            0,
            constants.MAX_INCOMING_ATTACK_DAMAGE)

    M.GAME_STATE[M.EH_IN_BOT_ATTACK_RANGE] = NUM[
                          env.ENEMY_HERO_DISTANCE
                          <= algorithms.GetAttackRange(
                               env.BOT_DATA,
                               env.ENEMY_HERO_DATA,
                               true)]

    M.GAME_STATE[M.BOT_IN_EH_ATTACK_RANGE] = NUM[
                          env.ENEMY_HERO_DISTANCE
                          <= algorithms.GetAttackRange(
                               env.ENEMY_HERO_DATA,
                               env.BOT_DATA,
                               true)]

    M.GAME_STATE[M.EH_IS_VISIBLE] = NUM[env.ENEMY_HERO_DATA.is_visible]

    M.GAME_STATE[M.EH_CAN_BE_ATTACKED_UNDER_TOWER] =
      NUM[IsAttackHeroUnderTowerSafe()]

    M.GAME_STATE[M.EH_CAN_BE_FOLLOWED_UNDER_TOWER] =
      NUM[algorithms.IsTowerDiveReasonable(
           env.BOT_DATA,
           env.ENEMY_HERO_DATA)]
  end

  M.GAME_STATE[M.AT_PRESENT] = NUM[env.ALLY_TOWER_DATA ~= nil]

  if env.ALLY_TOWER_DATA ~= nil then
    M.GAME_STATE[M.AT_IS_LOW_HP] =
      NUM[algorithms.IsUnitLowHp(env.ALLY_TOWER_DATA)]

    M.GAME_STATE[M.AT_INCOMING_DAMAGE] =
      NormalizeValue(GetAllyTowerIncomingDamage(),
                     0,
                     constants.MAX_INCOMING_TOWER_DAMAGE)

    M.GAME_STATE[M.AT_GLYPH_READY] = NUM[GetGlyphCooldown() == 0]
  end

  M.GAME_STATE[M.ET_PRESENT] = NUM[env.ENEMY_TOWER_DATA ~= nil]

  if env.ENEMY_TOWER_DATA ~= nil then
    M.GAME_STATE[M.ET_BOT_DISTANCE] = NormalizeValue(
                                        env.ENEMY_TOWER_DISTANCE,
                                        0,
                                        constants.MIN_TOWER_DISTANCE)
  end

  M.GAME_STATE[M.EC_FRONT_PRESENT] =
    NUM[env.ENEMY_CREEP_FRONT_DATA ~= nil]

  M.GAME_STATE[M.EC_BACK_PRESENT] = NUM[env.ENEMY_CREEP_BACK_DATA ~= nil]
  M.GAME_STATE[M.AC_FRONT_PRESENT] = NUM[env.ALLY_CREEP_FRONT_DATA ~= nil]
  M.GAME_STATE[M.AC_BACK_PRESENT] = NUM[env.ALLY_CREEP_BACK_DATA ~= nil]

  M.GAME_STATE[M.EC_PRE_LAST_HIT_PRESENT] =
    NUM[env.PRE_LAST_HIT_ENEMY_CREEP ~= nil]

  M.GAME_STATE[M.AC_PRE_LAST_HIT_PRESENT] =
    NUM[env.PRE_LAST_HIT_ALLY_CREEP ~= nil]

  M.GAME_STATE[M.EC_LAST_HIT_PRESENT] =
    NUM[env.LAST_HIT_ENEMY_CREEP ~= nil]

  M.GAME_STATE[M.AC_LAST_HIT_PRESENT] =
    NUM[env.LAST_HIT_ALLY_CREEP ~= nil]

  M.GAME_STATE[M.EC_IN_AGRO_RADIUS] =
    NUM[algorithms.AreEnemyCreepsInRadius(
          env.BOT_DATA,
          constants.CREEP_MAX_AGGRO_RADIUS)]

  if env.LAST_HIT_ENEMY_CREEP ~= nil then
    M.GAME_STATE[M.EC_LAST_HIT_IS_TOWER_PROTECTED] =
      NUM[algorithms.DoesTowerProtectUnit(
            env.LAST_HIT_ENEMY_CREEP)]
  end

  if env.LAST_HIT_ALLY_CREEP ~= nil then
    M.GAME_STATE[M.AC_LAST_HIT_IS_TOWER_PROTECTED] =
      NUM[algorithms.DoesTowerProtectUnit(
            env.LAST_HIT_ALLY_CREEP)]

    M.GAME_STATE[M.AC_LAST_HIT_HP_RATE] =
      functions.GetRate(
        env.LAST_HIT_ALLY_CREEP.health,
        env.LAST_HIT_ALLY_CREEP.max_health)
  end

  M.GAME_STATE[M.NO_TREE_PRESENT] = NUM[env.NEARBY_TREE == nil]

  if env.NEARBY_TREE ~= nil and env.ENEMY_TOWER_DATA ~= nil then
    M.GAME_STATE[M.TREE_ET_UNSAFE_DISTANCE] = NUM[
                 functions.GetDistance(
                   GetTreeLocation(tree),
                   env.ENEMY_TOWER_DATA.location)
                 <= algorithms.GetAttackRange(
                      env.ENEMY_TOWER_DATA,
                      env.BOT_DATA,
                      true)]
  end

  logger.PrintGameState(M.GAME_STATE)
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
