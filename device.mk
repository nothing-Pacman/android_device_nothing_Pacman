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

# Debug filsystem
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

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

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Properties
include $(LOCAL_PATH)/configs/properties/vendor_logtag.mk

# Recovery
PRODUCT_PACKAGES += \
    init.recovery.mt6886.rc

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
