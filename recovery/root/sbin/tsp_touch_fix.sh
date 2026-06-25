#!/sbin/sh

fix() {
    echo incell_power_control,0 > /sys/class/sec/tsp/cmd
    echo incell_power_control,1 > /sys/class/sec/tsp/cmd
    echo fw_update > /sys/class/sec/tsp/cmd
}

node="/sys/class/sec/tsp/input/enabled"
screen_was_off=0

while true; do
    sleep 0.1
    new=$(cat "$node" 2>/dev/null)
    if [ "$new" = "0" ]; then
        screen_was_off=1
    elif [ "$screen_was_off" = "1" ]; then
        fix
        screen_was_off=0
    fi
done