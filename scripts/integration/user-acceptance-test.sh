#!/bin/bash

# User Acceptance Testing Script for Beyond the AI Plateau Content
# Validates content meets user experience and learning objectives

set -e

echo "🎯 Starting User Acceptance Testing..."

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

# Test 1: Content Quality and Readability
echo -e "\n${BLUE}Testing Content Quality and Readability...${NC}"

test_content_quality() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    if [ ${#content_files[@]} -eq 0 ]; then
        log_result "WARN" "No content files found for quality testing"
        return
    fi
    
    for file in "${content_files[@]}"; do
        local word_count=$(wc -w < "$file" 2>/dev/null || echo 0)
        local line_count=$(wc -l < "$file" 2>/dev/null || echo 0)
        
        # Check word count for different content types
        if [[ "$file" =~ content/principles/ ]]; then
            if [ "$word_count" -ge 4000 ] && [ "$word_count" -le 6000 ]; then
                log_result "PASS" "Chapter word count appropriate: $file ($word_count words)"
            else
                log_result "WARN" "Chapter word count outside target range: $file ($word_count words, target: 4000-6000)"
            fi
        fi
        
        # Check for empty files
        if [ "$line_count" -lt 10 ]; then
            log_result "WARN" "Content file appears incomplete: $file ($line_count lines)"
        else
            log_result "PASS" "Content file has substantial content: $file"
        fi
        
        # Check for code examples
        if grep -q "```" "$file"; then
            log_result "PASS" "Code examples present in $file"
        else
            log_result "WARN" "No code examples found in $file"
        fi
    done
}

# Test 2: Learning Objectives Validation
echo -e "\n${BLUE}Testing Learning Objectives Validation...${NC}"

test_learning_objectives() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    for file in "${content_files[@]}"; do
        # Check for learning objectives section
        if grep -q "## Learning Objectives\|## Objectives\|## You Will Learn" "$file"; then
            log_result "PASS" "Learning objectives defined in $file"
        else
            log_result "WARN" "Missing learning objectives in $file"
        fi
        
        # Check for quick wins section
        if grep -q "## Quick Win\|## Quick Implementation\|## 15-Minute" "$file"; then
            log_result "PASS" "Quick wins section found in $file"
        else
            log_result "WARN" "Missing quick wins section in $file"
        fi
        
        # Check for practical examples
        if grep -q "## Example\|## Case Study\|## Implementation" "$file"; then
            log_result "PASS" "Practical examples found in $file"
        else
            log_result "WARN" "Missing practical examples in $file"
        fi
    done
}

# Test 3: Template Usability Testing
echo -e "\n${BLUE}Testing Template Usability...${NC}"

