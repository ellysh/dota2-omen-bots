package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local attack_with_better_position = require("attack_with_better_position")
local luaunit = require("luaunit")

function test_pre_attack_with_better_position_1_succeed()
  attack_with_better_position.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertTrue(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_1_fails()
  attack_with_better_position.test_SetBotState({
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_2_fails()
  attack_with_better_position.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 0, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

function test_pre_attack_with_better_position_3_fails()
  attack_with_better_position.test_SetBotState({
    [1] = 0, -- algorithms.IsBotAlive()
    [2] = 1, -- env.IS_BOT_LOW_HP
  })

  luaunit.assertFalse(
    attack_with_better_position.pre_attack_with_better_position())
end

os.exit(luaunit.LuaUnit.run())
