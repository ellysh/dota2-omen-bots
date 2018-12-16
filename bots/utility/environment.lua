local map = require(
  GetScriptDirectory() .."/utility/map")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local M = {}

M.BOT = {}
M.BOT_DATA = {}
M.IS_BOT_LOW_HP = false
M.IS_ENEMY_HERO_LOW_HP = false
M.ENEMY_CREEP_FRONT_DATA = {}
M.ENEMY_CREEP_BACK_DATA = {}
M.ENEMY_CREEP_MAX_HP_TARGETABLE_DATA = {}
M.ENEMY_CREEP_MIN_HP_TARGETABLE_DATA = {}
M.ENEMY_CREEP_ATTACKING_TOWER = {}
M.ENEMY_CREEP_ATTACKING_BOT = {}
M.ENEMY_HERO_DATA = {}
M.ENEMY_HERO_DISTANCE = 0
M.ALLY_CREEP_FRONT_DATA = {}
M.ALLY_CREEP_BACK_DATA = {}
M.ALLY_CREEP_TARGETABLE_DATA = {}
M.ENEMY_TOWER_DATA = {}
M.ENEMY_TOWER_DISTANCE = 0
M.ALLY_TOWER_DATA = {}
M.PRE_LAST_HIT_ENEMY_CREEP = {}
M.PRE_LAST_HIT_ALLY_CREEP = {}
M.PRE_LAST_HIT_ANY_CREEP = {}
M.LAST_HIT_ENEMY_CREEP = {}
M.LAST_HIT_ALLY_CREEP = {}
M.ALLY_CREEPS_HP = 0
M.ENEMY_CREEPS_HP = 0
M.SAFE_SPOT = {}
M.SAFE_SPOT_WAYPOINTS = {}
M.FARM_SPOT = {}
M.FOUNTAIN_SPOT = {}
M.FOUNTAIN_SPOT_WAYPOINTS = {}
M.FOUNTAIN_DISTANCE = 0
M.DOES_TOWER_PROTECT_ENEMY = false
M.IS_FOCUSED_BY_CREEPS = false
M.IS_FOCUSED_BY_ENEMY_HERO = false
M.IS_FOCUSED_BY_UNKNOWN_UNIT = false
M.IS_FOCUSED_BY_TOWER = false
M.IS_BASE_RECOVERY = false
M.NEARBY_TREE = {}
M.TURN_TARGET_DATA = {}
M.BODY_BLOCK_SPOT = {}
M.NEAR_SHADOWRAZE_ABILITY = {}
M.MEDIUM_SHADOWRAZE_ABILITY = {}
M.FAR_SHADOWRAZE_ABILITY = {}
M.SHADOWRAZE_EVADE_DISTANCE = 0
M.ENEMY_UNITS_DATA = {}

local function GetClosestCreep(radius, get_function, direction)
  local creeps = get_function(
    M.BOT_DATA,
    radius)

  return functions.GetElementWith(
    creeps,
    algorithms.CompareMinUnitDistance,
    function(unit_data)
      return algorithms.IsAttackTargetable(unit_data)
             and not algorithms.IsCourierUnit(unit_data)
             and (direction == constants.DIRECTION["ANY"]
                  or (direction == constants.DIRECTION["FRONT"]
                      and algorithms.IsFrontUnit(M.BOT_DATA, unit_data)
                      and algorithms.IsAliveFrontUnit(unit_data))
                  or (direction == constants.DIRECTION["BACK"]
                      and not algorithms.IsFrontUnit(
                                M.BOT_DATA,
                                unit_data)))
    end)
end

local function IsUnitRelativeLowHp(unit_data, enemy_hero_data)
  return unit_data ~= nil
         and (algorithms.IsUnitLowHp(unit_data)

              or (enemy_hero_data ~= nil
                  and functions.GetRate(
                        unit_data.health,
                        unit_data.max_health)
                      < constants.UNIT_MODERATE_HEALTH_LEVEL
                  and (algorithms.IsBiggerThan(
                         enemy_hero_data.health,
                         unit_data.health,
                         unit_data.max_health / 2)
                       or algorithms.IsBiggerThan(
                         enemy_hero_data.attack_damage * 3,
                         unit_data.health,
                         0))))
