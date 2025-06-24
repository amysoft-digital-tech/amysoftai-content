#!/bin/bash

# Content Quality Review Script for Beyond the AI Plateau
# Comprehensive review for technical accuracy, consistency, and quality standards

set -e

echo "🔍 Content Quality Review - Beyond the AI Plateau"
echo "================================================"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
TESTS_PASSED=0
TESTS_FAILED=0
WARNINGS=0
FILES_REVIEWED=0

# Helper function for results
log_result() {
    local status=$1
    local message=$2
    
    case "$status" in
        "PASS")
            echo -e "${GREEN}✓ PASS${NC}: $message"
            ((TESTS_PASSED++))
            ;;
        "FAIL")
            echo -e "${RED}✗ FAIL${NC}: $message"
            ((TESTS_FAILED++))
            ;;
        "WARN")
            echo -e "${YELLOW}⚠ WARNING${NC}: $message"
            ((WARNINGS++))
            ;;
        "INFO")
            echo -e "${BLUE}ℹ INFO${NC}: $message"
            ;;
    esac
}

# Review content file
review_content_file() {
    local file="$1"
    echo -e "\n${BLUE}=== Reviewing: $file ===${NC}"
    ((FILES_REVIEWED++))
    
    if [[ ! "$file" =~ \.md$ ]]; then
        log_result "INFO" "Skipping non-markdown file: $file"
        return
    fi
    
    if [ ! -r "$file" ]; then
        log_result "FAIL" "Cannot read file: $file"
        return
    fi
    
    if [ ! -s "$file" ]; then
        log_result "WARN" "File is empty: $file"
        return
    fi
    
    # Check frontmatter
    if head -5 "$file" | grep -q "^---$"; then
        log_result "PASS" "Frontmatter present in $file"
    else
        log_result "WARN" "Missing frontmatter in $file"
    fi
    
    # Check heading structure
    local h1_count=$(grep -c "^# " "$file" 2>/dev/null || echo 0)
    if [ "$h1_count" -eq 1 ]; then
        log_result "PASS" "Proper H1 usage in $file"
    elif [ "$h1_count" -gt 1 ]; then
        log_result "WARN" "Multiple H1 headers in $file"
    fi
    
    # Check for code examples
    local code_blocks=$(grep -c "^```" "$file" 2>/dev/null || echo 0)
    if [ "$code_blocks" -gt 0 ]; then
        log_result "PASS" "Contains $code_blocks code examples in $file"
        
        # Check language specification
        local unspecified=$(grep -c "^```$" "$file" 2>/dev/null || echo 0)
        if [ "$unspecified" -gt 0 ]; then
            log_result "WARN" "$unspecified code blocks missing language specification in $file"
        fi
    fi
    
    # Check for images with alt text
    if grep -q "!\[.*\]" "$file"; then
        if grep -q "!\[\s*\]" "$file"; then
            log_result "FAIL" "Images missing alt text in $file"
        else
            log_result "PASS" "Images have alt text in $file"
        fi
    fi
    
    # Check for inclusive language
    if grep -qi "guys\|master.*slave\|blacklist\|whitelist" "$file"; then
        log_result "WARN" "Potentially non-inclusive language in $file"
    else
        log_result "PASS" "Inclusive language check passed for $file"
    fi
    
    # Check word count for chapters
    if [[ "$file" == *"principles"* ]]; then
        local word_count=$(wc -w < "$file" 2>/dev/null || echo 0)
        if [ "$word_count" -lt 4000 ]; then
            log_result "WARN" "Chapter may be too short ($word_count words, target: 4000-6000)"
        elif [ "$word_count" -gt 6000 ]; then
            log_result "WARN" "Chapter is quite long ($word_count words, target: 4000-6000)"
        else
            log_result "PASS" "Word count appropriate ($word_count words)"
        fi
    fi
    
    log_result "INFO" "Completed review of $file"
}

# Main function
main() {
    echo -e "${BLUE}Starting content quality review...${NC}"
    
    # Find all markdown files
    local content_files=()
    
    # Check content directory
    if [ -d "./content" ]; then
        while IFS= read -r -d '' file; do
            content_files+=("$file")
        done < <(find ./content -name "*.md" -type f -print0 2>/dev/null)
    fi
    
    # Check root directory for markdown files
    for file in *.md; do
        if [ -f "$file" ]; then
            content_files+=("$file")
        fi
    done
    
    if [ ${#content_files[@]} -eq 0 ]; then
        log_result "WARN" "No content files found for review"
        log_result "INFO" "Content directories appear empty - expected for initial setup"
    else
        log_result "INFO" "Found ${#content_files[@]} content files for review"
        
        for file in "${content_files[@]}"; do
            review_content_file "$file"
        done
    fi
    
    # Generate summary report
    echo -e "\n${BLUE}=== Content Quality Review Summary ===${NC}"
    echo -e "${BLUE}Files Reviewed:${NC} $FILES_REVIEWED"
    echo -e "${GREEN}Tests Passed:${NC} $TESTS_PASSED"
    echo -e "${RED}Tests Failed:${NC} $TESTS_FAILED"
    echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
    
    if [ "$TESTS_FAILED" -eq 0 ] && [ "$WARNINGS" -lt 5 ]; then
        echo -e "\n${GREEN}✅ Content Quality Review PASSED${NC}"
        echo "Content meets quality standards for production."
    elif [ "$TESTS_FAILED" -eq 0 ]; then
        echo -e "\n${YELLOW}⚠️ Content Quality Review PASSED with recommendations${NC}"
        echo "Address warnings to improve content quality."
    else
        echo -e "\n${RED}❌ Content Quality Review FAILED${NC}"
        echo "Address failed tests before proceeding to production."
    fi
    
    # Recommendations
    if [ "$WARNINGS" -gt 0 ] || [ "$TESTS_FAILED" -gt 0 ]; then
        echo -e "\n${BLUE}=== Recommendations ===${NC}"
        echo "• Add frontmatter to all content files"
        echo "• Include language specification for all code blocks"
        echo "• Ensure all images have descriptive alt text"
        echo "• Use inclusive language throughout content"
        echo "• Maintain appropriate word count for chapters (4000-6000 words)"
        echo "• Follow consistent heading hierarchy (single H1 per file)"
    fi
}

main "$@"