local hist = require(
  GetScriptDirectory() .."/utility/history")

local M = {}

---------------------------------

function M.pre_cancel_current_move()
  local objective = hist.LAST_OBJECTIVE
  local move = hist.LAST_MOVE

  return objective ~= nil
         and move ~= nil
         and (not objective.module["pre_" .. objective.objective]()
              or not objective.module["pre_" .. move.move]())
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
