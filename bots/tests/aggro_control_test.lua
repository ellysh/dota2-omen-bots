package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local aggro_control = require("aggro_control")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_aggro_last_hit_1_succeed()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertTrue(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_1_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_2_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_3_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_4_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 0,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_5_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_6_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 1,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_7_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_8_fails()
  aggro_control.test_SetGameState({
    [gs.BOT_HAS_DAMAGE_FOR_AGGRO_CONTROL] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

---------------------------------

function test_pre_aggro_hg_1_succeed()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertTrue(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_1_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_2_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_3_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 0,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_4_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 0,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_5_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 0,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_6_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_7_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 1,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

function test_pre_aggro_hg_8_fails()
  aggro_control.test_SetGameState({
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_FRONT_PRESENT] = 1,
    [gs.EC_BACK_PRESENT] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_RIVER] = 1,
    [gs.EC_FRONT_IN_AGGRO_RADIUS] = 1,
    [gs.AC_FRONT_IN_MAX_BASE_DISTANCE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_hg())
end

os.exit(luaunit.LuaUnit.run())
