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

local game_state = require(
  GetScriptDirectory() .."/utility/game_state")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local M = {}

---------------------------------

function M.pre_base_recovery()
  local weights = {
    [1] = 0.7,
    [2] = 0.3,
    [4] = -0.3,
    [5] = 0.3,
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

---------------------------------

function M.pre_restore_hp_on_base()
  local weights = {
    [11] = (1 - constants.UNIT_FOUNTAIN_MAX_HEALTH),
    [12] = 1,
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

function M.restore_hp_on_base()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_restore_mp_on_base()
  local weights = {
    [11] = (1 - constants.UNIT_FOUNTAIN_MAX_MANA),
    [13] = 1,
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
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

function M.test_SetBotState(state)
  game_state.BOT_STATE = state
end

return M
