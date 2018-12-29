package.path = package.path .. ";../utility/?.lua"

pcall(require, "luacov")
require("global_functions")

local cyclone_and_requiem = require("cyclone_and_requiem")
local gs = require("game_state")
local luaunit = require("luaunit")

---------------------------------

function test_pre_cyclone_and_requiem_1_succeed()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_HAS_MP_FOR_CYCLONE_AND_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.BOT_CASTABLE_REQUIEM] = 1,

    -- M.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertTrue(cyclone_and_requiem.pre_cyclone_and_requiem())
end

function test_pre_cyclone_and_requiem_1_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_HAS_MP_FOR_CYCLONE_AND_REQUIEM] = 0,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.BOT_CASTABLE_REQUIEM] = 1,

    -- M.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_cyclone_and_requiem())
end

function test_pre_cyclone_and_requiem_2_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_HAS_MP_FOR_CYCLONE_AND_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 0,
    [gs.BOT_CASTABLE_REQUIEM] = 1,

    -- M.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_cyclone_and_requiem())
end

function test_pre_cyclone_and_requiem_3_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_HAS_MP_FOR_CYCLONE_AND_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.BOT_CASTABLE_REQUIEM] = 0,

    -- M.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 0,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_cyclone_and_requiem())
end

function test_pre_cyclone_and_requiem_4_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_HAS_MP_FOR_CYCLONE_AND_REQUIEM] = 1,
    [gs.BOT_HAS_MAX_SOULS] = 1,
    [gs.BOT_CASTABLE_REQUIEM] = 1,

    -- M.pre_attack_objective
    [gs.BOT_IS_ALIVE] = 1,
    [gs.BOT_IS_LOW_HP] = 1,
    [gs.BOT_IS_CASTING] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_cyclone_and_requiem())
end

---------------------------------

function test_pre_cyclone_1_succeed()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_CYCLONE] = 1,
    [gs.EH_IN_CYCLONE_RANGE] = 1,
  })

  luaunit.assertTrue(cyclone_and_requiem.pre_cyclone())
end

function test_pre_cyclone_1_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 0,
    [gs.BOT_CASTABLE_CYCLONE] = 1,
    [gs.EH_IN_CYCLONE_RANGE] = 1,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_cyclone())
end

function test_pre_cyclone_2_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_CYCLONE] = 0,
    [gs.EH_IN_CYCLONE_RANGE] = 1,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_cyclone())
end

function test_pre_cyclone_3_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_IS_VISIBLE] = 1,
    [gs.BOT_CASTABLE_CYCLONE] = 1,
    [gs.EH_IN_CYCLONE_RANGE] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_cyclone())
end

---------------------------------

function test_pre_move_enemy_hero_location_1_succeed()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_HAS_CYCLONE_MODIFIER] = 1,
    [gs.BOT_CASTABLE_REQUIEM] = 1,
    [gs.BOT_IN_EH_LOCATION] = 0,
  })

  luaunit.assertTrue(cyclone_and_requiem.pre_move_enemy_hero_location())
end

function test_pre_move_enemy_hero_location_1_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_HAS_CYCLONE_MODIFIER] = 0,
    [gs.BOT_CASTABLE_REQUIEM] = 1,
    [gs.BOT_IN_EH_LOCATION] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_move_enemy_hero_location())
end

function test_pre_move_enemy_hero_location_2_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_HAS_CYCLONE_MODIFIER] = 1,
    [gs.BOT_CASTABLE_REQUIEM] = 0,
    [gs.BOT_IN_EH_LOCATION] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_move_enemy_hero_location())
end

function test_pre_move_enemy_hero_location_3_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.EH_HAS_CYCLONE_MODIFIER] = 1,
    [gs.BOT_CASTABLE_REQUIEM] = 1,
    [gs.BOT_IN_EH_LOCATION] = 1,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_move_enemy_hero_location())
end

---------------------------------

function test_pre_requiem_1_succeed()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_CASTABLE_REQUIEM] = 1,
    [gs.BOT_IN_EH_LOCATION] = 1,
  })

  luaunit.assertTrue(cyclone_and_requiem.pre_requiem())
end

function test_pre_requiem_1_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_CASTABLE_REQUIEM] = 0,
    [gs.BOT_IN_EH_LOCATION] = 1,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_requiem())
end

function test_pre_requiem_2_fails()
  cyclone_and_requiem.test_SetGameState({
    [gs.BOT_CASTABLE_REQUIEM] = 1,
    [gs.BOT_IN_EH_LOCATION] = 0,
  })

  luaunit.assertFalse(cyclone_and_requiem.pre_requiem())
end

os.exit(luaunit.LuaUnit.run())
