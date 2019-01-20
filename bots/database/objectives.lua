
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


    },
  },

  {
    strategy = "combo",
    objectives = {
  {
    objective = "blink_attack",
    module = require(GetScriptDirectory() .."/utility/blink_attack"),
    moves = {
      {
        move = "blink",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "blink"},

        },
      },
      {
        move = "use_gust",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_gust"},

        },
      },
    },
  },


    },
  },

  {
    strategy = "fight",
    objectives = {
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
    objective = "close_fight",
    module = require(GetScriptDirectory() .."/utility/close_fight"),
    moves = {
      {
        move = "use_pike",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_pike"},

        },
      },
      {
        move = "attack_enemy_hero_with_pike",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_enemy_hero_with_pike"},

        },
      },
      {
        move = "kill_enemy_hero",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "kill_enemy_hero"},

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
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "attack_enemy_hero"},

        },
      },
      {
        move = "move_enemy_hero_with_force_staff",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_enemy_hero_with_force_staff"},

        },
      },
      {
        move = "move_enemy_hero_with_pike",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_enemy_hero_with_pike"},

        },
      },
      {
        move = "move_enemy_hero",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_enemy_hero"},

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
        move = "swap_flask_for_recovery",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "swap_flask_for_recovery"},

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
    objective = "evasion",
    module = require(GetScriptDirectory() .."/utility/evasion"),
    moves = {
      {
        move = "evade_enemy_hero_with_force_staff",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "evade_enemy_hero_with_force_staff"},

        },
      },
      {
        move = "evade_enemy_hero_with_pike",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "evade_enemy_hero_with_pike"},

        },
      },
      {
        move = "use_gust",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_gust"},

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


    },
  },

  {
    strategy = "assault_enemy_tower",
    objectives = {
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
    },
  },

  {
    objective = "push_lane",
    module = require(GetScriptDirectory() .."/utility/push_lane"),
    moves = {
      {
        move = "destroy_enemy_tower",
        wait_condition = "nil",
        cancel_condition = "nil",
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
    },
  },

  {
    objective = "push_lane",
    module = require(GetScriptDirectory() .."/utility/push_lane"),
    moves = {
      {
        move = "use_precision_aura",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_precision_aura"},

        },
      },
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
    objective = "positioning",
    module = require(GetScriptDirectory() .."/utility/positioning"),
    moves = {
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


    },
  },

  {
    strategy = "farm",
    objectives = {
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
        move = "use_precision_aura",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_precision_aura"},

        },
      },
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


    },
  },

}

return M
