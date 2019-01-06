
local M = {}

M.OBJECTIVES = {

  {
    objective = "blink_attack",
    module = require(GetScriptDirectory() .."/utility/blink_attack"),
    moves = {
      {
        move = "blink",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "blink"},

        },
      },
      {
        move = "use_gust",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_gust"},

        },
      },
    },
  },

}

return M
