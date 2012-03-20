#!/system/bin/sh

BUSYBOX=/system/xbin/busybox

sync;sync;sync;
$BUSYBOX mount -o remount,ro,noatime,barrier=1,data=ordered system /system
has_journal=`tunefs.ext4 -l /dev/block/mmcblk0p7|grep has_journal|wc -l`
if [ ${has_journal} -gt 0 ]; then
	$BUSYBOX mount -o remount,ro cache /cache
	$BUSYBOX umount /cache
	tunefs.ext4 -O ^has_journal /dev/block/mmcblk0p7
	$BUSYBOX mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
	sleep 1
fi
$BUSYBOX mount -o remount,rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
$BUSYBOX mount -o remount,rw,nosuid,nodev,noatime,barrier=1,data=ordered,commit=17 /dev/block/mmcblk0p1 /efs
$BUSYBOX mount -o remount,rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,noauto_da_alloc,discard /dev/block/mmcblk0p10 /data
