
local M = {}

M.MAP = {
  [TEAM_RADIANT] = {
    tower_tier_1_attack = Vector(-1532, -1409, 800),
    tower_tier_1_day_vision = Vector(-1532, -1409, 1900),
    tower_tier_1_night_vision = Vector(-1532, -1409, 800),
    high_ground = Vector(-1072, -913, 350),
    fountain = Vector(-7000, -6500, 500),
    tp_tower_tier_1 = Vector(-1181, -1741, 100),
    first_body_block = Vector(-3709, -3307, 100),
    second_body_block = Vector(-1478, -1274, 100),
    tower_tier_1_rear_deep = Vector(-4115, -3637, 1734),
    between_tier_1_tear_2 = Vector(-2562, -2062, 1030),
    river = Vector(-598, -472, 260),

    -- Farm spots

    high_ground_farm_bot = Vector(-600, -1150, 100),
    high_ground_farm_top = Vector(-1300, -450, 100),
    forest_farm_bot = Vector(-1071, -1287, 100),
    forest_farm_top = Vector(-1664, -1000, 100),

    -- Safe spots

    tier1_front = Vector(-1415, -1192, 100),
    tier1_back = Vector(-1862, -1616, 100),
    tier2_front = Vector(-2944, -2595, 100),
    tier2_back = Vector(-3485, -3098, 100),
    tier3_front = Vector(-4405, -3969, 100),
    tier3_back = Vector(-4823, -4356, 100),

    forest_top_1 = Vector(-2075, -898, 100),
    forest_top_2 = Vector(-2457, -1303, 100),
    forest_top_3 = Vector(-2935, -1605, 100),
    forest_top_4 = Vector(-3541, -2175, 100),
    forest_top_5 = Vector(-4105, -2632, 100),

    forest_bot_1 = Vector(-1150, -1730, 100),
    forest_bot_2 = Vector(-1606, -2003, 100),
    forest_bot_3 = Vector(-1701, -2784, 100),
    forest_bot_4 = Vector(-2102, -2967, 100),
    forest_bot_5 = Vector(-2552, -2656, 100),
    forest_bot_6 = Vector(-3049, -3852, 100),

    forest_enemy_top_1 = Vector(988, 2274, 100),
    forest_enemy_top_2 = Vector(-208, 1814, 100),

    forest_enemy_bot_1 = Vector(1732, 563, 100),
    forest_enemy_bot_2 = Vector(1462, -479, 100),

    river_top_1 = Vector(-997, 1312, 100),
    river_top_2 = Vector(-1988, 478, 100),
  },

  [TEAM_DIRE] = {
    tower_tier_1_attack = Vector(524, 652, 800),
    tower_tier_1_day_vision = Vector(524, 652, 1900),
    tower_tier_1_night_vision = Vector(524, 652, 800),
    high_ground = Vector(62, 99, 350),
    fountain = Vector(6950, 6300, 500),
    tp_tower_tier_1 = Vector(530, 1138, 100),
    first_body_block = Vector(3357, 2878, 100),
    second_body_block = Vector(573, 463, 100),
    tower_tier_1_rear_deep = Vector(3654, 3017, 1971),
    between_tier_1_tear_2 = Vector(1606, 1236, 1040),
    river = Vector(-437, -313, 250),

    -- Farm spots

    high_ground_farm_bot = Vector(350, -220, 100),
    high_ground_farm_top = Vector(-400, 470, 100),
    forest_farm_bot = Vector(814, 217, 100),
    forest_farm_top = Vector(218, 928, 100),

    -- Safe spots
    tier1_front = Vector(465, 383, 100),
    tier1_back = Vector(1040, 815, 100),
    tier2_front = Vector(2263, 1830, 100),
    tier2_back = Vector(2856, 2397, 100),
    tier3_front = Vector(4070, 3575, 100),
    tier3_back = Vector(4532, 4019, 100),

    forest_top_1 = Vector(563, 1145, 100),
    forest_top_2 = Vector(1069, 1149, 100),
    forest_top_3 = Vector(1735, 2272, 100),
    forest_top_4 = Vector(2175, 3056, 100),
    forest_top_5 = Vector(2730, 3552, 100),

    forest_bot_1 = Vector(1283, 388, 100),
    forest_bot_2 = Vector(1993, 580, 100),
    forest_bot_3 = Vector(2435, 1212, 100),
    forest_bot_4 = Vector(3095, 1487, 100),
    forest_bot_5 = Vector(3698, 2079, 100),
    forest_bot_6 = Vector(3698, 2079, 100),

    forest_enemy_top_1 = Vector(-3313, -1305, 100),
    forest_enemy_top_2 = Vector(2875, 331, 100),

    forest_enemy_bot_1 = Vector(-1422, -2380, 100),
    forest_enemy_bot_2 = Vector(-452, -1585, 100),

    river_top_1 = Vector(-1988, 478, 100),
    river_top_2 = Vector(-997, 1312, 100),
  },
  [TEAM_NEUTRAL] = {
    river = Vector(-521, -375, 280),
    river_farm_bot = Vector(-249, -623, 100),
    river_farm_top = Vector(-834, -93, 100),
  },
}

return M
