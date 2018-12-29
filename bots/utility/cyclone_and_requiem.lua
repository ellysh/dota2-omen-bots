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

function M.pre_cyclone_and_requiem()
  local weights = {
    [gs.BOT_HAS_MP_FOR_CYCLONE_AND_REQUIEM] = 0.3,
    [gs.BOT_HAS_MAX_SOULS] = 0.3,
    [gs.BOT_CASTABLE_REQUIEM] = 0.4,
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

function M.pre_cyclone()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_CYCLONE] = 0.3,
    [gs.EH_IN_CYCLONE_RANGE] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.cyclone()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_cyclone"),
    env.ENEMY_HERO_DATA.handle)
end

---------------------------------

function M.pre_move_enemy_hero_location()
  local weights = {
    [gs.EH_HAS_CYCLONE_MODIFIER] = 0.5,
    [gs.BOT_CASTABLE_REQUIEM] = 0.5,
    [gs.BOT_IN_EH_LOCATION] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.move_enemy_hero_location()
  env.BOT:Action_MoveDirectly(env.ENEMY_HERO_DATA.location)
end

---------------------------------

function M.pre_wait_cyclone_timing()
  local weights = {
    [gs.EH_HAS_CYCLONE_MODIFIER] = 0.3,
    [gs.BOT_CASTABLE_REQUIEM] = 0.3,
    [gs.BOT_IN_EH_LOCATION] = 0.4,
    [gs.EH_CYCLONE_TIMING_READY] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.wait_cyclone_timing()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_requiem()
  local weights = {
    [gs.BOT_CASTABLE_REQUIEM] = 0.3,
    [gs.BOT_IN_EH_LOCATION] = 0.3,
    [gs.EH_CYCLONE_TIMING_READY] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.requiem()
  env.BOT:Action_UseAbility(env.REQUIEM_ABILITY)
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
