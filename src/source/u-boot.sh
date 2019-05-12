#!/bin/bash -e

U_BOOT_ARCHIVE_NAME="u-boot-${U_BOOT_VERSION}.tar.gz"
U_BOOT_SOURCE_LINK=\
"https://github.com/u-boot/u-boot/archive/v${U_BOOT_VERSION}.tar.gz"

if [ ! -f "${DOWNLOADS_DIR}/${U_BOOT_ARCHIVE_NAME}.done" ]; then
    wget ${U_BOOT_SOURCE_LINK} \
    --output-document=${DOWNLOADS_DIR}/${U_BOOT_ARCHIVE_NAME} --no-verbose
    touch "${DOWNLOADS_DIR}/${U_BOOT_ARCHIVE_NAME}.done"
fi

if [ ! -f "${U_BOOT_SRC}.done" ]; then
    tar -zxf ${DOWNLOADS_DIR}/${U_BOOT_ARCHIVE_NAME} \
        --directory ${U_BOOT_SRC} \
        --strip-components=1
    touch -f "${U_BOOT_SRC}.done"
fi
