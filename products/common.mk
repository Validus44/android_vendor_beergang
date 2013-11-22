# Generic product
PRODUCT_NAME := beergang
PRODUCT_BRAND := beergang
PRODUCT_DEVICE := generic

# Inherit kitkat audio package.


# Common overrides
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Build Launcher 3
PRODUCT_PACKAGES += \
    Launcher3 \

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/beergang/overlay/common

# World APN list
PRODUCT_COPY_FILES += \
    vendor/beergang/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml
    
# World SPN overrides list
PRODUCT_COPY_FILES += \
    vendor/beergang/prebuilt/common/etc/spn-conf.xml:system/etc/spn-conf.xml

# Latin IME lib
PRODUCT_COPY_FILES += \
    vendor/beergang/proprietary/common/system/lib/libjni_latinime.so:system/lib/libjni_latinime.so

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml
    
# T-Mobile theme engine
#include vendor/beergang/products/themes_common.mk

# Boot animation include
ifneq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))

# determine the smaller dimension
TARGET_BOOTANIMATION_SIZE := $(shell \
  if [ $(TARGET_SCREEN_WIDTH) -lt $(TARGET_SCREEN_HEIGHT) ]; then \
    echo $(TARGET_SCREEN_WIDTH); \
  else \
    echo $(TARGET_SCREEN_HEIGHT); \
  fi )

# get a sorted list of the sizes
bootanimation_sizes := $(subst .zip,, $(shell ls vendor/beergang/prebuilt/common/bootanimation))
bootanimation_sizes := $(shell echo -e $(subst $(space),'\n',$(bootanimation_sizes)) | sort -rn)

# find the appropriate size and set
define check_and_set_bootanimation
$(eval TARGET_BOOTANIMATION_NAME := $(shell \
  if [ -z "$(TARGET_BOOTANIMATION_NAME)" ]; then
    if [ $(1) -le $(TARGET_BOOTANIMATION_SIZE) ]; then \
      echo $(1); \
      exit 0; \
    fi;
  fi;
  echo $(TARGET_BOOTANIMATION_NAME); ))
endef
$(foreach size,$(bootanimation_sizes), $(call check_and_set_bootanimation,$(size)))

PRODUCT_COPY_FILES += \
    vendor/beergang/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif
    
# Versioning System
 PRODUCT_VERSION_MAJOR = alpha
 PRODUCT_VERSION_MINOR = 0
 PRODUCT_VERSION_MAINTENANCE = 4
 BEERGANG_POSTFIX := -$(shell date +"%Y%m%d-%H%M")


# Motox dalvik patch
    ifneq ($(filter beergang_mako,$(TARGET_PRODUCT)),)
    $(call inherit-product, vendor/beergang/products/motoxdalvikpatch.mk)
endif
