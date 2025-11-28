# Device Setup Guide for Redmi Note 10s (rosemary/secret)

This guide will help you prepare the device-specific files needed to build Evolution X for your Redmi Note 10s.

## 📂 Required Repositories

You need to create and populate these repositories on your GitHub account:

### 1. Device Tree (`android_device_xiaomi_rosemary`)
### 2. Device Common Tree (`android_device_xiaomi_mt6785-common`)
### 3. Vendor Blobs (`android_vendor_xiaomi_rosemary`)
### 4. Vendor Common Blobs (`android_vendor_xiaomi_mt6785-common`)

## 🔍 Finding Existing Device Trees

Before creating from scratch, check if someone has already created device trees:

1. **GitHub Search**:
   - Search: `xiaomi rosemary device tree`
   - Search: `xiaomi mt6785 device tree`
   - Look for LineageOS or other AOSP-based ROMs

2. **Common Sources**:
   - https://github.com/LineageOS-MT6785
   - https://github.com/xiaomi-mt6785
   - Check XDA Developers forums

3. **Similar Devices**:
   - Look for other Redmi Note 10 series devices
   - Check other MT6785 devices (Redmi Note 9 Pro 5G)

## 🛠️ Creating Device Tree from Scratch

If you can't find existing trees, you'll need to create them:

### Step 1: Extract Proprietary Files

You need a stock ROM or running device to extract vendor blobs.

#### Option A: From Running Device (Recommended)

```bash
# Install ADB and connect your device
adb devices

# Create extraction directory
mkdir -p ~/android/vendor_extract
cd ~/android/vendor_extract

# Get LineageOS extract scripts
git clone https://github.com/LineageOS/android_tools_extract-utils tools

# Create a basic extraction script (extract-files.sh)
cat > extract-files.sh << 'EOF'
#!/bin/bash

DEVICE=rosemary
VENDOR=xiaomi

# Create vendor directory structure
mkdir -p vendor/${VENDOR}/${DEVICE}/proprietary

# Extract files from device
adb pull /system/lib vendor/${VENDOR}/${DEVICE}/proprietary/lib
adb pull /system/lib64 vendor/${VENDOR}/${DEVICE}/proprietary/lib64
adb pull /system/bin vendor/${VENDOR}/${DEVICE}/proprietary/bin
adb pull /system/etc vendor/${VENDOR}/${DEVICE}/proprietary/etc
adb pull /vendor vendor/${VENDOR}/${DEVICE}/proprietary/vendor
adb pull /product vendor/${VENDOR}/${DEVICE}/proprietary/product
adb pull /system_ext vendor/${VENDOR}/${DEVICE}/proprietary/system_ext

echo "Extraction complete!"
EOF

chmod +x extract-files.sh
./extract-files.sh
```

#### Option B: From Stock ROM

```bash
# Download stock ROM (MIUI for rosemary)
# Extract system, vendor, product partitions using:
# - payload_dumper (for payload.bin)
# - android-simg2img (for sparse images)

# Tools you'll need:
pip3 install brotli protobuf pycrypto

# Use payload-dumper-go for extraction
git clone https://github.com/ssut/payload-dumper-go
cd payload-dumper-go
go build
./payload-dumper-go /path/to/payload.bin
```

### Step 2: Create Basic Device Tree Structure

```bash
mkdir -p ~/android/device/xiaomi/rosemary
cd ~/android/device/xiaomi/rosemary
```

#### Create `AndroidProducts.mk`:

```makefile
PRODUCT_MAKEFILES := \
    $(LOCAL_DIR)/lineage_rosemary.mk

COMMON_LUNCH_CHOICES := \
    lineage_rosemary-user \
    lineage_rosemary-userdebug \
    lineage_rosemary-eng
```

#### Create `lineage_rosemary.mk`:

```makefile
# Inherit from rosemary device
$(call inherit-product, device/xiaomi/rosemary/device.mk)

# Inherit some common Evolution X stuff
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier
PRODUCT_NAME := lineage_rosemary
PRODUCT_DEVICE := rosemary
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := Redmi Note 10s
PRODUCT_MANUFACTURER := Xiaomi

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

# Build fingerprint
BUILD_FINGERPRINT := Redmi/rosemary/rosemary:13/TP1A.220624.014/V14.0.3.0.TKLMIXM:user/release-keys
```

#### Create `device.mk`:

```makefile
DEVICE_PATH := device/xiaomi/rosemary

# Inherit from mt6785-common
$(call inherit-product, device/xiaomi/mt6785-common/mt6785.mk)

# Kernel
TARGET_KERNEL_CONFIG := rosemary_defconfig
TARGET_KERNEL_SOURCE := kernel/xiaomi/mt6785

# Inherit vendor blobs
$(call inherit-product, vendor/xiaomi/rosemary/rosemary-vendor.mk)
```

#### Create `BoardConfig.mk`:

```makefile
DEVICE_PATH := device/xiaomi/rosemary

# Inherit from mt6785-common
include device/xiaomi/mt6785-common/BoardConfigCommon.mk

# Kernel
TARGET_KERNEL_CONFIG := rosemary_defconfig
BOARD_KERNEL_IMAGE_NAME := Image.gz
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/Image.gz

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3758096384
BOARD_USERDATAIMAGE_PARTITION_SIZE := 119548821504
BOARD_VENDORIMAGE_PARTITION_SIZE := 1073741824
BOARD_PRODUCTIMAGE_PARTITION_SIZE := 1073741824
BOARD_CACHEIMAGE_PARTITION_SIZE := 452984832

# File systems
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Verified Boot
BOARD_AVB_ENABLE := true
```

