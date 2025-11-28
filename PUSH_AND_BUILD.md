# 🚀 Push to GitHub and Start Build

## ✅ Current Status

All files have been **committed locally** (commit `a2c762a`):
- ✅ rosemary.xml with official LineageOS repos
- ✅ GitHub Actions workflows
- ✅ Complete documentation
- ✅ Build configuration

**Next:** Push to GitHub and trigger the build!

---

## 📤 Step 1: Push to GitHub

Run this command in your terminal:

```bash
cd /Users/ahmad/Public/evo-manifest
git push origin bka
```

**Expected output:**
```
Enumerating objects: X, done.
Counting objects: 100% (X/X), done.
Writing objects: 100% (X/X), X.XX KiB | X.XX MiB/s, done.
Total X (delta X), reused X (delta X)
To github.com:1stfoldAhmad/evo-manifest.git
   xxxxxxx..a2c762a  bka -> bka
```

If you see **"Permission denied"**, you need to set up GitHub authentication:

### Option A: SSH Key (Current setup)
```bash
# Check if SSH key exists
ls -la ~/.ssh/id_*.pub

# If not, generate one:
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to GitHub: Copy the public key
cat ~/.ssh/id_ed25519.pub
# Then add it at: https://github.com/settings/keys
```

### Option B: Switch to HTTPS with Token
```bash
# Change remote URL to HTTPS
git remote set-url origin https://github.com/1stfoldAhmad/evo-manifest.git

# Push (will prompt for credentials)
git push origin bka
# Username: 1stfoldAhmad
# Password: <your GitHub Personal Access Token>
```

Create token at: https://github.com/settings/tokens

---

## 🎬 Step 2: Trigger GitHub Actions Build

After pushing successfully, you have 3 options:

### Option 1: Manual Trigger (Recommended for First Build)

1. Go to: https://github.com/1stfoldAhmad/evo-manifest/actions

2. Click on **"Build Evolution X for Redmi Note 10s (rosemary)"** workflow

3. Click **"Run workflow"** button

4. Configure:
   - **Branch:** `bka` ✓
   - **Device Name:** `rosemary`
   - **Build Type:** `userdebug`
   - **Clean Build:** ☐ (unchecked for first build)
   - **Upload to Release:** ☑ (checked)

5. Click **"Run workflow"** (green button)

### Option 2: Using GitHub CLI

If you have GitHub CLI installed:

```bash
# Install GitHub CLI (if not installed)
brew install gh  # macOS
# or
sudo apt install gh  # Ubuntu/Debian

# Login
gh auth login

# Trigger workflow
gh workflow run build-rom.yml \
  --repo 1stfoldAhmad/evo-manifest \
  --ref bka \
  -f DEVICE_NAME=rosemary \
  -f BUILD_TYPE=userdebug \
  -f CLEAN_BUILD=false \
  -f UPLOAD_TO_RELEASE=true
```

### Option 3: Automatic Trigger

The workflow is set to trigger automatically on:
- Manual dispatch (Option 1 & 2 above)
- Future pushes to rosemary.xml or workflow files

---

## 📊 Step 3: Monitor the Build

### Method 1: Web Interface (Easiest)

Visit: https://github.com/1stfoldAhmad/evo-manifest/actions

You'll see:
- 🟡 **Yellow** = Running
- 🟢 **Green** = Success
- 🔴 **Red** = Failed

Click on the run to see detailed logs.

### Method 2: Using GitHub CLI

```bash
# Check workflow status
./check-workflow.sh

# Or manually:
gh run list --repo 1stfoldAhmad/evo-manifest

# Watch a specific run (replace RUN_ID)
gh run watch <RUN_ID> --repo 1stfoldAhmad/evo-manifest

# View logs
gh run view <RUN_ID> --log --repo 1stfoldAhmad/evo-manifest
```

### Method 3: Real-time Terminal Monitoring

```bash
# Install GitHub CLI first (see above)

# Watch the latest run
gh run watch --repo 1stfoldAhmad/evo-manifest
```

---

## ⏱️ Expected Timeline

| Phase | Duration | Status Check |
|-------|----------|--------------|
| **Setup Environment** | 10-15 min | Installing packages |
| **Initialize Repo** | 5 min | Setting up repo tool |
| **Sync Source** | 60-120 min | Downloading ~100GB |
| **Build ROM** | 180-360 min | Compiling |
| **Upload** | 10-20 min | Creating release |
| **TOTAL** | **4-8 hours** | ⏰ |

---

## 🔍 Monitoring Key Stages

