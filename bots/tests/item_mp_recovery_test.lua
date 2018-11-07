package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local item_hp_recovery = require("item_hp_recovery")
local gs = require("game_state")
local luaunit = require("luaunit")

function test_pre_item_hp_recovery_1_succeed()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
  })

  luaunit.assertTrue(item_hp_recovery.pre_item_hp_recovery())
end

function test_pre_item_hp_recovery_1_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_item_hp_recovery())
end

function test_pre_item_hp_recovery_2_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_item_hp_recovery())
end

function test_pre_item_hp_recovery_3_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_item_hp_recovery())
end

function test_pre_item_hp_recovery_4_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_item_hp_recovery())
end

function test_pre_item_hp_recovery_5_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
  })

  luaunit.assertFalse(item_hp_recovery.pre_item_hp_recovery())
end

function test_pre_item_hp_recovery_6_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
  })

  luaunit.assertFalse(item_hp_recovery.pre_item_hp_recovery())
end

function test_pre_item_hp_recovery_7_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0.5,
  })

  luaunit.assertFalse(item_hp_recovery.pre_item_hp_recovery())
end

---------------------------------

function test_pre_heal_flask_1_succeed()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_2_succeed()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = nil,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_3_succeed()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_1_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_2_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 1,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_3_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_4_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 1,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_5_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_6_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.6,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_flask())
end

function test_pre_heal_flask_7_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_FLASK_HEALING] = 0,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0,
    [gs.BOT_HP_RATE] = 0.4,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_IN_EH_ATTACK_RANGE] = 1,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_flask())
end

---------------------------------

function test_pre_heal_faerie_fire_1_succeed()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.BOT_CASTABLE_FAERIE_FIRE] = 1,
    [gs.BOT_CASTABLE_TANGO] = 0,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_1_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.BOT_CASTABLE_FAERIE_FIRE] = 1,
    [gs.BOT_CASTABLE_TANGO] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_2_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.BOT_CASTABLE_FAERIE_FIRE] = 0,
    [gs.BOT_CASTABLE_TANGO] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_3_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
    [gs.BOT_CASTABLE_FAERIE_FIRE] = 1,
    [gs.BOT_CASTABLE_TANGO] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_faerie_fire())
end

function test_pre_heal_faerie_fire_4_fails()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 0,
    [gs.BOT_CASTABLE_FAERIE_FIRE] = 1,
    [gs.BOT_CASTABLE_TANGO] = 1,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_faerie_fire())
end

---------------------------------

function test_pre_heal_tango_1_succeed()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_2_succeed()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = 0,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_3_succeed()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_4_succeed()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 1,
  })

  luaunit.assertTrue(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_1_fails()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.29,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_2_fails()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_FLASK] = 1,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_3_fails()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 1,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_4_fails()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 0,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_5_fails()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 0,
    [gs.TREE_ET_UNSAFE_DISTANCE] = 1,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_tango())
end

function test_pre_heal_tango_6_fails()
  item_hp_recovery.test_SetGameState({
    -- weights_1
    [gs.BOT_IS_HEALING] = 0,
    [gs.BOT_CASTABLE_TANGO] = 1,
    [gs.BOT_HP_MAX_DELTA] = 0.31,
    [gs.NO_TREE_PRESENT] = 1,
    [gs.TREE_ET_UNSAFE_DISTANCE] = nil,

    -- weights_2
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_FLASK] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_heal_tango())
end

---------------------------------

function test_pre_tp_base_1_succeed()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertTrue(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_2_succeed()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_BOT_DISTANCE] = 1,
  })

  luaunit.assertTrue(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_1_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_2_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 0,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_3_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 0,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_4_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_5_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 1,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_6_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 1,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_7_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_8_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.EH_BOT_DISTANCE] = 0,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

function test_pre_tp_base_9_false()
  item_hp_recovery.test_SetGameState({
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_CASTABLE_TP_SCROLL] = 1,
    [gs.BOT_GOLD] = 1,
    [gs.BOT_FOUNTAIN_DISTANCE] = 1,
    [gs.BOT_HAS_FLASK] = 0,
    [gs.BOT_HAS_FAERIE_FIRE] = 0,
    [gs.BOT_HAS_TANGO] = 0,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_BOT_DISTANCE] = 0.9,
  })

  luaunit.assertFalse(item_hp_recovery.pre_tp_base())
end

os.exit(luaunit.LuaUnit.run())
