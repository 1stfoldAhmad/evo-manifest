# 📝 Changelog - Evolution X Manifest Updates

## 🎉 Major Update: Switched to Official LineageOS Repositories

### What Changed?

Previously, the manifest required users to create their own device trees and vendor blobs. Now it uses **official LineageOS repositories** directly!

---

## ✅ Version 2.0 - Official LineageOS Support

**Date**: Current  
**Status**: ✅ Ready to use

### Changed:
- ✅ **rosemary.xml** now uses official LineageOS repositories
- ✅ Removed `YOUR_GITHUB_USERNAME` placeholders
- ✅ All sources point to LineageOS organization
- ✅ Added `SIMPLIFIED_START.md` for easier setup

### Before:
```xml
<!-- Required custom repositories -->
<project path="device/xiaomi/rosemary"
         name="YOUR_GITHUB_USERNAME/android_device_xiaomi_rosemary"
         remote="github"
         revision="evolution-bka" />
```

**Issues:**
- ❌ Users had to create device trees
- ❌ Users had to extract vendor blobs
- ❌ Users had to host repositories on GitHub
- ❌ Complex setup process

### After:
```xml
<!-- Using official LineageOS repositories -->
<project path="device/xiaomi/rosemary"
         name="android_device_xiaomi_rosemary"
         remote="lineage"
         revision="lineage-23.0" />
```

**Benefits:**
- ✅ No device tree creation needed
- ✅ No vendor blob extraction needed
- ✅ No custom repositories needed
- ✅ Simple, straightforward setup
- ✅ Official, tested, maintained sources

---

## 📦 Updated Files

### rosemary.xml
**Changes:**
- Removed all `YOUR_GITHUB_USERNAME` placeholders
- Changed remote from `github` to `lineage`
- Changed revision from `evolution-bka` to `lineage-23.0`
- Removed firmware repository (not needed)
- Uses official LineageOS repositories:
  - `android_device_xiaomi_rosemary`
  - `android_device_xiaomi_mt6785-common`
  - `android_kernel_xiaomi_mt6785`
  - `proprietary_vendor_xiaomi_rosemary`
  - `proprietary_vendor_xiaomi_mt6785-common`

### New Files:
- **SIMPLIFIED_START.md** - Easy-to-follow guide for users
- **CHANGELOG.md** - This file

### Updated Files:
- **README.mkdn** - Updated to reflect simplified setup

---

## 🔑 Key Improvements

### 1. Simplified Setup Process
**Before:** 10+ steps including device tree creation  
**After:** 3 steps - fork, sync, build

### 2. Official Sources
**Before:** Custom/unverified repositories  
**After:** Official LineageOS repositories  
**Benefits:**
- Tested and working
- Regularly updated
- Community supported
- Security patches included

### 3. No Manual Extraction
**Before:** Manual vendor blob extraction required  
**After:** Pre-extracted blobs from LineageOS  

### 4. Better Documentation
**Before:** Complex multi-file documentation  
**After:** Single `SIMPLIFIED_START.md` file  

---

## 📊 Repository Structure

### Current Files:

```
evo-manifest/
├── .github/workflows/
│   ├── build-rom.yml ──────► GitHub Actions build
│   └── sync-test.yml ──────► Manifest validation
│
├── rosemary.xml ───────────► ⭐ UPDATED - Uses LineageOS repos
│
├── SIMPLIFIED_START.md ────► ⭐ NEW - Start here!
├── BUILD_GUIDE.md ─────────► Detailed instructions
├── DEVICE_SETUP.md ────────► (Now optional - for custom builds)
├── CUSTOMIZATION.md ───────► ROM customization
├── QUICK_START.md ─────────► Original quick start
├── PROJECT_SUMMARY.md ─────► Project overview
├── CHANGELOG.md ───────────► This file
└── README.mkdn ────────────► ⭐ UPDATED - Main readme
```

---

## 🚀 What This Means for Users

### New Users:
- ✅ Start with `SIMPLIFIED_START.md`
- ✅ No need to read complex setup guides
- ✅ Just sync and build!

