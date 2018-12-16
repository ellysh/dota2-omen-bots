local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local map = require(
  GetScriptDirectory() .."/utility/map")

local base_recovery = require(
  GetScriptDirectory() .."/utility/base_recovery")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

---------------------------------

local function DoesCreepMeet()
  return 25 < DotaTime()
end

function M.pre_buy()
  return DoesCreepMeet()
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

function M.pre_farm()
  return true
end

---------------------------------

return M
