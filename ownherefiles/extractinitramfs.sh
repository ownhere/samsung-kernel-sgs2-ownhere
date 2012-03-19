#!/bin/sh

if [ $# -lt 1 ]; then
	echo "Usage:$0 <zImage filename>"
	exit
fi
zImage=$1
pos=`grep -P -a -b --only-matching '\x1F\x8B\x08' $zImage | cut -f 1 -d : | awk '(int($0)<50000){print $0;exit}'`
zipfunc="gzip -d"
if [ "$pos" == "" ];then
	pos=`grep -P -a -b --only-matching '\135\0\0\0' $zImage | cut -f 1 -d : | awk '(int($0)<50000){print $0;exit}'`
	zipfunc="lzma -d"
	if [ "$pos" == "" ];then
		pos=`grep -P -a -b --only-matching '\211\114\132' $zImage | head -2 |tail -1|cut -f 1 -d : | awk '(int($0)<50000){print $0;exit}'`
		zipfunc="lzop -d"
		if [ "$pos" == "" ];then
			pos=`grep -P -a -b --only-matching '\xfd\x37\x7a\x58\x5a' $zImage | head -2 |tail -1|cut -f 1 -d : | awk '(int($0)<50000){print $0;exit}'`
			zipfunc="xz -d"
		fi
	fi
fi
if [ "$pos" == "" ];then
	echo "can not found kernel compress header, may be invalid zImage."
	exit
fi
dd if=$zImage bs=$pos skip=1 | $zipfunc > ${zImage}.uncompress
echo "${zImage} use ${zipfunc} decompress to ${zImage}.uncompress"

start=`grep -a -b --only-matching '070701' ${zImage}.uncompress | head -1 | cut -f 1 -d :`
end=`grep -a -b --only-matching 'TRAILER!!!' ${zImage}.uncompress | awk -F ':' '{pos=$1;if (pos<10000000) { if (pos>max) {max=pos}}}END{print max}'`

end=$((end + 10))
count=$((end - start))
zipfunc=""
echo "initramfs size is :$count"

if [ $count -lt 1000000 ]; then
	pos=`grep -P -a -b --only-matching '\x1F\x8B\x08' ${zImage}.uncompress | cut -f 1 -d : | awk '(int($0)<200000){print $0;exit}'`
	zipfunc="gzip -d"
	if [ "$pos" == "" ]; then
		pos=`grep -P -a -b --only-matching '\135\0\0\0' ${zImage}.uncompress | cut -f 1 -d : | awk '(int($0)<200000){print $0;exit}'`
		zipfunc="unlzma"
		if [ "$pos" == "" ];then
			pos=`grep -P -a -b --only-matching '\211\114\132' $zImage | cut -f 1 -d : | awk '(int($0)<200000){print $0;exit}'`
			zipfunc="lzop -d"
			if [ "$pos" == "" ];then
				pos=`grep -P -a -b --only-matching '\xfd\x37\x7a\x58\x5a' $zImage | cut -f 1 -d : | awk '(int($0)<200000){print $0;exit}'`
				zipfunc="xz -d"
			fi
		fi
	fi
	if [ "$pos" == "" ]; then
		echo "can not found initramfs in ${zImage}, may be invalid zImage."
		exit
	fi
	dd if=${zImage}.uncompress bs=$pos skip=1 | $zipfunc > ${zImage}.initramfs.cpio
else
	dd if=${zImage}.uncompress ibs=$start skip=1 of=${zImage}.temp
	dd if=${zImage}.temp bs=$count count=1 of=${zImage}.initramfs.cpio
	rm -f ${zImage}.temp
fi
echo "${zImage}'s initramfs use ${zipfunc} extract to ${zImage}.initramfs.cpio"
