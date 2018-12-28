
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
        move = "put_wraith_band_in_backpack",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "put_wraith_band_in_backpack"},

        },
      },
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
      {
        move = "swap_flask_to_backpack",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_flask_to_backpack"},

        },
      },
      {
        move = "swap_raindrop_mango",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_raindrop_mango"},

        },
      },
    },
  },

  {
    objective = "item_hp_recovery",
    module = require(GetScriptDirectory() .."/utility/item_hp_recovery"),
    moves = {
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
        wait_condition = "wait_move_base",
        cancel_condition = "cancel_move_base",
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
        wait_condition = "wait_move_safe_recovery",
        cancel_condition = "cancel_move_safe_recovery",
        actions = {
          {action = "move_safe_spot"},

        },
      },
      {
        move = "evade_enemy_hero",
        wait_condition = "wait_evade_enemy_hero",
        cancel_condition = "cancel_evade_enemy_hero",
        actions = {
          {action = "move_safe_spot"},

        },
      },
      {
        move = "evade_enemy_tower",
        wait_condition = "wait_evade_enemy_tower",
        cancel_condition = "cancel_evade_enemy_tower",
        actions = {
          {action = "move_safe_spot"},

        },
      },
      {
        move = "evade_enemy_creeps",
        wait_condition = "wait_evade_enemy_creeps",
        cancel_condition = "cancel_evade_enemy_creeps",
        actions = {
          {action = "move_safe_spot"},

        },
      },
      {
        move = "evade_invisible_enemy_hero",
        wait_condition = "wait_evade_invisible_enemy_hero",
        cancel_condition = "cancel_evade_invisible_enemy_hero",
        actions = {
          {action = "move_safe_spot"},

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
