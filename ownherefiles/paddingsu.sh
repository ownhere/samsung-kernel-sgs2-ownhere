#!/bin/sh

if [ $# -lt 1 ]; then
	dir="initramfs.ownhere"
else
	dir=$1
fi

dir=`pwd`"/"${dir}
cwmsize=`cat ${dir}"/../ownherefiles/CWMManager.apk"|wc -c`
susize=`cat ${dir}"/../ownherefiles/Superuser.apk"|wc -c`
kernelsize=`cat ${dir}"/../arch/arm/boot/zImage"|wc -c`
newkernelsize=`expr \( ${kernelsize} / 500000 + 1 \) \* 500000`
kernelsizediff=$(( newkernelsize - kernelsize ))
echo "cwm:"$cwmsize
echo "su:"$susize
echo "kernelsize:"$kernelsize
echo "newkernelsize:"$newkernelsize
echo "kernelsizediff:"$kernelsizediff
#if [ $cwmsize -gt 500000 ]; then
#	echo "ERROR! cwmsize is more than 500000"
#	exit
#fi
perl -p -i -e "s/CWMSIZE=([0-9]*)/CWMSIZE=${cwmsize}/" ${dir}"/ownhere/scripts/init_2rooting.sh"
perl -p -i -e "s/SUSIZE=([0-9]*)/SUSIZE=${susize}/" ${dir}"/ownhere/scripts/init_2rooting.sh"
perl -p -i -e "s/PADDINGBASE=([0-9]*)/PADDINGBASE=${newkernelsize}/" ${dir}"/ownhere/scripts/init_2rooting.sh"

#dd if=/dev/null of=${dir}"/../arch/arm/boot/zImage" skip=0 seek=$kernelsize bs=1 count=$kernelsizediff conv=notrunc
#dd if=${dir}"/ownhere/files/CWMManager.apk" of=${dir}"/../arch/arm/boot/zImage" skip=0 seek=6500000 bs=1 count=$cwmsize conv=notrunc
#dd if=${dir}"/ownhere/files/Superuser.apk" of=${dir}"/../arch/arm/boot/zImage" skip=0 seek=7000000 bs=1 count=$susize conv=notrunc
cat /dev/zero|head -c $kernelsizediff >> ${dir}"/../arch/arm/boot/zImage"
cat ${dir}"/../ownherefiles/Superuser.apk" >> ${dir}"/../arch/arm/boot/zImage"
cat ${dir}"/../ownherefiles/CWMManager.apk" >> ${dir}"/../arch/arm/boot/zImage"
echo "OWNHEREPADDING" >> ${dir}"/../arch/arm/boot/zImage"
