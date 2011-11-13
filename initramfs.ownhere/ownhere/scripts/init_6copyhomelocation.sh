#!/system/bin/sh

locationdb="HomeLocationDB.bin"
locationver="HomeLocationVersion.bin"
if [ -e /data/data/com.android.phone/${locationdb} ]; then
	cat /data/data/com.android.phone/${locationdb} > /data/local/${locationdb}
	chmod 777 /data/local/${locationdb}
fi
if [ -e /data/data/com.android.phone/${locationver} ]; then
	cat /data/data/com.android.phone/${locationver} > /data/local/${locationver}
	chmod 777 /data/local/${locationver}
fi
