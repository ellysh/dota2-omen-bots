
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

}

return M
