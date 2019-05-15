#!/bin/bash -e

GCC_LINARO_ARCHIVE_NAME="gcc-linaro.tar.gz"

if [ ! -f "${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME}.done" ]; then
    wget ${GCC_SOURCE_LINK} \
    --output-document=${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME} \
     --no-verbose
    touch "${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME}.done"
fi

if [ ! -f "${GCC_LINARO_SRC}.done" ]; then
    tar -xf ${DOWNLOADS_DIR}/${GCC_LINARO_ARCHIVE_NAME} \
        --directory ${GCC_LINARO_SRC} \
        --strip-components=1
    touch "${GCC_LINARO_SRC}.done"
fi
