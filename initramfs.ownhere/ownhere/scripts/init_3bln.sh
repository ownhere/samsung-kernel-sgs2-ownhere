#!/system/bin/sh

exit 0 

SRC=/ownhere/files/lights.GT-I9100.so
DEST=/system/lib/hw/lights.GT-I9100.so

result=`diff $SRC $DEST 2>&1`
if [ "$result" != "" ]; then
	echo "need install BLN $DEST."
	mount -o remount,rw system /system

	# copy files
	cat $SRC > $DEST

	sync
	# set su permissions
	chmod 0755 $DEST
	chown 0.0 $DEST

	mount -o remount,ro system /system
fi
