local M = {}

M.BOTS_VERSION = "0.5.1"

M.INVENTORY_START_INDEX = 0
M.INVENTORY_END_INDEX = 9
M.INVENTORY_SIZE = 10

M.STASH_START_INDEX = 10
M.STASH_END_INDEX = 15
M.STASH_SIZE = 6

M.MAX_UNIT_SEARCH_RADIUS = 2000
M.MAX_UNIT_TARGET_RADIUS = 1600

M.TREE_SEARCH_RADIUS = 1000
M.CREEP_MAX_AGGRO_RADIUS = 500
M.CREEP_MIN_AGGRO_RADIUS = 400
M.NEAR_SPOT_RADIUS = 750
M.TOWER_AGGRO_RADIUS = 500

M.MIN_TP_SPOT_RADIUS = 4000
M.BASE_RADIUS = 4000
M.MIN_TP_ENEMY_HERO_RADIUS = 1200

M.TOWER_PROTECT_DISTANCE = 450
M.SAFE_TOWER_DISTANCE = 1000
M.TOWER_ATTACK_RANGE = 700
M.MIN_BASE_CREEP_DISTANCE = 300
M.MAX_BASE_CREEP_DISTANCE = 400
M.LASTHIT_CREEP_DISTANCE = 300
M.MAX_CREEP_DISTANCE = 710
M.MIN_CREEP_DISTANCE = 150
M.MIN_HERO_DISTANCE = 300
M.BASE_HERO_DISTANCE = 400
M.MIN_TOWER_DISTANCE = 400
M.SAFE_HERO_DISTANCE = 1200
M.PRE_LASTHIT_CREEP_MAX_DISTANCE = 1200

M.BODY_BLOCK_FOUNTAIN_RADIANT_DISTANCE = 8600
M.BODY_BLOCK_FOUNTAIN_DIRE_DISTANCE = 9800

M.MAX_PURSUIT_INC_DISTANCE = 250
M.MAX_SAFE_INC_DISTANCE = 250

M.TANGO_USAGE_FROM_ET_DISTANCE = 1500

M.MOM_USAGE_FROM_ENEMY_HERO_DISTANCE = 500

M.MOTION_BUFFER_RANGE = 250

M.MAX_MELEE_ATTACK_RANGE = 310
M.MELEE_ATTACK_RANGE = 150

M.NEAR_SHADOWRAZE_MIN_RANGE = 0
M.NEAR_SHADOWRAZE_MAX_RANGE = 450
M.MEDIUM_SHADOWRAZE_MIN_RANGE = 200
M.MEDIUM_SHADOWRAZE_MAX_RANGE = 700
M.FAR_SHADOWRAZE_MIN_RANGE = 450
M.FAR_SHADOWRAZE_MAX_RANGE = 950

M.UNIT_LOW_HEALTH = 250
M.UNIT_LOW_MANA = 90
M.UNIT_MIN_TOWER_DIVE_HEALTH = 440
M.UNIT_MIN_TOWER_DIVE_HEALTH_WITH_HEALING = 300
M.UNIT_CRITICAL_HEALTH = 100
M.UNIT_LOW_HEALTH_LEVEL = 0.3 -- 30%
M.UNIT_HALF_HEALTH_LEVEL = 0.5 -- 50%
M.UNIT_MODERATE_HEALTH_LEVEL = 0.6 -- 60%
M.UNIT_FOUNTAIN_MAX_HEALTH = 0.85 -- 85%
M.UNIT_FOUNTAIN_MAX_MANA = 0.82 -- 82%

M.TOWER_LOW_HEALTH = 200

M.NEVERMORE_ATTACK_POINT = 0.51
M.NEVERMORE_TURN_TIME = 0.1 -- for 180 degrees
M.NEVERMORE_SHADOWRAZE_CAST_TIME = 0.55

M.TURN_TARGET_MAX_DEGREE = 11.5
M.TURN_TARGET_MELEE_MAX_DEGREE = 40

M.MAX_CREEPS_HP_DELTA = 300

M.POWER_RATE_DEFENSE = 0.65
M.POWER_RATE_OFFENSE = 3

M.MAX_INCOMING_TOWER_DAMAGE = 100
M.MIN_INCOMING_TOWER_DAMAGE = 15

M.MIN_BOT_RESPAWN_TIME = 10

M.LAST_ATTACK_TIME_CORRECTION = 0.5

M.LAST_SEEN_LOCATION_MIN_DISTANCE = 100

M.CREEPS_AGGRO_COOLDOWN = 3

M.RESERVED_GOLD = 109

M.TIME_FIRST_WAVE_MEET = 22

M.MIN_HERO_LEVEL_FOR_AGGRESSION = 5

M.FLASK_HEALING_PER_SECOND = 50

M.MAX_INCOMING_ATTACK_DAMAGE = 100

M.SIDE = {
  ENEMY = {},
  ALLY = {},
}

M.DIRECTION = {
  FRONT = {},
  BACK = {},
  ANY = {},
}

return M