end

local function GetTargetableMaxHpEnemyCreep()
  return algorithms.GetCreepWith(
           M.BOT_DATA,
           constants.SIDE["ENEMY"],
           algorithms.CompareMaxHealth,
           function(unit_data)
             return constants.UNIT_HALF_HEALTH_LEVEL
                    < functions.GetRate(
                        unit_data.health,
                        unit_data.max_health)
           end)
end

local function GetTargetableAllyCreep()
  return algorithms.GetCreepWith(
           M.BOT_DATA,
           constants.SIDE["ALLY"],
           algorithms.CompareMaxHealth,
           function(unit_data)
             return functions.GetRate(
                      unit_data.health,
                      unit_data.max_health)
                    < constants.UNIT_HALF_HEALTH_LEVEL
           end)
end

local function GetBodyBlockSpot()
  return functions.ternary(
           algorithms.IsFirstWave(),
           map.GetAllySpot("first_body_block"),
           map.GetAllySpot("second_body_block"))
end

local function GetCreepAttackingTower(tower_data)
  if tower_data == nil then
    return nil end

  local creeps = algorithms.GetEnemyCreeps(
                   M.BOT_DATA,
                   constants.MAX_UNIT_SEARCH_RADIUS)

  return functions.GetElementWith(
    creeps,
    algorithms.CompareMaxDamage,
    function(unit_data)
      return algorithms.IsUnitAttackTarget(
               unit_data,
               tower_data)
    end)
end

local function GetCreepAttackingBot(bot_data)
  if bot_data == nil then
    return nil end

  local creeps = algorithms.GetEnemyCreeps(
                   bot_data,
                   constants.MAX_UNIT_TARGET_RADIUS)

  return functions.GetElementWith(
    creeps,
    algorithms.CompareMaxDamage,
    function(unit_data)
      return algorithms.IsUnitAttackTarget(
               unit_data,
               bot_data)
    end)
end

---------------------------------

local function IsLastSeenLocationValid(unit_data)
  return unit_data.is_visible

         or constants.LAST_SEEN_LOCATION_MIN_DISTANCE
             < functions.GetUnitDistance(unit_data, M.BOT_DATA)

         or algorithms.IsUnitLastSeenOnStairs(unit_data)
end

local LAST_ENEMY_HERO_DEATHS = 0

local function IsHeroDiedRecently(unit_data)
  local deaths = GetHeroDeaths(unit_data.player_id)

  if LAST_ENEMY_HERO_DEATHS < deaths then
    LAST_ENEMY_HERO_DEATHS = deaths
    return true
  else
    return false
  end
end

local function IsUnitTpOut(unit_data)
  -- TODO: Store a name of the current casting ability in the UNIT_LIST
  -- and check it here for TP out.

  return not unit_data.is_visible
         and unit_data.is_channeling
end

local function InvalidateEnemyHeroData()
  if not IsLastSeenLocationValid(M.ENEMY_HERO_DATA)
     or IsHeroDiedRecently(M.ENEMY_HERO_DATA)
     or IsUnitTpOut(M.ENEMY_HERO_DATA) then

    all_units.InvalidateUnit(M.ENEMY_HERO_DATA)
    M.ENEMY_HERO_DATA = nil
    return true
  end

  return false
end

---------------------------------

