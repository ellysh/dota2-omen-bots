local M = {}

M.LAST_AGGRO_CONTROL = 0

M.LAST_SOMA = {
  strategy = nil,
  objective = nil,
  move = nil,
  action_index = 1,
  is_action_started = false,
}

-- Provide an access to local functions for unit tests only

return M
