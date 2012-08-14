#!/system/bin/sh

#echo 1200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#echo 200000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo "500" > /proc/sys/vm/dirty_expire_centisecs
echo "1500" > /proc/sys/vm/dirty_writeback_centisecs
echo "5" > /proc/sys/vm/laptop_mode
#echo "50" > /proc/sys/vm/vfs_cache_pressure
a_echo()
{
	[ -e $2 ] && echo $1 > $2
}
for i in $(find /sys/block/mmcblk?);
do 
	a_echo "0" $i/queue/iostats
	a_echo "256" > $i/bdi/read_ahead_kb
done
echo "0" > /sys/module/wakelock/parameters/debug_mask
echo "0" > /sys/module/userwakelock/parameters/debug_mask
echo "0" > /sys/module/earlysuspend/parameters/debug_mask
echo "0" > /sys/module/alarm/parameters/debug_mask
echo "0" > /sys/module/alarm_dev/parameters/debug_mask
echo "0" > /sys/module/binder/parameters/debug_mask
