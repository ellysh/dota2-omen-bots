
local M = {}

M.OBJECTIVES = {

  {
    objective = "buy_items",
    module = require(GetScriptDirectory() .."/utility/buy_items"),
    moves = {
      {
        move = "buy_tango",
        actions = {
          {action = "buy_tango"},

        },
      },
      {
        move = "buy_flask",
        actions = {
          {action = "buy_flask"},

        },
      },
      {
        move = "buy_tpscroll",
        actions = {
          {action = "buy_tpscroll"},

        },
      },
      {
        move = "buy_enchanted_mango",
        actions = {
          {action = "buy_enchanted_mango"},

        },
      },
      {
        move = "buy_magic_stick",
        actions = {
          {action = "buy_magic_stick"},

        },
      },
      {
        move = "buy_boots",
        actions = {
          {action = "buy_boots"},

        },
      },
      {
        move = "buy_cloak",
        actions = {
          {action = "buy_cloak"},

        },
      },
      {
        move = "buy_two_blades_of_attack",
        actions = {
          {action = "buy_two_blades_of_attack"},

        },
      },
      {
        move = "buy_ring_of_regen",
        actions = {
          {action = "buy_ring_of_regen"},

        },
      },
      {
        move = "buy_ring_of_health",
        actions = {
          {action = "buy_ring_of_health"},

        },
      },
      {
        move = "deliver_items",
        actions = {
          {action = "deliver_items"},

        },
      },
    },
  },

}

return M
