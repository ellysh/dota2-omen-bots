local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_nuke_enemy_hero()
  local weights = {
    [gs.BOT_HAS_LEVEL_FOR_NUKES] = 1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
         and moves.pre_attack_objective()
end

---------------------------------

function M.pre_turn_near_shadowraze()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0.3,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0.4,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = -1,
    [gs.BOT_IS_TURNING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_turn_near_shadowraze()
  return M.pre_turn_near_shadowraze()
end

function M.pre_cancel_turn_near_shadowraze()
  return not M.pre_turn_near_shadowraze()
end

function M.turn_via_attack()
  env.BOT:Action_AttackUnit(env.ENEMY_HERO_DATA.handle, true)
end

---------------------------------

function M.pre_turn_medium_shadowraze()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0.3,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0.4,
    [gs.BOT_IS_FACING_EH] = -1,
    [gs.BOT_IS_TURNING] = -1,
  }
  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_turn_medium_shadowraze()
  return not M.pre_turn_medium_shadowraze()
end

---------------------------------

function M.pre_turn_far_shadowraze()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0.3,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0.4,
    [gs.BOT_IS_FACING_EH] = -1,
    [gs.BOT_IS_TURNING] = -1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_turn_far_shadowraze()
  return not M.pre_turn_far_shadowraze()
end

function M.turn()
  env.BOT:Action_MoveDirectly(env.ENEMY_HERO_DATA.location)
end

---------------------------------

function M.pre_near_shadowraze()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_NEAR_SHADOWRAZE] = 0.3,
    [gs.EH_IN_NEAR_SHADOWRAZE_RANGE] = 0.2,
    [gs.BOT_IS_FACING_EH_MELEE_RANGE] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_near_shadowraze()
  return not M.pre_near_shadowraze()
end

function M.near_shadowraze()
  env.BOT:Action_UseAbility(env.NEAR_SHADOWRAZE_ABILITY)
end

---------------------------------

function M.pre_medium_shadowraze()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_MEDIUM_SHADOWRAZE] = 0.3,
    [gs.EH_IN_MEDIUM_SHADOWRAZE_RANGE] = 0.2,
    [gs.BOT_IS_FACING_EH] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_medium_shadowraze()
  return not M.pre_medium_shadowraze()
end

function M.medium_shadowraze()
  env.BOT:Action_UseAbility(env.MEDIUM_SHADOWRAZE_ABILITY)
end

---------------------------------

function M.pre_far_shadowraze()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_FAR_SHADOWRAZE] = 0.3,
    [gs.EH_IN_FAR_SHADOWRAZE_RANGE] = 0.2,
    [gs.BOT_IS_FACING_EH] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_far_shadowraze()
  return not M.pre_far_shadowraze()
end

function M.far_shadowraze()
  env.BOT:Action_UseAbility(env.FAR_SHADOWRAZE_ABILITY)
end

---------------------------------

function M.pre_requiem()
  local weights = {
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.BOT_CASTABLE_REQUIEM ] = 0.3,
    [gs.EH_IN_REQUIEM_RANGE] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_cancel_requiem()
  return not M.pre_requiem()
end

function M.requiem()
  env.BOT:Action_UseAbility(env.REQUIEM_ABILITY)
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state

  moves.test_SetGameState(state)
end

return M
