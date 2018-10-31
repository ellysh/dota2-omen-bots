local env = require(
  GetScriptDirectory() .."/utility/environment")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local gs = require(
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
    [gs.BOT_IS_ALIVE] = -1,
    [gs.BOT_HAS_BUYBACK] = 0.5,
    [gs.BOT_RESPAWN_TIME] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.do_buyback()
  env.BOT:ActionImmediate_Buyback()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