function M.UpdateVariables()
  M.BOT = GetBot()

  M.BOT_DATA = algorithms.GetBotData()

  M.ENEMY_HERO_DATA = algorithms.GetLastSeenEnemyHero(M.BOT_DATA)

  if M.ENEMY_HERO_DATA ~= nil
     and not InvalidateEnemyHeroData() then
    M.IS_ENEMY_HERO_LOW_HP = IsUnitRelativeLowHp(
                               M.ENEMY_HERO_DATA,
                               M.BOT_DATA)

    M.DOES_TOWER_PROTECT_ENEMY =
      algorithms.DoesTowerProtectUnit(M.ENEMY_HERO_DATA)

    M.ENEMY_HERO_DISTANCE = functions.GetUnitDistance(
                              M.BOT_DATA,
                              M.ENEMY_HERO_DATA)
  end

  M.IS_BOT_LOW_HP = IsUnitRelativeLowHp(M.BOT_DATA, M.ENEMY_HERO_DATA)

  M.ENEMY_CREEP_FRONT_DATA = GetClosestCreep(
                               constants.MAX_UNIT_SEARCH_RADIUS,
                               algorithms.GetEnemyCreeps,
                               constants.DIRECTION["FRONT"])

  M.ENEMY_CREEP_BACK_DATA = GetClosestCreep(
                               constants.MAX_UNIT_SEARCH_RADIUS,
                               algorithms.GetEnemyCreeps,
                               constants.DIRECTION["BACK"])

  M.ENEMY_CREEP_MAX_HP_TARGETABLE_DATA = GetTargetableMaxHpEnemyCreep()

  M.ENEMY_CREEP_MIN_HP_TARGETABLE_DATA =
    algorithms.GetCreepWith(
      M.BOT_DATA,
      constants.SIDE["ENEMY"],
      algorithms.CompareMinHealth,
      nil)

  M.ALLY_CREEP_FRONT_DATA = GetClosestCreep(
                              constants.MAX_UNIT_SEARCH_RADIUS,
                              algorithms.GetAllyCreeps,
                              constants.DIRECTION["FRONT"])

  M.ALLY_CREEP_BACK_DATA = GetClosestCreep(
                             constants.MAX_UNIT_SEARCH_RADIUS,
                             algorithms.GetAllyCreeps,
                             constants.DIRECTION["BACK"])

  M.ALLY_CREEP_TARGETABLE_DATA = GetTargetableAllyCreep()

  M.ENEMY_TOWER_DATA = algorithms.GetEnemyTier1Tower(M.BOT_DATA)

  if M.ENEMY_TOWER_DATA ~= nil then
    M.ENEMY_TOWER_DISTANCE = functions.GetUnitDistance(
                               M.BOT_DATA,
                               M.ENEMY_TOWER_DATA)
  end

  M.ALLY_TOWER_DATA = algorithms.GetAllyTier1Tower(M.BOT_DATA)

  M.PRE_LAST_HIT_ENEMY_CREEP = algorithms.GetPreLastHitCreep(
                                 M.BOT_DATA,
                                 constants.SIDE["ENEMY"])

  M.PRE_LAST_HIT_ALLY_CREEP = algorithms.GetPreLastHitCreep(
                                M.BOT_DATA,
                                constants.SIDE["ALLY"])

  M.PRE_LAST_HIT_ANY_CREEP = functions.ternary(
                               M.PRE_LAST_HIT_ENEMY_CREEP ~= nil,
                               M.PRE_LAST_HIT_ENEMY_CREEP,
                               M.PRE_LAST_HIT_ALLY_CREEP)

  M.LAST_HIT_ENEMY_CREEP = algorithms.GetLastHitCreep(
                             M.BOT_DATA,
                             constants.SIDE["ENEMY"])

  M.LAST_HIT_ALLY_CREEP = algorithms.GetLastHitCreep(
                             M.BOT_DATA,
                             constants.SIDE["ALLY"])

  M.ALLY_CREEPS_HP = algorithms.GetTotalHealth(
                       algorithms.GetAllyCreeps(
                         M.BOT_DATA,
                         constants.MAX_UNIT_SEARCH_RADIUS))

  M.ENEMY_CREEPS_HP = algorithms.GetTotalHealth(
                        algorithms.GetEnemyCreeps(
                          M.BOT_DATA,
                          constants.MAX_UNIT_SEARCH_RADIUS))

  M.ENEMY_UNITS_DATA = algorithms.GetEnemyUnits(M.BOT_DATA)

  M.FOUNTAIN_SPOT = map.GetAllySpot("fountain")

  M.FOUNTAIN_SPOT_WAYPOINTS = algorithms.GetSpotWaypoints(
                                       M.BOT_DATA,
                                       M.FOUNTAIN_SPOT,
                                       {M.ENEMY_HERO_DATA,
                                        M.ENEMY_TOWER_DATA})

  M.SAFE_SPOT = algorithms.GetSafeSpot(M.BOT_DATA, M.ENEMY_UNITS_DATA)

  if functions.AreTablesEqual(M.SAFE_SPOT, M.FOUNTAIN_SPOT) then
    local enemy_units = {M.ENEMY_HERO_DATA, M.ENEMY_TOWER_DATA}

    M.SAFE_SPOT = algorithms.GetSafeSpot(
                    M.BOT_DATA,
                    enemy_units)

    M.SAFE_SPOT_WAYPOINTS = algorithms.GetSpotWaypoints(
                              M.BOT_DATA,
                              M.SAFE_SPOT,
                              enemy_units)
  else
    M.SAFE_SPOT_WAYPOINTS = algorithms.GetSpotWaypoints(
                              M.BOT_DATA,
                              M.SAFE_SPOT,
                              M.ENEMY_UNITS_DATA)
  end

  M.FARM_SPOT = algorithms.GetFarmSpot(M.BOT_DATA,
                                       M.ENEMY_UNITS_DATA)

  M.FOUNTAIN_DISTANCE = functions.GetDistance(
                          M.FOUNTAIN_SPOT,
                          M.BOT_DATA.location)

  M.IS_FOCUSED_BY_CREEPS = algorithms.IsFocusedByCreeps(M.BOT_DATA)

  M.IS_FOCUSED_BY_ENEMY_HERO = algorithms.IsFocusedByEnemyHero(
                                 M.BOT_DATA)

  M.IS_FOCUSED_BY_UNKNOWN_UNIT = algorithms.IsFocusedByUnknownUnit(
                                   M.BOT_DATA)

  M.IS_FOCUSED_BY_TOWER = algorithms.IsFocusedByTower(M.BOT_DATA)

  M.IS_BASE_RECOVERY = functions.GetRate(
                         M.BOT_DATA.health,
                         M.BOT_DATA.max_health)
                       < constants.UNIT_HALF_HEALTH_LEVEL

                       and M.FOUNTAIN_DISTANCE <= constants.BASE_RADIUS

  M.NEARBY_TREE = M.BOT_DATA.nearby_trees[1]

  M.TURN_TARGET_DATA = functions.ternary(
                         M.PRE_LAST_HIT_ANY_CREEP ~= nil,
                         M.PRE_LAST_HIT_ANY_CREEP,
                         M.ENEMY_HERO_DATA)

  M.BODY_BLOCK_SPOT = GetBodyBlockSpot()

  M.ENEMY_CREEP_ATTACKING_TOWER = GetCreepAttackingTower(
                                    M.ALLY_TOWER_DATA)

  M.ENEMY_CREEP_ATTACKING_BOT = GetCreepAttackingBot(M.BOT_DATA)

  M.NEAR_SHADOWRAZE_ABILITY =
    M.BOT:GetAbilityByName("nevermore_shadowraze1")

  M.MEDIUM_SHADOWRAZE_ABILITY =
    M.BOT:GetAbilityByName("nevermore_shadowraze2")

  M.FAR_SHADOWRAZE_ABILITY =
    M.BOT:GetAbilityByName("nevermore_shadowraze3")

  M.SHADOWRAZE_EVADE_DISTANCE =
    M.BOT_DATA.speed * constants.NEVERMORE_SHADOWRAZE_CAST_TIME
end

-- Provide an access to local functions for unit tests only

return M
