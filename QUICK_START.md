# 🚀 Quick Start Guide - Evolution X for Redmi Note 10s

This is your quick reference to get started building Evolution X for the Redmi Note 10s (rosemary/secret).

## 📋 What You Have

This repository now includes everything you need:

1. ✅ **rosemary.xml** - Device manifest with LineageOS 23.0 kernel
2. ✅ **.github/workflows/build-rom.yml** - GitHub Actions build workflow
3. ✅ **.github/workflows/sync-test.yml** - Manifest validation workflow
4. ✅ **BUILD_GUIDE.md** - Complete build instructions
5. ✅ **DEVICE_SETUP.md** - Device tree setup guide
6. ✅ **CUSTOMIZATION.md** - Customization options
7. ✅ **README.mkdn** - Updated main README

## ⚡ 3-Step Quick Start

### Step 1: Prepare Device Trees (Required!)

You need to create or obtain these repositories:

```
YOUR_GITHUB_USERNAME/android_device_xiaomi_rosemary
YOUR_GITHUB_USERNAME/android_device_xiaomi_mt6785-common
YOUR_GITHUB_USERNAME/android_vendor_xiaomi_rosemary
YOUR_GITHUB_USERNAME/android_vendor_xiaomi_mt6785-common
```

**Read DEVICE_SETUP.md for detailed instructions on creating these!**

### Step 2: Update Manifest

Edit `rosemary.xml` and replace **YOUR_GITHUB_USERNAME** with your actual GitHub username:

```xml
<project path="device/xiaomi/rosemary"
         name="YOUR_GITHUB_USERNAME/android_device_xiaomi_rosemary"
         remote="github"
         revision="evolution-bka" />
```

Do this for ALL occurrences of `YOUR_GITHUB_USERNAME`.

### Step 3: Build

#### Option A: GitHub Actions (Recommended for Beginners)
1. Fork this repository
2. Go to **Actions** tab
3. Select **"Build Evolution X for Redmi Note 10s"**
4. Click **"Run workflow"**
5. Wait 4-8 hours
6. Download ROM from Releases or Artifacts

#### Option B: Local Build (Advanced)
```bash
# Initialize
mkdir ~/evolution && cd ~/evolution
repo init -u https://github.com/Evolution-X/manifest -b bka --git-lfs

# Add device manifest
mkdir -p .repo/local_manifests
cp /path/to/rosemary.xml .repo/local_manifests/

# Sync (takes 2-4 hours)
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# Build (takes 2-6 hours)
source build/envsetup.sh
lunch lineage_rosemary-bp2a-userdebug
m evolution
```

## 📚 Documentation Structure

```
├── README.mkdn ────────────► Main repository information
├── QUICK_START.md ─────────► This file (start here!)
├── BUILD_GUIDE.md ─────────► Detailed building instructions
├── DEVICE_SETUP.md ────────► How to create device trees
├── CUSTOMIZATION.md ───────► Customization options
└── rosemary.xml ───────────► Device manifest file
```

**Reading Order:**
1. QUICK_START.md (you are here!)
2. DEVICE_SETUP.md (prepare your device files)
3. BUILD_GUIDE.md (build the ROM)
4. CUSTOMIZATION.md (optional customizations)

## 🎯 Your Next Steps

### Immediate (Today):
- [ ] Read DEVICE_SETUP.md thoroughly
- [ ] Gather device specifications
- [ ] Search for existing device trees on GitHub
- [ ] Join XDA/Telegram groups for your device

### Short-term (This Week):
- [ ] Create/fork device tree repositories
- [ ] Extract vendor blobs from stock ROM
- [ ] Update rosemary.xml with your repository URLs
- [ ] Run sync-test workflow to validate manifest

### Build Phase (Next Week):
- [ ] Run your first build (local or GitHub Actions)
- [ ] Fix any build errors (check logs)
- [ ] Generate flashable ROM zip
- [ ] Test on device

### Post-Build:
- [ ] Report bugs/issues
- [ ] Optimize and customize
- [ ] Share with community
- [ ] Maintain and update

