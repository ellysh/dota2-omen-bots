local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local map = require(
  GetScriptDirectory() .."/utility/map")

local M = {}

---------------------------------

function M.pre_warding()
  local weights = {
    [gs.BOT_CASTABLE_WARD] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
         and moves.pre_interrupt_cast_objective()
end

---------------------------------

function M.pre_plant_ward()
  local weights = {
    [gs.IS_NIGHT] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.plant_ward()
  env.BOT:Action_UseAbilityOnLocation(
    algorithms.GetItem(env.BOT_DATA, "item_ward_observer"),
    map.GetUnitAllySpot(env.BOT_DATA, "ally_revier_side"))
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
