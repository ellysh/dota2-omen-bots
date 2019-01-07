local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local map = require(
  GetScriptDirectory() .."/utility/map")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_close_fight()
  local weights = {
    [gs.BOT_IS_CASTING] = -1,
    [gs.EH_IS_VISIBLE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_kill_enemy_hero()
  local weights = {
    [gs.EH_HAS_LESS_HTD] = 1,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.kill_enemy_hero()
  moves.attack_enemy_hero()
end

---------------------------------

function M.pre_use_pike()
  local weights = {
    [gs.EH_HAS_HP_FOR_PIKE] = 0.3,
    [gs.EH_IN_PIKE_RANGE] = 0.3,
    [gs.BOT_CASTABLE_PIKE] = 0.4,
    [gs.IS_NIGHT] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.use_pike()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_hurricane_pike"),
    env.ENEMY_HERO_DATA.handle)
end

---------------------------------

function M.pre_attack_enemy_hero_with_pike()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.5,
    [gs.BOT_HAS_PIKE_MODIFIER] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_hero_with_pike()
  -- The hero attacks automatically when it has the pike modifier
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
