#!/bin/bash

sleep 3

# Give items, gold and level to the bot

xdotool type 'dota_bot_give_level 15'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_cyclone'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_wraith_band'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_power_treads'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_flask'
xdotool key 'Return'

xdotool type 'dota_bot_give_item item_blink'
xdotool key 'Return'
