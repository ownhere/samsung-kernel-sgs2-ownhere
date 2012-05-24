#!/system/bin/sh
SRC=/ownhere/files/su
DEST=/system/xbin/su

sufilesize=`busybox_recovery wc -c /system/app/Superuser.apk`
cwmfilesize=`busybox_recovery wc -c /system/app/CWMManager.apk`

if [ ! -e $DEST ] || [ ! -e /system/app/Superuser.apk ] || [ ! -e /system/app/CWMManager.apk ] || [ $sufilesize -eq 0 ] || [ $cwmfilesize -eq 0 ] ; then
	echo "need auto rooting."
	mount -o remount,rw system /system

	# copy files
	cat $SRC > $DEST
	CWMSIZE=331212
	SUSIZE=811856
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
