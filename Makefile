include $(TOPDIR)/rules.mk
 
PKG_NAME:=l2-isolation
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
 
PKG_SOURCE_VERSION:=bb5e8692dfdfa69a8474a4811700e243236c478e

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/xize/l2-isolation
PKG_MIRROR_HASH:=skip

include $(INCLUDE_DIR)/package.mk
 
define Package/l2-isolation
  SECTION:=base
  CATEGORY:=Network
  TITLE:=L2 isolation utility
  #DESCRIPTION:=This variable is obsolete. use the Package/name/description define instead!
  URL:=https://github.com/xize/l2-iolation
  DEPENDS:=+ebtables-nft
endef
 
define Package/l2-isolation/description
 use L2 isolation on bridges
endef
 
define Build/Configure
  $(call Build/Configure/Default,--with-linux-headers=$(LINUX_DIR))
endef
 
define Package/l2-isolation/install
        $(INSTALL_BIN) $(PKG_BUILD_DIR)/files/etc/init.d/isolation $(1)/etc/init.d/isolation
		$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/usr/bin/set_isolation $(1)/usr/bin/set_isolation
endef

define Package/l2-isolation/postinst
	#!/bin/sh
	chmod +x /etc/init.d/isolation
	chmod +x /usr/bin/set_isolation
	/etc/init.d/isolation enable
	exit 0
endef
 
$(eval $(call BuildPackage,l2-isolation))