### Step 3: Create Common Device Tree

Create a separate repository for common MT6785 configurations:

```bash
mkdir -p ~/android/device/xiaomi/mt6785-common
cd ~/android/device/xiaomi/mt6785-common
```

This should contain:
- Common hardware configurations
- Common MediaTek-specific settings
- Shared overlays and properties

### Step 4: Generate Vendor Blobs Repository

Use the extracted files to create vendor blobs:

```bash
cd ~/android
mkdir -p vendor/xiaomi/rosemary

# Create vendor.mk
cat > vendor/xiaomi/rosemary/rosemary-vendor.mk << 'EOF'
PRODUCT_SOONG_NAMESPACES += \
    vendor/xiaomi/rosemary

PRODUCT_COPY_FILES += \
    vendor/xiaomi/rosemary/proprietary/lib/libexample.so:$(TARGET_COPY_OUT_SYSTEM)/lib/libexample.so
# Add all extracted files here
EOF
```

## 📝 Important Files to Configure

### 1. `system.prop`
System properties for your device.

### 2. `vendor.prop`
Vendor-specific properties.

### 3. SELinux Policies
Located in `sepolicy/vendor/` directory.

### 4. Device Overlays
In `overlay/` directory for UI customizations.

### 5. Init Scripts
In `rootdir/etc/` for initialization.

## 🔍 Finding Device Specifications

You'll need these specs for BoardConfig.mk:

```bash
# From your device:
adb shell cat /proc/partitions
adb shell cat /proc/cpuinfo
adb shell cat /proc/meminfo
adb shell getprop ro.build.fingerprint
adb shell getprop ro.product.board
```

## 🧪 Testing Your Device Tree

### Build test:
```bash
cd ~/evolution
source build/envsetup.sh
lunch lineage_rosemary-userdebug
m bacon
```

### Common Errors:
1. **Missing HALs**: Check vendor blobs extraction
2. **Kernel errors**: Verify kernel config and source
3. **SELinux denials**: Review and fix sepolicy rules

## 📚 Reference Devices

Look at similar device trees for guidance:

### MediaTek MT6785 Devices:
- Redmi Note 9 Pro 5G (gauguin)
- Realme devices with MT6785

### Similar Configurations:
- https://github.com/LineageOS/android_device_xiaomi_surya
- https://github.com/LineageOS/android_device_xiaomi_karna

## 🔗 Useful Resources

- **LineageOS Device Tree Guide**: https://wiki.lineageos.org/devices/
- **MediaTek Developer Portal**: https://github.com/MediaTek
- **XDA Forums**: Search for "Redmi Note 10s development"
- **Telegram Groups**: Join device-specific developer groups

## 📦 Repository Structure

Your final repository structure should look like:

```
device/xiaomi/rosemary/
├── AndroidProducts.mk
├── BoardConfig.mk
├── device.mk
├── lineage_rosemary.mk
├── extract-files.sh
├── setup-makefiles.sh
├── overlay/
│   ├── frameworks/
│   └── packages/
├── rootdir/
│   └── etc/
├── sepolicy/
│   └── vendor/
└── proprietary-files.txt

vendor/xiaomi/rosemary/
├── rosemary-vendor.mk
├── BoardConfigVendor.mk
└── proprietary/
    ├── bin/
    ├── lib/
    ├── lib64/
    ├── etc/
    └── vendor/
```

## ⚙️ Kernel Configuration

The manifest already includes LineageOS 23.0 kernel. Ensure your device tree references it correctly:

```makefile
# In BoardConfig.mk
TARGET_KERNEL_SOURCE := kernel/xiaomi/mt6785
TARGET_KERNEL_CONFIG := rosemary_defconfig
```

If `rosemary_defconfig` doesn't exist, you may need to:
1. Use a similar config (like `secret_defconfig`)
2. Create one based on stock kernel config
3. Extract from stock kernel

## 🚀 Quick Start Checklist

- [ ] Find or create device tree
- [ ] Extract vendor blobs from stock ROM or device
- [ ] Create vendor repository with extracted blobs
- [ ] Configure kernel source (using LineageOS 23.0)
- [ ] Update `rosemary.xml` with your repository URLs
- [ ] Test build locally or with GitHub Actions
- [ ] Fix any build errors
- [ ] Flash and test on device
- [ ] Report issues and iterate

## 💡 Tips

1. **Start with existing trees**: Don't reinvent the wheel
2. **Join communities**: Telegram/Discord groups are very helpful
3. **Document changes**: Keep notes of what you modify
4. **Test incrementally**: Don't make too many changes at once
5. **Use git**: Version control is your friend
6. **Ask for help**: Developer communities are usually helpful

## 🤝 Need Help?

If you're stuck:
1. Check build logs carefully
2. Search for error messages online
3. Compare with working device trees
4. Ask in XDA or Telegram groups
5. Review LineageOS wiki

---

**Good luck with your device setup! 📱**

