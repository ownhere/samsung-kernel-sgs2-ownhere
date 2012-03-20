#!/system/xbin/busybox sh
#expandsd by ownhere v1.3 20110919

trap "exit" INT TERM EXIT
BUSYBOX=/system/xbin/busybox
EXPANDPATH="/sdcard/external_sd/expandsd.ownhere"
if [ $# -lt 1 ]; then
	run=`getprop ownhere.expandsd.ready`
	if [ $run -eq 1 ]; then
		echo "already running..."
		exit 0
	fi

	setsid flock -x /init.rc -c $0 1 &
	exit;
fi
if [ "$1" == "2" ]; then
	cd ${EXPANDPATH}
	while(true)
	do
		sleep 20000
	done
fi
if [ "$1" == "3" ]; then
	exit
fi
echo "EXPANDSD: expandsd start"

if ! [ -e /sys/block/mmcblk1/mmcblk1p1 ]; then
	echo "EXPANDSD: no second SD card inserted, waiting 10s."
	sleep 10
	if ! [ -e /sys/block/mmcblk1/mmcblk1p1 ]; then
		echo "EXPANDSD: no second SD card inserted, exit."
		exit;
	fi
fi

sleep 60 #wait for system bootup
cd /
setprop ownhere.expandsd.ready 1
laststatus=0
while(true)
do
	isMountESD=`cat /proc/mounts|grep -c " /mnt/sdcard/external_sd "`
	if [ $isMountESD -gt 0 ]; then
		if [ $laststatus -eq 0 ]; then
			laststatus=1
			sleep 30 #wait for mediascanner, avoid crash
			continue
		fi	
		if ! [ -d ${EXPANDPATH} ]; then
			echo "EXPANDSD: no expandsd.ownhere dir, exit."
			exit;
		fi
		if [ -d ${EXPANDPATH} ]; then
			if ! [ -e ${EXPANDPATH}/disable.expandsd ]; then

				disablemediascanner=0
				mountlist=""
				for dir in ${EXPANDPATH}/*
				do
					dir=`basename ${dir}`
					if [ "$dir" == "external_sd" ]; then
						continue
					fi
					if ! [ -d ${EXPANDPATH}/${dir} ]; then
						continue
					fi
					#echo "try mount dir:" $dir
					alreadymount=`cat /proc/mounts|grep -c " /mnt/sdcard/${dir} "`
					#echo "alreadymount:" $alreadymount
					if [ $alreadymount -eq 0 ]; then
						if ! [ -d /mnt/sdcard/${dir} ]; then
							if [ -e /mnt/sdcard/${dir} ]; then
								echo "EXPANDSD: will be remove /mnt/sdcard/${dir}, which is not directory, can not act as mount point."
								#rm -f /sdcard/${dir}
							else
								mkdir /mnt/sdcard/${dir}
							fi
						fi
						#pm disable com.android.providers.media/com.android.providers.media.MediaScannerReceiver
						disablemediascanner=1
						$BUSYBOX mount --bind $EXPANDPATH/${dir} /mnt/sdcard/${dir} 
						echo "EXPANDSD: dir:${EXPANDPATH}/${dir} mount on /mnt/sdcard/${dir}."
					#else
						#echo "dir:${EXPANDPATH}/${dir} already mount on /mnt/sdcard/${dir}, no need mount twice."
					fi
					mountlist="${mountlist} /mnt/sdcard/${dir}"
				done
				touch ${EXPANDPATH}/mount.lock
				setsid flock -x ${EXPANDPATH}/mount.lock -c $0 2 &
				sleep 2
				echo "EXPANDSD: will be lock"
				flock -x ${EXPANDPATH}/mount.lock -c $0 3
				echo "EXPANDSD: get flock"
				#mountlist=`cat /proc/mounts|awk '$2~/^(\/mnt\/sdcard\/|\/mnt\/secure\/asec)/{print $2}'`
				for mountpoint in $mountlist
				do
					echo "EXPANDSD: try unmount $mountpoint:"
					if ! [ "$mountpoint" == "/mnt/sdcard/external_sd/.android_secure" ]; then
						disablemediascanner=1
						$BUSYBOX umount $mountpoint
					fi
				done
			fi
		fi
		sleeptime=30
		laststatus=0
	else
		laststatus=0
		#echo "not mount external_sd, try umount expandsd mountpoint"
		mountlist=`cat /proc/mounts|awk '$2~/^(\/mnt\/sdcard\/|\/mnt\/secure\/asec)/{print $2}'`
		disablemediascanner=0
		for mountpoint in $mountlist
		do
			echo "EXPANDSD: try unmount $mountpoint:"
			if ! [ "$mountpoint" == "/mnt/sdcard/external_sd/.android_secure" ]; then
				#pm disable com.android.providers.media/com.android.providers.media.MediaScannerReceiver
				disablemediascanner=1
				$BUSYBOX umount $mountpoint
			fi
		done
		#if [ $disablemediascanner -eq 1 ]; then
		#	pm enable com.android.providers.media/com.android.providers.media.MediaScannerReceiver
		#fi
		sleeptime=20
	fi
	sleep ${sleeptime}
done
