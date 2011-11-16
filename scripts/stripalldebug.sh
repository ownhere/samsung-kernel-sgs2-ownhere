#!/bin/sh
if [ ! -e .config ]; then
	echo "current dir not exists .config file. exit"
	exit
fi
perl -p -i -e "s/(.*)DEBUG(.*)=y/# \1DEBUG\2 is not set/" .config
