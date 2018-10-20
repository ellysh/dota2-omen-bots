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

os.exit(luaunit.LuaUnit.run())
