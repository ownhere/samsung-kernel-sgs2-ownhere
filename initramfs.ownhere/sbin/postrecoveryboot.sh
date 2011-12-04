#!/sbin/sh

#rm /etc
#mkdir /etc
#cat /res/etc/recovery.fstab > /etc/recovery.fstab
#
#rm /sdcard
#mkdir /sdcard
#busybox mount -t vfat -o noatime,nodiratime /dev/block/mmcblk0p11 /sdcard >> /dev/null 2>&1
#
#rmdir /sdcard/external_sd
#mkdir /sdcard/external_sd
#busybox mount -t vfat /dev/block/mmcblk1p1 /sdcard/external_sd
#
#rm -rf /sdcard/.android_secure
#if [ -d /sdcard/external_sd/.android_secure ];
#then
#  mkdir /sdcard/.android_secure
#  busybox mount --bind /sdcard/external_sd/.android_secure /sdcard/.android_secure
#fi;
for i in $(seq 1 10)
do
    TMP=$(mount | grep /tmp)
    if [ -z "$TMP" ]
    then
        break
    fi
    umount -l /tmp
    sleep 1
done

busybox_recovery mount -o rw,remount /
rm -r /tmp
mkdir -p /tmp
rm /sdcard
mkdir /sdcard
busybox_recovery mount /sdcard >> /dev/null 2>&1
rm /emmc
mkdir /emmc
busybox_recovery mount /emmc >> /dev/null 2>&1
touch /tmp/recovery.log
sync
