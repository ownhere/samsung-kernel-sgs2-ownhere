#!/bin/sh

export LANG=en_US
prefix=""
#if [[ "$1" =~ "clean" || "$1" =~ "install" ]]; then
#	prefix="sudo "
#fi
myinitramfs="initramfs.ownhere"
branch=`git branch|grep -E "^\*"|awk '{print $2}'`
if [ ! -z ${BUILD} ]; then
	branch=${branch}"-"${BUILD}
fi
compiler="/opt/toolchains/none/arm-2009q3/bin/arm-none-eabi-"
#compiler="/opt/toolchains/none/arm-2011.03/bin/arm-none-eabi-"
#compiler="/opt/toolchains/linaro201109-4.5/bin/arm-eabi-"
#compiler="/opt/toolchains/linaro201109-4.6/bin/arm-eabi-"
#compiler="/www/android/cm/prebuilt/linux-x86/toolchain/arm-eabi-4.4.0/bin/arm-eabi-"
#compiler="/www/android/cm/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-"
if [[ $1 =~ ^pack ]]; then
	echo "branch:" $branch
	cd arch/arm/boot
	curdate=`date +%Y%m%d`
	kernelpath="/www/android/kernel/sgs2-kernel"
	lastbuild=`ls ${kernelpath}-${branch}-${curdate}-*.tar`
	maxnum=0
	for num in $lastbuild
	do
		num=${num##*-}
		num=${num%%.tar}
		if [ $num -gt $maxnum ]; then
			maxnum=$num
		fi
	done
	((maxnum++))
	tar cvf ${kernelpath}-${branch}-${curdate}-${maxnum}.tar zImage
	echo "kernel tar file create: ${kernelpath}-${branch}-${curdate}-${maxnum}.tar"
	if [ "$1" == "packsend" ]; then
		sz ${kernelpath}-${branch}-${curdate}-${maxnum}.tar
	fi

else
	echo "compile prefix: $prefix"
	if [ "$1" == "modules_install" ]; then
		$prefix rm -rf $PWD/${myinitramfs}/lib/modules/
	fi
	####################
	#!!!!!!!!!!!!!!!!!
	#add -march=armv7-a -mtune=cortex-a9 -mfpu=neon to Makefile KBUILD_CFLAGS
	#!!!!!!!!!!!!!!!!!
	$prefix make -j `cat /proc/cpuinfo |grep -c ^processor` EXTRA_AFLAGS=-mfpu=neon ARCH=arm CROSS_COMPILE=${compiler} INSTALL_MOD_PATH=$PWD/${myinitramfs} CONFIG_INITRAMFS_SOURCE=$PWD/${myinitramfs} CONFIG_INITRAMFS_ROOT_UID=0 CONFIG_INITRAMFS_ROOT_GID=0 LOCALVERSION="-I9100-${branch}" $1 $2 $3 $4 $5 $6 $7 $8 $9

	if [ "$1" == "modules_install" ]; then
		$prefix find $PWD/${myinitramfs}/lib/modules -iname "*.ko" -exec mv {} $PWD/${myinitramfs}/lib/modules \;
		$prefix find $PWD/${myinitramfs}/lib/modules -maxdepth 1 -type d -not -iname "." -a -not -iname ".." -a -not -wholename "$PWD/${myinitramfs}/lib/modules" -exec rm -rf {} \;
		$prefix ${compiler}strip --strip-unneeded $PWD/${myinitramfs}/lib/modules/*.ko
	fi
fi
