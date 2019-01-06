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

local hist = require(
  GetScriptDirectory() .."/utility/history")

local logger = require(
  GetScriptDirectory() .."/utility/logger")

local M = {}

local NUM = {  [true] = 1, [false] = 0 }

M.GAME_STATE = {}

-- Do not use GAME_STATE variables as bool! They are converted to numbers

-- GAME_STATE indexes
-- BOT state
M.BOT_IS_ALIVE = 1
M.BOT_IS_LOW_HP = 2
M.BOT_IS_FLASK_HEALING = 3
M.BOT_IS_HEALING = 4
M.BOT_IS_BASE_RECOVERY = 5
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
M.BOT_NEAR_FOUNTAIN = 17
M.BOT_CASTABLE_FLASK = 18
M.BOT_CASTABLE_FAERIE_FIRE = 19
M.BOT_IS_SILENCED = 20
M.BOT_CASTABLE_TP_SCROLL = 21
M.BOT_HAS_RESERVED_GOLD = 22
M.BOT_HAS_FLASK = 23
M.BOT_HAS_FAERIE_FIRE = 24
M.BOT_HAS_FROST_ARROWS_MODIFIER = 25
M.BOT_IN_ENEMY_TOWER_RANGE = 26
M.BOT_IN_SAFE_SPOT = 27
M.BOT_HAS_LEVEL_FOR_AGRESSION = 28
M.BOT_CASTABLE_PIKE = 29
M.BOT_HAS_BETTER_POSITION = 30
M.BOT_STASH_FULL = 31
M.BOT_MOVING = 32
M.BOT_IN_ALLY_TOWER_RANGE = 33
M.BOT_IN_RIVER = 34
M.BOT_IN_MID_TP_DISTANCE = 35
M.TURN_TARGET_PRESENT = 36
M.BOT_IS_FACING_TURN_TARGET = 37
M.BOT_IN_BODY_BLOCK_SPOT = 38
M.BOT_IS_FACING_ENEMY_FOUNTAIN = 39
M.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE = 40
M.BOT_CASTABLE_FROST_ARROWS = 41
M.BOT_CASTABLE_GUST = 42
M.BOT_CASTABLE_PRECISION_AURA = 43
M.BOT_IS_LOW_MP = 44
--M.BOT_CASTABLE_ENCHANTED_MANGO = 45
--M.BOT_HAS_MP_FOR_CYCLONE_AND_REQUIEM = 46
--M.BOT_HAS_MAX_SOULS = 47
--M.BOT_IS_CASTING_NEAR_SHADOWRAZE = 48
--M.BOT_IS_CASTING_MEDIUM_SHADOWRAZE = 49
--M.BOT_IS_CASTING_FAR_SHADOWRAZE = 50
M.BOT_IS_CASTING = 51
M.BOT_IS_TURNING = 52
M.BOT_IS_ATTACKING = 53
M.BOT_DOES_BACKSWING = 54
M.BOT_IS_MOVING_BASE = 55
M.BOT_NEXT_WAYPOINT_BLOCKED = 56
M.BOT_LAST_WAYPOINT_REACHED = 57
M.SAFE_SPOT_HAS_CHANGED = 58
M.BOT_CASTABLE_WARD = 59
M.BOT_BUY_WARD_PERIOD_ACHIEVED = 60
--M.BOT_HAS_LEVEL_FOR_NUKES = 61
M.BOT_IS_INACTIVE = 62
M.BOT_CASTABLE_BLINK = 63
--M.BOT_HAS_HP_FOR_NUKE = 64

