#!/system/bin/sh

busybox_recovery mount -o remount,rw rootfs /
busybox_recovery mkdir -p /customkernel/property
echo true >> /customkernel/property/customkernel.cf-root
echo true >> /customkernel/property/customkernel.base.cf-root
echo CF-Root >> /customkernel/property/customkernel.name
echo "CF-Root 5.0" >> /customkernel/property/customkernel.namedisplay
echo 100 >> /customkernel/property/customkernel.version.number
echo 5.0 >> /customkernel/property/customkernel.version.name
echo true >> /customkernel/property/customkernel.bootani.zip
echo true >> /customkernel/property/customkernel.bootani.bin
echo true >> /customkernel/property/customkernel.cwm
echo 5.0.2.7 >> /customkernel/property/customkernel.cwm.version
busybox_recovery mount -o remount,ro rootfs /
