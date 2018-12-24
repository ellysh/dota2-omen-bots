local skill_build = require(
  GetScriptDirectory() .."/database/skill_build")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local map = require(
  GetScriptDirectory() .."/utility/map")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

---------------------------------

function M.pre_upgrade_skills()
  return algorithms.IsBotAlive()
end

---------------------------------

function M.pre_upgrade()
  return 0 < env.BOT_DATA.ability_points
         and 0 < #skill_build.SKILL_BUILD
end

function M.upgrade()
  local skill_name = table.remove(skill_build.SKILL_BUILD, 1)

  env.BOT:ActionImmediate_LevelAbility(skill_name)
end

---------------------------------

-- Provide an access to local functions for unit tests only

return M
