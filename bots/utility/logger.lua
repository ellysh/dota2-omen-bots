local constants = require(
  GetScriptDirectory() .."/utility/constants")

local M = {}

function M.Print(string)
  print(GameTime() .. ": " ..string .. "\n")
end

M.Print("OML Bots version " .. constants.BOTS_VERSION ..
        " play in team " .. GetTeam())

return M