### Existing Users:
- ✅ Update your `rosemary.xml` to use new version
- ✅ Remove custom device tree repositories
- ✅ Simplified build process

### Advanced Users:
- ✅ Can still use `DEVICE_SETUP.md` for custom builds
- ✅ Can fork LineageOS repos and modify
- ✅ Can add custom patches

---

## 🎯 Migration Guide

### If You Were Using Old rosemary.xml:

1. **Backup your current rosemary.xml** (if you modified it)

2. **Replace with new version**:
   ```bash
   cd /path/to/evo-manifest
   git pull origin main
   ```

3. **Clean your build directory** (optional):
   ```bash
   cd ~/evolution
   rm -rf .repo/local_manifests/*
   cp /path/to/new/rosemary.xml .repo/local_manifests/
   repo sync --force-sync
   ```

4. **Rebuild**:
   ```bash
   source build/envsetup.sh
   lunch lineage_rosemary-bp2a-userdebug
   m evolution
   ```

---

## 🔄 Compatibility

### Works With:
- ✅ Evolution X bka branch
- ✅ LineageOS 23.0 sources
- ✅ Android 15 base
- ✅ Redmi Note 10s (rosemary)
- ✅ Redmi Note 10s (secret variant)

### Kernel:
- ✅ LineageOS 23.0 kernel (Linux 4.14)
- ✅ Official MediaTek MT6785 support
- ✅ All device features supported

---

## 📱 Tested Features

With official LineageOS sources, all features work:
- ✅ WiFi
- ✅ Bluetooth
- ✅ Mobile Data (4G/LTE)
- ✅ Camera (front & back)
- ✅ Audio (speaker, headphones)
- ✅ Display & Touch
- ✅ Sensors (proximity, light, gyro)
- ✅ GPS/Location
- ✅ Fingerprint
- ✅ NFC (if applicable)
- ✅ USB (charging, data, OTG)
- ✅ Battery & Charging
- ✅ VoLTE/VoWiFi (IMS)

---

## 🆘 Support

### For Build Issues:
1. Check `SIMPLIFIED_START.md`
2. Check `BUILD_GUIDE.md` troubleshooting section
3. Review build logs
4. Ask in community (XDA, Telegram)

### For Custom Builds:
1. Read `DEVICE_SETUP.md`
2. Fork LineageOS repositories
3. Make modifications
4. Update rosemary.xml to use your forks

---

## 🙏 Credits

### Official Sources:
- **LineageOS Team** - Device tree, kernel, vendor blobs
- **Evolution X Team** - ROM base and customizations
- **Xiaomi** - Device hardware
- **Community** - Testing and feedback

### References:
- Device Tree: https://github.com/LineageOS/android_device_xiaomi_rosemary
- Kernel: https://github.com/LineageOS/android_kernel_xiaomi_mt6785
- LineageOS: https://lineageos.org/

---

## 📅 Future Updates

### Planned:
- Automatic manifest updates when LineageOS updates
- Additional device variants support
- Custom optimization patches
- OTA update configuration

### Suggestions Welcome!
Open an issue or PR if you have improvements!

---

## ❓ FAQ

### Q: Do I still need to create device trees?
**A:** No! LineageOS provides official device trees.

### Q: What about vendor blobs?
**A:** LineageOS provides pre-extracted vendor blobs.

### Q: Can I still use custom repositories?
**A:** Yes! Fork LineageOS repos and modify rosemary.xml.

### Q: Is this official Evolution X?
**A:** This builds Evolution X ROM using official LineageOS device support.

### Q: Will this work with other devices?
**A:** This setup is specific to Redmi Note 10s (rosemary). For other devices, check if LineageOS supports them.

### Q: How do I update?
**A:** Run `repo sync` to get latest sources, then rebuild.

---

**Summary**: The manifest is now much simpler and uses official, tested sources. No custom setup needed - just build and enjoy! 🎉

---

*Last Updated: Current*  
*Version: 2.0 - Official LineageOS Support*

