#!/system/bin/sh

sync;sync;sync;
busybox_recovery mount -o remount,ro,noatime,barrier=1,data=ordered system /system
has_journal=`tunefs.ext4 -l /dev/block/mmcblk0p7|grep has_journal|wc -l`
if [ ${has_journal} -gt 0 ]; then
	busybox_recovery mount -o remount,ro cache /cache
	busybox_recovery umount /cache
	tunefs.ext4 -O ^has_journal /dev/block/mmcblk0p7
	busybox_recovery mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
	sleep 1
fi
busybox_recovery mount -o remount,rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
busybox_recovery mount -o remount,rw,nosuid,nodev,noatime,barrier=1,data=ordered,commit=17 /dev/block/mmcblk0p1 /efs
busybox_recovery mount -o remount,rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,noauto_da_alloc,discard /dev/block/mmcblk0p10 /data
