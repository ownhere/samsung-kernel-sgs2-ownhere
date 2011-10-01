#!/system/bin/sh

echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo "1500" > /proc/sys/vm/dirty_writeback_centisecs
echo "5" > /proc/sys/vm/laptop_mode
#echo "50" > /proc/sys/vm/vfs_cache_pressure
