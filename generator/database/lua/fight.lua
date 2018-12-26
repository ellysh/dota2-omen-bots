
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
    objective = "item_defense",
    module = require(GetScriptDirectory() .."/utility/item_defense"),
    moves = {
      {
        move = "use_hood_vs_near_shadowraze",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_hood"},

        },
      },
      {
        move = "use_hood_vs_medium_shadowraze",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_hood"},

        },
      },
      {
        move = "use_hood_vs_far_shadowraze",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_hood"},

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
      {
        move = "heal_magic_stick",
        wait_condition = "nil",
        cancel_condition = "nil",
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
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "use_enchanted_mango"},

        },
      },
      {
        move = "use_magic_stick",
        wait_condition = "nil",
        cancel_condition = "nil",
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
          {action = "turn_via_attack"},

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
          {action = "turn_via_attack"},

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
    objective = "close_fight",
    module = require(GetScriptDirectory() .."/utility/close_fight"),
    moves = {
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
        move = "move_enemy_hero",
        wait_condition = "nil",
        cancel_condition = "nil",
        actions = {
          {action = "move_enemy_hero"},

        },
      },
    },
  },

}

return M
