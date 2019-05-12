#!/bin/bash -e

ROCKO_META_EMLID_NEUTIS_HASH=858be875304f728db22a7f921dfd2ee635b9a191

PACKAGE_NAME=neutis-n5-initramfs
PACKAGE_DEB_DIR=${STAGE_WORK_DIR}/packages/${PACKAGE_NAME}
META_EMLID_NEUTIS_BSP=${META_EMLID_NEUTIS_SRC}/meta-neutis-bsp

mkdir -p ${PACKAGE_DEB_DIR}/boot
mkdir -p ${PACKAGE_DEB_DIR}/DEBIAN

pushd ${STAGE_WORK_DIR}
cp \
${META_EMLID_NEUTIS_SRC}/meta-neutis-bsp/recipes-bsp/u-boot/u-boot/boot.cmd .
apply_patches ${SUB_STAGE_DIR}/files
mkimage -C none -A arm -T script -d boot.cmd boot.scr
cp boot.scr ${PACKAGE_DEB_DIR}/boot
rm PATCHED
popd

cp $META_EMLID_NEUTIS_SRC/meta-neutis-bsp/recipes-bsp/u-boot/u-boot/Env.txt\
 $PACKAGE_DEB_DIR/boot

git -C ${META_EMLID_NEUTIS_SRC} checkout ${ROCKO_META_EMLID_NEUTIS_HASH} >-
cp \
${META_EMLID_NEUTIS_BSP}/recipes-bsp/neutis-initramfs/files/uInitrd \
${PACKAGE_DEB_DIR}/boot
git -C ${META_EMLID_NEUTIS_SRC} checkout - >-

build_deb_package
install_deb_package
