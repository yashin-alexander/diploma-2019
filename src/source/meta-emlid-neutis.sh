#!/bin/bash -e

META_EMLID_NEUTIS_SOURCE_LINK="https://github.com/Neutis/meta-emlid-neutis.git"
META_EMLID_NEUTIS_BRANCH="sumo"
META_EMLID_NEUTIS_COMMIT_HASH=e020b06b5c5b36581ae72ab7a4b932913cdf96a0

if [ ! -d ${META_EMLID_NEUTIS_SRC} ]; then
  git clone -b ${META_EMLID_NEUTIS_BRANCH} \
  --single-branch ${META_EMLID_NEUTIS_SOURCE_LINK} ${META_EMLID_NEUTIS_SRC}
  git -C ${META_EMLID_NEUTIS_SRC} checkout ${META_EMLID_NEUTIS_COMMIT_HASH} >-
fi