### Stage 1: Environment Setup ✅
```
✓ Free up disk space
✓ Install required packages
✓ Set up Git configuration
✓ Install repo tool
✓ Set up ccache
```

### Stage 2: Source Sync 📥
```
⟳ Initialize repo
⟳ Add local manifest
⟳ Sync source code (longest stage)
```

### Stage 3: Build 🔨
```
⟳ Set up build environment
⟳ Lunch target
⟳ Build ROM (m evolution)
```

### Stage 4: Completion 🎉
```
✓ Check build output
✓ Generate build info
✓ Upload to artifacts
✓ Create GitHub Release
```

---

## ⚠️ Common Issues and Solutions

### Issue 1: Push Failed - Permission Denied
**Solution:** Set up SSH key or switch to HTTPS (see Step 1)

### Issue 2: Workflow Not Visible
**Solution:** 
- Make sure you pushed to the correct branch (`bka`)
- Check: https://github.com/1stfoldAhmad/evo-manifest/actions

### Issue 3: Build Fails - Out of Space
**Solution:** GitHub runners have limited space. The workflow includes cleanup steps, but if it fails:
- Enable "Clean Build" option
- Or use a self-hosted runner

### Issue 4: Build Fails - Sync Errors
**Solution:**
- Check if all LineageOS repositories are accessible
- Run the sync-test workflow first to validate manifest

### Issue 5: Build Takes Too Long
**Solution:**
- This is normal! First builds take 4-8 hours
- Subsequent builds with ccache are faster (2-4 hours)

---

## 📱 After Build Completes

### Download ROM:

**From Releases:**
1. Go to: https://github.com/1stfoldAhmad/evo-manifest/releases
2. Find latest release (EvolutionX-8.0-rosemary-userdebug-YYYYMMDD)
3. Download the `.zip` file

**From Artifacts:**
1. Go to: https://github.com/1stfoldAhmad/evo-manifest/actions
2. Click on completed workflow run
3. Scroll to "Artifacts" section
4. Download the ROM (available for 7 days)

### Verify ROM:

```bash
# Check file size (should be ~1-2GB)
ls -lh EvolutionX*.zip

# Verify it's a valid ZIP
unzip -t EvolutionX*.zip
```

---

## 🔄 Running Additional Builds

### Quick Rebuild (After First Successful Build):

1. Go to Actions
2. Select previous workflow run
3. Click "Re-run jobs"
4. Or start fresh with "Run workflow"

### For Different Variants:

**For "secret" variant:**
- Change Device Name to: `secret`
- Everything else same

**For clean build:**
- Check "Clean Build" option
- Takes same time as first build

---

## 🎯 Next Steps After Successful Build

1. ✅ Download ROM
2. ✅ Verify MD5/SHA256 checksums
3. ✅ Backup device data
4. ✅ Flash via custom recovery
5. ✅ Test all features
6. ✅ Report any issues

See `SIMPLIFIED_START.md` for flashing instructions!

---

## 💡 Pro Tips

1. **Enable Email Notifications:**
   - Go to: https://github.com/settings/notifications
   - Enable workflow notifications

2. **Use GitHub Mobile App:**
   - Get real-time notifications
   - View build status on the go

3. **Bookmark Actions Page:**
   - https://github.com/1stfoldAhmad/evo-manifest/actions

4. **Save Build Logs:**
   - Click on failed builds
   - Download logs for troubleshooting

5. **Join Community:**
   - XDA Developers forum
   - Evolution X Telegram groups
   - Get help from experienced builders

---

## 📞 Need Help?

### Build Issues:
1. Check the workflow logs (Actions tab)
2. Search for error messages online
3. Read BUILD_GUIDE.md troubleshooting section
4. Ask in XDA or Telegram groups

### Authentication Issues:
1. Check GitHub SSH keys: https://github.com/settings/keys
2. Try HTTPS authentication instead
3. Generate new Personal Access Token

### Workflow Issues:
1. Run sync-test workflow first
2. Check manifest validity
3. Verify all repos are accessible

---

## ✅ Quick Commands Summary

```bash
# 1. Push to GitHub
git push origin bka

# 2. Check workflow status (if gh CLI installed)
gh run list --repo 1stfoldAhmad/evo-manifest
gh run watch --repo 1stfoldAhmad/evo-manifest

# 3. Or use the helper script
./check-workflow.sh

# 4. View specific run logs
gh run view <RUN_ID> --log --repo 1stfoldAhmad/evo-manifest
```

---

**Ready to start? Push your changes and trigger the build!** 🚀

**Repository:** https://github.com/1stfoldAhmad/evo-manifest  
**Actions:** https://github.com/1stfoldAhmad/evo-manifest/actions

