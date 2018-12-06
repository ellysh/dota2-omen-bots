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
  local soma = {}

  soma.strategy = functions.GetElementWith(
           objectives.OBJECTIVES,
           nil,
           function(strategy)
             if not strategies["pre_" .. strategy.strategy]() then
               return false end

             soma.objective, soma.move
               = FindObjectiveAndMoveToExecute(strategy)

             return soma.objective ~= nil and soma.move ~= nil
           end)

  return soma
end

local function GetCurrentAction(move, action_index)
  return move.actions[action_index]
end

local function FindNextAction(soma)
  soma.action_index = soma.action_index + 1

  if #soma.move.actions < soma.action_index then
    soma.action_index = 1
    soma.move = nil
  end

  return soma
end

local function ExecuteAction(soma)
  local current_action = GetCurrentAction(
                           soma.move,
                           soma.action_index)

  if current_action == nil then
    return FindNextAction(soma)
  end

  if soma.is_action_started
     and (soma.move.wait_condition ~= "nil"
         and soma.objective.module[
               "pre_" .. soma.move.wait_condition]()) then

    logger.Print("\tcurrent_action = " .. current_action.action ..
      " ACTION_INDEX = " .. soma.action_index .. " - waiting")

    return soma
  else

    logger.Print("\tcurrent_action = " .. current_action.action ..
      " ACTION_INDEX = " .. soma.action_index)

    soma.objective.module[current_action.action]()
    soma.is_action_started = true
  end

  return FindNextAction(soma)
end

local function IsActionTimingDelay()
  local action_time = action_timing.GetNextActionTime()

  return action_time ~= 0 and GameTime() < action_time
end

local function IsMoveActual(soma)
  return soma.objective ~= nil
         and soma.move ~= nil
         and soma.objective.module["pre_" .. soma.objective.objective]()
         and soma.objective.module["pre_" .. soma.move.move]()
end

local function CancelCurrentMove(soma)
  if soma.objective ~= nil
     and soma.move ~= nil
     and soma.move.cancel_condition ~= "nil"
     and soma.objective.module["pre_" .. soma.move.cancel_condition]() then

    logger.Print("team = " .. GetTeam() ..
      " current_objective = " .. soma.objective.objective ..
      " current_move = " .. soma.move.move ..
      " - cancel")

    env.BOT:Action_ClearActions(true)

    return true
  end

  return false
end

local function ResetSoma(soma)
  soma.strategy = nil
  soma.objective = nil
  soma.move = nil
  soma.action_index = 1
  soma.is_action_started = false
end

local CURRENT_SOMA = {
  strategy = nil,
  objective = nil,
  move = nil,
  action_index = 1,
  is_action_started = false,
}

function M.Process()
  if IsActionTimingDelay() then
    return end

  env.UpdateVariables()

  game_state.UpdateState()

  if CancelCurrentMove(hist.LAST_SOMA) then
    ResetSoma(hist.LAST_SOMA)
    ResetSoma(CURRENT_SOMA)
    return
  end

  if CURRENT_SOMA.strategy == nil
     or not IsMoveActual(CURRENT_SOMA) then

    ResetSoma(CURRENT_SOMA)

    CURRENT_SOMA = ChooseStrategyObjectiveMove()
  end

  if CURRENT_SOMA.objective ~= nil
     and CURRENT_SOMA.move ~= nil then

    logger.Print("team = " .. GetTeam() ..
      " current_strategy = " .. CURRENT_SOMA.strategy.strategy ..
      " current_objective = " .. CURRENT_SOMA.objective.objective ..
      " current_move = " .. CURRENT_SOMA.move.move)

    hist.LAST_SOMA = CURRENT_SOMA

    CURRENT_SOMA = ExecuteAction(CURRENT_SOMA)
  end
end

-- Provide an access to local functions for unit tests only

return M
