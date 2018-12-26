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

local M = {}

---------------------------------

function M.pre_item_hp_recovery()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_HEALING] = -1,
    [gs.BOT_NEAR_FOUNTAIN] = -1,
    [gs.BOT_IS_CASTING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_heal_flask()
  local weights_1 = {
    [gs.BOT_IS_LOW_HP] = 0.75,
    [gs.BOT_HP_RATE] = -1,
    [gs.BOT_CASTABLE_FLASK] = 0.75,
  }

  local weights_2 = {
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0.5,
    [gs.EH_PRESENT] = 0.5,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = -1,
    [gs.BOT_IS_FLASK_HEALING] = -1,
  }

  local weights_3 = {
    [gs.EH_PRESENT] = -1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = -1,
    [gs.BOT_IS_FLASK_HEALING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         and (gs.Evaluate(gs.GAME_STATE, weights_2)
              or gs.EvaluateFrom(1, gs.GAME_STATE, weights_3))
end

function M.heal_flask()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_flask"),
    env.BOT)
end

----------------------------------

function M.pre_heal_faerie_fire()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.5,
    [gs.BOT_CASTABLE_FLASK] = -1,
    [gs.BOT_CASTABLE_FAERIE_FIRE] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.heal_faerie_fire()
  env.BOT:Action_UseAbility(
    algorithms.GetItem(env.BOT_DATA, "item_faerie_fire"))
end

---------------------------------

function M.pre_tp_base()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.5,
    [gs.BOT_CASTABLE_TP_SCROLL] = 0.5,
    [gs.BOT_HAS_RESERVED_GOLD] = -1,
    [gs.BOT_NEAR_FOUNTAIN] = -1,
    [gs.BOT_HAS_FLASK] = -1,
    [gs.BOT_HAS_FAERIE_FIRE] = -1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = -1,
    [gs.EH_PRESENT] = -1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.tp_base()
  local item = algorithms.GetItem(env.BOT_DATA, "item_tpscroll")

  env.BOT:Action_UseAbilityOnLocation(item, env.FOUNTAIN_SPOT)

  action_timing.SetNextActionDelay(item:GetChannelTime())
end

---------------------------------

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
