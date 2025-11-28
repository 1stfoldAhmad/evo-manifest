# Customization Guide for Evolution X Build

This guide covers various customization options for your Evolution X build.

## 🎨 Build Customization

### 1. Build Variants

You can build different variants by changing the lunch target:

```bash
# User build (most stable, no root)
lunch lineage_rosemary-bp2a-user

# Userdebug build (recommended, includes debugging tools)
lunch lineage_rosemary-bp2a-userdebug

# Engineering build (full debugging, less secure)
lunch lineage_rosemary-bp2a-eng
```

### 2. Device Codename

For the "secret" variant of Redmi Note 10s, update these files:

**In GitHub Actions workflow:**
```yaml
DEVICE_NAME: secret
TARGET_NAME: lineage_secret-bp2a-userdebug
```

**Create new device tree** or symlink:
```bash
ln -s device/xiaomi/rosemary device/xiaomi/secret
```

## 🔧 Manifest Customization

### Add Custom Repositories

Edit `rosemary.xml` to add custom repositories:

```xml
<!-- Example: Add custom kernel -->
<project path="kernel/xiaomi/mt6785-custom"
         name="YOUR_USERNAME/custom_kernel_mt6785"
         remote="github"
         revision="custom-branch" />

<!-- Example: Add custom apps -->
<project path="packages/apps/MyCustomApp"
         name="YOUR_USERNAME/MyCustomApp"
         remote="github"
         revision="main" />
```

### Use Different Kernel

To use a different kernel source:

```xml
<!-- Replace LineageOS kernel with custom kernel -->
<project path="kernel/xiaomi/mt6785"
         name="YOUR_USERNAME/android_kernel_xiaomi_mt6785"
         remote="github"
         revision="your-custom-branch"
         clone-depth="1" />
```

### Add Prebuilt Kernel

If you have a prebuilt kernel:

```xml
<!-- Remove the kernel source project -->
<!-- Add prebuilt kernel in device tree instead -->
```

In your device tree `BoardConfig.mk`:
```makefile
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz
BOARD_PREBUILT_DTBOIMAGE := $(DEVICE_PATH)/prebuilt/dtbo.img
```

## 🌐 Add GApps

### Option 1: Use Built-in GMS

Evolution X includes minimal GMS by default. To customize:

**Edit device.mk:**
```makefile
# Minimal GApps
$(call inherit-product, vendor/gms/products/gms_minimal.mk)

# Or full GApps
$(call inherit-product, vendor/gms/products/gms_full.mk)
```

### Option 2: FlashableZIP GApps

Build without GApps and flash separately:

**In device.mk, remove GMS inheritance:**
```makefile
# Comment out or remove:
# $(call inherit-product, vendor/gms/...)
```

Users can then flash:
- NikGApps
- MindTheGapps
- OpenGApps

## 🎯 Custom Features

### Enable/Disable Features

**Edit device.mk:**

```makefile
# Face unlock
TARGET_FACE_UNLOCK_SUPPORTED := true

# Device Settings app
TARGET_DEVICE_SETTINGS := true

# Blur
TARGET_ENABLE_BLUR := true

# Pixel features
TARGET_SUPPORTS_GOOGLE_RECORDER := false
TARGET_INCLUDE_STOCK_ARCORE := false
TARGET_INCLUDE_LIVE_WALLPAPERS := true
```

### Custom Overlays

Create overlay to customize UI:

**device/xiaomi/rosemary/overlay/frameworks/base/core/res/res/values/config.xml:**

```xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <!-- Rounded corners -->
    <dimen name="rounded_corner_radius">28dp</dimen>
    
    <!-- Status bar height -->
    <dimen name="status_bar_height">28dp</dimen>
    
    <!-- Enable/disable features -->
    <bool name="config_supportDoze">true</bool>
</resources>
```

## 🔋 Performance Tweaks

### Build Optimization

**Edit device.mk:**

```makefile
# Enable Dex preopt for faster boot
WITH_DEXPREOPT := true
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := false

# Use speed compiler filter
PRODUCT_DEX_PREOPT_DEFAULT_COMPILER_FILTER := speed

# Enable ART optimizations
PRODUCT_ART_TARGET_INCLUDE_DEBUG_BUILD := false

# LTO (Link Time Optimization)
USE_THIN_LTO := true

# Enable HWUI renderscript
HWUI_COMPILE_FOR_PERF := true
```

### ccache Configuration

**For GitHub Actions, edit workflow:**

```yaml
- name: Configure ccache
  run: |
    ccache -M 100G  # Increase cache size
    ccache -o compression=true
    ccache -o compression_level=9  # Higher compression
```

## 📦 Add Custom Apps

### Include APKs in Build

**Create prebuilt app structure:**

```
device/xiaomi/rosemary/prebuilt/app/MyApp/
└── MyApp.apk
```

**In device.mk:**

