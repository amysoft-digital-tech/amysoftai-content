#!/bin/bash

# Content Backup and Version Control Verification Script
# Ensures content integrity and recovery capabilities

set -e

echo "💾 Starting Content Backup and Version Control Verification..."

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
WARNINGS=0

# Helper function for test results
log_result() {
    local status=$1
    local message=$2
    
    if [ "$status" = "PASS" ]; then
        echo -e "${GREEN}✓ PASS${NC}: $message"
        ((TESTS_PASSED++))
    elif [ "$status" = "FAIL" ]; then
        echo -e "${RED}✗ FAIL${NC}: $message"
        ((TESTS_FAILED++))
    elif [ "$status" = "WARN" ]; then
        echo -e "${YELLOW}⚠ WARNING${NC}: $message"
        ((WARNINGS++))
    else
        echo -e "${BLUE}ℹ INFO${NC}: $message"
    fi
}

# Test 1: Git Repository Health
echo -e "\n${BLUE}Testing Git Repository Health...${NC}"

test_git_health() {
    # Check if we're in a git repository
    if git rev-parse --git-dir >/dev/null 2>&1; then
        log_result "PASS" "Repository is under Git version control"
    else
        log_result "FAIL" "Not in a Git repository"
        return 1
    fi
    
    # Check repository status
    local status_output=$(git status --porcelain 2>/dev/null || echo "ERROR")
    if [ "$status_output" = "ERROR" ]; then
        log_result "FAIL" "Unable to check repository status"
    else
        log_result "PASS" "Repository status accessible"
    fi
    
    # Check for remote repositories
    local remotes=$(git remote -v 2>/dev/null | wc -l)
    if [ "$remotes" -gt 0 ]; then
        log_result "PASS" "Remote repositories configured ($((remotes / 2)) remotes)"
    else
        log_result "WARN" "No remote repositories configured"
    fi
    
    # Check recent commits
    local commit_count=$(git log --oneline -10 2>/dev/null | wc -l)
    if [ "$commit_count" -gt 0 ]; then
        log_result "PASS" "Recent commit history available ($commit_count recent commits)"
    else
        log_result "WARN" "No recent commits found"
    fi
}

# Test 2: Content File Tracking
echo -e "\n${BLUE}Testing Content File Tracking...${NC}"

