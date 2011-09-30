#!/system/bin/sh
#loadnfs.sh by ownhere v1.0

if [ -e /lib/modules/nfs.ko ]; then
	insmod /lib/modules/sunrpc.ko
	insmod /lib/modules/lockd.ko
	insmod /lib/modules/auth_rpcgss.ko
	insmod /lib/modules/rpcsec_gss_krb5.ko
	insmod /lib/modules/nfs.ko
else
	insmod /system/lib/modules/sunrpc.ko
	insmod /system/lib/modules/lockd.ko
	insmod /system/lib/modules/auth_rpcgss.ko
	insmod /system/lib/modules/rpcsec_gss_krb5.ko
	insmod /system/lib/modules/nfs.ko
fi
