#!/ownhere/bin/busybox sh
# be sure / is read+write for Gingerbread
/ownhere/bin/busybox rm /etc
/ownhere/bin/busybox mkdir /etc
/ownhere/bin/busybox cat /res/etc/recovery.fstab > /etc/recovery.fstab
/ownhere/bin/busybox mount -o remount,rw /

exec >> /ownhere/logs/cwm_log.txt 2>&1

# mostly replicate updater-script behavior from CWM as update.zip
set -x
export PATH=$PATH

# froyo make /sdcard a symlink to /mnt/sdcard, which confuses CWM
#rm /sdcard
#mkdir /sdcard
mkdir /sdcard1

ln -s /sbin/recovery /sbin/busybox
ln -s /sbin/recovery /sbin/flash_image
ln -s /sbin/recovery /sbin/volume
ln -s /sbin/recovery /sbin/edify
ln -s /sbin/recovery /sbin/setprop
ln -s /sbin/recovery /sbin/unyaffs
ln -s /sbin/recovery /sbin/erase_image
ln -s /sbin/recovery /sbin/nandroid
ln -s /sbin/recovery /sbin/reboot
ln -s /sbin/recovery /sbin/dump_image
ln -s /sbin/recovery /sbin/mkyaffs2image
ln -s /sbin/busybox /sbin/bzip2
ln -s /sbin/busybox /sbin/setconsole
ln -s /sbin/busybox /sbin/dos2unix
ln -s /sbin/busybox /sbin/rev
ln -s /sbin/busybox /sbin/groups
ln -s /sbin/busybox /sbin/patch
ln -s /sbin/busybox /sbin/mv
ln -s /sbin/busybox /sbin/sleep
ln -s /sbin/busybox /sbin/lsmod
ln -s /sbin/busybox /sbin/ash
ln -s /sbin/busybox /sbin/cpio
ln -s /sbin/busybox /sbin/echo
ln -s /sbin/busybox /sbin/seq
ln -s /sbin/busybox /sbin/pkill
ln -s /sbin/busybox /sbin/stty
ln -s /sbin/busybox /sbin/md5sum
ln -s /sbin/busybox /sbin/lzopcat
ln -s /sbin/busybox /sbin/resize
ln -s /sbin/busybox /sbin/time
ln -s /sbin/busybox /sbin/bzcat
ln -s /sbin/busybox /sbin/mkdir
ln -s /sbin/busybox /sbin/makedevs
ln -s /sbin/busybox /sbin/lzop
ln -s /sbin/busybox /sbin/mkfs.ext2
ln -s /sbin/busybox /sbin/unlzma
ln -s /sbin/busybox /sbin/swapoff
ln -s /sbin/busybox /sbin/df
ln -s /sbin/busybox /sbin/chown
ln -s /sbin/busybox /sbin/unzip
ln -s /sbin/busybox /sbin/swapon
ln -s /sbin/busybox /sbin/modinfo
ln -s /sbin/busybox /sbin/readlink
ln -s /sbin/busybox /sbin/unix2dos
ln -s /sbin/busybox /sbin/nohup
ln -s /sbin/busybox /sbin/depmod
ln -s /sbin/busybox /sbin/fgrep
ln -s /sbin/busybox /sbin/less
ln -s /sbin/busybox /sbin/zcat
ln -s /sbin/busybox /sbin/sha256sum
ln -s /sbin/busybox /sbin/dd
ln -s /sbin/busybox /sbin/bbconfig
ln -s /sbin/busybox /sbin/awk
ln -s /sbin/busybox /sbin/date
ln -s /sbin/busybox /sbin/tty
ln -s /sbin/busybox /sbin/chroot
ln -s /sbin/busybox /sbin/expr
ln -s /sbin/busybox /sbin/grep
ln -s /sbin/busybox /sbin/cal
ln -s /sbin/busybox /sbin/egrep
ln -s /sbin/busybox /sbin/unxz
ln -s /sbin/busybox /sbin/uuencode
ln -s /sbin/busybox /sbin/rmmod
ln -s /sbin/busybox /sbin/tr
ln -s /sbin/busybox /sbin/realpath
ln -s /sbin/busybox /sbin/uudecode
ln -s /sbin/busybox /sbin/xargs
ln -s /sbin/busybox /sbin/true
ln -s /sbin/busybox /sbin/rmdir
ln -s /sbin/busybox /sbin/killall
ln -s /sbin/busybox /sbin/stat
ln -s /sbin/busybox /sbin/free
ln -s /sbin/busybox /sbin/dc
ln -s /sbin/busybox /sbin/mkswap
ln -s /sbin/busybox /sbin/setsid
ln -s /sbin/busybox /sbin/mountpoint
ln -s /sbin/busybox /sbin/mke2fs
ln -s /sbin/busybox /sbin/pidof
ln -s /sbin/busybox /sbin/[[
ln -s /sbin/busybox /sbin/nice
ln -s /sbin/busybox /sbin/sed
ln -s /sbin/busybox /sbin/printenv
ln -s /sbin/busybox /sbin/cat
ln -s /sbin/busybox /sbin/chattr
ln -s /sbin/busybox /sbin/pwd
ln -s /sbin/busybox /sbin/sh
ln -s /sbin/busybox /sbin/mknod
ln -s /sbin/busybox /sbin/catv
ln -s /sbin/busybox /sbin/xzcat
ln -s /sbin/busybox /sbin/basename
ln -s /sbin/busybox /sbin/wc
ln -s /sbin/busybox /sbin/usleep
ln -s /sbin/busybox /sbin/fuser
ln -s /sbin/busybox /sbin/pstree
ln -s /sbin/busybox /sbin/sort
ln -s /sbin/busybox /sbin/devmem
ln -s /sbin/busybox /sbin/du
ln -s /sbin/busybox /sbin/unlzop
ln -s /sbin/busybox /sbin/hexdump
ln -s /sbin/busybox /sbin/od
ln -s /sbin/busybox /sbin/whoami
ln -s /sbin/busybox /sbin/mkfifo
ln -s /sbin/busybox /sbin/expand
ln -s /sbin/busybox /sbin/cp
ln -s /sbin/busybox /sbin/rdev
ln -s /sbin/busybox /sbin/pgrep
ln -s /sbin/busybox /sbin/lspci
ln -s /sbin/busybox /sbin/split
ln -s /sbin/busybox /sbin/env
ln -s /sbin/busybox /sbin/which
ln -s /sbin/busybox /sbin/dmesg
ln -s /sbin/busybox /sbin/cmp
ln -s /sbin/busybox /sbin/more
ln -s /sbin/busybox /sbin/renice
ln -s /sbin/busybox /sbin/cut
ln -s /sbin/busybox /sbin/fold
ln -s /sbin/busybox /sbin/chmod
ln -s /sbin/busybox /sbin/bunzip2
ln -s /sbin/busybox /sbin/lsusb
ln -s /sbin/busybox /sbin/tee
ln -s /sbin/busybox /sbin/uptime
ln -s /sbin/busybox /sbin/nandwrite
ln -s /sbin/busybox /sbin/touch
ln -s /sbin/busybox /sbin/diff
ln -s /sbin/busybox /sbin/cksum
ln -s /sbin/busybox /sbin/install
ln -s /sbin/busybox /sbin/tail
ln -s /sbin/busybox /sbin/dirname
ln -s /sbin/busybox /sbin/tar
ln -s /sbin/busybox /sbin/kill
ln -s /sbin/busybox /sbin/sysctl
ln -s /sbin/busybox /sbin/mktemp
ln -s /sbin/busybox /sbin/setserial
ln -s /sbin/busybox /sbin/rm
ln -s /sbin/busybox /sbin/insmod
ln -s /sbin/busybox /sbin/strings
ln -s /sbin/busybox /sbin/sha1sum
ln -s /sbin/busybox /sbin/reset
ln -s /sbin/busybox /sbin/length
ln -s /sbin/busybox /sbin/umount
ln -s /sbin/busybox /sbin/uname
ln -s /sbin/busybox /sbin/freeramdisk
ln -s /sbin/busybox /sbin/losetup
ln -s /sbin/busybox /sbin/ls
ln -s /sbin/busybox /sbin/chgrp
ln -s /sbin/busybox /sbin/head
ln -s /sbin/busybox /sbin/sync
ln -s /sbin/busybox /sbin/gzip
ln -s /sbin/busybox /sbin/modprobe
ln -s /sbin/busybox /sbin/test
ln -s /sbin/busybox /sbin/false
ln -s /sbin/busybox /sbin/uniq
ln -s /sbin/busybox /sbin/tac
ln -s /sbin/busybox /sbin/gunzip
ln -s /sbin/busybox /sbin/watch
ln -s /sbin/busybox /sbin/top
ln -s /sbin/busybox /sbin/lzcat
ln -s /sbin/busybox /sbin/unexpand
ln -s /sbin/busybox /sbin/lsattr
ln -s /sbin/busybox /sbin/[
ln -s /sbin/busybox /sbin/killall5
ln -s /sbin/busybox /sbin/find
ln -s /sbin/busybox /sbin/id
ln -s /sbin/busybox /sbin/nanddump
ln -s /sbin/busybox /sbin/clear
ln -s /sbin/busybox /sbin/run-parts
ln -s /sbin/busybox /sbin/ps
ln -s /sbin/busybox /sbin/mount
ln -s /sbin/busybox /sbin/ln
ln -s /sbin/busybox /sbin/getopt
ln -s /sbin/busybox /sbin/sha512sum
ln -s /sbin/busybox /sbin/fdisk
ln -s /sbin/busybox /sbin/printf
ln -s /sbin/busybox /sbin/yes

#/ownhere/bin/busybox mount -o remount,ro /

# run the actual recovery
exec /sbin/recovery
