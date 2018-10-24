local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local constants = require(
  GetScriptDirectory() .."/utility/constants")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local moves = require(
  GetScriptDirectory() .."/utility/moves")

local game_state = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_attack_with_better_position()
  local weights = {
    [1] = 1, -- algorithms.IsBotAlive()
    [2] = -1, -- env.IS_BOT_LOW_HP
  }

  return game_state.Evaluate(game_state.BOT_STATE, weights)
end

---------------------------------

--[[
local function IsUnitIncomingDamageMore(unit_data, target_data)
  return (target_data.incoming_damage_from_creeps
          + target_data.incoming_damage_from_towers)
         < (unit_data.incoming_damage_from_creeps
          + unit_data.incoming_damage_from_towers)

end
--]]

function M.pre_attack_enemy_hero_from_hg()
  local weights_bot_state = {
    [32] = -1, -- incoming damage
    [33] = 1.6, -- IsUnitPositionBetter(bot, enemy_hero)
  }

  local weights_enemy_hero_state = {
    [4] = 1.6, -- env.ENEMY_HERO_DISTANCE
  }

  local weights_creeps_state = {
    [1] = -0.5, -- env.ENEMY_CREEP_FRONT_DATA ~= nil
    [2] = -0.5, -- env.ENEMY_CREEP_BACK_DATA ~= nil
    [3] = 1, -- env.ALLY_CREEP_FRONT_DATA ~= nil
  }

  return moves.pre_attack_enemy_hero()
         and game_state.Evaluate(game_state.BOT_STATE, weights_bot_state)
         and game_state.Evaluate(
               game_state.ENEMY_HERO_STATE,
               weights_enemy_hero_state)
         and game_state.Evaluate(
               game_state.CREEPS_STATE,
               weights_creeps_state)

--[[
  return moves.pre_attack_enemy_hero()
         and (env.ALLY_CREEP_FRONT_DATA ~= nil
              or (env.ENEMY_CREEP_FRONT_DATA == nil
                  and env.ENEMY_CREEP_BACK_DATA == nil))

         and env.ENEMY_HERO_DISTANCE
             <= algorithms.GetAttackRange(
                  env.BOT_DATA,
                  env.ENEMY_HERO_DATA,
                  true)

         and not algorithms.AreEnemyCreepsInRadius(
                   env.BOT_DATA,
                   constants.MAX_MELEE_ATTACK_RANGE)

         and algorithms.IsUnitPositionBetter(
                 env.BOT_DATA,
                 env.ENEMY_HERO_DATA)

         and not IsUnitIncomingDamageMore(
                   env.BOT_DATA,
                   env.ENEMY_HERO_DATA)
--]]
end

function M.pre_attack_enemy_hero_from_hg()
  moves.attack_enemy_hero()
end

---------------------------------

function M.pre_attack_enemy_hero()
  return moves.pre_attack_enemy_hero()
         and (env.ALLY_CREEP_FRONT_DATA ~= nil
              or (env.ENEMY_CREEP_FRONT_DATA == nil
                  and env.ENEMY_CREEP_BACK_DATA == nil))

         and env.ENEMY_HERO_DISTANCE
             <= algorithms.GetAttackRange(
                  env.BOT_DATA,
                  env.ENEMY_HERO_DATA,
                  true)

         and not algorithms.AreEnemyCreepsInRadius(
                   env.BOT_DATA,
                   constants.MAX_MELEE_ATTACK_RANGE)

         and ((algorithms.IsUnitPositionBetter(
                 env.BOT_DATA,
                 env.ENEMY_HERO_DATA)
               and not IsUnitIncomingDamageMore(
                         env.BOT_DATA,
                         env.ENEMY_HERO_DATA))

              or (IsUnitIncomingDamageMore(
                    env.ENEMY_HERO_DATA,
                    env.BOT_DATA)
                  and not algorithms.IsUnitPositionBetter(
                            env.ENEMY_HERO_DATA,
                            env.BOT_DATA)))
end

function M.attack_enemy_hero()
  moves.attack_enemy_hero()
end

-- Provide an access to local functions for unit tests only

function M.test_SetBotState(state)
  game_state.BOT_STATE = state
end

return M
