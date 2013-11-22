# Inherit AOSP device configuration for mako.
$(call inherit-product, device/motorola/xt907/full_xt907.mk)

# Inherit common product files.
$(call inherit-product, vendor/beergang/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := aosp_xt907
PRODUCT_BRAND := motorola
PRODUCT_DEVICE := xt907
PRODUCT_MODEL := Razr M
PRODUCT_MANUFACTURER := motorola

PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=xt907 BUILD_FINGERPRINT="motorola/xt907/xt907:4.4/KRT16S/920375:user/release-keys" PRIVATE_BUILD_DESC="razor-user 4.4 KRT16S 920375 release-keys"

PRODUCT_COPY_FILES += \
    vendor/beergang/prebuilt/common/bootanimation/540.zip:system/media/bootanimation.zip

# Build SimToolKit
PRODUCT_PACKAGES += \
    Stk

# Inherit media effect blobs
-include vendor/beergang/products/common_media_effects.mk
