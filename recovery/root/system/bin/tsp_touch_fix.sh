#!/sbin/sh

fix() {
    echo check_connection > /sys/class/sec/tsp/cmd
    cat /sys/class/sec/tsp/cmd_result
}

dir="/sys/class/backlight/panel/brightness"
screen_was_off=0

while true; do
    sleep 0.3
    new=$(cat "$dir" 2>/dev/null)
    
    if [ "$new" = "0" ]; then
        screen_was_off=1
    elif [ "$screen_was_off" = "1" ]; then
        # Screen just came back on from off state
        sleep 0.2
        fix
        sleep 0.3
        fix  # Second poke for stubborn TSP
        screen_was_off=0
    fi
done