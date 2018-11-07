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
    [gs.BOT_IS_ALIVE] = 0.5,
    [gs.BOT_IS_HEALING] = -0.5,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0.5
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------

function M.pre_heal_flask()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.75,
    [gs.BOT_IS_FLASK_HEALING] = -1,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = -1,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = -1,
    [gs.BOT_HP_RATE] = -1,
    [gs.BOT_CASTABLE_FLASK] = 0.75,
    [gs.BOT_IN_EH_ATTACK_RANGE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
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
    [gs.BOT_CASTABLE_TANGO] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.heal_faerie_fire()
  env.BOT:Action_UseAbility(
    algorithms.GetItem(env.BOT_DATA, "item_faerie_fire"))
end

---------------------------------

function M.pre_heal_tango()
  local weights_1 = {
    [gs.BOT_IS_HEALING] = -1,
    [gs.BOT_CASTABLE_TANGO] = 0.7,
    [gs.BOT_HP_MAX_DELTA] = 1,
    [gs.NO_TREE_PRESENT] = -1,
    [gs.TREE_ET_UNSAFE_DISTANCE] = -1,
  }

  local weights_2 = {
    [gs.BOT_IS_LOW_HP] = -1,
    [gs.BOT_CASTABLE_FLASK] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.EvaluateFrom(2, gs.GAME_STATE, weights_2)
end

function M.heal_tango()
  env.BOT:Action_UseAbilityOnTree(
    algorithms.GetItem(env.BOT_DATA, "item_tango"),
    env.NEARBY_TREE)
end

---------------------------------

function M.pre_tp_base()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.3,
    [gs.BOT_CASTABLE_TP_SCROLL] = 0.3,
    [gs.BOT_GOLD] = 0.2,
    [gs.BOT_FOUNTAIN_DISTANCE] = 0.2,
    [gs.BOT_HAS_FLASK] = -1,
    [gs.BOT_HAS_FAERIE_FIRE] = -1,
    [gs.BOT_HAS_TANGO] = -1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = -1,
    [gs.EH_PRESENT] = -1,
    [gs.EH_BOT_DISTANCE] = 1,
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