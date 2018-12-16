#!/bin/bash -x

set -e

CSV_DIR="database/csv"
LUA_DIR="database/lua"
RESULT_DIR="../bots/database"

./ods2csv.sh

./generator.py $CSV_DIR/buy.csv > $LUA_DIR/buy.lua
./generator.py $CSV_DIR/farm.csv > $LUA_DIR/farm.lua
./generator.py $CSV_DIR/recovery.csv > $LUA_DIR/recovery.lua

./linker.py $LUA_DIR/buy.lua $LUA_DIR/recovery.lua $LUA_DIR/farm.lua > $RESULT_DIR/objectives.lua

./check.sh
