local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local M = {}

---------------------------------

function M.pre_base_recovery()
  local weights = {
    [gs.BOT_IS_ALIVE] = 0.7,
    [gs.BOT_IS_LOW_HP] = 0.3,
    [gs.BOT_IS_HEALING] = -0.3,
    [gs.BOT_IS_BASE_RECOVERY] = 0.3,
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
  return true
end

function M.move_base()
  env.BOT:Action_MoveDirectly(env.FOUNTAIN_SPOT)

  if functions.GetDistance(env.FOUNTAIN_SPOT, env.BOT_DATA.location)
     < constants.BASE_RADIUS
     and not algorithms.HasModifier(
               env.BOT_DATA,
               "modifier_fountain_aura_buff") then

    action_timing.SetNextActionDelay(1.5)
  else
    action_timing.SetNextActionDelay(0.2)
  end
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
