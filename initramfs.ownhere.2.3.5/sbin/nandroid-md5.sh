#!/sbin/sh
cd $1
md5sum * .* > nandroid.md5
# need this because wildcard seems to cause md5sum to return 1
if [ -f nandroid.md5 ]
then
  return 0
else
  return 1
fi
