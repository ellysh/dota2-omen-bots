local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_plant_ward()
  local weights = {
    [gs.BOT_HAS_WARD] = 0.5,
    [gs.IS_NIGHT] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.plant_ward()
  env.BOT:Action_UseAbilityOnLocation(
    algorithms.GetItem(env.BOT_DATA, "item_ward_observer"),
    map.GetUnitAllySpot(unit_data, "ally_revier_side"))
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
