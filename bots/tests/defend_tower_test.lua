package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local defend_tower = require("defend_tower")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_pull_enemy_creep_1_succeed()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertTrue(defend_tower.pre_pull_enemy_creep())
end

function test_pre_pull_enemy_creep_1_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_pull_enemy_creep())
end

function test_pre_pull_enemy_creep_2_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_pull_enemy_creep())
end

function test_pre_pull_enemy_creep_3_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_pull_enemy_creep())
end

function test_pre_pull_enemy_creep_4_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_pull_enemy_creep())
end

function test_pre_pull_enemy_creep_5_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_pull_enemy_creep())
end

function test_pre_pull_enemy_creep_6_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_pull_enemy_creep())
end

function test_pre_pull_enemy_creep_7_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
  })

  luaunit.assertFalse(defend_tower.pre_pull_enemy_creep())
end

---------------------------------

function test_pre_move_enemy_creep_1_succeed()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertTrue(defend_tower.pre_move_enemy_creep())
end

function test_pre_move_enemy_creep_1_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_enemy_creep())
end

function test_pre_move_enemy_creep_2_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_enemy_creep())
end

function test_pre_move_enemy_creep_3_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_enemy_creep())
end

function test_pre_move_enemy_creep_4_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 0,
  })

  luaunit.assertFalse(defend_tower.pre_move_enemy_creep())
end

function test_pre_move_enemy_creep_5_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_enemy_creep())
end

function test_pre_move_enemy_creep_6_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 1,
    [gs.EC_AGGRO_COOLDOWN] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_enemy_creep())
end

function test_pre_move_enemy_creep_7_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.EH_IS_VISIBLE] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_ATTACKING_TOWER_IN_AGGRO_RADIUS] = 0,
    [gs.EC_AGGRO_COOLDOWN] = 1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.BOT_HAS_LEVEL_FOR_AGRESSION] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_enemy_creep())
end

---------------------------------

function test_pre_move_safe_1_succeed()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.EC_ATTACKING_BOT_PRESENT] = 1,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 0,
  })

  luaunit.assertTrue(defend_tower.pre_move_safe())
end

function test_pre_move_safe_2_succeed()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.EC_ATTACKING_BOT_PRESENT] = 1,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 0,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 1,
  })

  luaunit.assertTrue(defend_tower.pre_move_safe())
end

function test_pre_move_safe_3_succeed()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.EC_ATTACKING_BOT_PRESENT] = 1,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 1,
  })

  luaunit.assertTrue(defend_tower.pre_move_safe())
end

function test_pre_move_safe_1_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0,
    [gs.EC_ATTACKING_BOT_PRESENT] = 1,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(defend_tower.pre_move_safe())
end

function test_pre_move_safe_2_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.EC_ATTACKING_BOT_PRESENT] = 0,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 0,
  })

  luaunit.assertFalse(defend_tower.pre_move_safe())
end

function test_pre_move_safe_3_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.EC_ATTACKING_BOT_PRESENT] = 0,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_safe())
end

function test_pre_move_safe_4_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 0,
    [gs.EC_ATTACKING_BOT_PRESENT] = 1,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_safe())
end

function test_pre_move_safe_5_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 1,
    [gs.AC_FRONT_PRESENT] = 0,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.EC_ATTACKING_BOT_PRESENT] = 1,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_safe())
end

function test_pre_move_safe_6_fails()
  defend_tower.test_SetGameState({
    [gs.EC_ATTACKING_TOWER_PRESENT] = 0,
    [gs.AC_FRONT_PRESENT] = 1,
    [gs.EC_HAVE_HP_ADVANTAGE] = 1,
    [gs.EC_ATTACKING_BOT_PRESENT] = 1,
    [gs.EC_ATTACKING_BOT_BETWEEN_AT] = 1,
    [gs.EC_ATTACKING_BOT_IN_AT_ATTACK_RANGE] = 1,
  })

  luaunit.assertFalse(defend_tower.pre_move_safe())
end

os.exit(luaunit.LuaUnit.run())