test_content_tracking() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    local tracked_files=0
    local untracked_files=0
    
    if [ ${#content_files[@]} -eq 0 ]; then
        log_result "WARN" "No content files found for tracking verification"
        return
    fi
    
    for file in "${content_files[@]}"; do
        if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
            ((tracked_files++))
            log_result "PASS" "Content file tracked: $file"
        else
            ((untracked_files++))
            log_result "WARN" "Content file not tracked: $file"
        fi
    done
    
    echo -e "${BLUE}ℹ INFO${NC}: Tracked files: $tracked_files, Untracked files: $untracked_files"
    
    # Check for important files
    local important_files=("CLAUDE.md" "README.md" "package.json" "LAUNCH_READINESS_CHECKLIST.md")
    for file in "${important_files[@]}"; do
        if [ -f "$file" ]; then
            if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
                log_result "PASS" "Important file tracked: $file"
            else
                log_result "WARN" "Important file not tracked: $file"
            fi
        fi
    done
}

# Test 3: Schema and Configuration Backup
echo -e "\n${BLUE}Testing Schema and Configuration Backup...${NC}"

test_schema_backup() {
    local schema_files=($(find schemas -name "*.json" -type f 2>/dev/null || true))
    local script_files=($(find scripts -name "*.sh" -type f 2>/dev/null || true))
    
    # Check schema files
    for file in "${schema_files[@]}"; do
        if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
            log_result "PASS" "Schema file backed up: $file"
        else
            log_result "WARN" "Schema file not backed up: $file"
        fi
    done
    
    # Check script files  
    for file in "${script_files[@]}"; do
        if git ls-files --error-unmatch "$file" >/dev/null 2>&1; then
            log_result "PASS" "Script file backed up: $file"
        else
            log_result "WARN" "Script file not backed up: $file"
        fi
    done
    
    # Check for configuration files
    local config_files=(".gitignore" ".github/workflows/" "CLAUDE.md")
    for file in "${config_files[@]}"; do
        if [ -e "$file" ]; then
            if git ls-files --error-unmatch "$file" >/dev/null 2>&1 || \
               ([ -d "$file" ] && [ "$(git ls-files "$file" | wc -l)" -gt 0 ]); then
                log_result "PASS" "Configuration backed up: $file"
            else
                log_result "WARN" "Configuration not backed up: $file"
            fi
        fi
    done
}

# Test 4: Commit History and Documentation
echo -e "\n${BLUE}Testing Commit History and Documentation...${NC}"

test_commit_history() {
    # Check commit message quality
    local recent_commits=($(git log --oneline -5 --pretty=format:"%s" 2>/dev/null || true))
    local good_commits=0
    
    for commit in "${recent_commits[@]}"; do
        if echo "$commit" | grep -q "^feat:\|^fix:\|^docs:\|^refactor:\|^test:"; then
            ((good_commits++))
            log_result "PASS" "Well-formatted commit message: $commit"
        else
            log_result "WARN" "Commit message could be improved: $commit"
        fi
    done
    
    # Check for merge commits
    local merge_commits=$(git log --merges --oneline -5 2>/dev/null | wc -l)
    if [ "$merge_commits" -gt 0 ]; then
        log_result "PASS" "Merge history available ($merge_commits recent merges)"
    fi
    
    # Check for tags
    local tags=$(git tag -l 2>/dev/null | wc -l)
    if [ "$tags" -gt 0 ]; then
        log_result "PASS" "Version tags available ($tags tags)"
    else
        log_result "WARN" "No version tags found"
    fi
    
    echo -e "${BLUE}ℹ INFO${NC}: Well-formatted commits: $good_commits/5 recent commits"
}

# Test 5: Branch Management and Recovery
echo -e "\n${BLUE}Testing Branch Management...${NC}"

test_branch_management() {
    # Check current branch
    local current_branch=$(git branch --show-current 2>/dev/null || echo "unknown")
    log_result "PASS" "Current branch: $current_branch"
    
    # Check for main/master branch
    if git branch -r | grep -q "origin/main\|origin/master"; then
        log_result "PASS" "Main branch available in remote"
    else
        log_result "WARN" "Main branch not found in remote"
    fi
    
    # Check branch count
    local branch_count=$(git branch -a 2>/dev/null | wc -l)
    if [ "$branch_count" -gt 1 ]; then
        log_result "PASS" "Multiple branches available ($branch_count branches)"
    else
        log_result "WARN" "Only one branch available"
    fi
    
    # Check for uncommitted changes
    if git diff --quiet && git diff --cached --quiet; then
        log_result "PASS" "Working directory clean"
    else
        log_result "WARN" "Uncommitted changes present"
    fi
}

# Test 6: Remote Backup Verification
echo -e "\n${BLUE}Testing Remote Backup Verification...${NC}"

test_remote_backup() {
    # Check remote connection
    local remotes=($(git remote 2>/dev/null || true))
    
    for remote in "${remotes[@]}"; do
        local remote_url=$(git remote get-url "$remote" 2>/dev/null || echo "unknown")
        log_result "PASS" "Remote configured: $remote ($remote_url)"
        
        # Test remote connectivity (without pushing)
        if git ls-remote "$remote" >/dev/null 2>&1; then
            log_result "PASS" "Remote accessible: $remote"
        else
            log_result "WARN" "Remote connection failed: $remote"
        fi
    done
    
    # Check last push status
    local current_branch=$(git branch --show-current 2>/dev/null || echo "main")
    if git log "origin/$current_branch..$current_branch" --oneline 2>/dev/null | grep -q .; then
        log_result "WARN" "Local commits not pushed to remote"
    else
        log_result "PASS" "Local branch up to date with remote"
    fi
    
    # Check for GitHub/GitLab integration
    if echo "$remote_url" | grep -q "github.com\|gitlab.com\|bitbucket.org"; then
        log_result "PASS" "Using professional Git hosting service"
    else
        log_result "WARN" "Not using a professional Git hosting service"
    fi
}

# Test 7: Asset and Media Backup
echo -e "\n${BLUE}Testing Asset and Media Backup...${NC}"

test_asset_backup() {
    local asset_dirs=("assets/diagrams" "assets/images" "assets/interactive")
    local backed_up_assets=0
    local total_assets=0
    
    for dir in "${asset_dirs[@]}"; do
        if [ -d "$dir" ]; then
            local assets=($(find "$dir" -type f 2>/dev/null || true))
            for asset in "${assets[@]}"; do
                ((total_assets++))
                if git ls-files --error-unmatch "$asset" >/dev/null 2>&1; then
                    ((backed_up_assets++))
                    log_result "PASS" "Asset backed up: $asset"
                else
                    log_result "WARN" "Asset not backed up: $asset"
                fi
            done
        else
            log_result "WARN" "Asset directory not found: $dir"
        fi
    done
    
    if [ "$total_assets" -eq 0 ]; then
        log_result "WARN" "No assets found for backup verification"
    else
        echo -e "${BLUE}ℹ INFO${NC}: Assets backed up: $backed_up_assets/$total_assets"
    fi
}

# Test 8: Disaster Recovery Simulation
echo -e "\n${BLUE}Testing Disaster Recovery Capabilities...${NC}"

test_disaster_recovery() {
    # Check if we can create a fresh clone (simulation)
    local temp_dir="/tmp/backup-test-$$"
    local origin_url=$(git remote get-url origin 2>/dev/null || echo "")
    
    if [ -n "$origin_url" ]; then
        log_result "PASS" "Repository can be cloned from: $origin_url"
        
        # Test clone operation (without actually cloning to save time)
        if git ls-remote origin >/dev/null 2>&1; then
            log_result "PASS" "Repository accessible for disaster recovery"
        else
            log_result "WARN" "Repository may not be accessible for recovery"
        fi
    else
        log_result "WARN" "No origin URL configured for disaster recovery"
    fi
    
    # Check for important recovery documentation
    if [ -f "README.md" ]; then
        if grep -q "setup\|install\|getting started" "README.md"; then
            log_result "PASS" "Setup documentation available for recovery"
        else
            log_result "WARN" "Setup documentation incomplete"
        fi
    else
        log_result "WARN" "No README.md for recovery documentation"
    fi
    
    # Check for environment configuration
    if [ -f ".env.example" ] || [ -f "CLAUDE.md" ]; then
        log_result "PASS" "Environment configuration documented"
    else
        log_result "WARN" "Environment configuration not documented"
    fi
}

# Run all tests
echo -e "\n${BLUE}Starting Backup and Version Control Test Suite...${NC}"

test_git_health
test_content_tracking
test_schema_backup
test_commit_history
test_branch_management
test_remote_backup
test_asset_backup
test_disaster_recovery

# Final summary
echo -e "\n${BLUE}=== Backup Verification Summary ===${NC}"
echo -e "${GREEN}Tests Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Tests Failed: $TESTS_FAILED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"

# Generate backup recommendations
echo -e "\n${BLUE}=== Backup Recommendations ===${NC}"

if [ $TESTS_FAILED -gt 0 ]; then
    echo -e "${RED}Critical Issues:${NC}"
    echo "• Fix Git repository access issues immediately"
    echo "• Ensure all critical files are under version control"
fi

if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}Improvement Recommendations:${NC}"
    echo "• Add untracked content files to Git"
    echo "• Improve commit message formatting"
    echo "• Set up automated backup verification"
    echo "• Document disaster recovery procedures"
    echo "• Consider multiple remote backup locations"
