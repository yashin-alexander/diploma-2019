build_deb_package()
{
  local package_name=${PACKAGE_DEB_DIR}.deb

  cp files/control ${PACKAGE_DEB_DIR}/DEBIAN
  fakeroot dpkg-deb --build ${PACKAGE_DEB_DIR}
  cp ${package_name} ${ROOTFS_DIR}/var/cache/apt/archives
}
export -f build_deb_package

install_deb_package()
{
  local package_name=${PACKAGE_NAME}.deb
  on_chroot << EOF
dpkg -i /var/cache/apt/archives/${package_name}
EOF
}
