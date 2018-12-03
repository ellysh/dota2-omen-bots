
local M = {}

M.OBJECTIVES = {

  {
    objective = "buyback",
    module = require(GetScriptDirectory() .."/utility/buyback"),
    moves = {
      {
        move = "do_buyback",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "do_buyback"},

        },
      },
    },
  },

  {
    objective = "glyph",
    module = require(GetScriptDirectory() .."/utility/glyph"),
    moves = {
      {
        move = "do_glyph",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "do_glyph"},

        },
      },
    },
  },

  {
    objective = "swap_items",
    module = require(GetScriptDirectory() .."/utility/swap_items"),
    moves = {
      {
        move = "put_item_in_inventory",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "put_item_in_inventory"},

        },
      },
      {
        move = "swap_flask_wraith_band",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_flask_wraith_band"},

        },
      },
      {
        move = "swap_mango_wraith_band",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_mango_wraith_band"},

        },
      },
    },
  },

  {
    objective = "item_hp_recovery",
    module = require(GetScriptDirectory() .."/utility/item_hp_recovery"),
    moves = {
      {
        move = "heal_tango",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "heal_tango"},

        },
      },
      {
        move = "heal_flask",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "heal_flask"},

        },
      },
      {
        move = "heal_faerie_fire",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "heal_faerie_fire"},

        },
      },
      {
        move = "heal_magic_stick",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "heal_magic_stick"},

        },
      },
      {
        move = "tp_base",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "tp_base"},

        },
      },
    },
  },

  {
    objective = "manage_movement",
    module = require(GetScriptDirectory() .."/utility/manage_movement"),
    moves = {
      {
        move = "cancel_movement",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "cancel_movement"},

        },
      },
      {
        move = "wait_movement",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "wait_movement"},

        },
      },
    },
  },

  {
    objective = "base_recovery",
    module = require(GetScriptDirectory() .."/utility/base_recovery"),
    moves = {
      {
        move = "deliver_items",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "deliver_items"},

        },
      },
      {
        move = "restore_hp_on_base",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "restore_hp_on_base"},

        },
      },
      {
        move = "restore_mp_on_base",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "restore_mp_on_base"},

        },
      },
      {
        move = "move_base",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_base"},

        },
      },
    },
  },

  {
    objective = "evasion",
    module = require(GetScriptDirectory() .."/utility/evasion"),
    moves = {
      {
        move = "move_safe_recovery",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_safe_recovery"},

        },
      },
      {
        move = "evade_enemy_hero",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "evade_enemy_hero"},

        },
      },
      {
        move = "evade_enemy_creeps",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "evade_enemy_creeps"},

        },
      },
      {
        move = "evade_enemy_tower",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "evade_enemy_tower"},

        },
      },
    },
  },

  {
    objective = "force_stop",
    module = require(GetScriptDirectory() .."/utility/force_stop"),
    moves = {
      {
        move = "stop",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },

}

return M