-- ENEMY_HERO state
M.EH_PRESENT = 100
M.EH_IS_LOW_HP = 101
M.EH_IS_TOWER_PROTECTED = 102
M.BOT_IN_SAFE_DISTANCE_FROM_EH = 103
M.EH_IN_GUST_RANGE = 104
M.EH_HAS_HP_FOR_PIKE = 105
M.EH_NOT_IN_BOT_ATTACK_RANGE = 106
M.EH_IN_PURSUIT_RANGE = 107
M.BOT_IN_EH_ATTACK_RANGE = 108
M.EH_IS_VISIBLE = 109
M.EH_CAN_BE_ATTACKED_UNDER_TOWER = 110
M.EH_CAN_BE_FOLLOWED_UNDER_TOWER = 111
M.EH_HAS_BETTER_POSITION = 112
M.BOT_ATTACK_EH = 113
M.EH_IN_REAR_SPOT = 114
M.BOT_IN_EH_MIN_DISTANCE = 115
M.EH_IS_FLASK_HEALING = 116
M.EH_IN_PIKE_RANGE = 117
--M.EH_IN_MEDIUM_SHADOWRAZE_RANGE = 118
--M.EH_IN_FAR_SHADOWRAZE_RANGE = 119
M.BOT_IS_FACING_EH = 120
M.EH_IS_CASTING = 121
--M.EH_IS_CASTING_NEAR_SHADOWRAZE = 122
--M.EH_IS_CASTING_MEDIUM_SHADOWRAZE = 123
--M.EH_IS_CASTING_FAR_SHADOWRAZE = 124
--M.BOT_CAN_EVADE_NEAR_SHADOWRAZE_BACK = 125
--M.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_BACK = 126
--M.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_FRONT = 127
--M.BOT_CAN_EVADE_FAR_SHADOWRAZE_BACK = 128
--M.BOT_CAN_EVADE_FAR_SHADOWRAZE_FRONT = 129
M.BOT_IS_FACING_EH_MELEE_RANGE = 130
M.EH_IS_FACING_BOT = 131
M.EH_IS_FACING_BOT_MELEE_RANGE = 132
M.BOT_SHOOT_EH = 133
M.EH_HAS_LESS_HTD = 134
M.EH_ATTACK_BOT = 135
M.BOT_IN_EH_POTENTIAL_RADIUS = 136
--M.EH_IN_CYCLONE_RANGE = 137
--M.EH_HAS_CYCLONE_MODIFIER = 138
M.BOT_IN_EH_LOCATION = 139
M.EH_IN_BLINK_RANGE = 140
--M.EH_CYCLONE_TIMING_READY = 141

-- ALLY_TOWER state
M.AT_PRESENT = 200
M.AT_IS_LOW_HP = 201
M.AT_INCOMING_DAMAGE = 202
M.AT_GLYPH_READY = 203
M.EH_ATTACK_AT = 204

-- ENEMY_TOWER state
M.ET_PRESENT = 300
M.BOT_IN_ET_MIN_DISTANCE = 301
M.ET_ATTACK_AC = 302
M.BOT_IN_ET_AGGRO_RADIUS = 303
M.ET_IS_LOW_HP = 304
M.ET_IS_VISIBLE = 305

-- Creeps state
M.EC_FRONT_PRESENT = 400
M.EC_BACK_PRESENT = 401
M.AC_FRONT_PRESENT = 402
M.AC_BACK_PRESENT = 403
M.EC_PRE_LAST_HIT_PRESENT = 404
M.AC_PRE_LAST_HIT_PRESENT = 405
M.EC_LAST_HIT_PRESENT = 406
M.AC_LAST_HIT_PRESENT = 407
M.EC_IN_AGGRO_RADIUS = 408
M.EC_LAST_HIT_IS_TOWER_PROTECTED = 409
M.AC_LAST_HIT_IS_TOWER_PROTECTED = 410
M.AC_LAST_HIT_HP_RATE = 411
M.EC_MAX_HP_TARGETABLE_PRESENT = 412
M.AC_TARGETABLE_PRESENT = 413
M.EC_MAX_HP_TARGETABLE_IS_TOWER_PROTECTED = 414
M.AC_TARGETABLE_IS_TOWER_PROTECTED = 415
M.EC_AGGRO_COOLDOWN = 416
M.EAC_PRE_LAST_HIT_PRESENT = 417
M.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS = 418
M.EC_FRONT_IN_AGGRO_RADIUS = 419
M.IS_FIRST_WAVE = 420
M.EC_IN_MIN_BASE_DISTANCE = 421
M.EC_IN_MAX_BASE_DISTANCE = 422
M.AC_FRONT_IN_MAX_BASE_DISTANCE = 423
M.EC_HAVE_HP_ADVANTAGE = 424
M.AC_HAVE_HP_ADVANTAGE = 425
M.EC_IN_BOT_ATTACK_RANGE = 426
M.AC_IN_MELEE_ATTACK_RANGE = 427
M.EC_MIN_HP_TARGETABLE_PRESENT = 428
M.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED = 429
M.EC_ATTACKING_TOWER_PRESENT = 430
M.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS = 431
M.EC_ATTACKING_BOT_PRESENT = 432
M.EC_ATTACKING_BOT_BETWEEN_AT = 433
M.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE = 434
M.EC_IN_MELEE_ATTACK_RANGE = 435
M.AC_SIEGE_PRESENT = 436

-- Courier state
M.COURIER_ON_BASE = 600
M.COURIER_IS_AVAILABLE = 601

-- Wards state
M.AW_PRESENT = 700

-- General game state
M.DOES_CREEP_MEET = 800
M.IS_NIGHT = 801

local function GetAllyTowerIncomingDamage()
  return algorithms.GetTotalIncomingDamage(env.ALLY_TOWER_DATA)
           * functions.GetDamageMultiplier(env.ALLY_TOWER_DATA.armor)
