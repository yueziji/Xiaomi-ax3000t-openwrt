#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Compatibility patch:
# Current luci-app-vsftpd in openwrt-25.12 depends on +vsftpd.
# If this build uses vsftpd-alt, rewrite dependency so LuCI can coexist with vsftpd-alt.
for mk in \
  feeds/luci/applications/luci-app-vsftpd/Makefile \
  package/feeds/luci/luci-app-vsftpd/Makefile
do
  [ -f "$mk" ] || continue
  sed -i -e 's/LUCI_DEPENDS:=+luci-compat +vsftpd$/LUCI_DEPENDS:=+luci-compat +vsftpd-alt/' \
         -e 's/LUCI_DEPENDS:=+vsftpd$/LUCI_DEPENDS:=+vsftpd-alt/' \
         "$mk"
done
