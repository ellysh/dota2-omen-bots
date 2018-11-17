package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local evade_enemy_nukes = require("evade_enemy_nukes")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_evade_near_shadowraze_back_1_succeed()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_NEAR_SHADOWRAZE_BACK] = 1,
  })

  luaunit.assertTrue(evade_enemy_nukes.pre_evade_near_shadowraze_back())
end

function test_pre_evade_near_shadowraze_back_1_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_NEAR_SHADOWRAZE_BACK] = 0,
  })

  luaunit.assertFalse(evade_enemy_nukes.pre_evade_near_shadowraze_back())
end

function test_pre_evade_near_shadowraze_back_2_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 0,
    [gs.BOT_CAN_EVADE_NEAR_SHADOWRAZE_BACK] = 1,
  })

  luaunit.assertFalse(evade_enemy_nukes.pre_evade_near_shadowraze_back())
end

---------------------------------

function test_pre_evade_medium_shadowraze_back_1_succeed()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_BACK] = 1,
  })

  luaunit.assertTrue(evade_enemy_nukes.pre_evade_medium_shadowraze_back())
end

function test_pre_evade_medium_shadowraze_back_1_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_BACK] = 0,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_medium_shadowraze_back())
end

function test_pre_evade_medium_shadowraze_back_2_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_BACK] = 1,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_medium_shadowraze_back())
end

---------------------------------

function test_pre_evade_far_shadowraze_back_1_succeed()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_BACK] = 1,
  })

  luaunit.assertTrue(evade_enemy_nukes.pre_evade_far_shadowraze_back())
end

function test_pre_evade_far_shadowraze_back_1_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_BACK] = 0,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_far_shadowraze_back())
end

function test_pre_evade_far_shadowraze_back_2_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_BACK] = 1,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_far_shadowraze_back())
end

---------------------------------

function test_pre_evade_medium_shadowraze_front_1_succeed()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_FRONT] = 1,
  })

  luaunit.assertTrue(
    evade_enemy_nukes.pre_evade_medium_shadowraze_front())
end

function test_pre_evade_medium_shadowraze_front_1_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_FRONT] = 0,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_medium_shadowraze_front())
end

function test_pre_evade_medium_shadowraze_front_2_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0,
    [gs.BOT_CAN_EVADE_MEDIUM_SHADOWRAZE_FRONT] = 1,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_medium_shadowraze_front())
end

---------------------------------

function test_pre_evade_far_shadowraze_front_1_succeed()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_FRONT] = 1,
  })

  luaunit.assertTrue(
    evade_enemy_nukes.pre_evade_far_shadowraze_front())
end

function test_pre_evade_far_shadowraze_front_1_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 1,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_FRONT] = 0,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_far_shadowraze_front())
end

function test_pre_evade_far_shadowraze_front_2_fails()
  evade_enemy_nukes.test_SetGameState({
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0,
    [gs.BOT_CAN_EVADE_FAR_SHADOWRAZE_FRONT] = 1,
  })

  luaunit.assertFalse(
    evade_enemy_nukes.pre_evade_far_shadowraze_front())
end

os.exit(luaunit.LuaUnit.run())
