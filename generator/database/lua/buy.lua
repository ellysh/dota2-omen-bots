
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
        move = "buy_slippers",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_slippers"},

        },
      },
      {
        move = "buy_circlet",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_circlet"},

        },
      },
      {
        move = "buy_recipe_wraith_band",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_recipe_wraith_band"},

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
        move = "buy_blink",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_blink"},

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
