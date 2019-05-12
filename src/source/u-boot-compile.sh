#!/bin/bash -e

export PATH="${GCC_LINARO_SRC}/bin:$PATH"

cp $ATF_SUNXI_SRC/build/sun50i_a64/debug/bl31.bin $U_BOOT_SRC
pushd $U_BOOT_SRC
apply_patches $META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-bsp/u-boot/u-boot
make CROSS_COMPILE=aarch64-linux-gnu- emlid_neutis_n5_defconfig
make CROSS_COMPILE=aarch64-linux-gnu- -j $CPU_CORES
popd
