#!/sbin/sh

fix() {
    echo fw_update > /sys/class/sec/tsp/cmd
    cat /sys/class/sec/tsp/cmd_result
}

dir="/sys/class/backlight/panel/brightness"
screen_was_off=0

while true; do
    sleep 0.1
    new=$(cat "$dir" 2>/dev/null)

    if [ "$new" = "0" ]; then
        screen_was_off=1
    elif [ "$screen_was_off" = "1" ]; then
        sleep 1.0
        fix
        screen_was_off=0
    fi
done