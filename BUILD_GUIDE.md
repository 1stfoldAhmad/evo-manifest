# Evolution X Build Guide for Redmi Note 10s (rosemary/secret)

This guide will help you build Evolution X for your Redmi Note 10s using the LineageOS 23.0 kernel.

## 📋 Prerequisites

Before you start, you need to prepare:

### 1. Device Trees and Vendor Blobs

You'll need to create or obtain the following repositories:

- **Device Tree**: `android_device_xiaomi_rosemary`
- **Device Common Tree**: `android_device_xiaomi_mt6785-common` (if needed)
- **Vendor Blobs**: `android_vendor_xiaomi_rosemary`
- **Vendor Common Blobs**: `android_vendor_xiaomi_mt6785-common` (if needed)
- **Firmware**: `android_vendor_xiaomi_firmware` (optional)

### 2. Update the Manifest

Edit `rosemary.xml` and replace `YOUR_GITHUB_USERNAME` with your actual GitHub username where you'll host the device trees and vendor blobs:

```xml
<project path="device/xiaomi/rosemary"
         name="YOUR_GITHUB_USERNAME/android_device_xiaomi_rosemary"
         remote="github"
         revision="evolution-bka" />
```

## 🚀 Building with GitHub Actions (Recommended)

### Setup Steps:

1. **Fork this repository** to your GitHub account

2. **Update the manifest file** (`rosemary.xml`) with your device tree repositories

3. **Go to Actions tab** in your forked repository

4. **Select "Build Evolution X for Redmi Note 10s"** workflow

5. **Click "Run workflow"** and configure:
   - Device Name: `rosemary` (or `secret`)
   - Build Type: `userdebug` (recommended)
   - Clean Build: Check if you want a clean build
   - Upload to Release: Check to auto-upload to GitHub Releases

6. **Wait for build to complete** (takes 4-8 hours depending on GitHub runner speed)

7. **Download ROM** from:
   - Artifacts section (available for 7 days)
   - Releases page (if you enabled auto-upload)

### Build Requirements:
- GitHub Free tier: ~300 minutes/month (not enough for regular builds)
- GitHub Pro: ~3000 minutes/month
- Consider using self-hosted runners for unlimited builds

## 💻 Building Locally

### System Requirements:
- **OS**: Ubuntu 20.04+ or similar Linux distribution
- **RAM**: 16GB minimum (32GB recommended)
- **Storage**: 300GB+ free space
- **CPU**: Multi-core processor (8+ cores recommended)

### Step 1: Install Required Packages

```bash
sudo apt-get update
sudo apt-get install -y bc bison build-essential ccache curl flex \
  g++-multilib gcc-multilib git git-lfs gnupg gperf imagemagick \
  lib32ncurses-dev lib32readline-dev lib32z1-dev libelf-dev \
  liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev \
  libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool \
  squashfs-tools xsltproc zip zlib1g-dev python3 python3-pip \
  python-is-python3 openjdk-11-jdk android-sdk-libsparse-utils \
  android-sdk-ext4-utils brotli liblz4-tool libprotobuf-dev \
  protobuf-compiler
```

### Step 2: Install repo tool

```bash
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH
```

### Step 3: Configure Git

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Step 4: Initialize Repository

```bash
mkdir -p ~/evolution
cd ~/evolution
repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs --depth=1
```

### Step 5: Add Local Manifest

```bash
mkdir -p .repo/local_manifests
# Copy rosemary.xml to .repo/local_manifests/
cp /path/to/rosemary.xml .repo/local_manifests/
```

### Step 6: Sync Source Code

```bash
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
```

**Note**: This will download ~100GB of source code and may take several hours.

### Step 7: Set up ccache (Optional but Recommended)

```bash
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_DIR=~/.ccache
ccache -M 50G
```

### Step 8: Build the ROM

```bash
source build/envsetup.sh
lunch lineage_rosemary-bp2a-userdebug
m evolution
```

**Build time**: 2-6 hours depending on your hardware.

### Step 9: Get Your ROM

After successful build, find your ROM at:
```
out/target/product/rosemary/Evolution*.zip
```

## 📦 What's Included

- **LineageOS 23.0 Kernel**: Official kernel from LineageOS for MT6785 devices
- **Evolution X Features**: All Evolution X customizations and features
- **MediaTek Hardware Support**: Proper HAL support for MT6785 platform
- **IMS Support**: VoLTE/VoWiFi support

## 🔧 Troubleshooting

### Build Fails with "No rule to make target"
- Make sure all repositories in `rosemary.xml` are accessible
- Check that device trees are properly set up
- Verify vendor blobs are extracted correctly

### Out of Space Error
- Clean build output: `make clean`
- Remove ccache: `rm -rf ~/.ccache`
- Free up disk space (need at least 300GB)

### Sync Errors
- Try syncing with fewer threads: `repo sync -c -j4`
- Check internet connection
- Run `repo sync` again, it will resume

### Kernel Build Fails
- Ensure you're using the correct kernel source (lineage-23.0 branch)
- Check kernel defconfig matches your device
- Review device tree kernel configuration

## 📱 Flashing Instructions

### Prerequisites:
1. Unlocked bootloader
2. Custom recovery installed (TWRP/OrangeFox)
3. Backup your data

### Flash Steps:

1. **Boot into recovery**
2. **Wipe**:
   - Dalvik/ART Cache
   - Cache
   - System
   - Data (if coming from different ROM)
3. **Install ROM ZIP**
4. **Format Data** (if encryption issues occur)
5. **Reboot to system**

## 🔄 Updates

To update your local source and rebuild:

```bash
cd ~/evolution
repo sync -c -j$(nproc --all) --force-sync
source build/envsetup.sh
lunch lineage_rosemary-bp2a-userdebug
make clean  # Optional, for clean build
m evolution
```

## 🆘 Getting Help

- Check Evolution X official documentation
- Visit LineageOS wiki for device-specific info
- Search XDA forums for Redmi Note 10s
- Check build logs for specific errors

## 📄 License

All source code follows AOSP/LineageOS/Evolution X licensing terms.

## ⚠️ Disclaimer

- Building and flashing custom ROMs can brick your device
- We are not responsible for any damage to your device
- Always maintain backups
- Proceed at your own risk

## 🤝 Contributing

Feel free to:
- Report issues
- Submit pull requests
- Improve documentation
- Share your builds

---

**Happy Building! 🎉**

