local env = require(
  GetScriptDirectory() .."/utility/environment")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local game_state = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

-- We do not have environment variables in this objective

function M.pre_buyback()
  return M.pre_do_buyback()
end

---------------------------------

function M.pre_do_buyback()
  local weights = {
    [1] = 0.4,
    [14] = 0.3,
    [15] = 0.3,
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

function M.do_buyback()
  env.BOT:ActionImmediate_Buyback()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetBotState(state)
  game_state.BOT_STATE = state
end


return M
