
local M = {}

M.OBJECTIVES = {

  {
    strategy = "buy",
    objectives = {
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
        move = "buy_boots_of_elves",
        actions = {
          {action = "buy_boots_of_elves"},

        },
      },
      {
        move = "buy_blades_of_attack",
        actions = {
          {action = "buy_blades_of_attack"},

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


    },
  },

  {
    strategy = "recovery",
    objectives = {
  {
    objective = "buyback",
    module = require(GetScriptDirectory() .."/utility/buyback"),
    moves = {
      {
        move = "do_buyback",
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
        actions = {
          {action = "put_item_in_inventory"},

        },
      },
      {
        move = "swap_flask_wraith_band",
        actions = {
          {action = "swap_flask_wraith_band"},

        },
      },
      {
        move = "swap_mango_wraith_band",
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
        actions = {
          {action = "heal_tango"},

        },
      },
      {
        move = "heal_flask",
        actions = {
          {action = "heal_flask"},

        },
      },
      {
        move = "heal_faerie_fire",
        actions = {
          {action = "heal_faerie_fire"},

        },
      },
      {
        move = "heal_magic_stick",
        actions = {
          {action = "heal_magic_stick"},

        },
      },
      {
        move = "tp_base",
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
        actions = {
          {action = "deliver_items"},

        },
      },
      {
        move = "restore_hp_on_base",
        actions = {
          {action = "restore_hp_on_base"},

        },
      },
      {
        move = "restore_mp_on_base",
        actions = {
          {action = "restore_mp_on_base"},

        },
      },
      {
        move = "move_base",
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
        actions = {
          {action = "move_safe_recovery"},

        },
      },
      {
        move = "evade_enemy_hero",
        actions = {
          {action = "evade_enemy_hero"},

        },
      },
      {
        move = "evade_enemy_creeps",
        actions = {
          {action = "evade_enemy_creeps"},

        },
      },
      {
        move = "evade_enemy_tower",
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
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },


    },
  },

  {
    strategy = "defensive",
    objectives = {
  {
    objective = "cancel_current_move",
    module = require(GetScriptDirectory() .."/utility/cancel_current_move"),
    moves = {
      {
        move = "stop_attack_and_move",
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },

  {
    objective = "manage_attack_anim",
    module = require(GetScriptDirectory() .."/utility/manage_attack_anim"),
    moves = {
      {
        move = "cancel_attack",
        actions = {
          {action = "cancel_attack"},

        },
      },
      {
        move = "wait_attack",
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
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_far_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_front",
        actions = {
          {action = "move_front"},

        },
      },
      {
        move = "evade_far_shadowraze_front",
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
        actions = {
          {action = "put_item_in_inventory"},

        },
      },
      {
        move = "swap_flask_wraith_band",
        actions = {
          {action = "swap_flask_wraith_band"},

        },
      },
      {
        move = "swap_mango_wraith_band",
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
        actions = {
          {action = "heal_tango"},

        },
      },
      {
        move = "heal_magic_stick",
        actions = {
          {action = "heal_magic_stick"},

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
        actions = {
          {action = "use_enchanted_mango"},

        },
      },
      {
        move = "use_magic_stick",
        actions = {
          {action = "use_magic_stick"},

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
        actions = {
          {action = "upgrade"},

        },
      },
    },
  },

  {
    objective = "nuke_enemy_hero",
    module = require(GetScriptDirectory() .."/utility/nuke_enemy_hero"),
    moves = {
      {
        move = "turn",
        actions = {
          {action = "turn"},

        },
      },
      {
        move = "near_shadowraze",
        actions = {
          {action = "near_shadowraze"},

        },
      },
      {
        move = "medium_shadowraze",
        actions = {
          {action = "medium_shadowraze"},

        },
      },
      {
        move = "far_shadowraze",
        actions = {
          {action = "far_shadowraze"},

        },
      },
    },
  },

  {
    objective = "defend_tower",
    module = require(GetScriptDirectory() .."/utility/defend_tower"),
    moves = {
      {
        move = "attack_enemy_hero",
        actions = {
          {action = "attack_enemy_hero"},

        },
      },
      {
        move = "move_enemy_creep",
        actions = {
          {action = "move_enemy_creep"},

        },
      },
      {
        move = "pull_enemy_creep",
        actions = {
          {action = "pull_enemy_creep"},

        },
      },
      {
        move = "move_safe",
        actions = {
          {action = "move_safe"},

        },
      },
      {
        move = "kill_enemy_creep",
        actions = {
          {action = "kill_enemy_creep"},

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
        actions = {
          {action = "move_safe_recovery"},

        },
      },
      {
        move = "evade_enemy_hero",
        actions = {
          {action = "evade_enemy_hero"},

        },
      },
      {
        move = "evade_enemy_tower",
        actions = {
          {action = "evade_enemy_tower"},

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
        actions = {
          {action = "lasthit_enemy_creep"},

        },
      },
      {
        move = "deny_ally_creep",
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
        actions = {
          {action = "evade_enemy_creeps"},

        },
      },
    },
  },

  {
    objective = "attack_with_better_position",
    module = require(GetScriptDirectory() .."/utility/attack_with_better_position"),
    moves = {
      {
        move = "attack_enemy_hero_from_hg",
        actions = {
          {action = "attack_enemy_hero_from_hg"},

        },
      },
      {
        move = "attack_enemy_hero_with_incoming_damage",
        actions = {
          {action = "attack_enemy_hero_with_incoming_damage"},

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
        actions = {
          {action = "attack_enemy_hero"},

        },
      },
      {
        move = "attack_enemy_tower",
        actions = {
          {action = "attack_enemy_tower"},

        },
      },
      {
        move = "move_safe",
        actions = {
          {action = "move_safe"},

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
        actions = {
          {action = "attack_enemy_creep"},

        },
      },
      {
        move = "kill_enemy_creep",
        actions = {
          {action = "kill_enemy_creep"},

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
        actions = {
          {action = "aggro_last_hit"},
          {action = "stop_attack"},

        },
      },
      {
        move = "aggro_hg",
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
        actions = {
          {action = "tp_mid_tower"},

        },
      },
      {
        move = "decrease_creeps_distance_aggro",
        actions = {
          {action = "decrease_creeps_distance_aggro"},

        },
      },
      {
        move = "increase_creeps_distance",
        actions = {
          {action = "increase_creeps_distance"},

        },
      },
      {
        move = "decrease_creeps_distance_base",
        actions = {
          {action = "decrease_creeps_distance_base"},

        },
      },
      {
        move = "turn",
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
        actions = {
          {action = "attack_enemy_creep"},

        },
      },
      {
        move = "attack_ally_creep",
        actions = {
          {action = "attack_ally_creep"},

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
        actions = {
          {action = "move_and_block"},
          {action = "stop_attack_and_move"},

        },
      },
      {
        move = "move_start_position",
        actions = {
          {action = "move_start_position"},

        },
      },
      {
        move = "turn_enemy_fountain",
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
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },


    },
  },

  {
    strategy = "offensive",
    objectives = {
  {
    objective = "cancel_current_move",
    module = require(GetScriptDirectory() .."/utility/cancel_current_move"),
    moves = {
      {
        move = "stop_attack_and_move",
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },

  {
    objective = "manage_attack_anim",
    module = require(GetScriptDirectory() .."/utility/manage_attack_anim"),
    moves = {
      {
        move = "cancel_attack",
        actions = {
          {action = "cancel_attack"},

        },
      },
      {
        move = "wait_attack",
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
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_far_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_front",
        actions = {
          {action = "move_front"},

        },
      },
      {
        move = "evade_far_shadowraze_front",
        actions = {
          {action = "move_front"},

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
        actions = {
          {action = "put_item_in_inventory"},

        },
      },
      {
        move = "swap_flask_wraith_band",
        actions = {
          {action = "swap_flask_wraith_band"},

        },
      },
      {
        move = "swap_mango_wraith_band",
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
        actions = {
          {action = "heal_tango"},

        },
      },
      {
        move = "heal_magic_stick",
        actions = {
          {action = "heal_magic_stick"},

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
        actions = {
          {action = "use_enchanted_mango"},

        },
      },
      {
        move = "use_magic_stick",
        actions = {
          {action = "use_magic_stick"},

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
        actions = {
          {action = "upgrade"},

        },
      },
    },
  },

  {
    objective = "nuke_enemy_hero",
    module = require(GetScriptDirectory() .."/utility/nuke_enemy_hero"),
    moves = {
      {
        move = "turn",
        actions = {
          {action = "turn"},

        },
      },
      {
        move = "near_shadowraze",
        actions = {
          {action = "near_shadowraze"},

        },
      },
      {
        move = "medium_shadowraze",
        actions = {
          {action = "medium_shadowraze"},

        },
      },
      {
        move = "far_shadowraze",
        actions = {
          {action = "far_shadowraze"},

        },
      },
    },
  },

  {
    objective = "pursuit_enemy_hero",
    module = require(GetScriptDirectory() .."/utility/pursuit_enemy_hero"),
    moves = {
      {
        move = "attack_enemy_hero",
        actions = {
          {action = "attack_enemy_hero"},

        },
      },
      {
        move = "move_enemy_hero",
        actions = {
          {action = "move_enemy_hero"},

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
        actions = {
          {action = "move_safe_recovery"},

        },
      },
      {
        move = "evade_enemy_hero",
        actions = {
          {action = "evade_enemy_hero"},

        },
      },
      {
        move = "evade_enemy_tower",
        actions = {
          {action = "evade_enemy_tower"},

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
        actions = {
          {action = "lasthit_enemy_creep"},

        },
      },
      {
        move = "deny_ally_creep",
        actions = {
          {action = "deny_ally_creep"},

        },
      },
    },
  },

  {
    objective = "push_lane",
    module = require(GetScriptDirectory() .."/utility/push_lane"),
    moves = {
      {
        move = "destroy_enemy_tower",
        actions = {
          {action = "destroy_enemy_tower"},

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
        actions = {
          {action = "evade_enemy_creeps"},

        },
      },
    },
  },

  {
    objective = "attack_with_better_position",
    module = require(GetScriptDirectory() .."/utility/attack_with_better_position"),
    moves = {
      {
        move = "attack_enemy_hero_from_hg",
        actions = {
          {action = "attack_enemy_hero_from_hg"},

        },
      },
      {
        move = "attack_enemy_hero_with_incoming_damage",
        actions = {
          {action = "attack_enemy_hero_with_incoming_damage"},

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
        actions = {
          {action = "attack_enemy_hero"},

        },
      },
      {
        move = "attack_enemy_tower",
        actions = {
          {action = "attack_enemy_tower"},

        },
      },
      {
        move = "move_safe",
        actions = {
          {action = "move_safe"},

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
        actions = {
          {action = "attack_enemy_creep"},

        },
      },
      {
        move = "kill_enemy_creep",
        actions = {
          {action = "kill_enemy_creep"},

        },
      },
      {
        move = "attack_enemy_tower",
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
        actions = {
          {action = "aggro_last_hit"},
          {action = "stop_attack"},

        },
      },
      {
        move = "aggro_hg",
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
        actions = {
          {action = "tp_mid_tower"},

        },
      },
      {
        move = "decrease_creeps_distance_aggro",
        actions = {
          {action = "decrease_creeps_distance_aggro"},

        },
      },
      {
        move = "increase_creeps_distance",
        actions = {
          {action = "increase_creeps_distance"},

        },
      },
      {
        move = "decrease_creeps_distance_base",
        actions = {
          {action = "decrease_creeps_distance_base"},

        },
      },
      {
        move = "turn",
        actions = {
          {action = "turn"},

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
        actions = {
          {action = "move_and_block"},
          {action = "stop_attack_and_move"},

        },
      },
      {
        move = "move_start_position",
        actions = {
          {action = "move_start_position"},

        },
      },
      {
        move = "turn_enemy_fountain",
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
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },


    },
  },

  {
    strategy = "farm",
    objectives = {
  {
    objective = "cancel_current_move",
    module = require(GetScriptDirectory() .."/utility/cancel_current_move"),
    moves = {
      {
        move = "stop_attack_and_move",
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },

  {
    objective = "manage_attack_anim",
    module = require(GetScriptDirectory() .."/utility/manage_attack_anim"),
    moves = {
      {
        move = "cancel_attack",
        actions = {
          {action = "cancel_attack"},

        },
      },
      {
        move = "wait_attack",
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
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_far_shadowraze_back",
        actions = {
          {action = "move_back"},

        },
      },
      {
        move = "evade_medium_shadowraze_front",
        actions = {
          {action = "move_front"},

        },
      },
      {
        move = "evade_far_shadowraze_front",
        actions = {
          {action = "move_front"},

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
        actions = {
          {action = "put_item_in_inventory"},

        },
      },
      {
        move = "swap_flask_wraith_band",
        actions = {
          {action = "swap_flask_wraith_band"},

        },
      },
      {
        move = "swap_mango_wraith_band",
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
        actions = {
          {action = "heal_tango"},

        },
      },
      {
        move = "heal_magic_stick",
        actions = {
          {action = "heal_magic_stick"},

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
        actions = {
          {action = "use_enchanted_mango"},

        },
      },
      {
        move = "use_magic_stick",
        actions = {
          {action = "use_magic_stick"},

        },
      },
    },
  },

  {
    objective = "nuke_enemy_hero",
    module = require(GetScriptDirectory() .."/utility/nuke_enemy_hero"),
    moves = {
      {
        move = "turn",
        actions = {
          {action = "turn"},

        },
      },
      {
        move = "near_shadowraze",
        actions = {
          {action = "near_shadowraze"},

        },
      },
      {
        move = "medium_shadowraze",
        actions = {
          {action = "medium_shadowraze"},

        },
      },
      {
        move = "far_shadowraze",
        actions = {
          {action = "far_shadowraze"},

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
        actions = {
          {action = "move_safe_recovery"},

        },
      },
      {
        move = "evade_enemy_hero",
        actions = {
          {action = "evade_enemy_hero"},

        },
      },
      {
        move = "evade_enemy_tower",
        actions = {
          {action = "evade_enemy_tower"},

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
        actions = {
          {action = "lasthit_enemy_creep"},

        },
      },
      {
        move = "deny_ally_creep",
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
        actions = {
          {action = "evade_enemy_creeps"},

        },
      },
    },
  },

  {
    objective = "attack_with_better_position",
    module = require(GetScriptDirectory() .."/utility/attack_with_better_position"),
    moves = {
      {
        move = "attack_enemy_hero_from_hg",
        actions = {
          {action = "attack_enemy_hero_from_hg"},

        },
      },
      {
        move = "attack_enemy_hero_with_incoming_damage",
        actions = {
          {action = "attack_enemy_hero_with_incoming_damage"},

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
        actions = {
          {action = "attack_enemy_hero"},

        },
      },
      {
        move = "attack_enemy_tower",
        actions = {
          {action = "attack_enemy_tower"},

        },
      },
      {
        move = "move_safe",
        actions = {
          {action = "move_safe"},

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
        actions = {
          {action = "aggro_last_hit"},
          {action = "stop_attack"},

        },
      },
      {
        move = "aggro_hg",
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
        actions = {
          {action = "tp_mid_tower"},

        },
      },
      {
        move = "decrease_creeps_distance_aggro",
        actions = {
          {action = "decrease_creeps_distance_aggro"},

        },
      },
      {
        move = "increase_creeps_distance",
        actions = {
          {action = "increase_creeps_distance"},

        },
      },
      {
        move = "decrease_creeps_distance_base",
        actions = {
          {action = "decrease_creeps_distance_base"},

        },
      },
      {
        move = "turn",
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
        actions = {
          {action = "attack_enemy_creep"},

        },
      },
      {
        move = "attack_ally_creep",
        actions = {
          {action = "attack_ally_creep"},

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
        actions = {
          {action = "move_and_block"},
          {action = "stop_attack_and_move"},

        },
      },
      {
        move = "move_start_position",
        actions = {
          {action = "move_start_position"},

        },
      },
      {
        move = "turn_enemy_fountain",
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
        actions = {
          {action = "stop_attack_and_move"},

        },
      },
    },
  },


    },
  },

}

return M
