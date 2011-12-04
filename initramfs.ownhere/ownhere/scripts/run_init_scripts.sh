#!/system/bin/sh

for x in /ownhere/scripts/init*; do
	$x
done

setprop ownhere.system.ready 1;

(
sleep 30
mkdir /sdcard/clockworkmod
touch /sdcard/clockworkmod/.salted_hash
) &
