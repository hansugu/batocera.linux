##########################################################™™######################
#
# MAME
#
################################################################################
# Version: Commits on Nov 16, 2020 (0.226)
LIBRETRO_MAME_VERSION = 78361d7b213c4d011ebfa73321f659cb5400fd22
LIBRETRO_MAME_SITE = $(call github,libretro,mame,$(LIBRETRO_MAME_VERSION))
LIBRETRO_MAME_LICENSE = MAME
# install in staging for debugging (gdb)
LIBRETRO_MAME_INSTALL_STAGING=YES

ifeq ($(BR2_x86_64),y)
	LIBRETRO_MAME_EXTRA_ARGS += PTR64=1 LIBRETRO_CPU=x86_64 PLATFORM=x86_64
endif

ifeq ($(BR2_i386),y)
	LIBRETRO_MAME_EXTRA_ARGS += PTR64=0 LIBRETRO_CPU=x86 PLATFORM=x86
endif

ifeq ($(BR2_arm),y) 
	LIBRETRO_MAME_EXTRA_ARGS += PTR64=0 LIBRETRO_CPU=arm PLATFORM=arm
	# workaround for asmjit broken build system (arm backend is not public)
	LIBRETRO_MAME_ARCHOPTS += -D__arm__ -DASMJIT_BUILD_X86
endif

ifeq ($(BR2_aarch64),y)
	LIBRETRO_MAME_EXTRA_ARGS += PTR64=1 LIBRETRO_CPU= PLATFORM=arm64
	# workaround for asmjit broken build system (arm backend is not public)
	LIBRETRO_MAME_ARCHOPTS += -D__aarch64__ -DASMJIT_BUILD_X86
endif

ifeq ($(BR2_ENABLE_DEBUG),y)
	LIBRETRO_MAME_EXTRA_ARGS += SYMBOLS=1 SYMLEVEL=2 OPTIMIZE=0
endif

define LIBRETRO_MAME_BUILD_CMDS
	# create some dirs while with parallelism, sometimes it fails because this directory is missing
	mkdir -p $(@D)/build/libretro/obj/x64/libretro/src/osd/libretro/libretro-internal

	$(MAKE) -C $(@D)/ OPENMP=1 REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2            \
		CONFIG=libretro LIBRETRO_OS="unix" ARCH="" PROJECT="" ARCHOPTS="$(LIBRETRO_MAME_ARCHOPTS)" \
		DISTRO="debian-stable" OVERRIDE_CC="$(TARGET_CC)" OVERRIDE_CXX="$(TARGET_CXX)"             \
		OVERRIDE_LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)"                     \
		$(LIBRETRO_MAME_EXTRA_ARGS) CROSS_BUILD=1 TARGET="mame" SUBTARGET="arcade" RETRO=1         \
		OSD="retro" DEBUG=0
endef

define LIBRETRO_MAME_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mamearcade_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mame_libretro.so
endef

define LIBRETRO_MAME_INSTALL_STAGING_CMDS
	$(INSTALL) -D $(@D)/mamearcade_libretro.so \
		$(STAGING_DIR)/usr/lib/libretro/mame_libretro.so
endef

$(eval $(generic-package))
