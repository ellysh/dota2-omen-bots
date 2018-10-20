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

local M = {}

---------------------------------

function M.pre_item_recovery()
  local weights = {
    [1] = 0.5,
    [4] = -0.5,
    [16] = 0.5
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

---------------------------------

function M.pre_heal_flask()
  local weights_bot_state = {
    [2] = 0.75,
    [3] = -1,
    [8] = -1,
    [9] = -1,
    [12] = -1,
    [17] = 0.75,
  }

  local weights_enemy_hero_state = {
    [1] = -1,
    [4] = 1.6,
    [6] = 1,
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights_bot_state)
         and game_state.Evaluate(
               game_state.ENEMY_HERO_STATE,
               weights_enemy_hero_state)
end

function M.heal_flask()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_flask"),
    env.BOT)
end

----------------------------------

function M.pre_heal_faerie_fire()
  local weights = {
    [2] = 0.5,
    [17] = -1,
    [18] = 0.5,
    [19] = -1,
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

function M.heal_faerie_fire()
  env.BOT:Action_UseAbility(
    algorithms.GetItem(env.BOT_DATA, "item_faerie_fire"))
end

---------------------------------

function M.pre_heal_tango()
  local weights_bot_state = {
    [2] = -1,
    [4] = -1,
    [19] = 0.7,
    [20] = 1
  }

  local weights_nearby_tree_state = {
    [1] = 1,
    [2] = 1,
    [3] = -1
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights_bot_state)
         and game_state.Evaluate(
               game_state.NEARBY_TREE_STATE,
               weights_nearby_tree_state)
end

function M.heal_tango()
  env.BOT:Action_UseAbilityOnTree(
    algorithms.GetItem(env.BOT_DATA, "item_tango"),
    env.NEARBY_TREE)
end

---------------------------------

function M.pre_tp_base()
  local weights_bot_state = {
    [2] = 0.3,
    [21] = 0.3,
    [22] = 0.2,
    [23] = 0.2,
    [24] = -1,
    [25] = -1,
    [26] = -1,
    [27] = -1,
  }

  local weights_enemy_hero_state = {
    [1] = -1,
    [4] = 1,
    [6] = 1,
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights_bot_state)
         and game_state.Evaluate(
               game_state.ENEMY_HERO_STATE,
               weights_enemy_hero_state)
end

function M.tp_base()
  local item = algorithms.GetItem(env.BOT_DATA, "item_tpscroll")

  env.BOT:Action_UseAbilityOnLocation(item, env.FOUNTAIN_SPOT)

  action_timing.SetNextActionDelay(item:GetChannelTime())
end

---------------------------------

function M.test_SetBotState(state)
  game_state.BOT_STATE = state
end

function M.test_SetEnemyHeroState(state)
  game_state.ENEMY_HERO_STATE = state
end

function M.test_SetNearbyTreeState(state)
  game_state.NEARBY_TREE_STATE = state
end

return M