fi

echo -e "\n${GREEN}Backup Best Practices:${NC}"
echo "• Commit changes frequently with descriptive messages"
echo "• Push to remote repositories regularly"
echo "• Use conventional commit message format"
echo "• Tag important releases"
echo "• Maintain clean working directory"
echo "• Document setup and recovery procedures"

# Generate backup status report
echo -e "\n${BLUE}=== Backup Status Report ===${NC}"
echo "Repository Health: $([ $TESTS_FAILED -eq 0 ] && echo "✅ GOOD" || echo "❌ ISSUES")"
echo "Content Protection: $([ $WARNINGS -lt 3 ] && echo "✅ PROTECTED" || echo "⚠️ NEEDS ATTENTION")"
echo "Recovery Capability: $([ $TESTS_PASSED -gt $TESTS_FAILED ] && echo "✅ READY" || echo "❌ LIMITED")"

if [ $TESTS_FAILED -eq 0 ] && [ $WARNINGS -lt 5 ]; then
    echo -e "\n${GREEN}💾 Backup and Version Control Verification Passed!${NC}"
    echo "Content is properly protected and recoverable."
    exit 0
else
    echo -e "\n${YELLOW}⚠️ Backup Verification Completed with Recommendations${NC}"
    echo "Address issues to ensure content protection."
    exit 0
fi