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
    [gs.BOT_ATTACK_EH] = 0.5,
    [gs.BOT_IS_LOW_HP] = -0.5,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.kill_enemy_hero()
  moves.attack_enemy_hero()
end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
