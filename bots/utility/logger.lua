local constants = require(
  GetScriptDirectory() .."/utility/constants")

local functions = require(
  GetScriptDirectory() .."/utility/functions")

local M = {}

function M.Print(string)
  print(GameTime() .. ": " ..string)
end

function M.PrintGameState(state)
--[[
  M.Print("GAME_STATE for team = " .. GetTeam())

  functions.DoWithKeysAndElements(
    state,
    function(key, value)
      if state[key] ~= nil then
        M.Print(tostring(key) .. " = " .. tostring(value))
      end
    end)
--]]
end

print("OMEN Bots version " .. constants.BOTS_VERSION ..
      " play in team " .. GetTeam())

return M