test_template_usability() {
    local template_files=($(find content/templates -name "*.md" -type f 2>/dev/null || true))
    
    if [ ${#template_files[@]} -eq 0 ]; then
        log_result "WARN" "No template files found for usability testing"
        return
    fi
    
    for template in "${template_files[@]}"; do
        # Check for clear usage instructions
        if grep -q "## How to Use\|## Usage\|## Instructions" "$template"; then
            log_result "PASS" "Usage instructions found in $template"
        else
            log_result "FAIL" "Missing usage instructions in $template"
        fi
        
        # Check for variable documentation
        if grep -q "## Variables\|{{\w+}}\|<\w+>" "$template"; then
            log_result "PASS" "Variable documentation found in $template"
        else
            log_result "WARN" "Variable documentation missing in $template"
        fi
        
        # Check for examples
        if grep -q "## Example\|## Sample\|## Demo" "$template"; then
            log_result "PASS" "Usage examples found in $template"
        else
            log_result "WARN" "Usage examples missing in $template"
        fi
        
        # Check for expected outcomes
        if grep -q "## Expected Output\|## Results\|## Outcome" "$template"; then
            log_result "PASS" "Expected outcomes documented in $template"
        else
            log_result "WARN" "Expected outcomes not documented in $template"
        fi
    done
}

# Test 4: Navigation and Cross-References
echo -e "\n${BLUE}Testing Navigation and Cross-References...${NC}"

test_navigation() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    for file in "${content_files[@]}"; do
        # Check for internal links
        local internal_links=($(grep -o '\[.*\](.*\.md\|#.*\|ch[0-9]\+)' "$file" 2>/dev/null || true))
        
        if [ ${#internal_links[@]} -gt 0 ]; then
            log_result "PASS" "Internal navigation links found in $file"
            
            # Validate internal links
            for link in "${internal_links[@]}"; do
                if echo "$link" | grep -q "\.md"; then
                    local target_file=$(echo "$link" | sed 's/.*(\(.*\.md\)).*/\1/')
                    if [ -f "$target_file" ] || [ -f "content/$target_file" ]; then
                        log_result "PASS" "Valid internal link: $link in $file"
                    else
                        log_result "WARN" "Broken internal link: $link in $file"
                    fi
                fi
            done
        else
            log_result "WARN" "No internal navigation links in $file"
        fi
        
        # Check for table of contents
        if grep -q "## Table of Contents\|## Contents\|## Overview" "$file"; then
            log_result "PASS" "Table of contents found in $file"
        else
            log_result "WARN" "Missing table of contents in $file"
        fi
    done
}

# Test 5: Code Example Validation
echo -e "\n${BLUE}Testing Code Example Quality...${NC}"

test_code_examples() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    for file in "${content_files[@]}"; do
        # Check for code blocks with language specification
        if grep -q "```[a-zA-Z]" "$file"; then
            log_result "PASS" "Code blocks with language specification in $file"
        elif grep -q "```" "$file"; then
            log_result "WARN" "Code blocks missing language specification in $file"
        fi
        
        # Check for common code patterns
        if grep -q "```typescript\|```javascript\|```bash\|```json" "$file"; then
            log_result "PASS" "Relevant code examples found in $file"
        fi
        
        # Check for commented code
        if grep -A5 "```" "$file" | grep -q "//\|#\|<!--" 2>/dev/null; then
            log_result "PASS" "Commented code examples in $file"
        fi
    done
}

# Test 6: Accessibility and Inclusivity
echo -e "\n${BLUE}Testing Accessibility and Inclusivity...${NC}"

test_accessibility() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    for file in "${content_files[@]}"; do
        # Check for heading hierarchy
        local h1_count=$(grep -c "^# " "$file" 2>/dev/null || echo 0)
        local h2_count=$(grep -c "^## " "$file" 2>/dev/null || echo 0)
        
        if [ "$h1_count" -eq 1 ]; then
            log_result "PASS" "Proper H1 usage in $file"
        elif [ "$h1_count" -gt 1 ]; then
            log_result "WARN" "Multiple H1 tags in $file (accessibility concern)"
        fi
        
        if [ "$h2_count" -gt 0 ]; then
            log_result "PASS" "Structured content with H2 sections in $file"
        fi
        
        # Check for alt text on images
        if grep -q "!\[.*\]" "$file"; then
            if grep -q "!\[\s*\]" "$file"; then
                log_result "FAIL" "Images missing alt text in $file"
            else
                log_result "PASS" "Images have alt text in $file"
            fi
        fi
        
        # Check for inclusive language patterns
        if grep -qi "guys\|master/slave\|blacklist\|whitelist" "$file"; then
            log_result "WARN" "Potentially non-inclusive language found in $file"
        else
            log_result "PASS" "Inclusive language check passed for $file"
        fi
    done
}

# Test 7: Content Completeness
echo -e "\n${BLUE}Testing Content Completeness...${NC}"

test_content_completeness() {
    local expected_chapters=(
        "content/principles/ch01-ai-betrayal"
        "content/principles/ch02-framework" 
        "content/principles/ch03-context-mastery"
        "content/principles/ch04-dynamic-planning"
        "content/principles/ch05-code-evolution"
        "content/principles/ch06-strategic-testing"
        "content/principles/ch07-intelligent-review"
        "content/principles/ch08-compound-effects"
        "content/principles/ch09-transformation-roadmap"
    )
    
    for chapter_dir in "${expected_chapters[@]}"; do
        if [ -d "$chapter_dir" ]; then
            local chapter_files=($(find "$chapter_dir" -name "*.md" -type f 2>/dev/null || true))
            if [ ${#chapter_files[@]} -gt 0 ]; then
                log_result "PASS" "Chapter content exists: $chapter_dir"
            else
                log_result "WARN" "Chapter directory exists but no content: $chapter_dir"
            fi
        else
            log_result "WARN" "Missing chapter directory: $chapter_dir"
        fi
    done
    
    # Check template categories
    local template_categories=(
        "content/templates/context-mastery"
        "content/templates/dynamic-planning"
        "content/templates/code-evolution"
        "content/templates/strategic-testing"
        "content/templates/intelligent-review"
    )
    
    for category in "${template_categories[@]}"; do
        if [ -d "$category" ]; then
            local template_files=($(find "$category" -name "*.md" -type f 2>/dev/null || true))
            if [ ${#template_files[@]} -gt 0 ]; then
                log_result "PASS" "Template category has content: $category"
            else
                log_result "WARN" "Template category exists but no templates: $category"
            fi
        else
            log_result "WARN" "Missing template category: $category"
        fi
    done
}

# Test 8: User Experience Flow
echo -e "\n${BLUE}Testing User Experience Flow...${NC}"

test_user_experience() {
    # Check for consistent content structure
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    for file in "${content_files[@]}"; do
        # Check for consistent frontmatter
        if head -5 "$file" | grep -q "^---$"; then
            log_result "PASS" "Frontmatter present in $file"
        else
            log_result "WARN" "Missing frontmatter in $file"
        fi
        
        # Check for conclusion/summary
        if grep -q "## Conclusion\|## Summary\|## Key Takeaways\|## Next Steps" "$file"; then
            log_result "PASS" "Conclusion section found in $file"
        else
            log_result "WARN" "Missing conclusion section in $file"
        fi
    done
}

# Run all tests
echo -e "\n${BLUE}Starting User Acceptance Test Suite...${NC}"

test_content_quality
test_learning_objectives
test_template_usability
test_navigation
test_code_examples
test_accessibility
test_content_completeness
test_user_experience

# Final summary
echo -e "\n${BLUE}=== User Acceptance Test Summary ===${NC}"
echo -e "${GREEN}Tests Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Tests Failed: $TESTS_FAILED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"

# Generate recommendations
echo -e "\n${BLUE}=== Recommendations ===${NC}"
if [ $TESTS_FAILED -gt 0 ]; then
    echo -e "${RED}Critical Issues:${NC}"
    echo "- Address all failed tests before launch"
    echo "- Focus on missing usage instructions in templates"
    echo "- Fix accessibility issues (missing alt text)"
fi

if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}Improvement Opportunities:${NC}"
    echo "- Complete missing content sections"
    echo "- Add more practical examples and code comments"
    echo "- Improve internal navigation and cross-references"
    echo "- Ensure consistent content structure across all files"
fi

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}🎉 User Acceptance Testing Completed Successfully!${NC}"
    echo "Content is ready for user testing and feedback incorporation."
    exit 0
else
    echo -e "\n${RED}❌ User Acceptance Testing Failed - Please address critical issues${NC}"
    exit 1
fi