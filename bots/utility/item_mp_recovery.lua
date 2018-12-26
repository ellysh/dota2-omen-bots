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

function M.pre_item_mp_recovery()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_NEAR_FOUNTAIN] = -1,
    [gs.BOT_IS_CASTING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_use_enchanted_mango()
  local weights = {
    [gs.BOT_IS_LOW_MP] = 0.5,
    [gs.BOT_CASTABLE_ENCHANTED_MANGO] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.use_enchanted_mango()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_enchanted_mango"),
    env.BOT)
end

----------------------------------

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