end

local function IsAttackHeroUnderTowerSafe()
  return env.ALLY_CREEP_FRONT_DATA ~= nil
         and constants.TOWER_AGGRO_RADIUS < env.ENEMY_TOWER_DISTANCE
end

local function IsBodyBlockFountainDistance()
  local max_distance = functions.ternary(
                         GetTeam() == TEAM_RADIANT,
                         constants.BODY_BLOCK_FOUNTAIN_RADIANT_DISTANCE,
                         constants.BODY_BLOCK_FOUNTAIN_DIRE_DISTANCE)

  return functions.GetDistance(env.FOUNTAIN_SPOT, env.BOT_DATA.location)
         <= max_distance
end

local function NormalizeValue(value, min, max)
  local result = (value - min) / (max - min)

  if result < 0 then
    return 0 end

  if 1 < result then
    return 1 end

  return result
end

local function IsTurning(move)
  local list = {
    "turn",
  }

  return functions.IsElementInList(list, move, false)
end

local function IsInactive(objective)
  local list = {
    "swap_items",
    "buy_items",
    "glyph",
  }

  return functions.IsElementInList(list, objective, false)
end

local function IsNight()
  return GetTimeOfDay() < 0.25
         or 0.75 < GetTimeOfDay()
end

local function IsAllySiegeCreepPresent()
  local creeps = algorithms.GetAllyCreeps(
                   env.BOT_DATA,
                   constants.MAX_UNIT_SEARCH_RADIUS)

  return nil ~= functions.GetElementWith(
                  creeps,
                  nil,
                  function(unit_data)
                    return unit_data.name == "npc_dota_goodguys_siege"
                           or unit_data.name == "npc_dota_badguys_siege"
                  end)
end

