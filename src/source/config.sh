apply_config_file()
{
  if [ -f config ]; then
	  source config
  fi
  if [ -z "${IMG_NAME}" ]; then
    IMAGE_NAME="neutis-n5-xenial"
  fi
  if [ -z "${CPU_CORES}" ]; then
	  CPU_CORES=1
  fi
}

set_up_stages_skip()
{
  log "Begin set_up_stages_skip"
  find . -name "SKIP" | xargs rm -f
  if [ -n "$SKIP_STAGES" ]; then
    for STAGE_IDENTITIES in ${SKIP_STAGES}; do
      STAGE_SUFFIX=`echo ${STAGE_IDENTITIES} | awk -F: '{print $1}'`
      SUBSTAGE_PREFIX=`echo ${STAGE_IDENTITIES} | awk -F: '{print $2}'`
      stage_dir=${BASE_DIR}/stage${STAGE_SUFFIX}
      if [ -z "${SUBSTAGE_PREFIX}" -a -d ${stage_dir} ]; then
        log "Create SKIP file for directory ${stage_dir}"
        touch $stage_dir/SKIP
      fi
      if  [ -n "${SUBSTAGE_PREFIX}" ]; then
        for substage_dir in $stage_dir/${SUBSTAGE_PREFIX}*; do
          log "Create SKIP file for directory ${substage_dir}"
          touch ${substage_dir}/SKIP
        done
      fi
    done
  fi
  log "End set_up_stages_skip"
}

set_up_export_stages()
{
  log "Begin set_up_export_stages"
  find . -name "EXPORT_IMAGE" | xargs rm -f
  if [ -n "$EXPORT_STAGES" ]; then
      for STAGE_IDENTITIES in ${EXPORT_STAGES}; do
      STAGE_SUFFIX=`echo ${STAGE_IDENTITIES} | awk -F: '{print $1}'`
      IMG_SUFFIX=`echo ${STAGE_IDENTITIES} | awk -F: '{print $2}'`
      stage_dir=${BASE_DIR}/stage${STAGE_SUFFIX}
      if [ -z "${IMG_SUFFIX}" ]; then
        IMG_SUFFIX="${DEFAULT_DEVICE_NAME}-stage${STAGE_SUFFIX}"
      fi
      if [ -d ${stage_dir} ]; then
        log "Create EXPORT_IMAGE file for directory ${stage_dir}"
        printf "IMG_SUFFIX=\"${IMG_SUFFIX}\"" > ${stage_dir}/EXPORT_IMAGE
      fi
    done
  fi
  log "End set_up_export_stages"
}