## ⚠️ Important Notes

### Before You Start:
1. **You MUST have device trees** - See DEVICE_SETUP.md
2. **The manifest uses LineageOS 23.0 kernel** - Official and tested
3. **Building takes time** - Be patient, first builds are slow
4. **You need space** - 300GB+ for local builds
5. **Backup your device** - Before flashing anything

### For GitHub Actions:
- Free tier: Limited minutes (~300/month) ❌ Not enough
- Pro tier: More minutes (~3000/month) ⚠️ Might work
- Self-hosted runner: Unlimited ✅ Recommended for frequent builds

### For Local Builds:
- RAM: 16GB minimum, 32GB recommended
- CPU: 8+ cores recommended
- Storage: 300GB+ free space (SSD preferred)
- OS: Ubuntu 20.04+ or similar Linux

## 🔗 Essential Links

### Your Device:
- XDA Forum: Search "Redmi Note 10s development"
- LineageOS Wiki: https://wiki.lineageos.org/
- Evolution X: https://evolution-x.org/

### Kernel Source:
- https://github.com/LineageOS/android_kernel_xiaomi_mt6785/tree/lineage-23.0

### Tools & Resources:
- repo tool: https://source.android.com/setup/develop/repo
- extract-utils: https://github.com/LineageOS/android_tools_extract-utils
- payload_dumper: https://github.com/ssut/payload-dumper-go

## 🆘 Common Issues

### "Can't find device tree"
→ You need to create it first! Read DEVICE_SETUP.md

### "Repo sync fails"
→ Check your rosemary.xml - make sure all repositories exist

### "Build fails with missing files"
→ Incomplete vendor blobs extraction. Re-extract from stock ROM

### "Out of space"
→ Need 300GB+ free. Clean up or get bigger drive

### "Build takes forever"
→ Normal for first build. Use ccache for subsequent builds

## 💡 Pro Tips

1. **Start simple**: Get a basic build working first, customize later
2. **Use existing trees**: Don't create from scratch if alternatives exist
3. **Join communities**: Telegram/Discord groups are invaluable
4. **Document everything**: Keep notes of all changes you make
5. **Test incrementally**: Don't make too many changes at once
6. **Keep backups**: Always backup working configurations
7. **Be patient**: ROM building has a learning curve

## 🎓 Learning Path

### Beginner:
1. Use existing device trees (if available)
2. Build with default settings
3. Learn from build errors
4. Test on device

### Intermediate:
1. Modify device trees
2. Add/remove features
3. Apply patches
4. Customize ROM

### Advanced:
1. Create device trees from scratch
2. Port features from other ROMs
3. Fix kernel issues
4. Contribute upstream

## ✅ Success Checklist

Build successful when you have:
- [ ] ROM zip file (Evolution*.zip)
- [ ] Build completed without errors
- [ ] ROM size reasonable (~1-2GB)
- [ ] MD5/SHA256 checksums generated
- [ ] Boot.img and recovery.img present

## 📱 After Building

### Before Flashing:
1. **Backup everything** on your device
2. Charge device to 80%+
3. Download appropriate recovery (TWRP/OrangeFox)
4. Have stock ROM ready (in case of issues)

### Flashing Steps:
1. Boot to recovery
2. Wipe: System, Data, Cache, Dalvik
3. Flash ROM zip
4. Format data (if coming from different ROM)
5. Reboot and wait (first boot takes 5-10 minutes)

### If Boot Loops:
1. Check logcat via ADB
2. Flash stock ROM and retry
3. Review build logs for errors
4. Ask community for help

## 🎉 Ready to Build?

You now have everything needed! Follow this path:

```
DEVICE_SETUP.md → BUILD_GUIDE.md → Build! → Flash → Enjoy!
```

**Still confused?** Join the community:
- XDA Developers Forum
- Telegram ROM development groups
- Reddit r/AndroidDev
- Discord Android building servers

---

**Good luck with your build! You've got this! 💪**

Questions? Check the other documentation files or reach out to the community!

