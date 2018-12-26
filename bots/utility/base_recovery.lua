local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local item_hp_recovery = require(
  GetScriptDirectory() .."/utility/item_hp_recovery")

local M = {}

---------------------------------

function M.pre_base_recovery()
  local weights = {
    [gs.BOT_IS_ALIVE] = 0.7,
    [gs.BOT_IS_LOW_HP] = 0.3,
    [gs.BOT_IS_HEALING] = -0.3,
    [gs.BOT_IS_BASE_RECOVERY] = 0.3,
    [gs.BOT_IS_CASTING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_restore_hp_on_base()
  local weights = {
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] =
      (1 + constants.UNIT_FOUNTAIN_MAX_HEALTH),
    [gs.BOT_HP_RATE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.restore_hp_on_base()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_restore_mp_on_base()
  local weights = {
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] =
      (1 + constants.UNIT_FOUNTAIN_MAX_MANA),
    [gs.BOT_MP_RATE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.restore_mp_on_base()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_move_base()
  local weights = {
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = -1,
    [gs.BOT_CASTABLE_FLASK] = -1,
    [gs.BOT_NEAR_FOUNTAIN] = 1,
    [gs.BOT_HAS_FLASK] = -1,
  }

  return gs.EvaluateFrom(1, gs.GAME_STATE, weights)
end

function M.pre_wait_move_base()
  return M.pre_move_base()
end

function M.pre_cancel_move_base()
  return not M.pre_move_base()
         or item_hp_recovery.pre_heal_flask()
end

function M.move_base()
  env.BOT:Action_ClearActions(true)

  env.BOT:Action_MovePath(env.FOUNTAIN_SPOT_WAYPOINTS)
end

---------------------------------

function M.pre_deliver_items()
  return moves.pre_deliver_items()
end

function M.deliver_items()
  moves.deliver_items()
end

-- Provide an access to local functions and variables for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
