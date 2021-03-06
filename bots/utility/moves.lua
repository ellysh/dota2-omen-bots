local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local hist = require(
  GetScriptDirectory() .."/utility/history")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

--------------------------------

function M.pre_interrupt_cast_objective()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_CASTING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

--------------------------------

function M.pre_attack_objective()
  local weights = {
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = -1,
    [gs.BOT_IS_CASTING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

--------------------------------

function M.pre_attack_enemy_creep()
  local weights = {
    [gs.EC_MAX_HP_TARGETABLE_PRESENT] = 0.5,
    [gs.EC_MAX_HP_TARGETABLE_IS_TOWER_PROTECTED] = -1,
    [gs.AC_FRONT_PRESENT] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_creep()
  algorithms.AttackUnit(
    env.BOT_DATA,
    env.ENEMY_CREEP_MAX_HP_TARGETABLE_DATA)
end

--------------------------------

function M.pre_attack_ally_creep()
  local weights = {
    [gs.AC_TARGETABLE_PRESENT] = 1,
    [gs.AC_TARGETABLE_IS_TOWER_PROTECTED] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_ally_creep()
  algorithms.AttackUnit(env.BOT_DATA, env.ALLY_CREEP_TARGETABLE_DATA)
end

--------------------------------

function M.stop_attack()
  if not algorithms.IsUnitAttack(env.BOT_DATA)
     or not algorithms.IsAttackDone(env.BOT_DATA) then
    return end

  env.BOT:Action_ClearActions(true)
end

---------------------------------

function M.pre_attack_enemy_hero()
  local weights = {
    [gs.EH_PRESENT] = 0.5,
    [gs.EH_IS_VISIBLE] = 0.5,
    [gs.EH_IS_TOWER_PROTECTED] = -0.2,
    [gs.EH_CAN_BE_ATTACKED_UNDER_TOWER] = 0.2,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 0.2,
    [gs.EH_NOT_IN_BOT_ATTACK_RANGE] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_hero()
  algorithms.AttackUnit(env.BOT_DATA, env.ENEMY_HERO_DATA)
end

---------------------------------

function M.pre_move_enemy_hero()
  local weights = {
    [gs.EH_PRESENT] = 0.5,
    [gs.EH_IN_PURSUIT_RANGE] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.move_enemy_hero()
  env.BOT:Action_MoveDirectly(env.ENEMY_HERO_DATA.location)
end

---------------------------------

function M.pre_deliver_items()
  local weights = {
    [gs.BOT_STASH_FULL] = 0.5,
    [gs.COURIER_ON_BASE] = 0.5,
    [gs.COURIER_IN_SECRET_SHOP] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.deliver_items()
  local courier = GetCourier(0)

  env.BOT:ActionImmediate_Courier(
    courier,
    COURIER_ACTION_TAKE_AND_TRANSFER_ITEMS)
end

---------------------------------

function M.pre_cancel_move_safe_spot()
  local weights = {
    [gs.BOT_NEXT_WAYPOINT_BLOCKED] = 1,
    [gs.BOT_SAFE_SPOT_IS_FOUNTAIN] = -1,
    [gs.BOT_LAST_WAYPOINT_REACHED] = 2,
    [gs.SAFE_SPOT_HAS_CHANGED] = 2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.move_safe_spot()
  env.BOT:Action_ClearActions(true)

  env.BOT:Action_MovePath(env.SAFE_SPOT_WAYPOINTS)

  hist.LAST_SAFE_SPOT = env.SAFE_SPOT
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
