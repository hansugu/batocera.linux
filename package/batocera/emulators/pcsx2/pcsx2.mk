################################################################################
#
# PCSX2
#
################################################################################

PCSX2_VERSION = c998a51f71f6a81a2f4f0c9d27c85714d74ccd57
PCSX2_SITE = $(call github,pcsx2,pcsx2,$(PCSX2_VERSION))
PCSX2_LICENSE = GPLv2 GPLv3 LGPLv2.1 LGPLv3
PCSX2_DEPENDENCIES = xserver_xorg-server alsa-lib freetype zlib libpng wxwidgets libaio portaudio libsoundtouch sdl2 libpcap yaml-cpp libgtk3

PCSX2_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release
PCSX2_CONF_OPTS += -DXDG_STD=TRUE
PCSX2_CONF_OPTS += -DSDL2_API=TRUE
PCSX2_CONF_OPTS += -DDISABLE_PCSX2_WRAPPER=1
PCSX2_CONF_OPTS += -DPACKAGE_MODE=FALSE
PCSX2_CONF_OPTS += -DwxWidgets_CONFIG_EXECUTABLE="$(STAGING_DIR)/usr/bin/wx-config"
PCSX2_CONF_OPTS += -DPCSX2_TARGET_ARCHITECTURES=x86_64
PCSX2_CONF_OPTS += -DENABLE_TESTS=OFF
PCSX2_CONF_OPTS += -DUSE_SYSTEM_YAML=ON
PCSX2_CONF_OPTS += -DEXTRA_PLUGINS=TRUE
#PCSX2_CONF_OPTS += -DwxUSE_UNICODE=0
#PCSX2_CONF_OPTS += -DwxUSE_UNICODE_UTF8=0
PCSX2_CONF_OPTS += -DBUILD_SHARED_LIBS=ON
PCSX2_CONF_OPTS += -DDISABLE_ADVANCE_SIMD=ON
PCSX2_CONF_OPTS += -DUSE_VTUNE=OFF

# https://github.com/PCSX2/pcsx2/blob/51ceec74a351bd25a1066ec2c02c2aa3f8c813f4/cmake/BuildParameters.cmake#L215
# DITCH PCSX2_CONF_OPTS += -DARCH_FLAG="-msse -msse2 -mfxsr -mxsave -march=x86_64"

define PCSX2_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/pcsx2/PCSX2 $(TARGET_DIR)/usr/PCSX/bin/PCSX2
	cp -pr $(@D)/bin/Langs      $(TARGET_DIR)/usr/PCSX/bin
        mkdir -p $(TARGET_DIR)/usr/PCSX/bin/plugins
	cp -pr $(@D)/plugins/*/*.so $(TARGET_DIR)/usr/PCSX/bin/plugins
endef

$(eval $(cmake-package))
