#
# Copyright (C) 2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Audio
USE_XML_AUDIO_POLICY_CONF := 1

# Exclude AudioFX
TARGET_EXCLUDES_AUDIOFX := true

# Bluetooth
ifeq ($(TARGET_TEGRA_BT),bcm)
BOARD_HAVE_BLUETOOTH     := true
BOARD_HAVE_BLUETOOTH_BCM := true
DEVICE_MANIFEST_FILE     += device/nvidia/tegra-common/manifests/bcm_bluetooth.xml
endif

# Graphics
ifeq ($(TARGET_TEGRA_GPU),drm)
BOARD_GPU_DRIVERS         ?= nouveau
BOARD_USES_DRM_HWCOMPOSER := true
DEVICE_MANIFEST_FILE      += device/nvidia/tegra-common/manifests/drm.xml
TARGET_USES_HWC2          := true
else ifeq ($(TARGET_TEGRA_GPU),swiftshader)
TARGET_USES_HWC2          := true
endif

# Health
ifeq ($(TARGET_TEGRA_HEALTH),aosp)
DEVICE_MANIFEST_FILE += device/nvidia/tegra-common/manifests/health.xml
endif

# Memtrack
ifeq ($(TARGET_TEGRA_MEMTRACK),lineage)
include hardware/nvidia/memtrack/BoardMemtrack.mk
endif

# Omx
ifeq ($(TARGET_TEGRA_OMX),software)
DEVICE_MANIFEST_FILE += device/nvidia/tegra-common/manifests/omx.xml
endif

# Power
ifeq ($(TARGET_TEGRA_POWER),lineage)
include hardware/nvidia/power/BoardPower.mk
endif

# Sepolicy
#BOARD_SEPOLICY_DIRS += \
    device/nvidia/tegra-common/sepolicy/upstream \
    device/nvidia/tegra-common/sepolicy/lineage

# TWRP Support
ifeq ($(WITH_TWRP),true)
include device/nvidia/tegra-common/twrp.mk
endif

# Usb
DEVICE_MANIFEST_FILE += device/nvidia/tegra-common/manifests/usb.xml

# Wifi
ifeq ($(TARGET_TEGRA_WIFI),bcm)
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE                := bcmdhd
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_bcmdhd
WIFI_DRIVER_FW_PATH_STA          := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_AP           := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P          := "/vendor/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_PARAM        := "/data/vendor/wifi/fw_path"
WIFI_DRIVER_MODULE_ARG           := "iface_name=wlan0"
WIFI_DRIVER_MODULE_NAME          := "bcmdhd"
DEVICE_MANIFEST_FILE             += device/nvidia/tegra-common/manifests/bcm_wifi.xml
endif
