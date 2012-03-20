#!/system/bin/sh

mount -o remount,rw rootfs /
killall -9 adbd
sleep 1
rm /sbin/adbd
cat /system/ownherefiles/adbd > /sbin/adbd
chmod 755 /sbin/adbd
sync
mount -o remount,ro rootfs /
adbenabled=`getprop sys.usb.config|grep adb|wc -l`
if [ $adbenabled -gt 0 ]; then
	stop adbd
	sleep 1
	start adbd
fi
