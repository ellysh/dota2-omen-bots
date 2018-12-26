#!/bin/bash

sleep 3

# Give items, gold and level to the bot

xdotool type 'dota_bot_give_level 10'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_shivas_guard'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_shivas_guard'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_heart'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_travel_boots_2'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_hood_of_defiance'
xdotool key 'Return'

xdotool type 'dota_creeps_no_spawning 1'
xdotool key 'Return'
