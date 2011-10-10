#!/system/bin/sh

sync;sync;sync;
mount -o remount,ro,noatime,barrier=1,data=ordered system /system
mount -o remount,rw,nosuid,nodev,noatime,barrier=1,data=ordered,commit=19 cache /cache
mount -o remount,rw,nosuid,nodev,noatime,barrier=1,data=ordered,commit=17 efs /efs
mount -o remount,rw,nosuid,nodev,noatime,barrier=1,data=ordered,noauto_da_alloc,discard,commit=13 data /data
