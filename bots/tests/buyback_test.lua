package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local buyback = require("buyback")
local luaunit = require("luaunit")

function test_pre_do_buyback_1_succeed()
  buyback.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [14] = 1,  -- env.BOT:HasBuyback()
    [15] = 1,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertTrue(buyback.pre_do_buyback())
end

function test_pre_do_buyback_1_fails()
  buyback.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [14] = 1,  -- env.BOT:HasBuyback()
    [15] = 1,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_2_fails()
  buyback.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [14] = 0,  -- env.BOT:HasBuyback()
    [15] = 1,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_3_fails()
  buyback.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [14] = 1,  -- env.BOT:HasBuyback()
    [15] = 0,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_4_fails()
  buyback.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [14] = 0,  -- env.BOT:HasBuyback()
    [15] = 1,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_5_fails()
  buyback.test_SetBotState({
    [1] = 1,  -- algorithms.IsBotAlive()
    [14] = 0,  -- env.BOT:HasBuyback()
    [15] = 0,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_6_fails()
  buyback.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [14] = 1,  -- env.BOT:HasBuyback()
    [15] = 0,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

function test_pre_do_buyback_7_fails()
  buyback.test_SetBotState({
    [1] = 0,  -- algorithms.IsBotAlive()
    [14] = 0,  -- env.BOT:HasBuyback()
    [15] = 0,  -- MIN_BOT_RESPAWN_TIME < env.BOT:GetRespawnTime()
  })

  luaunit.assertFalse(buyback.pre_do_buyback())
end

os.exit(luaunit.LuaUnit.run())
