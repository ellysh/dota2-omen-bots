local M = {}

M.LAST_AGGRO_CONTROL = 0

M.LAST_SOMA = {
  strategy = nil,
  objective = nil,
  move = nil,
  action_index = 1,
  is_action_started = false,
}

M.LAST_SAFE_SPOT = {}

M.WARD_BUYING_TIMESTAMP = 0

M.SWAP_FLASK_TIMESTAMP = 0

M.SWAP_MANGO_TIMESTAMP = 0

-- Provide an access to local functions for unit tests only

return M
