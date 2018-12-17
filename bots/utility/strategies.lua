local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local base_recovery = require(
  GetScriptDirectory() .."/utility/base_recovery")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

local function DoesCreepMeet()
  return 25 < DotaTime()
end

function M.pre_buy()
  return DoesCreepMeet()
         and algorithms.IsBotAlive()
end

---------------------------------

function M.pre_recovery()
  return DoesCreepMeet()
         and (not algorithms.IsBotAlive()
              or env.IS_BOT_LOW_HP
              or env.IS_BASE_RECOVERY
              or base_recovery.pre_restore_hp_on_base()
              or base_recovery.pre_restore_mp_on_base())
end

---------------------------------

function M.pre_assault_enemy_tower()
  local weights = {
    [gs.BOT_IS_LOW_HP] = -1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0.3,
    [gs.EH_PRESENT] = -0.3,
    [gs.BOT_IN_SAFE_DISTANCE_FROM_EH] = 0.3,
    [gs.ET_ATTACK_AC] = 0.3,
    [gs.AC_FRONT_PRESENT] = 0.4,
  }

  return gs.Evaluate(gs.GAME_STATE, weights)
end

---------------------------------
function M.pre_farm()
  return true
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
