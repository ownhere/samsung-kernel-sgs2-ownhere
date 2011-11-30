#!/ownhere/bin/busybox sh
# be sure / is read+write for Gingerbread
/ownhere/bin/mount -o remount,rw /

#exec >> /ownhere/logs/cwm_log.txt 2>&1

# mostly replicate updater-script behavior from CWM as update.zip
set -x
export PATH=$PATH:/ownhere/bin

# froyo make /sdcard a symlink to /mnt/sdcard, which confuses CWM
#rm /sdcard
#mkdir /sdcard
mkdir /sdcard1

ln -s /sbin/recovery /sbin/busybox
ln -s /sbin/recovery /sbin/amend
ln -s /sbin/recovery /sbin/dump_image
ln -s /sbin/recovery /sbin/erase_image
ln -s /sbin/recovery /sbin/flash_image
ln -s /sbin/recovery /sbin/edify
ln -s /sbin/recovery /sbin/mkyaffs2image
ln -s /sbin/recovery /sbin/nandroid
ln -s /sbin/recovery /sbin/reboot
ln -s /sbin/recovery /sbin/unyaffs
ln -s /sbin/recovery /sbin/md5sum
ln -s /ownhere/bin/busybox /sbin/ash
ln -s /ownhere/bin/busybox /sbin/cat
ln -s /ownhere/bin/busybox /sbin/chmod
ln -s /ownhere/bin/busybox /sbin/chown
ln -s /ownhere/bin/busybox /sbin/cmp
ln -s /ownhere/bin/busybox /sbin/cp
ln -s /ownhere/bin/busybox /sbin/cut
ln -s /ownhere/bin/busybox /sbin/date
ln -s /ownhere/bin/busybox /sbin/dd
ln -s /ownhere/bin/busybox /sbin/du
ln -s /ownhere/bin/busybox /sbin/find
ln -s /ownhere/bin/busybox /sbin/halt
ln -s /ownhere/bin/busybox /sbin/insmod
ln -s /ownhere/bin/busybox /sbin/kill
ln -s /ownhere/bin/busybox /sbin/killall
ln -s /ownhere/bin/busybox /sbin/ln
ln -s /ownhere/bin/busybox /sbin/lzcat
ln -s /ownhere/bin/busybox /sbin/lzop
ln -s /ownhere/bin/busybox /sbin/lzopcat
ln -s /ownhere/bin/busybox /sbin/mkdir
ln -s /ownhere/bin/busybox /sbin/mknod
ln -s /ownhere/bin/busybox /sbin/mount
ln -s /ownhere/bin/busybox /sbin/mv
ln -s /ownhere/bin/busybox /sbin/poweroff
ln -s /ownhere/bin/busybox /sbin/reboot
ln -s /ownhere/bin/busybox /sbin/rm
ln -s /ownhere/bin/busybox /sbin/run-parts
ln -s /ownhere/bin/busybox /sbin/sh
ln -s /ownhere/bin/busybox /sbin/sha1sum
ln -s /ownhere/bin/busybox /sbin/sleep
ln -s /ownhere/bin/busybox /sbin/stat
ln -s /ownhere/bin/busybox /sbin/sync
ln -s /ownhere/bin/busybox /sbin/tail
ln -s /ownhere/bin/busybox /sbin/tar
ln -s /ownhere/bin/busybox /sbin/tee
ln -s /ownhere/bin/busybox /sbin/time
ln -s /ownhere/bin/busybox /sbin/umount
ln -s /ownhere/bin/busybox /sbin/unlzma
ln -s /ownhere/bin/busybox /sbin/unlzop
ln -s /ownhere/bin/busybox /sbin/unzip

/ownhere/bin/busybox mount -o remount,rw rootfs /

/ownhere/bin/busybox rm /emmc
/ownhere/bin/busybox mkdir /emmc
/ownhere/bin/busybox chmod 777 /emmc

/ownhere/bin/busybox rm /sdcard
/ownhere/bin/busybox mkdir /sdcard
/ownhere/bin/busybox chmod 777 /sdcard

/ownhere/bin/busybox rm /etc
/ownhere/bin/busybox mkdir /etc
/ownhere/bin/busybox cat /res/etc/recovery.fstab > /etc/recovery.fstab

start adbd
stop tvout

/ownhere/bin/busybox rm /cache
/ownhere/bin/busybox mkdir /cache
/ownhere/bin/busybox chmod 777 /cache
/ownhere/bin/busybox mount -t ext4 /dev/block/mmcblk0p7 /cache
/ownhere/bin/busybox mount -t ext4 /dev/block/mmcblk0p9 /system
/ownhere/bin/busybox mount -t ext4 /dev/block/mmcblk0p10 /data

# run the actual recovery
echo 1 > /sbin/recovery-is-running
exec /sbin/recovery
