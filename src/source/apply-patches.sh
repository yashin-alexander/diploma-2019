apply_patches()
{
  local patches_dir=$1
  local patchfiles=`ls $patches_dir | grep .patch`
  if [ -e "PATCHED" ]; then
    echo "${patches_dir} is patched already. Nothing to do."
  else
    for patch in $patchfiles; do
      echo "Applying $patch patchfile."
      patch --batch --silent -p1 -N < "${patches_dir}/${patch}"
    done;
    touch "PATCHED"
  fi
}
export -f apply_patches
