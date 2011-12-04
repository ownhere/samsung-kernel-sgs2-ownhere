#!/system/bin/sh

sync;sync;sync
busybox_recovery umount /cache
/system/bin/e2fsck -f -y /dev/block/mmcblk0p7 > /data/checkcache.log 2>&1
busybox_recovery mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
busybox_recovery mount -o remount,rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
busybox_recovery rm -r /cache/lost+found/*
sleep 1
busybox_recovery umount /data
/system/bin/e2fsck -f -y /dev/block/mmcblk0p10 > /cache/checkdata.log 2>&1
busybox_recovery mount -t ext4 -o rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,noauto_da_alloc,discard /dev/block/mmcblk0p10 /data
busybox_recovery mount -o remount,rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,noauto_da_alloc,discard /dev/block/mmcblk0p10 /data
busybox_recovery rm -r /data/lost+found/*
