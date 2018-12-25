local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_item_defense()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_NEAR_FOUNTAIN] = -1,
    [gs.BOT_IS_CASTING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_use_hood_of_defiance()
  local weights_1 = {
    [gs.BOT_IS_LOW_MP] = 0.5,
    [gs.BOT_CASTABLE_HOOD] = 0.5,
  }

  local weights_2 = {
    [gs.EH_IS_CASTING_NEAR_SHADOWRAZE] = 0.3,
    [gs.EH_IS_FACING_BOT_MELEE_RANGE] = 0.3,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0.4,
  }

  local weights_3 = {
    [gs.EH_IS_CASTING_MEDIUM_SHADOWRAZE] = 0.3,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0.3,
    [gs.EH_IS_FACING_BOT] = 0.4,
  }

  local weights_4 = {
    [gs.EH_IS_CASTING_FAR_SHADOWRAZE] = 0.3,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0.3,
    [gs.EH_IS_FACING_BOT] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         and (gs.Evaluate(gs.GAME_STATE, weights_2)
              or gs.Evaluate(gs.GAME_STATE, weights_3)
              or gs.Evaluate(gs.GAME_STATE, weights_4))
end

function M.use_hood_of_defiance()
  env.BOT:Action_UseAbility(
    algorithms.GetItem(env.BOT_DATA, "item_hood_of_defiance"))
end

----------------------------------

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
