#!/system/bin/sh
SRC=/ownhere/files/su
DEST=/system/xbin/su

if [ ! -e $DEST ] || [ ! -e /system/app/Superuser.apk ] || [ ! -e /system/app/CWMManager.apk ]; then
	echo "need auto rooting."
	mount -o remount,rw system /system

	# copy files
	cat $SRC > $DEST
	CWMSIZE=331212
	SUSIZE=640549
	PADDINGBASE=6500000
	PADDINGOFFSET=${PADDINGBASE}
	busybox_recovery dd if=/dev/block/mmcblk0p5 of=/system/app/Superuser.apk skip=${PADDINGOFFSET} seek=0 bs=1 count=$SUSIZE
	PADDINGOFFSET=`busybox_recovery expr ${PADDINGOFFSET} + $SUSIZE`
	busybox_recovery dd if=/dev/block/mmcblk0p5 of=/system/app/CWMManager.apk skip=${PADDINGOFFSET} seek=0 bs=1 count=$CWMSIZE

	# set su permissions
	chown 0.0 $DEST
	chmod 06755 $DEST

	mount -o remount,ro system /system
fi
mount -o remount,rw rootfs /
chown 0.0 $SRC
chmod 06755 $SRC
mount -o remount,ro rootfs /
