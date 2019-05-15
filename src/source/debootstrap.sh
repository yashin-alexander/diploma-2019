bootstrap(){
  local ARCH=$(dpkg --print-architecture)

  if [ "$ARCH" !=  "arm64" ]; then
    local BOOTSTRAP_CMD=qemu-debootstrap
  else
    local BOOTSTRAP_CMD=debootstrap
  fi

  capsh --drop=cap_setfcap -- -c "${BOOTSTRAP_CMD} \
    --components=main,contrib,non-free \
    --arch arm64 \
    --variant=minbase \
    $1 $2 $3" || rmdir "$2/debootstrap"
}
export -f bootstrap
