#!/system/bin/sh

#mount -o remount,ro,nosuid,nodev,noatime,barrier=1,data=ordered,noauto_da_alloc,discard,commit=13 /dev/block/mmcblk0p10 /data
sync;sync;sync
umount /data
e2fsck -y /dev/block/mmcblk0p10 > /cache/checkdata.log 2>&1
mount -t ext4 -o rw,nosuid,nodev,noatime,barrier=1,data=ordered,noauto_da_alloc,discard,commit=13 /dev/block/mmcblk0p10 /data
mount -o remount,rw,nosuid,nodev,noatime,barrier=1,data=ordered,noauto_da_alloc,discard,commit=13 /dev/block/mmcblk0p10 /data
rm -r "/data/lost+found/*"
