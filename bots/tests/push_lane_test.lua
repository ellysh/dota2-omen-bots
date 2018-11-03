package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local push_lane = require("push_lane")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_push_lane_1_succeed()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertTrue(push_lane.pre_push_lane())
end

function test_pre_push_lane_1_fails()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(push_lane.pre_push_lane())
end

function test_pre_push_lane_2_fails()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 0,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(push_lane.pre_push_lane())
end

function test_pre_push_lane_3_fails()
  push_lane.test_SetGameState({
    -- pre_push_lane
    [gs.EC_BACK_PRESENT] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,

    -- moves.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
  })

  luaunit.assertFalse(push_lane.pre_push_lane())
end

os.exit(luaunit.LuaUnit.run())
