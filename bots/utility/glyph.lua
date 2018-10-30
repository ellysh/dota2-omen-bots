local env = require(
  GetScriptDirectory() .."/utility/environment")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

---------------------------------

-- We do not have environment variables in this objective

function M.pre_glyph()
  return M.pre_do_glyph()
end

---------------------------------

function M.pre_do_glyph()
  local weights = {
    [gs.AT_PRESENT] = 0.4,
    [gs.AT_IS_LOW_HP] = 0.17,
    [gs.AT_INCOMING_DAMAGE] = 0.2,
    [gs.AT_GLYPH_READY] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.do_glyph()
  env.BOT:ActionImmediate_Glyph()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
