package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local aggro_control = require("aggro_control")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_aggro_last_hit_1_succeed()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
  })

  luaunit.assertTrue(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_1_fails()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 0,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_2_fails()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.EH_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_3_fails()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_4_fails()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 0,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_5_fails()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 1,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_6_fails()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 1,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 0,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

function test_pre_aggro_last_hit_7_fails()
  aggro_control.test_SetGameState({
    [gs.EC_PRE_LAST_HIT_PRESENT] = 1,
    [gs.EH_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.BOT_IN_ET_AGGRO_RADIUS] = 0,
    [gs.EC_PRE_LAST_HIT_IN_AGRO_RADIUS] = 1,
    [gs.BOT_IN_ALLY_TOWER_RANGE] = 1,
  })

  luaunit.assertFalse(aggro_control.pre_aggro_last_hit())
end

os.exit(luaunit.LuaUnit.run())
