
local M = {}

M.OBJECTIVES = {

  {
    objective = "buy_items",
    module = require(GetScriptDirectory() .."/utility/buy_items"),
    moves = {
      {
        move = "buy_flask",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_flask"},

        },
      },
      {
        move = "buy_tpscroll",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_tpscroll"},

        },
      },
      {
        move = "buy_enchanted_mango",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_enchanted_mango"},

        },
      },
      {
        move = "buy_magic_stick",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_magic_stick"},

        },
      },
      {
        move = "buy_boots",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_boots"},

        },
      },
      {
        move = "buy_cloak",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_cloak"},

        },
      },
      {
        move = "buy_boots_of_elves",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_boots_of_elves"},

        },
      },
      {
        move = "buy_blades_of_attack",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_blades_of_attack"},

        },
      },
      {
        move = "buy_ring_of_regen",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_ring_of_regen"},

        },
      },
      {
        move = "buy_ring_of_health",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_ring_of_health"},

        },
      },
      {
        move = "buy_observer_ward",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_observer_ward"},

        },
      },
      {
        move = "deliver_items",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "deliver_items"},

        },
      },
    },
  },

}

return M
