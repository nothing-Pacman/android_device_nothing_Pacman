#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Project ID Quota
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Enable virtual A/B over-the-air updates
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/vabc_features.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# Setup dalvik vm configs
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# A/B
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=$(BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=$(BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE) \
    POSTINSTALL_OPTIONAL_vendor=true

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

PRODUCT_PACKAGES += \
    update_engine \
    update_verifier \
    otapreopt_script \
    checkpoint_gc

# Audio
$(call soong_config_set,android_hardware_audio,run_64bit,true)

PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    android.hardware.audio@7.0-impl:64 \
    android.hardware.audio.effect@7.0-impl:64

PRODUCT_PACKAGES += \
    audioclient-types-aidl-cpp.vendor:64 \
    audio.bluetooth.default:64 \
    audio.usb.default:64

PRODUCT_PACKAGES += \
    libalsautils:64 \
    libopus.vendor:64 \
    libtinycompress:64 \
    libnbaio_mono:64 \
    libaudiofoundation.vendor:64

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio/,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.audio.pro.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.audio.pro.xml \

# Binder
PRODUCT_PACKAGES += \
    android.hidl.allocator@1.0.vendor:64 \
    android.hidl.memory@1.0.vendor:64

PRODUCT_PACKAGES += \
    libhidltransport:64 \
    libhidltransport.vendor:64 \
    libhwbinder.vendor:64 \
    libhwbinder:64

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth.audio-impl \
    android.hardware.bluetooth@1.1.vendor:64

PRODUCT_PACKAGES += \
    libbluetooth_audio_session

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.bluetooth_le.xml \

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.device@3.6.vendor:64 \
    android.hardware.camera.provider@2.6.vendor:64

PRODUCT_PACKAGES += \
    libcamera2ndk_vendor

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.camera.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.flash-autofocus.xml

# Debug filsystem
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Display
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.distinct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.distinct.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.xml \

# fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Filesystem table
PRODUCT_PACKAGES += \
    fstab.mt6886 \
    fstab.mt6886.vendor_ramdisk

# Init
PRODUCT_PACKAGES += \
    init.cgroup.rc \
    init.connectivity.rc \
    init.modem.rc \
    init.mt6886.rc \
    init.mt6886.usb.rc \
    init.project.rc \
    init.sensor_2_0.rc \
    init.stnfc.rc \
    stnfc_nt.rc \
    ueventd.mt6886.rc

# Kernel
PRODUCT_PACKAGES += \
    init.insmod.sh \
    init.insmod.cfg \
    init.mtkgki.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)-kernel/kernel:kernel

# Gatekeeper
PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-impl:64 \
    android.hardware.gatekeeper@1.0-service

# Graphics
PRODUCT_PACKAGES += \
    android.hardware.graphics.composer@2.3-service:64 \
    android.hardware.graphics.allocator@4.0.vendor:64 \
    android.hardware.memtrack-service.mediatek-mali:64 \

PRODUCT_PACKAGES += \
    libdrm.vendor:64

PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
	frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
	frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml

# Keymaster
PRODUCT_PACKAGES += \
    libkeymaster_messages.vendor:64 \
    libkeymaster_portable.vendor:64

PRODUCT_PACKAGES += \
    libkeymint.vendor:64 \
    libpuresoftkeymasterdevice.vendor:64

# Media
PRODUCT_PACKAGES += \
    libavservices_minijail_vendor:64 \
    libcodec2_hidl@1.1.vendor:64 \
    libcodec2_hidl@1.2.vendor:64 \
    libcodec2_soft_common.vendor:64 \
    libsfplugin_ccodec_utils.vendor:64 \
    libstagefright_foundation:64 \
    libstagefright_softomx_plugin.vendor:64

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/media,$(TARGET_COPY_OUT_VENDOR)/etc)

PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video_le.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_video_le.xml

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Properties
include $(LOCAL_PATH)/configs/properties/vendor_logtag.mk

# Recovery
PRODUCT_PACKAGES += \
    init.recovery.mt6886.rc

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0.vendor:64 \
    android.hardware.sensors@2.1.vendor:64 \
    android.frameworks.sensorservice@1.0.vendor:64

PRODUCT_PACKAGES += \
    libsensorndkbridge

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.sensor.dynamic.head_tracker.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.dynamic.head_tracker.xml

# Shipping API level
PRODUCT_SHIPPING_API_LEVEL := 33

# Script
PRODUCT_PACKAGES += \
    stnfc_nt.sh

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    device/nothing/Pacman \
    hardware/mediatek \
    hardware/nothing

# Inherit the proprietary files
$(call inherit-product, vendor/nothing/Pacman/Pacman-vendor.mk)
