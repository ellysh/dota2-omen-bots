local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local map = require(
  GetScriptDirectory() .."/utility/map")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_pursuit_enemy_hero()
  local weights_1 = {
    [gs.EH_PRESENT] = 0.3,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.3,
    [gs.BOT_CASTABLE_FLASK] = 0.4,
    [gs.EH_IN_REAR_SPOT] = -1,
  }

  local weights_2 = {
    [gs.EH_IS_LOW_HP] = 1,
    [gs.EH_IS_TOWER_PROTECTED] = -0.5,
    [gs.EH_CAN_BE_FOLLOWED_UNDER_TOWER] = 1.5,
  }

  return moves.pre_attack_objective()
         and gs.Evaluate(gs.GAME_STATE, weights_1)
         and gs.Evaluate(gs.GAME_STATE, weights_2)
end

---------------------------------

function M.pre_attack_enemy_hero()
  return moves.pre_attack_enemy_hero()
end

function M.attack_enemy_hero()
  moves.attack_enemy_hero()
end

---------------------------------

function M.pre_move_enemy_hero()
  return moves.pre_move_enemy_hero()
end

function M.move_enemy_hero()
  if algorithms.IsUnitLastSeenOnStairs(env.ENEMY_HERO_DATA) then
    env.BOT:Action_MoveDirectly(map.GetEnemySpot("high_ground"))
  else
    moves.move_enemy_hero()
  end
end

---------------------------------

function M.pre_move_enemy_hero_with_force_staff()
  local weights = {
    [gs.BOT_CASTABLE_FORCE_STAFF] = 0.5,
    [gs.BOT_IS_FACING_EH] = 0.5,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.move_enemy_hero_with_force_staff()
  env.BOT:Action_UseAbilityOnEntity(
    algorithms.GetItem(env.BOT_DATA, "item_force_staff"),
    env.BOT_DATA.handle)

end

---------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
