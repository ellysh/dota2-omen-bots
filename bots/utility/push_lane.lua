local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local M = {}

---------------------------------

function M.pre_push_lane()
  return algorithms.IsBotAlive()
         and not env.IS_BOT_LOW_HP
         and env.ENEMY_CREEP_BACK_DATA == nil
         and algorithms.HasLevelForAggression(env.BOT_DATA)
end

---------------------------------

function M.pre_attack_enemy_creep()
  return moves.pre_attack_enemy_creep()
         and env.ENEMY_HERO_DATA ~= nil
end

function M.attack_enemy_creep()
  moves.attack_enemy_creep()
end

--------------------------------

function M.pre_kill_enemy_creep()
  local creep = algorithms.GetCreepWith(
                  env.BOT_DATA,
                  constants.SIDE["ENEMY"],
                  algorithms.CompareMinHealth,
                  nil)

  return creep ~= nil
         and env.ENEMY_HERO_DATA == nil
         and env.ALLY_CREEP_FRONT_DATA ~= nil
         and not algorithms.DoesTowerProtectUnit(creep)
end

function M.kill_enemy_creep()
  local creep = algorithms.GetCreepWith(
                  env.BOT_DATA,
                  constants.SIDE["ENEMY"],
                  algorithms.CompareMinHealth,
                  nil)

  algorithms.AttackUnit(env.BOT_DATA, creep)
end

--------------------------------

function M.pre_attack_enemy_tower()
  return env.ENEMY_TOWER_DATA ~= nil
         and env.ALLY_CREEP_FRONT_DATA ~= nil
         and algorithms.IsFocusedByCreeps(env.ENEMY_TOWER_DATA)
         and algorithms.DoesEnemyTowerAttackAllyCreep(
               env.BOT_DATA,
               env.ENEMY_TOWER_DATA)
         and not env.IS_FOCUSED_BY_TOWER
end

function M.attack_enemy_tower()
  algorithms.AttackUnit(env.BOT_DATA, env.ENEMY_TOWER_DATA)
end

--------------------------------

function M.stop_attack()
  moves.stop_attack()
end

---------------------------------

-- Provide an access to local functions for unit tests only

return M