```makefile
PRODUCT_PACKAGES += MyApp

# Define the module
LOCAL_PATH := device/xiaomi/rosemary/prebuilt/app/MyApp
include $(CLEAR_VARS)
LOCAL_MODULE := MyApp
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_CLASS := APPS
LOCAL_SRC_FILES := MyApp.apk
LOCAL_MODULE_SUFFIX := .apk
LOCAL_CERTIFICATE := PRESIGNED
include $(BUILD_PREBUILT)
```

### Remove Unwanted Apps

**In device.mk:**

```makefile
# Remove apps
PRODUCT_PACKAGES_REMOVE += \
    Email \
    Exchange2 \
    Calendar
```

## 🎵 Audio Customization

### Audio Effects

**Edit audio configs:**

```makefile
# In device.mk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml
```

### Enable Hi-Fi Audio

```makefile
# In BoardConfig.mk
AUDIO_FEATURE_ENABLED_HIFI_AUDIO := true
AUDIO_FEATURE_ENABLED_24BIT_AUDIO := true
```

## 📸 Camera Enhancements

### Use Custom Camera

**In device.mk:**

```makefile
# Add GCam or custom camera
PRODUCT_PACKAGES += \
    GCam \
    CustomCamera

# Or use AOSP camera
PRODUCT_PACKAGES += \
    Aperture
```

## 🌍 Localization

### Add Languages

**In device.mk:**

```makefile
PRODUCT_LOCALES := en_US es_ES fr_FR de_DE zh_CN ja_JP
```

## 🔐 Security Features

### Enable Verified Boot

**In BoardConfig.mk:**

```makefile
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
```

### SELinux Mode

**For enforcing mode:**

```makefile
# In BoardConfig.mk
BOARD_KERNEL_CMDLINE += androidboot.selinux=enforcing
```

**For permissive mode (not recommended):**

```makefile
BOARD_KERNEL_CMDLINE += androidboot.selinux=permissive
```

## 🔄 OTA Updates

### Enable OTA Updates

**Setup OTA server** (requires separate infrastructure):

```makefile
# In device.mk
PRODUCT_PROPERTY_OVERRIDES += \
    lineage.updater.uri=https://your-ota-server.com/api/v1/{device}/{type}/{incr}
```

### Generate OTA Package

```bash
# After build completes
./build/tools/releasetools/ota_from_target_files \
    -k build/target/product/security/testkey \
    out/target/product/rosemary/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip \
    ota_update.zip
```

## 🎮 Gaming Optimizations

**In device.mk:**

```makefile
# Enable GameSpace
PRODUCT_PACKAGES += GameSpace

# Performance mode
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.perf.supported=true

# Disable frame rate limit
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.disable_backpressure=1
```

## 🔍 Debugging Options

### Enable ADB by Default

**In device.mk:**

```makefile
PRODUCT_PROPERTY_OVERRIDES += \
    persist.service.adb.enable=1 \
    persist.service.debuggable=1 \
    persist.sys.usb.config=adb
```

### Logcat on Boot

```makefile
PRODUCT_PROPERTY_OVERRIDES += \
    persist.logd.size=1M \
    ro.debuggable=1
```

## 📊 Build Stats

### Enable Build Stats

**In GitHub Actions workflow:**

```yaml
- name: Generate build stats
  run: |
    du -sh evolution/out/target/product/rosemary/system
    du -sh evolution/out/target/product/rosemary/vendor
    du -sh evolution/out/target/product/rosemary/product
    find evolution/out/target/product/rosemary/ -name "*.img" -exec ls -lh {} \;
```

## 🚀 Quick Customization Checklist

- [ ] Choose build variant (user/userdebug/eng)
- [ ] Select GApps package (minimal/full/none)
- [ ] Enable/disable Evolution X features
- [ ] Add custom apps or remove unwanted ones
- [ ] Configure performance optimizations
- [ ] Set up custom overlays
- [ ] Configure audio/camera preferences
- [ ] Set SELinux mode
- [ ] Configure OTA updates (optional)
- [ ] Add debugging options if needed

## 💡 Tips

1. **Test incrementally**: Make one change at a time
2. **Keep backups**: Save working configurations
3. **Document changes**: Note what you modified
4. **Check compatibility**: Ensure custom features work with your device
5. **Monitor build size**: Keep ROM size reasonable

## 📝 Example Configuration Files

See the examples directory (if created) for:
- device.mk templates
- BoardConfig.mk examples
- Custom overlay configurations
- Patch files

## 🆘 Troubleshooting Custom Builds

### Build Fails After Customization
1. Revert last change
2. Check syntax in makefiles
3. Verify all paths are correct
4. Clean build output and retry

### ROM Boots but Features Don't Work
1. Check logcat for errors
2. Verify SELinux policies
3. Check property overrides
4. Verify library dependencies

---

**Happy Customizing! 🎨**

