#!/bin/bash

# Helper script to check GitHub Actions workflow status
# Requires: gh CLI (GitHub CLI tool)

REPO="1stfoldAhmad/evo-manifest"
WORKFLOW="build-rom.yml"

echo "🔍 Checking GitHub Actions workflows for $REPO"
echo "================================================"
echo ""

# Check if gh CLI is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed."
    echo ""
    echo "Install it with:"
    echo "  macOS: brew install gh"
    echo "  Linux: See https://cli.github.com/"
    echo ""
    echo "Or check manually at:"
    echo "  https://github.com/$REPO/actions"
    exit 1
fi

# Check authentication
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated with GitHub CLI"
    echo ""
    echo "Run: gh auth login"
    exit 1
fi

echo "✅ Fetching workflow runs..."
echo ""

# List recent workflow runs
gh run list --repo "$REPO" --limit 5

echo ""
echo "================================================"
echo "📊 To see detailed logs of a specific run:"
echo "   gh run view <RUN_ID> --repo $REPO"
echo ""
echo "📝 To see logs:"
echo "   gh run view <RUN_ID> --log --repo $REPO"
echo ""
echo "🌐 Or view in browser:"
echo "   https://github.com/$REPO/actions"

