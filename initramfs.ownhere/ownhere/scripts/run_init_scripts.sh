#!/system/bin/sh

for x in /ownhere/scripts/init*; do
	$x
done

setprop ownhere.system.ready 1;
