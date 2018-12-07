local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local hist = require(
  GetScriptDirectory() .."/utility/history")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local all_units = require(
  GetScriptDirectory() .."/utility/all_units")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_defend_tower()
  return moves.pre_attack_objective()
end

---------------------------------

function M.pre_pull_enemy_creep()
  local weights = {
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0.3,
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.AC_FRONT_PRESENT] = -1,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0.2,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0.1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.1,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pull_enemy_creep()
  env.BOT:Action_AttackUnit(all_units.GetUnit(env.ENEMY_HERO_DATA), true)

  hist.LAST_AGGRO_CONTROL = GameTime()
end

---------------------------------

function M.pre_move_enemy_creep()
  local weights = {
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0.3,
    [gs.EH_IS_VISIBLE] = 0.3,
    [gs.AC_FRONT_PRESENT] = -1,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = -1,
    [gs.EC_AGGRO_COOLDOWN] = -1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0.2,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_move_enemy_creep()
  return M.pre_move_enemy_creep()
end

function M.pre_cancel_move_enemy_creep()
  return M.pre_pull_enemy_creep()
         or not M.pre_move_enemy_creep()
end

function M.move_enemy_creep()
  env.BOT:Action_MoveDirectly(env.ENEMY_CREEP_ATTACKING_TOWER.location)
end

---------------------------------

function M.pre_move_safe()
  local weights = {
    [gs.EC_ATTACKING_TOWER_PRESENT] = -1,
    [gs.AC_FRONT_PRESENT] = -1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0.4,
    [gs.EC_ATTACKING_BOT_PRESENT] = 0.4,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 0.2,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.pre_wait_move_safe()
  return M.pre_move_safe()
end

function M.pre_cancel_move_safe()
  return not M.pre_move_safe()
end

function M.move_safe()
  env.BOT:Action_MoveDirectly(env.FOUNTAIN_SPOT)
end

---------------------------------

function M.pre_kill_enemy_creep()
  local weights = {
    [gs.AC_FRONT_PRESENT] = 0.8,
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0.2,
    [gs.EC_ATTACKING_BOT_PRESENT] = 0.2,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

function M.kill_enemy_creep()
  local target = functions.ternary(
                   env.ENEMY_CREEP_ATTACKING_TOWER ~= nil,
                   env.ENEMY_CREEP_ATTACKING_TOWER,
                   env.ENEMY_CREEP_ATTACKING_BOT)

  algorithms.AttackUnit(env.BOT_DATA, target)
end

---------------------------------

function M.pre_attack_enemy_hero()
  local weights = {
    [gs.EH_ATTACK_AT] = 1,
  }

  return moves.pre_attack_enemy_hero()
         and gs.Evaluate(gs.GAME_STATE, weights)
end

function M.attack_enemy_hero()
  moves.attack_enemy_hero()
end

--------------------------------

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
