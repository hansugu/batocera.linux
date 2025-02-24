################################################################################
#
# YABASANSHIRO
#
################################################################################
# Version.: Commits on Nov 3, 2020
LIBRETRO_YABASANSHIRO_VERSION = 233a31827cd32ccec4803800cb2f554e1c363d78
LIBRETRO_YABASANSHIRO_SITE = $(call github,libretro,yabause,$(LIBRETRO_YABASANSHIRO_VERSION))
LIBRETRO_YABASANSHIRO_LICENSE = GPLv2

LIBRETRO_YABASANSHIRO_PLATFORM = $(LIBRETRO_PLATFORM)

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_XU4),y)
	LIBRETRO_YABASANSHIRO_PLATFORM = odroid
	LIBRETRO_YABASANSHIRO_EXTRA_ARGS += BOARD=ODROID-XU4 FORCE_GLES=1
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDN2)$(BR2_PACKAGE_BATOCERA_TARGET_VIM3),y)
	LIBRETRO_YABASANSHIRO_PLATFORM = odroid-n2
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ROCKPRO64),y)
	LIBRETRO_YABASANSHIRO_PLATFORM = rockpro64
	LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI4),y)
	LIBRETRO_YABASANSHIRO_PLATFORM = rpi4
	LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_LIBRETECH_H5),y)
        LIBRETRO_YABASANSHIRO_PLATFORM = arm64
        LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC2),y)
        LIBRETRO_YABASANSHIRO_PLATFORM = c2
        LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_S912),y)
        LIBRETRO_YABASANSHIRO_PLATFORM = s912
        LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
endif

ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_ODROIDC4),y)
        LIBRETRO_YABASANSHIRO_PLATFORM = c4
        LIBRETRO_YABASANSHIRO_EXTRA_ARGS += FORCE_GLES=1
endif


define LIBRETRO_YABASANSHIRO_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/yabause/src/libretro -f Makefile \
		platform="$(LIBRETRO_YABASANSHIRO_PLATFORM)" $(LIBRETRO_YABASANSHIRO_EXTRA_ARGS)
endef

define LIBRETRO_YABASANSHIRO_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/yabause/src/libretro/yabasanshiro_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/yabasanshiro_libretro.so
endef

$(eval $(generic-package))
