#!/bin/bash

# PWA Integration Testing Script for Beyond the AI Plateau Content
# Tests content compatibility with Progressive Web Application requirements

set -e

echo "🚀 Starting PWA Integration Testing..."

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

# Test 1: Content Structure and Organization
echo -e "\n${BLUE}Testing Content Structure and Organization...${NC}"

test_content_structure() {
    local required_dirs=(
        "content/principles"
        "content/templates" 
        "content/advanced"
        "content/case-studies"
        "assets/diagrams"
        "assets/images"
        "assets/interactive"
    )
    
    for dir in "${required_dirs[@]}"; do
        if [ -d "$dir" ]; then
            log_result "PASS" "Directory exists: $dir"
        else
            log_result "FAIL" "Missing required directory: $dir"
        fi
    done
}

# Test 2: PWA Metadata Compliance
echo -e "\n${BLUE}Testing PWA Metadata Compliance...${NC}"

test_pwa_metadata() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    if [ ${#content_files[@]} -eq 0 ]; then
        log_result "WARN" "No content files found for metadata testing"
        return
    fi
    
    for file in "${content_files[@]}"; do
        if grep -q "integration_requirements.*pwa-compatible" "$file"; then
            log_result "PASS" "PWA compatibility metadata found in $file"
        else
            log_result "FAIL" "Missing PWA compatibility metadata in $file"
        fi
        
        if grep -q "offline-accessible" "$file"; then
            log_result "PASS" "Offline accessibility metadata found in $file"
        else
            log_result "WARN" "Missing offline accessibility metadata in $file"
        fi
    done
}

# Test 3: Schema Validation
echo -e "\n${BLUE}Testing Schema Validation...${NC}"

test_schema_validation() {
    local schema_files=(
        "schemas/content-validation/chapter-schema.json"
        "schemas/content-validation/template-schema.json" 
        "schemas/metadata/content-metadata-schema.json"
    )
    
    for schema in "${schema_files[@]}"; do
        if [ -f "$schema" ]; then
            log_result "PASS" "Schema file exists: $schema"
            
            # Validate JSON syntax
            if jq empty "$schema" 2>/dev/null; then
                log_result "PASS" "Valid JSON syntax: $schema"
            else
                log_result "FAIL" "Invalid JSON syntax: $schema"
            fi
        else
            log_result "FAIL" "Missing schema file: $schema"
        fi
    done
}

# Test 4: Accessibility Compliance
echo -e "\n${BLUE}Testing Accessibility Compliance...${NC}"

test_accessibility_compliance() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    if [ ${#content_files[@]} -eq 0 ]; then
        log_result "WARN" "No content files found for accessibility testing"
        return
    fi
    
    for file in "${content_files[@]}"; do
        # Check for semantic markup indicators
        if grep -q "accessibility_features" "$file"; then
            log_result "PASS" "Accessibility metadata found in $file"
        else
            log_result "WARN" "Missing accessibility metadata in $file"
        fi
        
        # Check for alt text on images
        if grep -q "!\[.*\]" "$file"; then
            if grep -q "!\[\s*\]" "$file"; then
                log_result "FAIL" "Images missing alt text in $file"
            else
                log_result "PASS" "Images have alt text in $file"
            fi
        fi
    done
}

# Test 5: Interactive Elements Validation
echo -e "\n${BLUE}Testing Interactive Elements...${NC}"

test_interactive_elements() {
    local interactive_specs=($(find assets/interactive -name "*.json" -type f 2>/dev/null || true))
    
    if [ ${#interactive_specs[@]} -eq 0 ]; then
        log_result "WARN" "No interactive element specifications found"
        return
    fi
    
    for spec in "${interactive_specs[@]}"; do
        if jq empty "$spec" 2>/dev/null; then
            log_result "PASS" "Valid interactive specification: $spec"
            
            # Check for PWA compatibility fields
            if jq -e '.pwa_compatible' "$spec" >/dev/null 2>&1; then
                log_result "PASS" "PWA compatibility specified in $spec"
            else
                log_result "WARN" "PWA compatibility not specified in $spec"
            fi
        else
            log_result "FAIL" "Invalid interactive specification: $spec"
        fi
    done
}

# Test 6: Content Performance Validation
echo -e "\n${BLUE}Testing Content Performance Requirements...${NC}"

test_performance_requirements() {
    local large_files=($(find content -name "*.md" -size +100k -type f 2>/dev/null || true))
    
    if [ ${#large_files[@]} -gt 0 ]; then
        for file in "${large_files[@]}"; do
            log_result "WARN" "Large content file may need chunking: $file ($(du -h "$file" | cut -f1))"
        done
    else
        log_result "PASS" "No oversized content files found"
    fi
    
    # Check for progressive loading indicators
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    for file in "${content_files[@]}"; do
        if grep -q "progressive-loading" "$file"; then
            log_result "PASS" "Progressive loading support indicated in $file"
        fi
    done
}

# Test 7: Template System Integration
echo -e "\n${BLUE}Testing Template System Integration...${NC}"

test_template_integration() {
    local template_files=($(find content/templates -name "*.md" -type f 2>/dev/null || true))
    
    if [ ${#template_files[@]} -eq 0 ]; then
        log_result "WARN" "No template files found for integration testing"
        return
    fi
    
    for template in "${template_files[@]}"; do
        # Check for required template structure
        if grep -q "## Template Usage" "$template"; then
            log_result "PASS" "Template usage section found in $template"
        else
            log_result "WARN" "Missing template usage section in $template"
        fi
        
        if grep -q "## Variables" "$template"; then
            log_result "PASS" "Variables section found in $template"
        else
            log_result "WARN" "Missing variables section in $template"
        fi
        
        if grep -q "template-testing" "$template"; then
            log_result "PASS" "Template testing metadata found in $template"
        else
            log_result "WARN" "Missing template testing metadata in $template"
        fi
    done
}

# Test 8: Content Validation Script Integration
echo -e "\n${BLUE}Testing Content Validation Integration...${NC}"

test_validation_integration() {
    if [ -f "scripts/content-processing/validate-content.sh" ]; then
        log_result "PASS" "Content validation script exists"
        
        if [ -x "scripts/content-processing/validate-content.sh" ]; then
            log_result "PASS" "Content validation script is executable"
        else
            log_result "WARN" "Content validation script not executable"
        fi
    else
        log_result "FAIL" "Missing content validation script"
    fi
}

# Run all tests
echo -e "\n${BLUE}Starting PWA Integration Test Suite...${NC}"

test_content_structure
test_pwa_metadata
test_schema_validation
test_accessibility_compliance
test_interactive_elements
test_performance_requirements
test_template_integration
test_validation_integration

# Final summary
echo -e "\n${BLUE}=== PWA Integration Test Summary ===${NC}"
echo -e "${GREEN}Tests Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Tests Failed: $TESTS_FAILED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "\n${GREEN}🎉 PWA Integration Testing Completed Successfully!${NC}"
    exit 0
else
    echo -e "\n${RED}❌ PWA Integration Testing Failed - Please address failed tests${NC}"
    exit 1
fi