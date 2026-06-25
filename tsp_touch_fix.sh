#!/bin/sh

fix() {
    echo fw_update > /sys/class/sec/tsp/cmd
    result=$(cat /sys/class/sec/tsp/cmd_result 2>/dev/null)
    case "$result" in
        *OK*) ;;
        *)
            echo incell_power_control,0 > /sys/class/sec/tsp/cmd
            echo incell_power_control,1 > /sys/class/sec/tsp/cmd
            echo fw_update > /sys/class/sec/tsp/cmd
            ;;
    esac
}

sleep 10

getevent -l /dev/input/event2 | while read line; do
    case "$line" in
        *KEY_POWER*UP*)
            sleep 0.3
            fix
            ;;
    esac
done