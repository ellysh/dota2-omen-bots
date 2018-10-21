package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local farm = require("farm")
local luaunit = require("luaunit")

function test_pre_farm_1_succeed()
  farm.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertTrue(farm.pre_farm())
end

function test_pre_farm_1_fails()
  farm.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(farm.pre_farm())
end

function test_pre_farm_2_fails()
  farm.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(farm.pre_farm())
end

function test_pre_farm_3_fails()
  farm.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(farm.pre_farm())
end

os.exit(luaunit.LuaUnit.run())
