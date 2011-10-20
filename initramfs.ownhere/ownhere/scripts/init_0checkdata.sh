#!/system/bin/sh

#mount -o remount,ro,nosuid,nodev,noatime,barrier=1,data=ordered,noauto_da_alloc,discard,commit=13 /dev/block/mmcblk0p10 /data
sync;sync;sync
busybox umount /cache
e2fsck -f -y /dev/block/mmcblk0p7 > /data/checkcache.log 2>&1
busybox mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
busybox mount -o remount,rw,nosuid,nodev,noatime,barrier=1,commit=19 /dev/block/mmcblk0p7 /cache
rm -r /cache/lost+found/*
sleep 1
busybox umount /data
e2fsck -f -y /dev/block/mmcblk0p10 > /cache/checkdata.log 2>&1
#busybox mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,data=ordered,noauto_da_alloc,discard,commit=13 /dev/block/mmcblk0p10 /data
#busybox mount -o remount,rw,nosuid,nodev,noatime,barrier=1,data=ordered,noauto_da_alloc,discard,commit=13 /dev/block/mmcblk0p10 /data
busybox mount -t ext4 -o rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,noauto_da_alloc,discard /dev/block/mmcblk0p10 /data
busybox mount -o remount,rw,nosuid,nodev,noatime,commit=13,barrier=1,data=ordered,noauto_da_alloc,discard /dev/block/mmcblk0p10 /data
rm -r /data/lost+found/*
