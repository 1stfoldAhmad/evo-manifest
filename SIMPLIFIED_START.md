# 🎉 SIMPLIFIED Quick Start - Evolution X for Redmi Note 10s

## ✅ Great News!

Since LineageOS officially supports the Redmi Note 10s (rosemary), you **DON'T need to create any device trees or extract vendor blobs yourself!** Everything is already available from LineageOS repositories.

**Official LineageOS Device Tree**: https://github.com/LineageOS/android_device_xiaomi_rosemary

## 📦 What's Already Set Up

Your `rosemary.xml` now uses **official LineageOS repositories**:

✅ Device tree from LineageOS  
✅ LineageOS 23.0 kernel  
✅ Vendor blobs from LineageOS  
✅ MediaTek hardware support  
✅ IMS support (VoLTE/VoWiFi)

**No custom repositories needed!**

## 🚀 Super Simple Build Process

### Method 1: GitHub Actions (Easiest!)

1. **Fork this repository** to your GitHub account

2. **Go to Actions tab** in your forked repo

3. **Select "Build Evolution X for Redmi Note 10s"** workflow

4. **Click "Run workflow"**
   - Device Name: `rosemary`
   - Build Type: `userdebug`
   - Clean Build: `false` (for first build)
   - Upload to Release: `true`

5. **Wait 4-8 hours** for build to complete

6. **Download ROM** from:
   - Releases page, or
   - Artifacts section

### Method 2: Local Build

#### Quick Commands:

```bash
# 1. Create workspace
mkdir -p ~/evolution
cd ~/evolution

# 2. Initialize repo
repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs --depth=1

# 3. Add device manifest
mkdir -p .repo/local_manifests
# Copy your rosemary.xml to .repo/local_manifests/
cp /path/to/rosemary.xml .repo/local_manifests/

# 4. Sync source (takes 2-4 hours, downloads ~100GB)
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# 5. Set up environment
source build/envsetup.sh

# 6. Choose device
lunch lineage_rosemary-bp2a-userdebug

# 7. Build! (takes 2-6 hours)
m evolution
```

#### Output location:
```
~/evolution/out/target/product/rosemary/Evolution*.zip
```

## 📋 Requirements

### For GitHub Actions:
- GitHub account (free)
- Fork this repository
- **Note**: Free tier has limited build minutes (~300/month)
  - Consider GitHub Pro ($4/month) or self-hosted runner

### For Local Build:
- **OS**: Ubuntu 20.04+ or similar Linux
- **RAM**: 16GB minimum (32GB recommended)
- **Storage**: 300GB+ free space (SSD recommended)
- **CPU**: 8+ cores recommended
- **Time**: First build takes 2-6 hours

## 🎯 What Changed from Original Setup?

### Before (Complex):
```xml
<!-- Required YOUR_GITHUB_USERNAME -->
<project path="device/xiaomi/rosemary"
         name="YOUR_GITHUB_USERNAME/android_device_xiaomi_rosemary"
         remote="github"
         revision="evolution-bka" />
```
❌ You needed to create device trees  
❌ You needed to extract vendor blobs  
❌ You needed to host repositories  

### After (Simple):
```xml
<!-- Uses official LineageOS repositories -->
<project path="device/xiaomi/rosemary"
         name="android_device_xiaomi_rosemary"
         remote="lineage"
         revision="lineage-23.0" />
```
✅ Everything from official LineageOS  
✅ No setup needed  
✅ Just build!

## 🔧 Kernel Information

Using official LineageOS 23.0 kernel:
- **Source**: https://github.com/LineageOS/android_kernel_xiaomi_mt6785/tree/lineage-23.0
- **Branch**: lineage-23.0
- **Version**: Linux 4.14
- **Status**: Official, maintained, tested

## 📱 Device Support

**Device**: Redmi Note 10s  
**Codename**: rosemary (also works as "secret")  
**Platform**: MediaTek MT6785 (Helio G95)  
**Android Version**: Android 15 (Evolution X bka branch)

## ⚡ Quick Checklist

**Before Building:**
- [ ] Fork this repository (for GitHub Actions)
- [ ] Ensure you have enough disk space (300GB+)
- [ ] Have stable internet connection
- [ ] Be patient - builds take time!

**During Build:**
- [ ] Monitor build progress
- [ ] Check for errors in logs
- [ ] Don't interrupt the process

**After Build:**
- [ ] Verify ROM zip is created
- [ ] Check ROM size (~1-2GB is normal)
- [ ] Backup the ROM file
- [ ] Generate MD5/SHA256 checksums

## 🎊 That's It!

You don't need to read the complex setup guides anymore. Since LineageOS officially supports rosemary:

~~DEVICE_SETUP.md~~ - **NOT NEEDED!**  
✅ Just use the commands above  
✅ Everything is automated

## 🆘 Troubleshooting

### Build Fails
1. Check build logs in GitHub Actions or terminal
2. Common issues:
   - Out of space: Free up disk space
   - Sync errors: Run `repo sync` again
   - Missing packages: Install required dependencies

### Sync Errors
```bash
# Try syncing again with fewer threads
repo sync -c -j4 --force-sync --no-tags
```

### Out of Space
```bash
# Check disk space
df -h

# Clean build output
cd ~/evolution
make clean
```

## 📖 Additional Resources

**If you want to customize:**
- Read `CUSTOMIZATION.md` for customization options
- Read `BUILD_GUIDE.md` for detailed instructions

**Official Sources:**
- Evolution X: https://evolution-x.org/
- LineageOS Device Tree: https://github.com/LineageOS/android_device_xiaomi_rosemary
- LineageOS Kernel: https://github.com/LineageOS/android_kernel_xiaomi_mt6785

## 🎯 Next Steps After Build

1. **Flash to device**:
   - Boot to recovery (TWRP/OrangeFox)
   - Wipe: System, Data, Cache, Dalvik
   - Flash ROM zip
   - Reboot

2. **Test everything**:
   - WiFi, Bluetooth, Mobile data
   - Camera, Audio, Video
   - Sensors, GPS
   - Charging, Battery

3. **Enjoy Evolution X!** 🎉

## 💡 Pro Tips

1. **Use ccache** for faster subsequent builds
2. **Join communities** for support (XDA, Telegram)
3. **Keep ROM backup** before making changes
4. **Test thoroughly** before daily use

---

**Everything is ready! Just follow the commands above and start building! 🚀**

No complex setup, no custom repositories, no hassle - just build and enjoy!

