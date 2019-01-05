
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
        move = "buy_two_boots_of_elves",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_two_boots_of_elves"},

        },
      },
      {
        move = "buy_ogre_axe",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_ogre_axe"},

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
        move = "buy_ring_of_regen",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_ring_of_regen"},

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
        move = "buy_recipe_force_staff",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_recipe_force_staff"},

        },
      },
      {
        move = "buy_recipe_hurricane_pike",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_recipe_hurricane_pike"},

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
