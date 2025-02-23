#
# Copyright (C) 2018 The LineageOS Project
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

TARGET_TEGRA_HEALTH ?= aosp

# Enable nvidia framework enhancements if available
-include vendor/lineage/product/nvidia.mk

# System properties
include $(LOCAL_PATH)/system_prop.mk

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    device/nvidia/tegra-common/overlay

# Ramdisk
PRODUCT_PACKAGES += \
    adbenable \
    bt_loader \
    wifi_loader \
    init.comms.rc \
    init.data_bin.rc \
    init.hdcp.rc \
    init.none.rc \
    init.nv_dev_board.usb.rc \
    init.recovery.nv_dev_board.usb.rc \
    init.recovery.xusb.configfs.usb.rc \
    init.sata.configs.rc \
    init.tegra.rc \
    init.tegra_emmc.rc \
    init.tegra_sata.rc \
    init.tegra_sd.rc \
    init.xusb.configfs.usb.rc

PRODUCT_COPY_FILES += \
    system/core/rootdir/init.usb.configfs.rc:$(TARGET_COPY_OUT_ROOT)/init.recovery.usb.configfs.rc

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.usb.host.xml

# Audio
ifeq ($(TARGET_TEGRA_AUDIO),nvaudio)
PRODUCT_PACKAGES += \
    a2dp_module_deviceports.xml \
    a2dp_module_mixports.xml \
    primary_module_deviceports.xml \
    primary_module_mixports.xml \
    r_submix_audio_policy_configuration.xml \
    usb_module_deviceports.xml \
    usb_module_mixports.xml \
    ne_audio_policy_volumes.xml \
    ne_default_volume_tables.xml \
    msd_audio_policy_configuration.xml
endif

# Bluetooth
ifeq ($(TARGET_TEGRA_BT),bcm)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \

PRODUCT_PACKAGES += \
    libbt-vendor \
    android.hardware.bluetooth@1.0-service \
    android.hardware.bluetooth@1.0-impl
endif

# Graphics
ifeq ($(TARGET_TEGRA_GPU),drm)
PRODUCT_PACKAGES += \
    hwcomposer.drm \
    gralloc.gbm \
    libGLES_mesa
else ifeq ($(TARGET_TEGRA_GPU),swiftshader)
PRODUCT_PACKAGES += \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader \
    libyuv
endif

# Health HAL
ifeq ($(TARGET_TEGRA_HEALTH),aosp)
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service
endif

# Memtrack
ifeq ($(TARGET_TEGRA_MEMTRACK),lineage)
PRODUCT_PACKAGES += \
    android.hardware.memtrack@1.0-service-nvidia
endif

# PHS
ifeq ($(TARGET_TEGRA_PHS),nvphs)
PRODUCT_PACKAGES += \
    init.nvphsd_setup.rc \
    nvphsd.rc \
    nvphsd_common.conf \
    nvphsd_setup.sh
endif

# Power
ifeq ($(TARGET_TEGRA_POWER),lineage)
TARGET_POWERHAL_VARIANT := tegra
PRODUCT_PACKAGES += \
    vendor.nvidia.hardware.power@1.0-service
endif

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Wifi
ifeq ($(TARGET_TEGRA_WIFI),bcm)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml

PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    hostapd \
    wificond \
    libwpa_client \
    wpa_supplicant \
    wpa_supplicant.conf \
    p2p_supplicant_overlay.conf \
    wpa_supplicant_overlay.conf
endif

# Debug
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.adb.secure=0 \
    ro.secure=0 \
    ro.debuggable=1

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp,adb \
    persist.sys.root_access=2

