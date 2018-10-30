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

function M.pre_item_recovery()
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
    [2] = 0.5, -- env.IS_BOT_LOW_HP
    [17] = -1, -- IsItemCastable(env.BOT_DATA, "item_flask")
    [18] = 0.5, -- IsItemCastable(env.BOT_DATA, "item_faerie_fire")
    [19] = -1, -- IsItemCastable(env.BOT_DATA, "item_tango")
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.heal_faerie_fire()
  env.BOT:Action_UseAbility(
    algorithms.GetItem(env.BOT_DATA, "item_faerie_fire"))
end

---------------------------------

function M.pre_heal_tango()
  local weights_bot_state = {
    [2] = -1, -- env.IS_BOT_LOW_HP
    [4] = -1, -- env.BOT_DATA.is_healing
    [19] = 0.7, -- IsItemCastable(env.BOT_DATA, "item_tango")
    [20] = 1 -- env.BOT_DATA.max_health - env.BOT_DATA.health
  }

  local weights_nearby_tree_state = {
    [1] = 1, -- env.NEARBY_TREE ~= nil
    [2] = 1, -- GetDistance(tree, env.ENEMY_TOWER_DATA)
    [3] = -1 -- env.ENEMY_TOWER_DATA ~= nil
  }

  return gs.Evaluate(gs.GAME_STATE, weights_bot_state)
         and gs.Evaluate(
               gs.NEARBY_TREE_STATE,
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
    [2] = 0.3, -- env.IS_BOT_LOW_HP
    [21] = 0.3, -- IsItemCastable(env.BOT_DATA, "item_tpscroll")
    [22] = 0.2, -- env.BOT_DATA.gold < constants.RESERVED_GOLD
    [23] = 0.2, -- env.FOUNTAIN_DISTANCE / MIN_TP_BASE_RADIUS
    [24] = -1, -- DoesBotOrCourierHaveItem("item_faerie_fire")
    [25] = -1, -- DoesBotOrCourierHaveItem("item_flask")
    [26] = -1, -- DoesBotOrCourierHaveItem("item_tango")
    [27] = -1, -- IsUnitInEnemyTowerAttackRange(env.BOT_DATA)
  }

  local weights_enemy_hero_state = {
    [1] = -1, -- env.ENEMY_HERO_DATA ~= nil
    [4] = 1, -- env.ENEMY_HERO_DISTANCE / SAFE_HERO_DISTANCE
    [6] = 1, -- true
  }

  return gs.Evaluate(gs.GAME_STATE, weights_bot_state)
         and gs.Evaluate(
               gs.ENEMY_HERO_STATE,
               weights_enemy_hero_state)
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
