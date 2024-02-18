#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/nothing/Pacman

# Asserts
TARGET_OTA_ASSERT_DEVICE := Pacman,PacmanEEA,PacmanIND,PacmanJPN

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a-dotprod
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT := cortex-a76
TARGET_CPU_VARIANT_RUNTIME := cortex-a76

IGNORE_PREFER32_ON_DEVICE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := Pacman
TARGET_NO_BOOTLOADER := true

# Plaform
TARGET_BOARD_PLATFORM := mt6886

# Inherit the proprietary files
include vendor/nothing/Pacman/BoardConfigVendor.mk
