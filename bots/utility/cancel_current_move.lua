local functions = require(
  GetScriptDirectory() .."/utility/functions")

local hist = require(
  GetScriptDirectory() .."/utility/history")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local M = {}

---------------------------------

local function IsCancelable(move)
  local cancelable = {
    "turn",
    "near_shadowraze",
    "medium_shadowraze",
    "far_shadowraze",
  }

  return functions.IsElementInList(cancelable, move, false)
end

function M.pre_cancel_current_move()
  local objective = hist.LAST_OBJECTIVE
  local move = hist.LAST_MOVE

  return objective ~= nil
         and move ~= nil
         and IsCancelable(move.move)
         and not objective.module["pre_" .. move.move]()
end

---------------------------------

function M.pre_stop_attack_and_move()
  return true
end

---------------------------------

function M.stop_attack_and_move()
  env.BOT:Action_ClearActions(true)
end

-- Provide an access to local functions for unit tests only

function M.test_SetGameState(state)
  gs.GAME_STATE = state
end

return M
