#!/ownhere/bin/busybox sh
# be sure / is read+write for Gingerbread
/ownhere/bin/mount -o remount,rw /

exec >> /ownhere/logs/cwm_log.txt 2>&1

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
ln -s /sbin/recovery /sbin/mkyaffs2image
ln -s /sbin/recovery /sbin/nandroid
ln -s /sbin/recovery /sbin/reboot
ln -s /sbin/recovery /sbin/unyaffs
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

# also shorter
#echo '#!/sbin/sh
#set -x
#exec >> /ownhere/logs/cwm_postrecoveryboot_log.txt 2>&1
#rm /etc
#mkdir -p /etc
#mkdir -p /datadata
## chmod 4777 /sbin/su
#umount /efs
#umount /dbdata
#umount /data
#
## succeed to mount the sdcard by default even with broken fstab
#mount -t vfat -o rw,nosuid,nodev,noexec,uid=1000,gid=1015,fmask=0002,dmask=0002,allow_utime=0020,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro "`cat /lidroid/run/sdcard_device`" /sdcard
#' > /sbin/postrecoveryboot.sh
#
#chmod 755 /sbin/postrecoveryboot.sh

#/ownhere/bin/mount -o remount,ro /

# run the actual recovery
exec /sbin/recovery
