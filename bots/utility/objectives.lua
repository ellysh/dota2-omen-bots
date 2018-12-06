local objectives = require(
  GetScriptDirectory() .."/database/objectives")

local strategies = require(
  GetScriptDirectory() .."/utility/strategies")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local logger = require(
  GetScriptDirectory() .."/utility/logger")

local algorithms = require(
  GetScriptDirectory() .."/utility/algorithms")

local env = require(
  GetScriptDirectory() .."/utility/environment")

local hist = require(
  GetScriptDirectory() .."/utility/history")

local game_state = require(
  GetScriptDirectory() .."/utility/game_state")

local action_timing = require(
  GetScriptDirectory() .."/utility/action_timing")

local M = {}

local function FindMoveToExecute(objective)
  return functions.GetElementWith(
           objective.moves,
           nil,
           function(move)
             return objective.module["pre_" .. move.move]()
           end)
end

local function FindObjectiveAndMoveToExecute(strategy)
  local result_move = nil

  local result_objective = functions.GetElementWith(
           strategy.objectives,
           nil,
           function(objective)
             if not objective.module["pre_" .. objective.objective]() then
               return false
             end

             result_move = FindMoveToExecute(objective)

             return result_move ~= nil
           end)

  return result_objective, result_move
end

local function ChooseStrategyObjectiveMove()
  local objective = nil
  local move = nil

  local strategy = functions.GetElementWith(
           objectives.OBJECTIVES,
           nil,
           function(strategy)
             if not strategies["pre_" .. strategy.strategy]() then
               return false end

             objective, move = FindObjectiveAndMoveToExecute(strategy)

             return objective ~= nil and move ~= nil
           end)

  return strategy, objective, move
end

local function GetCurrentAction(move, action_index)
  return move.actions[action_index]
end

local function FindNextAction(move, action_index)
  action_index = action_index + 1

  if #move.actions < action_index then
    action_index = 1
    move = nil
  end

  return move, action_index
end

local function ExecuteAction(
  objective,
  move,
  action_index,
  is_action_started)

  local current_action = GetCurrentAction(move, action_index)

  if current_action == nil then
    return is_action_started, FindNextAction(move, action_index)
  end

  if is_action_started
     and (move.wait_condition ~= "nil"
         and objective.module["pre_" .. move.wait_condition]()) then

    logger.Print("\tcurrent_action = " ..
      current_action.action .. " ACTION_INDEX = " .. action_index ..
      " - waiting")

    return is_action_started, move, action_index
  else

    logger.Print("\tcurrent_action = " ..
      current_action.action .. " ACTION_INDEX = " .. action_index)

    objective.module[current_action.action]()
    is_action_started = true
  end

  return is_action_started, FindNextAction(move, action_index)
end

local function IsActionTimingDelay()
  local action_time = action_timing.GetNextActionTime()

  return action_time ~= 0 and GameTime() < action_time
end

local function IsMoveActual(objective, move)
  return objective ~= nil
         and move ~= nil
         and objective.module["pre_" .. objective.objective]()
         and objective.module["pre_" .. move.move]()
end

local function CancelCurrentMove(objective, move)
  if objective ~= nil
     and move ~= nil
     and move.cancel_condition ~= "nil"
     and objective.module["pre_" .. move.cancel_condition]() then

    logger.Print("team = " .. GetTeam() ..
      " current_objective = " .. objective.objective ..
      " current_move = " .. move.move ..
      " - cancel")

    env.BOT:Action_ClearActions(true)

    return true
  end

  return false
end

local CURRENT_STRATEGY = nil
local CURRENT_OBJECTIVE = nil
local CURRENT_MOVE = nil
local ACTION_INDEX = 1
local IS_ACTION_STARTED = false

function M.Process()
  if IsActionTimingDelay() then
    return end

  env.UpdateVariables()

  game_state.UpdateState()

  if CancelCurrentMove(hist.LAST_OBJECTIVE, hist.LAST_MOVE) then
    hist.LAST_OBJECTIVE = nil
    hist.LAST_MOVE = nil
    IS_ACTION_STARTED = false
    return
  end

  if CURRENT_STRATEGY == nil
     or not IsMoveActual(CURRENT_OBJECTIVE, CURRENT_MOVE) then

    IS_ACTION_STARTED = false
    CURRENT_STRATEGY, CURRENT_OBJECTIVE, CURRENT_MOVE
      = ChooseStrategyObjectiveMove()
  end

  if CURRENT_OBJECTIVE ~= nil
     and CURRENT_MOVE ~= nil then

    logger.Print("team = " .. GetTeam() ..
      " current_strategy = " .. CURRENT_STRATEGY.strategy ..
      " current_objective = " .. CURRENT_OBJECTIVE.objective ..
      " current_move = " .. CURRENT_MOVE.move)

    hist.LAST_STRATEGY = CURRENT_STRATEGY
    hist.LAST_OBJECTIVE = CURRENT_OBJECTIVE
    hist.LAST_MOVE = CURRENT_MOVE

    IS_ACTION_STARTED, CURRENT_MOVE, ACTION_INDEX
      = ExecuteAction(
          CURRENT_OBJECTIVE,
          CURRENT_MOVE,
          ACTION_INDEX,
          IS_ACTION_STARTED)
  end
end

-- Provide an access to local functions for unit tests only

return M