function M.UpdateState()
  -- BOT state

  M.GAME_STATE = {
    [M.BOT_IS_ALIVE] = NUM[algorithms.IsBotAlive()],
    [M.BOT_IS_LOW_HP] = NUM[env.IS_BOT_LOW_HP],
    [M.BOT_IS_FLASK_HEALING] = NUM[env.BOT_DATA.is_flask_healing],
    [M.BOT_IS_HEALING] = NUM[env.BOT_DATA.is_healing],
    [M.BOT_IS_BASE_RECOVERY] = NUM[env.IS_BASE_RECOVERY],
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

    [M.BOT_NEAR_FOUNTAIN] =
      NUM[env.FOUNTAIN_DISTANCE <= constants.BASE_RADIUS],

    [M.BOT_CASTABLE_BLINK] =
      NUM[algorithms.IsItemCastable(
            env.BOT_DATA,
            "item_blink",
            false,
            hist.SWAP_BACKPACK_TIMESTAMP)],

    [M.BOT_CASTABLE_FLASK] =
      NUM[algorithms.IsItemCastable(
            env.BOT_DATA,
            "item_flask",
            false,
            hist.SWAP_BACKPACK_TIMESTAMP)],

    [M.BOT_CASTABLE_FAERIE_FIRE] =
      NUM[algorithms.IsItemCastable(
            env.BOT_DATA,
            "item_faerie_fire",
            false,
            hist.SWAP_BACKPACK_TIMESTAMP)],

    [M.BOT_IS_SILENCED] = NUM[env.BOT_DATA.is_silenced],

    [M.BOT_CASTABLE_TP_SCROLL] =
      NUM[algorithms.IsItemCastable(
            env.BOT_DATA,
            "item_tpscroll",
            false)],

    [M.BOT_HAS_RESERVED_GOLD] =
      NUM[constants.RESERVED_GOLD <= env.BOT_DATA.gold],

    [M.BOT_HAS_FLASK] =
      NUM[algorithms.DoesBotOrCourierHaveItem("item_flask")],

    [M.BOT_HAS_FAERIE_FIRE] =
      NUM[algorithms.DoesBotOrCourierHaveItem("item_faerie_fire")],

    [M.BOT_HAS_FROST_ARROWS_MODIFIER] =
      NUM[algorithms.HasModifier(
            env.BOT_DATA,
            "modifier_drow_ranger_frost_arrows_slow")],

    [M.BOT_IN_ENEMY_TOWER_RANGE] =
      NUM[map.IsUnitInEnemyTowerAttackRange(env.BOT_DATA)],

    [M.BOT_IN_ALLY_TOWER_RANGE] =
      NUM[map.IsUnitInSpot(
            env.BOT_DATA,
            map.GetAllySpot("tower_tier_1_attack"))],

    [M.BOT_IN_SAFE_SPOT] = NUM[map.IsUnitInSpot(
                                 env.BOT_DATA,
                                 env.SAFE_SPOT)],

    [M.BOT_HAS_LEVEL_FOR_AGRESSION] =
      NUM[constants.HERO_LEVEL_FOR_AGGRESSION <= env.BOT_DATA.level],

    [M.BOT_CASTABLE_PIKE] =
      NUM[algorithms.IsItemCastable(
            env.BOT_DATA,
            "item_hurricane_pike",
            false,
            hist.SWAP_BACKPACK_TIMESTAMP)],

    [M.BOT_STASH_FULL] = NUM[0 < env.BOT_DATA.stash_value],

    [M.BOT_MOVING] = NUM[algorithms.IsUnitMoving(env.BOT_DATA)],

    [M.BOT_IN_RIVER] =
      NUM[map.IsUnitInSpot(env.BOT_DATA, map.GetEnemySpot("river"))],

    [M.BOT_IN_MID_TP_DISTANCE] =
      NUM[constants.MIN_TP_SPOT_RADIUS
          < functions.GetDistance(
              map.GetAllySpot("high_ground"),
              env.BOT_DATA.location)],

    [M.TURN_TARGET_PRESENT] =
      NUM[env.TURN_TARGET_DATA ~= nil],

    [M.BOT_IN_BODY_BLOCK_SPOT] =
      NUM[map.IsUnitInSpot(env.BOT_DATA, env.BODY_BLOCK_SPOT)],

    [M.BOT_IS_FACING_ENEMY_FOUNTAIN] =
      NUM[functions.IsFacingLocation(
            env.BOT_DATA,
            map.GetEnemySpot("high_ground"),
            30)],

    [M.BOT_IN_BODY_BLOCK_FOUNTAIN_DISTANCE] =
      NUM[IsBodyBlockFountainDistance()],

    [M.BOT_CASTABLE_FROST_ARROWS] =
      NUM[env.FROST_ARROWS_ABILITY:IsFullyCastable()],

    [M.BOT_CASTABLE_GUST] =
      NUM[env.GUST_ABILITY:IsFullyCastable()],

    [M.BOT_CASTABLE_PRECISION_AURA] =
      NUM[env.PRECISION_AURA_ABILITY:IsFullyCastable()],

    [M.BOT_IS_LOW_MP] = NUM[algorithms.IsUnitLowMp(env.BOT_DATA)],

    [M.BOT_IS_CASTING] = NUM[env.BOT_DATA.is_casting],

    [M.BOT_IS_ATTACKING] =
      NUM[algorithms.IsUnitAttack(env.BOT_DATA)
          and not algorithms.IsAttackDone(env.BOT_DATA)],

    [M.BOT_DOES_BACKSWING] =
      NUM[algorithms.IsUnitAttack(env.BOT_DATA)
          and algorithms.IsAttackDone(env.BOT_DATA)],

    [M.BOT_NEXT_WAYPOINT_BLOCKED] =
      NUM[env.ENEMY_HERO_DATA ~= nil
          and algorithms.IsEnemyBlockSpot(
                env.BOT_DATA,
                {env.ENEMY_HERO_DATA},
                algorithms.GetNextWaypoint(
                  env.BOT_DATA,
                  env.SAFE_SPOT_WAYPOINTS))],

    [M.BOT_LAST_WAYPOINT_REACHED] =
      NUM[map.IsUnitInSpot(
            env.BOT_DATA,
            env.SAFE_SPOT_WAYPOINTS[#env.SAFE_SPOT_WAYPOINTS])],

    [M.SAFE_SPOT_HAS_CHANGED] =
      NUM[not functions.AreTablesEqual(
                env.SAFE_SPOT,
                hist.LAST_SAFE_SPOT)],

    [M.BOT_CASTABLE_WARD] =
      NUM[algorithms.IsItemCastable(
            env.BOT_DATA,
            "item_ward_observer",
            false,
            hist.SWAP_BACKPACK_TIMESTAMP)],

    [M.BOT_BUY_WARD_PERIOD_ACHIEVED] =
      NUM[constants.BUY_WARD_PERIOD
          <= (env.CURRENT_GAME_TIME - hist.WARD_BUYING_TIMESTAMP)],
  }

  if hist.LAST_SOMA.move ~= nil then
    M.GAME_STATE[M.BOT_IS_TURNING] =
      NUM[IsTurning(hist.LAST_SOMA.move.move)]

    M.GAME_STATE[M.BOT_IS_MOVING_BASE] =
      NUM[hist.LAST_SOMA.move.move == "move_base"]

    M.GAME_STATE[M.BOT_IS_INACTIVE] =
      NUM[IsInactive(hist.LAST_SOMA.objective.objective)]
  end

  if env.TURN_TARGET_DATA ~= nil then
    M.GAME_STATE[M.BOT_IS_FACING_TURN_TARGET] =
      NUM[functions.IsFacingLocation(
            env.BOT_DATA,
            env.TURN_TARGET_DATA.location,
            constants.TURN_TARGET_MELEE_MAX_DEGREE)]
  end

  -- ENEMY_HERO state

  M.GAME_STATE[M.EH_PRESENT] = NUM[env.ENEMY_HERO_DATA ~= nil]

  if env.ENEMY_HERO_DATA ~= nil then
    M.GAME_STATE[M.EH_IS_LOW_HP] = NUM[env.IS_ENEMY_HERO_LOW_HP]
    M.GAME_STATE[M.EH_IS_TOWER_PROTECTED] =
      NUM[env.DOES_TOWER_PROTECT_ENEMY]

    M.GAME_STATE[M.BOT_IN_SAFE_DISTANCE_FROM_EH] =
      NUM[constants.SAFE_HERO_DISTANCE < env.ENEMY_HERO_DISTANCE]

    M.GAME_STATE[M.EH_IN_GUST_RANGE] =
      NUM[env.ENEMY_HERO_DISTANCE < env.GUST_ABILITY:GetCastRange()]

    M.GAME_STATE[M.EH_HAS_HP_FOR_PIKE] =
      NUM[env.ENEMY_HERO_DATA.health
          <= (4 * env.BOT_DATA.attack_damage)]

    M.GAME_STATE[M.EH_NOT_IN_BOT_ATTACK_RANGE] = NUM[
                          algorithms.GetAttackRange(
                            env.BOT_DATA,
                            env.ENEMY_HERO_DATA,
                            true)
                          < env.ENEMY_HERO_DISTANCE]

    M.GAME_STATE[M.EH_IN_PURSUIT_RANGE] =
      NUM[env.ENEMY_HERO_DISTANCE
          <= (algorithms.GetAttackRange(
                env.BOT_DATA,
                env.ENEMY_HERO_DATA,
                true)
              + constants.MAX_PURSUIT_INC_DISTANCE)]

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

    M.GAME_STATE[M.BOT_HAS_BETTER_POSITION] =
      NUM[algorithms.IsUnitPositionBetter(
            env.BOT_DATA,
            env.ENEMY_HERO_DATA)]

    M.GAME_STATE[M.EH_HAS_BETTER_POSITION] =
      NUM[algorithms.IsUnitPositionBetter(
            env.ENEMY_HERO_DATA,
            env.BOT_DATA)]

    M.GAME_STATE[M.BOT_ATTACK_EH] =
      NUM[env.BOT_DATA.attack_target == env.ENEMY_HERO_DATA]

    M.GAME_STATE[M.EH_IN_REAR_SPOT] =
      NUM[map.IsUnitInSpot(
            env.ENEMY_HERO_DATA,
            map.GetEnemySpot("tower_tier_1_rear_deep"))]

    M.GAME_STATE[M.BOT_IN_EH_MIN_DISTANCE] =
      NUM[env.ENEMY_HERO_DISTANCE <= constants.MIN_HERO_DISTANCE]

    M.GAME_STATE[M.EH_IS_FLASK_HEALING] =
      NUM[env.ENEMY_HERO_DATA.is_flask_healing]

    M.GAME_STATE[M.EH_IN_PIKE_RANGE] =
      NUM[env.ENEMY_HERO_DISTANCE <= constants.PIKE_CAST_RANGE]

    M.GAME_STATE[M.BOT_IS_FACING_EH] =
      NUM[functions.IsFacingLocation(
            env.BOT_DATA,
            env.ENEMY_HERO_DATA.location,
            constants.TURN_TARGET_MAX_DEGREE)]

    M.GAME_STATE[M.BOT_IS_FACING_EH_MELEE_RANGE] =
      NUM[functions.IsFacingLocation(
            env.BOT_DATA,
            env.ENEMY_HERO_DATA.location,
            constants.TURN_TARGET_MELEE_MAX_DEGREE)]

    M.GAME_STATE[M.EH_IS_CASTING] = NUM[env.ENEMY_HERO_DATA.is_casting]

    M.GAME_STATE[M.EH_IS_FACING_BOT] =
      NUM[functions.IsFacingLocation(
            env.ENEMY_HERO_DATA,
            env.BOT_DATA.location,
            constants.TURN_TARGET_MAX_DEGREE)]

    M.GAME_STATE[M.EH_IS_FACING_BOT_MELEE_RANGE] =
      NUM[functions.IsFacingLocation(
            env.ENEMY_HERO_DATA,
            env.BOT_DATA.location,
            constants.TURN_TARGET_MELEE_MAX_DEGREE)]

    M.GAME_STATE[M.BOT_SHOOT_EH] =
      NUM[algorithms.IsUnitShootTarget(env.BOT_DATA, env.ENEMY_HERO_DATA)]

    M.GAME_STATE[M.EH_HAS_LESS_HTD] =
      NUM[algorithms.GetHitsToDie(env.ENEMY_HERO_DATA)
          < algorithms.GetHitsToDie(env.BOT_DATA)]

    M.GAME_STATE[M.EH_ATTACK_BOT] =
      NUM[env.ENEMY_HERO_DATA.attack_target == env.BOT_DATA]

    M.GAME_STATE[M.BOT_IN_EH_LOCATION] =
      NUM[env.ENEMY_HERO_DISTANCE
          <= constants.UNITS_IN_SAME_LOCATION_DISTANCE]

    M.GAME_STATE[M.EH_IN_BLINK_RANGE] =
      NUM[env.ENEMY_HERO_DISTANCE <= constants.BLINK_CAST_RANGE]
  end

  if hist.LAST_SEEN_EH_DATA ~= nil
     and (env.ENEMY_HERO_DATA == nil
          or not env.ENEMY_HERO_DATA.is_visible) then

    local potential_distance =
      functions.GetUnitDistance(env.BOT_DATA, hist.LAST_SEEN_EH_DATA)
      - (hist.LAST_SEEN_EH_DATA.speed * (env.CURRENT_GAME_TIME
      - hist.LAST_SEEN_EH_DATA.timestamp))

    M.GAME_STATE[M.BOT_IN_EH_POTENTIAL_RADIUS] =
      NUM[potential_distance < constants.SAFE_HERO_DISTANCE]
  end

  -- ALLY_TOWER state

  M.GAME_STATE[M.AT_PRESENT] = NUM[env.ALLY_TOWER_DATA ~= nil]

  if env.ALLY_TOWER_DATA ~= nil then
    M.GAME_STATE[M.AT_IS_LOW_HP] =
      NUM[env.ALLY_TOWER_DATA.health <= constants.TOWER_LOW_HEALTH]

    M.GAME_STATE[M.AT_INCOMING_DAMAGE] =
      NormalizeValue(GetAllyTowerIncomingDamage(),
                     0,
                     constants.MAX_INCOMING_TOWER_DAMAGE)

    M.GAME_STATE[M.AT_GLYPH_READY] = NUM[GetGlyphCooldown() == 0]

    if env.ENEMY_HERO_DATA ~= nil then
      M.GAME_STATE[M.EH_ATTACK_AT] =
        NUM[algorithms.IsUnitAttackTarget(
              env.ENEMY_HERO_DATA,
              env.ALLY_TOWER_DATA)]
    end
  end

  -- ENEMY_TOWER state

  M.GAME_STATE[M.ET_PRESENT] = NUM[env.ENEMY_TOWER_DATA ~= nil]

  if env.ENEMY_TOWER_DATA ~= nil then
    M.GAME_STATE[M.BOT_IN_ET_MIN_DISTANCE] =
      NUM[env.ENEMY_TOWER_DISTANCE <= constants.MIN_TOWER_DISTANCE]

    M.GAME_STATE[M.ET_ATTACK_AC] =
      NUM[algorithms.DoesEnemyTowerAttackAllyCreep(
            env.BOT_DATA,
            env.ENEMY_TOWER_DATA)]

    M.GAME_STATE[M.BOT_IN_ET_AGGRO_RADIUS] =
      NUM[env.ENEMY_TOWER_DISTANCE <= constants.TOWER_AGGRO_RADIUS]

    M.GAME_STATE[M.ET_IS_LOW_HP] =
      NUM[env.ENEMY_TOWER_DATA.health <= constants.TOWER_LOW_HEALTH]

    -- The tower is always visible even in fog of war
    M.GAME_STATE[M.ET_IS_VISIBLE] =
      NUM[IsLocationVisible(env.ENEMY_TOWER_DATA.location)]
  end

  -- Creeps state

  M.GAME_STATE[M.EC_FRONT_PRESENT] =
    NUM[env.ENEMY_CREEP_FRONT_DATA ~= nil]

  if env.ENEMY_CREEP_FRONT_DATA ~= nil then
    local ec_distance = functions.GetUnitDistance(
                          env.BOT_DATA,
                          env.ENEMY_CREEP_FRONT_DATA)

    M.GAME_STATE[M.EC_FRONT_IN_AGGRO_RADIUS] =
      NUM[ec_distance <= constants.CREEP_MAX_AGGRO_RADIUS]

    M.GAME_STATE[M.EC_IN_MIN_BASE_DISTANCE] =
      NUM[ec_distance <= constants.MIN_BASE_CREEP_DISTANCE]
  end

  M.GAME_STATE[M.EC_BACK_PRESENT] = NUM[env.ENEMY_CREEP_BACK_DATA ~= nil]
  M.GAME_STATE[M.AC_FRONT_PRESENT] = NUM[env.ALLY_CREEP_FRONT_DATA ~= nil]

  if env.ALLY_CREEP_FRONT_DATA ~= nil then
    M.GAME_STATE[M.AC_FRONT_IN_MAX_BASE_DISTANCE] =
      NUM[functions.GetUnitDistance(
            env.BOT_DATA,
            env.ALLY_CREEP_FRONT_DATA)
          <= constants.MAX_BASE_CREEP_DISTANCE]
  end

  M.GAME_STATE[M.AC_BACK_PRESENT] = NUM[env.ALLY_CREEP_BACK_DATA ~= nil]

  M.GAME_STATE[M.EC_PRE_LAST_HIT_PRESENT] =
    NUM[env.PRE_LAST_HIT_ENEMY_CREEP ~= nil]

  if env.PRE_LAST_HIT_ENEMY_CREEP ~= nil then
    local creep_distance = functions.GetUnitDistance(
                             env.BOT_DATA,
                             env.PRE_LAST_HIT_ENEMY_CREEP)

    M.GAME_STATE[M.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] =
      NUM[constants.CREEP_MIN_AGGRO_RADIUS < creep_distance
          and creep_distance <= constants.CREEP_MAX_AGGRO_RADIUS]
  end

  M.GAME_STATE[M.AC_PRE_LAST_HIT_PRESENT] =
    NUM[env.PRE_LAST_HIT_ALLY_CREEP ~= nil]

  M.GAME_STATE[M.EC_LAST_HIT_PRESENT] =
    NUM[env.LAST_HIT_ENEMY_CREEP ~= nil]

  M.GAME_STATE[M.AC_LAST_HIT_PRESENT] =
    NUM[env.LAST_HIT_ALLY_CREEP ~= nil]

  M.GAME_STATE[M.EC_IN_AGGRO_RADIUS] =
    NUM[algorithms.AreEnemyCreepsInRadius(
          env.BOT_DATA,
          constants.CREEP_MAX_AGGRO_RADIUS)]

  if env.LAST_HIT_ENEMY_CREEP ~= nil then
    M.GAME_STATE[M.EC_LAST_HIT_IS_TOWER_PROTECTED] =
      NUM[algorithms.DoesTowerProtectUnit(env.LAST_HIT_ENEMY_CREEP)]
  end

  if env.LAST_HIT_ALLY_CREEP ~= nil then
    M.GAME_STATE[M.AC_LAST_HIT_IS_TOWER_PROTECTED] =
      NUM[algorithms.DoesTowerProtectUnit(env.LAST_HIT_ALLY_CREEP)]

    M.GAME_STATE[M.AC_LAST_HIT_HP_RATE] =
      functions.GetRate(
        env.LAST_HIT_ALLY_CREEP.health,
        env.LAST_HIT_ALLY_CREEP.max_health)
  end

  M.GAME_STATE[M.EC_MAX_HP_TARGETABLE_PRESENT] =
    NUM[env.ENEMY_CREEP_MAX_HP_TARGETABLE_DATA ~= nil]

  if env.ENEMY_CREEP_MAX_HP_TARGETABLE_DATA ~= nil then
    M.GAME_STATE[M.EC_MAX_HP_TARGETABLE_IS_TOWER_PROTECTED] =
      NUM[algorithms.DoesTowerProtectUnit(
            env.ENEMY_CREEP_MAX_HP_TARGETABLE_DATA)]
  end

  M.GAME_STATE[M.EC_MIN_HP_TARGETABLE_PRESENT] =
    NUM[env.ENEMY_CREEP_MIN_HP_TARGETABLE_DATA ~= nil]

  if env.ENEMY_CREEP_MIN_HP_TARGETABLE_DATA ~= nil then
    M.GAME_STATE[M.EC_MIN_HP_TARGETABLE_IS_TOWER_PROTECTED] =
      NUM[algorithms.DoesTowerProtectUnit(
            env.ENEMY_CREEP_MIN_HP_TARGETABLE_DATA)]
  end

  M.GAME_STATE[M.AC_TARGETABLE_PRESENT] =
    NUM[env.ALLY_CREEP_TARGETABLE_DATA ~= nil]

  if env.ALLY_CREEP_TARGETABLE_DATA ~= nil then
    M.GAME_STATE[M.AC_TARGETABLE_IS_TOWER_PROTECTED] =
      NUM[algorithms.DoesTowerProtectUnit(
            env.ALLY_CREEP_TARGETABLE_DATA)]
  end

  M.GAME_STATE[M.EC_AGGRO_COOLDOWN] =
    NUM[functions.GetDelta(hist.LAST_AGGRO_CONTROL, env.CURRENT_GAME_TIME)
        < constants.CREEPS_AGGRO_COOLDOWN]

  M.GAME_STATE[M.EAC_PRE_LAST_HIT_PRESENT] =
    NUM[env.PRE_LAST_HIT_ANY_CREEP ~= nil]

  M.GAME_STATE[M.IS_FIRST_WAVE] = NUM[algorithms.IsFirstWave()]

  M.GAME_STATE[M.EC_IN_MAX_BASE_DISTANCE] =
    NUM[algorithms.AreEnemyCreepsInRadius(
          env.BOT_DATA,
          constants.MAX_BASE_CREEP_DISTANCE)]

  M.GAME_STATE[M.EC_HAVE_HP_ADVANTAGE] =
    NUM[constants.MAX_CREEPS_HP_DELTA
        < (env.ENEMY_CREEPS_HP - env.ALLY_CREEPS_HP)]

  M.GAME_STATE[M.AC_HAVE_HP_ADVANTAGE] =
    NUM[constants.MAX_CREEPS_HP_DELTA
        < (env.ALLY_CREEPS_HP - env.ENEMY_CREEPS_HP)]

  M.GAME_STATE[M.EC_IN_BOT_ATTACK_RANGE] =
    NUM[algorithms.AreEnemyCreepsInRadius(
          env.BOT_DATA,
          env.BOT_DATA.attack_range)]

  M.GAME_STATE[M.AC_IN_MELEE_ATTACK_RANGE] =
    NUM[algorithms.AreAllyCreepsInRadius(
          env.BOT_DATA,
          constants.MAX_MELEE_ATTACK_RANGE,
          constants.DIRECTION["BACK"])]

  M.GAME_STATE[M.EC_ATTACKING_TOWER_PRESENT] =
    NUM[env.ENEMY_CREEP_ATTACKING_TOWER ~= nil]

  if env.ENEMY_CREEP_ATTACKING_TOWER ~= nil then
    M.GAME_STATE[M.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] =
      NUM[functions.GetUnitDistance(
            env.BOT_DATA,
            env.ENEMY_CREEP_ATTACKING_TOWER)
          <= constants.CREEP_MAX_AGGRO_RADIUS]
  end

  M.GAME_STATE[M.EC_ATTACKING_BOT_PRESENT] =
    NUM[env.ENEMY_CREEP_ATTACKING_BOT ~= nil]

  if env.ENEMY_CREEP_ATTACKING_BOT ~= nil then
    M.GAME_STATE[M.EC_ATTACKING_BOT_BETWEEN_AT] =
      NUM[map.IsUnitBetweenEnemyTowers(env.ENEMY_CREEP_ATTACKING_BOT)]

    M.GAME_STATE[M.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] =
      NUM[map.IsUnitInEnemyTowerAttackRange(
            env.ENEMY_CREEP_ATTACKING_BOT)]
  end

  M.GAME_STATE[M.EC_IN_MELEE_ATTACK_RANGE] =
    NUM[algorithms.AreEnemyCreepsInRadius(
          env.BOT_DATA,
          constants.MAX_MELEE_ATTACK_RANGE)]

  M.GAME_STATE[M.AC_SIEGE_PRESENT] = NUM[IsAllySiegeCreepPresent()]

  -- Courier state

  if env.COURIER_DATA ~= nil then
    M.GAME_STATE[M.COURIER_ON_BASE] =
      NUM[map.IsUnitInSpot(env.COURIER_DATA, map.GetAllySpot("fountain"))]

    M.GAME_STATE[M.COURIER_IS_AVAILABLE] = NUM[IsCourierAvailable()]
  end

  -- Wards state
  M.GAME_STATE[M.AW_PRESENT] = NUM[env.ALLY_WARD_DATA ~= nil]

  -- General game state
  M.GAME_STATE[M.DOES_CREEP_MEET] = NUM[25 < DotaTime()]
  M.GAME_STATE[M.IS_NIGHT] = NUM[IsNight()]

  logger.PrintGameState(M.GAME_STATE)
end

function M.EvaluateFrom(start, state, weights)
  local result = start

  functions.DoWithKeysAndElements(
    weights,
    function(key, weight)
      if state[key] ~= nil then
        result = result + state[key] * weight
      end
    end)

  return 1 <= result
end

function M.Evaluate(state, weights)
  return M.EvaluateFrom(0, state, weights)
end

-- Provide an access to local functions for unit tests only

return M
