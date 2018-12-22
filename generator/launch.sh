#!/bin/bash -x

set -e

CSV_DIR="database/csv"
LUA_DIR="database/lua"
RESULT_DIR="../bots/database"

./ods2csv.sh

./generator.py $CSV_DIR/buy.csv > $LUA_DIR/buy.lua
./generator.py $CSV_DIR/recovery.csv > $LUA_DIR/recovery.lua
./generator.py $CSV_DIR/assault_enemy_tower.csv > $LUA_DIR/assault_enemy_tower.lua
./generator.py $CSV_DIR/fight.csv > $LUA_DIR/fight.lua
./generator.py $CSV_DIR/farm.csv > $LUA_DIR/farm.lua

./linker.py \
  $LUA_DIR/buy.lua \
  $LUA_DIR/recovery.lua \
  $LUA_DIR/assault_enemy_tower.lua \
  $LUA_DIR/fight.lua \
  $LUA_DIR/farm.lua \
  > $RESULT_DIR/objectives.lua

./check.sh
