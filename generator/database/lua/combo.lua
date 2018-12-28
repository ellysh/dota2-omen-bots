
local M = {}

M.OBJECTIVES = {

  {
    objective = "cyclone_and_requiem",
    module = require(GetScriptDirectory() .."/utility/cyclone_and_requiem"),
    moves = {
      {
        move = "cyclone",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "cyclone"},

        },
      },
      {
        move = "move_enemy_hero_location",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_enemy_hero_location"},

        },
      },
      {
        move = "requiem",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "requiem"},

        },
      },
    },
  },

}

return M
