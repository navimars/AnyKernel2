#!/system/bin/sh

################################################################################
# helper functions to allow Android init like script

function write() {
    echo -n $2 > $1
}

function copy() {
    cat $1 > $2
}

# macro to write pids to system-background cpuset
function writepid_sbg() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/system-background/tasks;
        shift;
    done;
}

function writepid_top_app() {
    until [ ! "$1" ]; do
        echo -n $1 > /dev/cpuset/top-app/tasks;
        shift;
    done;
}
################################################################################

{

sleep 10

# cpu
chmod 0664 /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
chmod 0664 /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor

write /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load 100
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq 0
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads "70 672000:45 825600:50 1036800:60 1248000:70 1478400:85"
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time 40000
write /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate 30000

write /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load 99
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq 1574400
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay "19000 1400000:39000 1700000:19000 2100000:79000"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads "85 1728000:80 2112000:90 2342400:95"
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate 30000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time 19000
write /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis 39000

write /sys/module/cpu_boost/parameters/input_boost_freq "0:1036800"
write /sys/module/cpu_boost/parameters/input_boost_ms 150

sleep 20

}&
