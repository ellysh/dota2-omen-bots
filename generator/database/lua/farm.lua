
local M = {}

M.OBJECTIVES = {

  {
    objective = "manage_attack_anim",
    module = require(GetScriptDirectory() .."/utility/manage_attack_anim"),
    moves = {
      {
        move = "cancel_attack",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "cancel_attack"},

        },
      },
      {
        move = "wait_attack",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "wait_attack"},

        },
      },
    },
  },

  {
    objective = "evade_enemy_nukes",
    module = require(GetScriptDirectory() .."/utility/evade_enemy_nukes"),
    moves = {
      {
        move = "evade_near_shadowraze_back",
        wait_condition = "wait_evade_near_shadowraze_back",
        cancel_condition = "cancel_evade_near_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_back",
        wait_condition = "wait_evade_medium_shadowraze_back",
        cancel_condition = "cancel_evade_medium_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_far_shadowraze_back",
        wait_condition = "wait_evade_far_shadowraze_back",
        cancel_condition = "cancel_evade_far_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_front",
        wait_condition = "wait_evade_medium_shadowraze_front",
        cancel_condition = "cancel_evade_medium_shadowraze_front",
        actions = {
          {action = "move_front"},

        },
      },
      {
        move = "evade_far_shadowraze_front",
        wait_condition = "wait_evade_far_shadowraze_front",
        cancel_condition = "cancel_evade_far_shadowraze_front",
        actions = {
          {action = "move_front"},

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
    objective = "prepare_for_match",
    module = require(GetScriptDirectory() .."/utility/prepare_for_match"),
    moves = {
      {
        move = "buy_starting_items",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "buy_starting_items"},

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
        move = "swap_mango_for_recovery",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_mango_for_recovery"},

        },
      },
      {
        move = "swap_ward_for_using",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_ward_for_using"},

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
        move = "swap_mango_to_backpack",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_mango_to_backpack"},

        },
      },
    },
  },

  {
    objective = "item_hp_recovery",
    module = require(GetScriptDirectory() .."/utility/item_hp_recovery"),
    moves = {
      {
        move = "heal_faerie_fire",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "heal_faerie_fire"},

        },
      },
    },
  },

  {
    objective = "item_mp_recovery",
    module = require(GetScriptDirectory() .."/utility/item_mp_recovery"),
    moves = {
      {
        move = "use_enchanted_mango",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_enchanted_mango"},

        },
      },
      {
        move = "use_enchanted_mango_with_cyclone",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_enchanted_mango"},

        },
      },
    },
  },

  {
    objective = "nuke_enemy_hero",
    module = require(GetScriptDirectory() .."/utility/nuke_enemy_hero"),
    moves = {
      {
        move = "turn_near_shadowraze",
        wait_condition = "wait_turn_near_shadowraze",
        cancel_condition = "cancel_turn_near_shadowraze",
        actions = {
          {action = "turn_via_attack"},

        },
      },
      {
        move = "near_shadowraze",
        wait_condition = "nil",
        cancel_condition = "cancel_near_shadowraze",
        actions = {
          {action = "near_shadowraze"},

        },
      },
      {
        move = "turn_medium_shadowraze",
        wait_condition = "nil",
        cancel_condition = "cancel_turn_medium_shadowraze",
        actions = {
          {action = "turn"},

        },
      },
      {
        move = "medium_shadowraze",
        wait_condition = "nil",
        cancel_condition = "cancel_medium_shadowraze",
        actions = {
          {action = "medium_shadowraze"},

        },
      },
      {
        move = "turn_far_shadowraze",
        wait_condition = "nil",
        cancel_condition = "cancel_turn_far_shadowraze",
        actions = {
          {action = "turn"},

        },
      },
      {
        move = "far_shadowraze",
        wait_condition = "nil",
        cancel_condition = "cancel_far_shadowraze",
        actions = {
          {action = "far_shadowraze"},

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
        move = "evade_enemy_hero_low_hp",
        wait_condition = "wait_evade_enemy_hero_low_hp",
        cancel_condition = "cancel_evade_enemy_hero_low_hp",
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
    objective = "upgrade_skills",
    module = require(GetScriptDirectory() .."/utility/upgrade_skills"),
    moves = {
      {
        move = "upgrade",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "upgrade"},

        },
      },
    },
  },

  {
    objective = "farm",
    module = require(GetScriptDirectory() .."/utility/farm"),
    moves = {
      {
        move = "lasthit_enemy_creep",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "lasthit_enemy_creep"},

        },
      },
      {
        move = "deny_ally_creep",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "deny_ally_creep"},

        },
      },
    },
  },

  {
    objective = "evasion",
    module = require(GetScriptDirectory() .."/utility/evasion"),
    moves = {
      {
        move = "evade_enemy_creeps",
        wait_condition = "wait_evade_enemy_creeps",
        cancel_condition = "cancel_evade_enemy_creeps",
        actions = {
          {action = "move_safe_spot"},

        },
      },
    },
  },

  {
    objective = "kite",
    module = require(GetScriptDirectory() .."/utility/kite"),
    moves = {
      {
        move = "attack_enemy_hero",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_enemy_hero"},

        },
      },
      {
        move = "attack_enemy_tower",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_enemy_tower"},

        },
      },
      {
        move = "move_safe",
        wait_condition = "nil",
        cancel_condition = "cancel_move_safe",
        actions = {
          {action = "move_safe"},

        },
      },
    },
  },

  {
    objective = "evasion",
    module = require(GetScriptDirectory() .."/utility/evasion"),
    moves = {
      {
        move = "evade_enemy_hero",
        wait_condition = "wait_evade_enemy_hero",
        cancel_condition = "cancel_evade_enemy_hero",
        actions = {
          {action = "move_safe_spot"},

        },
      },
    },
  },

  {
    objective = "push_lane",
    module = require(GetScriptDirectory() .."/utility/push_lane"),
    moves = {
      {
        move = "attack_enemy_creep",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_enemy_creep"},

        },
      },
      {
        move = "kill_enemy_creep",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "kill_enemy_creep"},

        },
      },
      {
        move = "attack_enemy_tower",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_enemy_tower"},

        },
      },
    },
  },

  {
    objective = "aggro_control",
    module = require(GetScriptDirectory() .."/utility/aggro_control"),
    moves = {
      {
        move = "aggro_last_hit",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "aggro_last_hit"},
          {action = "stop_attack"},

        },
      },
      {
        move = "aggro_hg",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "aggro_hg"},
          {action = "stop_attack"},

        },
      },
    },
  },

  {
    objective = "positioning",
    module = require(GetScriptDirectory() .."/utility/positioning"),
    moves = {
      {
        move = "tp_mid_tower",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "tp_mid_tower"},

        },
      },
      {
        move = "increase_creeps_distance_aggro",
        wait_condition = "nil",
        cancel_condition = "cancel_increase_creeps_distance_aggro",
        actions = {
          {action = "increase_creeps_distance_aggro"},

        },
      },
      {
        move = "decrease_creeps_distance_aggro",
        wait_condition = "nil",
        cancel_condition = "cancel_decrease_creeps_distance_aggro",
        actions = {
          {action = "decrease_creeps_distance_aggro"},

        },
      },
      {
        move = "increase_creeps_distance",
        wait_condition = "nil",
        cancel_condition = "cancel_increase_creeps_distance",
        actions = {
          {action = "increase_creeps_distance"},

        },
      },
      {
        move = "decrease_creeps_distance_base",
        wait_condition = "nil",
        cancel_condition = "cancel_decrease_creeps_distance_base",
        actions = {
          {action = "decrease_creeps_distance_base"},

        },
      },
      {
        move = "turn",
        wait_condition = "nil",
        cancel_condition = "cancel_turn",
        actions = {
          {action = "turn"},

        },
      },
    },
  },

  {
    objective = "keep_equilibrium",
    module = require(GetScriptDirectory() .."/utility/keep_equilibrium"),
    moves = {
      {
        move = "attack_enemy_creep",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_enemy_creep"},

        },
      },
      {
        move = "attack_ally_creep",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_ally_creep"},

        },
      },
    },
  },

  {
    objective = "warding",
    module = require(GetScriptDirectory() .."/utility/warding"),
    moves = {
      {
        move = "plant_ward",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "plant_ward"},

        },
      },
    },
  },

  {
    objective = "body_block",
    module = require(GetScriptDirectory() .."/utility/body_block"),
    moves = {
      {
        move = "move_and_block",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_and_block"},
          {action = "stop_attack_and_move"},

        },
      },
      {
        move = "move_start_position",
        wait_condition = "wait_move_start_position",
        cancel_condition = "cancel_move_start_position",
        actions = {
          {action = "move_start_position"},

        },
      },
      {
        move = "turn_enemy_fountain",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "turn_enemy_fountain"},
          {action = "stop_turn"},

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
