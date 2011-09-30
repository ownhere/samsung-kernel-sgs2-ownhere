#!/system/bin/sh
DEST=/system/xbin/su

if [ ! -e $DEST ] || [ ! -e /system/app/Superuser.apk ] || [ ! -e /system/app/CWMManager.apk ]; then
	echo "need auto rooting."
	mount -o remount,rw system /system

	# copy files
	cat /ownhere/files/su-2.3.6.2-ef > $DEST
	cat /ownhere/files/Superuser.apk > /system/app/Superuser.apk
	cat /ownhere/files/CWMManager.apk > /system/app/CWMManager.apk

	# set su permissions
	chown 0.0 $DEST
	chmod 06755 $DEST

	mount -o remount,ro system /system
fi
