#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from msm8916-common
include device/cyanogen/msm8916-common/BoardConfigCommon.mk

DEVICE_PATH := device/asus/x00ad

# Assertions
TARGET_BOARD_INFO_FILE := $(DEVICE_PATH)/board-info.txt

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(DEVICE_PATH)/bluetooth

# Camera
BOARD_CAMERA_SENSORS := s5k5e2_olq5f19 s5k3m2_olqba20
TARGET_PROCESS_SDK_VERSION_OVERRIDE := \
    /system/bin/cameraserver=22 \
    /system/bin/mediaserver=22 \
    /system/vendor/bin/mm-qcamera-daemon=22

# Dexpreopt
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    WITH_DEXPREOPT ?= true
  endif
endif
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY ?= true

# Filesystem
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 33553920
BOARD_CACHEIMAGE_PARTITION_SIZE := 157285888
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33553920
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 33553920
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612224
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13295385600
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# GPS
TARGET_NO_RPC := true

# Init
TARGET_INIT_VENDOR_LIB := libinit_msm8916
TARGET_RECOVERY_DEVICE_MODULES := libinit_msm8916

# Kernel
BOARD_DTBTOOL_ARGS := -2
BOARD_KERNEL_IMAGE_NAME := Image
BOARD_KERNEL_SEPARATED_DT := true
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
TARGET_KERNEL_SOURCE := kernel/asus/x00ad
TARGET_KERNEL_CONFIG := lineageos_x00ad_defconfig

# Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom

# Security patch level
VENDOR_SECURITY_PATCH := 2016-12-01

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy

# TWRP
ifeq ($(WITH_TWRP),true)
include $(DEVICE_PATH)/twrp.mk
endif

# Inherit from proprietary files
-include vendor/asus/x00ad/BoardConfigVendor.mk
