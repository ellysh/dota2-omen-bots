local moves = require(
  GetScriptDirectory() .."/utility/moves")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local gs = require(
  GetScriptDirectory() .."/utility/game_state")

local M = {}

---------------------------------

function M.pre_force_stop()
  return moves.pre_interrupt_cast_objective()
end

---------------------------------

function M.pre_stop()
  return true
end

function M.stop_attack_and_move()
  env.BOT:Action_ClearActions(true)
end

---------------------------------

-- Provide an access to local functions for unit tests only

return M
