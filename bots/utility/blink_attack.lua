local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_blink_attack()
  local weights = {
    [gs.EH_HAS_LESS_HTD] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
         and moves.pre_attack_objective()
end

---------------------------------

function M.pre_blink()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_BLINK] = 0.3,
    [gs.EH_IN_BLINK_RANGE] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.blink()
  env.BOT:Action_UseAbilityOnLocation(
    algorithms.GetItem(env.BOT_DATA, "item_blink"),
    env.ENEMY_HERO_DATA.location)
end

---------------------------------

function M.pre_use_gust()
  local weights = {
    [gs.BOT_CASTABLE_GUST] = 0.5,
    [gs.BOT_IN_EH_LOCATION] = 0.5,
    [gs.BOT_IS_SILENCED] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.use_gust()
  env.BOT:Action_UseAbilityOnLocation(
    env.GUST_ABILITY,
    env.ENEMY_HERO_DATA.location)
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
