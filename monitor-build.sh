#!/bin/bash

# Build Monitor Script for Evolution X
# Monitors GitHub Actions workflow progress

REPO="1stfoldAhmad/evo-manifest"
WORKFLOW="build-rom.yml"
CHECK_INTERVAL=60  # seconds

echo "🔍 Evolution X Build Monitor"
echo "═══════════════════════════════════════════════"
echo "Repository: $REPO"
echo "Workflow: $WORKFLOW"
echo "Check Interval: ${CHECK_INTERVAL}s"
echo "═══════════════════════════════════════════════"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to check workflow status via GitHub API
check_status() {
    echo -e "${BLUE}[$(date '+%H:%M:%S')]${NC} Checking workflow status..."
    
    # Get latest workflow run
    response=$(curl -s -H "Accept: application/vnd.github+json" \
        "https://api.github.com/repos/$REPO/actions/workflows/$WORKFLOW/runs?per_page=1")
    
    # Extract status
    status=$(echo "$response" | grep -o '"status":"[^"]*"' | head -1 | cut -d'"' -f4)
    conclusion=$(echo "$response" | grep -o '"conclusion":"[^"]*"' | head -1 | cut -d'"' -f4)
    name=$(echo "$response" | grep -o '"name":"[^"]*"' | head -1 | cut -d'"' -f4)
    run_number=$(echo "$response" | grep -o '"run_number":[^,]*' | head -1 | cut -d':' -f2)
    html_url=$(echo "$response" | grep -o '"html_url":"[^"]*"' | head -1 | cut -d'"' -f4)
    created_at=$(echo "$response" | grep -o '"created_at":"[^"]*"' | head -1 | cut -d'"' -f4)
    
    echo ""
    echo "📊 Latest Run Information:"
    echo "   Run Number: #$run_number"
    echo "   Name: $name"
    echo "   Status: $status"
    
    if [ "$status" = "completed" ]; then
        if [ "$conclusion" = "success" ]; then
            echo -e "   Result: ${GREEN}✅ SUCCESS${NC}"
            echo ""
            echo "═══════════════════════════════════════════════"
            echo -e "${GREEN}🎉 BUILD COMPLETED SUCCESSFULLY!${NC}"
            echo "═══════════════════════════════════════════════"
            echo ""
            echo "📦 Download ROM from:"
            echo "   - Releases: https://github.com/$REPO/releases"
            echo "   - Artifacts: $html_url"
            echo ""
            return 0
        elif [ "$conclusion" = "failure" ]; then
            echo -e "   Result: ${RED}❌ FAILED${NC}"
            echo ""
            echo "═══════════════════════════════════════════════"
            echo -e "${RED}⚠️  BUILD FAILED${NC}"
            echo "═══════════════════════════════════════════════"
            echo ""
            echo "🔍 Check logs at: $html_url"
            echo ""
            return 1
        else
            echo "   Result: $conclusion"
            return 2
        fi
    elif [ "$status" = "in_progress" ] || [ "$status" = "queued" ]; then
        echo -e "   Result: ${YELLOW}⏳ In Progress${NC}"
        echo "   Started: $created_at"
        echo "   URL: $html_url"
        echo ""
        echo "   ⏳ Waiting for completion..."
        return 3
    else
        echo "   Status: $status"
        echo "   URL: $html_url"
        return 4
    fi
}

# Function to show build stages
show_stages() {
    echo ""
    echo "📋 Expected Build Stages:"
    echo "   1. ⚙️  Setup Environment (10-15 min)"
    echo "   2. 📥 Sync Source Code (60-120 min)"
    echo "   3. 🔨 Build ROM (180-360 min)"
    echo "   4. 📤 Upload Release (10-20 min)"
    echo ""
    echo "   Total: ⏱️  4-8 hours"
    echo ""
}

# Main monitoring loop
main() {
    show_stages
    
    echo "Starting continuous monitoring..."
    echo "Press Ctrl+C to stop"
    echo "═══════════════════════════════════════════════"
    echo ""
    
    iteration=0
    while true; do
        iteration=$((iteration + 1))
        echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
        echo -e "${BLUE}Check #$iteration${NC}"
        
        check_status
        exit_code=$?
        
        if [ $exit_code -eq 0 ] || [ $exit_code -eq 1 ]; then
            # Build completed or failed
            break
        fi
        
        echo ""
        echo "⏰ Next check in ${CHECK_INTERVAL}s..."
        sleep $CHECK_INTERVAL
    done
}

# Run if executed directly
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
    main
fi

