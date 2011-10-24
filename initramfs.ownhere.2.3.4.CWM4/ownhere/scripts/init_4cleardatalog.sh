#!/system/bin/sh

if ! [ -e /data/log/disableautoclear ]; then
	rm -r /data/log/*
fi
