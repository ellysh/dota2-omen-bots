
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
        move = "buy_infused_raindrop",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_infused_raindrop"},

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
        move = "buy_wind_lace",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_wind_lace"},

        },
      },
      {
        move = "buy_void_stone",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_void_stone"},

        },
      },
      {
        move = "buy_staff_of_wizardry",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_staff_of_wizardry"},

        },
      },
      {
        move = "buy_recipe_cyclone",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_recipe_cyclone"},

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
