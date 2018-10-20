local env = require(
  GetScriptDirectory() .."/utility/environment")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local game_state = require(
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
    [1] = 0.4,
    [2] = 0.4,
    [3] = 0.2,
    [4] = 0.17,
  }

  return game_state.Evaluate(game_state.ALLY_TOWER_STATE, weights)
end

function M.do_glyph()
  env.BOT:ActionImmediate_Glyph()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetAllyTowerState(state)
  game_state.ALLY_TOWER_STATE = state
end

return M
