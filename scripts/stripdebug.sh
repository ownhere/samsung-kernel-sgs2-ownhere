#!/bin/sh
if [ ! -e .config ]; then
	echo "current dir not exists .config file. exit"
	exit
fi
for f in DEBUG_PREEMPT DEBUG_RT_MUTEXES DEBUG_SPINLOCK DEBUG_MUTEXES PROFILING PERF_EVENTS PERF_COUNTERS LATENCYTOP FTRACE
do
	sed -i s/CONFIG_$f=y/#\ CONFIG_$f\ is\ not\ set/g .config
done
