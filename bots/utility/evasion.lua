local moves = require(
  GetScriptDirectory() .."/utility/moves")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_evasion()
  return moves.pre_interrupt_cast_objective()
end

---------------------------------

local function GetFlaskHealingRemainingDuration()
  local modifier = env.BOT:GetModifierByName("modifier_flask_healing")
  return env.BOT:GetModifierRemainingDuration(modifier)
end

function M.pre_move_safe_recovery()
  local weights_1 = {
    [gs.BOT_IS_FLASK_HEALING] = 0.924,
    [gs.BOT_HP_MAX_DELTA] = 0.95,
  }

  local weights_2 = {
    [gs.BOT_HAS_MODIFIER_FOUNTAIN] = -1,
    [gs.BOT_IN_SAFE_SPOT] = -1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -1,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.EvaluateFrom(1, gs.GAME_STATE, weights_2)
end

function M.pre_wait_move_safe_recovery()
  return M.pre_move_safe_recovery()
end

function M.pre_cancel_move_safe_recovery()
  return not M.pre_move_safe_recovery()
         or moves.pre_cancel_move_safe_spot()
end

function M.move_safe_spot()
  moves.move_safe_spot()
end

---------------------------------

function M.pre_evade_enemy_hero_low_hp()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_enemy_hero_low_hp()
  return M.pre_evade_enemy_hero_low_hp()
end

function M.pre_cancel_evade_enemy_hero_low_hp()
  return not M.pre_evade_enemy_hero_low_hp()
         or moves.pre_cancel_move_safe_spot()
end

---------------------------------

function M.pre_evade_enemy_hero()
  local weights = {
    [gs.BOT_IS_LOW_HP] = -1,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -1,
    [gs.BOT_IS_FOCUSED_BY_ENEMY_HERO] = 0.5,
    [gs.BOT_IS_FOCUSED_BY_UNKNOWN_UNIT] = 0.5,
    [gs.EC_IN_AGGRO_RADIUS] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_enemy_hero()
  return M.pre_evade_enemy_hero()
end

function M.pre_cancel_evade_enemy_hero()
  return not M.pre_evade_enemy_hero()
         or moves.pre_cancel_move_safe_spot()
end

---------------------------------

function M.pre_evade_invisible_enemy_hero()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.5,
    [gs.BOT_IN_EH_POTENTIAL_RADIUS] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_invisible_enemy_hero()
  return M.pre_evade_invisible_enemy_hero()
end

function M.pre_cancel_evade_invisible_enemy_hero()
  return not M.pre_evade_invisible_enemy_hero()
         or moves.pre_cancel_move_safe_spot()
end
---------------------------------

function M.pre_evade_enemy_creeps()
  local weights = {
    [gs.BOT_IS_FOCUSED_BY_CREEPS] = 1,
    [gs.EC_IN_MELEE_ATTACK_RANGE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_evade_enemy_creeps()
  return M.pre_evade_enemy_creeps()
end

function M.pre_cancel_evade_enemy_creeps()
  return not M.pre_evade_enemy_creeps()
         or moves.pre_cancel_move_safe_spot()
end

---------------------------------

function M.pre_evade_enemy_tower()
  local weights_1 = {
    [gs.BOT_IS_FOCUSED_BY_TOWER] = 1,
    [gs.BOT_IN_ET_MIN_DISTANCE] = 1,
  }

  local weights_2 = {
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = -1,
    [gs.BOT_IN_ENEMY_TOWER_RANGE] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights_1)
         or gs.Evaluate(gs.GAME_STATE, weights_2)
end

function M.pre_wait_evade_enemy_tower()
  return M.pre_evade_enemy_tower()
end

function M.pre_cancel_evade_enemy_tower()
  return not M.pre_evade_enemy_tower()
         or moves.pre_cancel_move_safe_spot()
end

---------------------------------

function M.pre_use_gust()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.3,
    [gs.BOT_CASTABLE_GUST] = 0.3,
    [gs.EH_IN_GUST_RANGE] = 0.2,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 0.2,
    [gs.BOT_IS_SILENCED] = -1,
    [gs.BOT_CASTABLE_PIKE] = -1,
    [gs.BOT_CASTABLE_FORCE_STAFF] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.use_gust()
  env.BOT:Action_UseAbilityOnLocation(
    env.GUST_ABILITY,
    env.ENEMY_HERO_DATA.location)
end

---------------------------------

function M.pre_evade_enemy_hero_with_force_staff()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.3,
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0.3,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 0.2,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 0.2,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.evade_enemy_hero_with_force_staff()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_force_staff"),
    env.BOT_DATA.handle)
end

---------------------------------

function M.pre_evade_enemy_hero_with_pike()
  local weights = {
    [gs.BOT_IS_LOW_HP] = 0.3,
    [gs.BOT_CASTABLE_PIKE] = 0.3,
    [gs.BOT_IS_FACING_SAFE_SPOT] = 0.2,
    [gs.BOT_HAS_FROST_ARROWS_MODIFIER] = 0.2,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.evade_enemy_hero_with_pike()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_hurricane_pike"),
    env.BOT_DATA.handle)
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
