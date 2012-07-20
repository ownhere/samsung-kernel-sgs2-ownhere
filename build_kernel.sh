export ARCH=arm
export PATH=/opt/toolchains/arm-linux-androideabi-4.4.3/bin/:$PATH
export CROSS_COMPILE=/opt/toolchains/arm-linux-androideabi-4.4.3/bin/arm-linux-androideabi-
export USE_SEC_FIPS_MODE=true

make u1_chn_defconfig
make