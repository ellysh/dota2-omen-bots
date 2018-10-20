package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local item_recovery = require("item_recovery")
local luaunit = require("luaunit")

function test_pre_item_recovery_1_succeed()
  item_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [4] = 0,  -- env.BOT_DATA.is_healing
    [16] = 1,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertTrue(item_recovery.pre_item_recovery())
end

function test_pre_item_recovery_1_fails()
  item_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [4] = 0,  -- env.BOT_DATA.is_healing
    [16] = 0,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertFalse(item_recovery.pre_item_recovery())
end

function test_pre_item_recovery_2_fails()
  item_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [4] = 0,  -- env.BOT_DATA.is_healing
    [16] = 0,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertFalse(item_recovery.pre_item_recovery())
end

function test_pre_item_recovery_3_fails()
  item_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [4] = 1,  -- env.BOT_DATA.is_healing
    [16] = 0,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertFalse(item_recovery.pre_item_recovery())
end

function test_pre_item_recovery_4_fails()
  item_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [4] = 1,  -- env.BOT_DATA.is_healing
    [16] = 0,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertFalse(item_recovery.pre_item_recovery())
end

function test_pre_item_recovery_5_fails()
  item_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [4] = 0,  -- env.BOT_DATA.is_healing
    [16] = 1,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertFalse(item_recovery.pre_item_recovery())
end

function test_pre_item_recovery_6_fails()
  item_recovery.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [4] = 1,  -- env.BOT_DATA.is_healing
    [16] = 1,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertFalse(item_recovery.pre_item_recovery())
end

function test_pre_item_recovery_7_fails()
  item_recovery.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [4] = 1,  -- env.BOT_DATA.is_healing
    [16] = 0.5,  -- env.FOUNTAIN_DISTANCE
  })

  luaunit.assertFalse(item_recovery.pre_item_recovery())
end

---------------------------------

function test_pre_heal_flask_1_succeed()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.4,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertTrue(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_2_succeed()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 1,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.63,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertTrue(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_3_succeed()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.1,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 1,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 1,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertTrue(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_1_fails()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.4,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_2_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 1,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.4,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_3_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 1,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.4,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_4_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 1,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.4,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_5_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 0,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.4,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_6_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.6,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.4,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_heal_flask())
end

function test_pre_heal_flask_7_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [3] = 0,  -- env.BOT_DATA.is_flask_healing
    [8] = 0,  -- env.IS_FOCUSED_BY_ENEMY_HERO
    [9] = 0,  -- env.IS_FOCUSED_BY_UNKNOWN_UNIT
    [12] = 0.4,  -- health / max_health
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 1,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.624,  -- env.ENEMY_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_heal_flask())
end

---------------------------------

function test_pre_heal_faerie_fire_1_succeed()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [17] = 0,  -- IsItemCastable(env.BOT_DATA, "item_flask")
    [18] = 1,  -- IsItemCastable(env.BOT_DATA, "item_faerie_fire")
    [19] = 0,  -- IsItemCastable(env.BOT_DATA, "item_tango")
  })

  luaunit.assertTrue(item_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_1_fails()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [17] = 0,  -- IsItemCastable(env.BOT_DATA, "item_flask")
    [18] = 1,  -- IsItemCastable(env.BOT_DATA, "item_faerie_fire")
    [19] = 0,  -- IsItemCastable(env.BOT_DATA, "item_tango")
  })

  luaunit.assertFalse(item_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_2_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [17] = 0,  -- IsItemCastable(env.BOT_DATA, "item_flask")
    [18] = 0,  -- IsItemCastable(env.BOT_DATA, "item_faerie_fire")
    [19] = 0,  -- IsItemCastable(env.BOT_DATA, "item_tango")
  })

  luaunit.assertFalse(item_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_3_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [17] = 1,  -- IsItemCastable(env.BOT_DATA, "item_flask")
    [18] = 1,  -- IsItemCastable(env.BOT_DATA, "item_faerie_fire")
    [19] = 0,  -- IsItemCastable(env.BOT_DATA, "item_tango")
  })

  luaunit.assertFalse(item_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_4_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [17] = 0,  -- IsItemCastable(env.BOT_DATA, "item_flask")
    [18] = 1,  -- IsItemCastable(env.BOT_DATA, "item_faerie_fire")
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
  })

  luaunit.assertFalse(item_recovery.pre_heal_faerie_fire())
end

---------------------------------

function test_pre_heal_tango_1_succeed()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.31,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 1,  -- env.NEARBY_TREE ~= nil
    [2] = 0,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertTrue(item_recovery.pre_heal_tango())
end

function test_pre_heal_tango_2_succeed()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.31,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 1,  -- env.NEARBY_TREE ~= nil
    [2] = 1,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 1,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertTrue(item_recovery.pre_heal_tango())
end

function test_pre_heal_tango_1_fails()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.29,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 1,  -- env.NEARBY_TREE ~= nil
    [2] = 0,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertFalse(item_recovery.pre_heal_tango())
end

function test_pre_heal_tango_2_fails()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.31,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 1,  -- env.NEARBY_TREE ~= nil
    [2] = 0,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertFalse(item_recovery.pre_heal_tango())
end

function test_pre_heal_tango_3_fails()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 1,  -- env.BOT_DATA.is_healing
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.31,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 1,  -- env.NEARBY_TREE ~= nil
    [2] = 0,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertFalse(item_recovery.pre_heal_tango())
end

function test_pre_heal_tango_4_fails()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [19] = 0,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.31,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 1,  -- env.NEARBY_TREE ~= nil
    [2] = 0,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertFalse(item_recovery.pre_heal_tango())
end

function test_pre_heal_tango_5_fails()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.31,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 1,  -- env.NEARBY_TREE ~= nil
    [2] = 0.9,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 1,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertFalse(item_recovery.pre_heal_tango())
end

function test_pre_heal_tango_6_fails()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [4] = 0,  -- env.BOT_DATA.is_healing
    [19] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 0.31,  -- env.BOT_DATA.max_health - env.BOT_DATA.health
  })

  item_recovery.test_SetNearbyTreeState({
    [1] = 0,  -- env.NEARBY_TREE ~= nil
    [2] = 0,  -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = 0,  -- env.ENEMY_TOWER_DATA ~= nil
  })

  luaunit.assertFalse(item_recovery.pre_heal_tango())
end

---------------------------------

function test_pre_tp_base_1_succeed()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertTrue(item_recovery.pre_tp_base())
end

function test_pre_tp_base_2_succeed()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 1,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 1,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertTrue(item_recovery.pre_tp_base())
end

function test_pre_tp_base_1_false()
  item_recovery.test_SetBotState({
    [2] = 0,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_2_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 0,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_3_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 0,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_4_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 0,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_5_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 1,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_6_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 1,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_7_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 1,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_8_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 1,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 0,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

function test_pre_tp_base_9_false()
  item_recovery.test_SetBotState({
    [2] = 1,  -- env.IS_BOT_LOW_HP
    [21] = 1,  -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 1,  -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 1,  -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = 0,  -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = 0,  -- DoesBotOrCourierHaveItem("item_flask")
    [26] = 0,  -- DoesBotOrCourierHaveItem("item_tango")
    [27] = 0,  -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  })

  item_recovery.test_SetEnemyHeroState({
    [1] = 1,  -- env.ENEMY_HERO_DATA ~= nil
    [4] = 0.9,  -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  })

  luaunit.assertFalse(item_recovery.pre_tp_base())
end

os.exit(luaunit.LuaUnit.run())
