#!/system/bin/sh

if [ -e /lib/modules/cifs.ko ]; then
	insmod /lib/modules/nls_utf8.ko
	insmod /lib/modules/slow-work.ko
	insmod /lib/modules/cifs.ko
else
	insmod /system/lib/modules/nls_utf8.ko
	insmod /system/lib/modules/slow-work.ko
	insmod /system/lib/modules/cifs.ko
fi
