#!/bin/bash

# Beyond the AI Plateau PWA Integration Testing Script
# Comprehensive validation of PWA features, offline functionality, and performance

set -e

echo "🚀 Starting PWA Integration Testing for Beyond the AI Plateau"
echo "============================================================="

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Test counters
TESTS_TOTAL=0
TESTS_PASSED=0
TESTS_FAILED=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_command="$2"
    
    TESTS_TOTAL=$((TESTS_TOTAL + 1))
    echo -e "\n${BLUE}Testing:${NC} $test_name"
    
    if eval "$test_command"; then
        echo -e "${GREEN}✅ PASS:${NC} $test_name"
        TESTS_PASSED=$((TESTS_PASSED + 1))
        return 0
    else
        echo -e "${RED}❌ FAIL:${NC} $test_name"
        TESTS_FAILED=$((TESTS_FAILED + 1))
        return 1
    fi
}

# Function to check file exists
check_file_exists() {
    local file_path="$1"
    local description="$2"
    
    if [[ -f "$file_path" ]]; then
        echo -e "${GREEN}✅${NC} Found: $description ($file_path)"
        return 0
    else
        echo -e "${RED}❌${NC} Missing: $description ($file_path)"
        return 1
    fi
}

# Function to validate JSON
validate_json() {
    local file_path="$1"
    
    if command -v jq &> /dev/null; then
        jq empty "$file_path" 2>/dev/null
    else
        # Basic JSON validation without jq
        python3 -c "import json; json.load(open('$file_path'))" 2>/dev/null
    fi
}

# Function to check PWA metadata in markdown files
check_pwa_metadata() {
    local file_path="$1"
    local required_fields=("pwa_integration" "offline_functionality" "progressive_loading")
    
    for field in "${required_fields[@]}"; do
        if ! grep -q "^$field:" "$file_path"; then
            echo -e "${RED}❌${NC} Missing PWA metadata field: $field in $file_path"
            return 1
        fi
    done
    
    echo -e "${GREEN}✅${NC} PWA metadata complete in $file_path"
    return 0
}

echo -e "\n${YELLOW}Phase 1: Core PWA Infrastructure${NC}"
echo "=================================="

# Test 1: Service Worker exists and is valid
run_test "Service Worker file exists" "check_file_exists 'sw.js' 'Service Worker'"

# Test 2: Manifest file exists and is valid JSON
run_test "PWA Manifest exists" "check_file_exists 'manifest.json' 'PWA Manifest'"
run_test "PWA Manifest is valid JSON" "validate_json 'manifest.json'"

# Test 3: Critical PWA files structure
run_test "Assets directory exists" "[[ -d 'assets' ]]"
run_test "Scripts directory exists" "[[ -d 'scripts' ]]"
run_test "Content directory exists" "[[ -d 'content' ]]"

echo -e "\n${YELLOW}Phase 2: Content PWA Integration${NC}"
echo "================================="

# Test 4: Chapter files have PWA metadata
CHAPTER_FILES=(
    "content/principles/ch01-ai-betrayal/chapter-01-the-great-ai-betrayal.md"
    "content/principles/ch02-framework/chapter-02-five-elite-principles-framework.md"
    "content/principles/ch03-context-mastery/chapter-03-context-mastery.md"
    "content/principles/ch04-dynamic-planning/chapter-04-dynamic-planning.md"
    "content/principles/ch05-code-evolution/chapter-05-code-evolution.md"
    "content/principles/ch06-strategic-testing/chapter-06-strategic-testing.md"
    "content/principles/ch07-intelligent-review/chapter-07-intelligent-review.md"
    "content/principles/ch08-compound-effects/README.md"
    "content/principles/ch09-transformation-roadmap/README.md"
)

for chapter_file in "${CHAPTER_FILES[@]}"; do
    if [[ -f "$chapter_file" ]]; then
        run_test "PWA metadata in $(basename "$chapter_file")" "check_pwa_metadata '$chapter_file'"
    else
        echo -e "${YELLOW}⚠️  SKIP:${NC} Chapter file not found: $chapter_file"
    fi
done

echo -e "\n${YELLOW}Phase 3: Template Library PWA Integration${NC}"
echo "========================================="

# Test 5: Template files have PWA metadata
TEMPLATE_FILES=(
    "content/templates/dynamic-planning/foundation/basic-project-initialization.md"
    "content/templates/cross-principle-integration/complete-feature-development-workflow.md"
    "content/templates/code-evolution/foundation/basic-code-cleanup.md"
)

for template_file in "${TEMPLATE_FILES[@]}"; do
    if [[ -f "$template_file" ]]; then
        run_test "PWA metadata in template $(basename "$template_file")" "check_pwa_metadata '$template_file'"
    else
        echo -e "${YELLOW}⚠️  SKIP:${NC} Template file not found: $template_file"
    fi
done

# Test 6: Template directory structure
run_test "Context Mastery templates exist" "[[ -d 'content/templates/context-mastery' ]]"
run_test "Dynamic Planning templates exist" "[[ -d 'content/templates/dynamic-planning' ]]"
run_test "Code Evolution templates exist" "[[ -d 'content/templates/code-evolution' ]]"
run_test "Strategic Testing templates exist" "[[ -d 'content/templates/strategic-testing' ]]"
run_test "Intelligent Review templates exist" "[[ -d 'content/templates/intelligent-review' ]]"

echo -e "\n${YELLOW}Phase 4: Case Study PWA Integration${NC}"
echo "==================================="

# Test 7: Case study files exist and have PWA metadata
CASE_STUDY_FILES=(
    "content/case-studies/foundation/tommy-complete-transformation.md"
    "content/case-studies/foundation/team-collaboration-transformation.md"
    "content/case-studies/foundation/team-velocity-transformation.md"
    "content/case-studies/advanced/enterprise-legacy-modernization.md"
    "content/case-studies/advanced/multi-repository-architecture-optimization.md"
    "content/case-studies/elite/global-enterprise-ai-transformation.md"
    "content/case-studies/elite/ai-first-team-culture-evolution.md"
)

for case_study_file in "${CASE_STUDY_FILES[@]}"; do
    if [[ -f "$case_study_file" ]]; then
        run_test "PWA metadata in case study $(basename "$case_study_file")" "check_pwa_metadata '$case_study_file'"
    else
        echo -e "${YELLOW}⚠️  SKIP:${NC} Case study file not found: $case_study_file"
    fi
done

echo -e "\n${YELLOW}Phase 5: Service Worker Validation${NC}"
echo "=================================="

# Test 8: Service Worker syntax and structure
if [[ -f "sw.js" ]]; then
    run_test "Service Worker syntax validation" "node -c sw.js"
    run_test "Service Worker contains install event" "grep -q 'addEventListener.*install' sw.js"
    run_test "Service Worker contains activate event" "grep -q 'addEventListener.*activate' sw.js"
    run_test "Service Worker contains fetch event" "grep -q 'addEventListener.*fetch' sw.js"
    run_test "Service Worker contains cache management" "grep -q 'caches.open' sw.js"
    run_test "Service Worker contains offline fallbacks" "grep -q 'createOffline.*Fallback' sw.js"
fi

echo -e "\n${YELLOW}Phase 6: Manifest Validation${NC}"
echo "============================"

# Test 9: Manifest required fields
if [[ -f "manifest.json" ]]; then
    run_test "Manifest contains name" "grep -q '\"name\"' manifest.json"
    run_test "Manifest contains short_name" "grep -q '\"short_name\"' manifest.json"
    run_test "Manifest contains start_url" "grep -q '\"start_url\"' manifest.json"
    run_test "Manifest contains display" "grep -q '\"display\"' manifest.json"
    run_test "Manifest contains icons array" "grep -q '\"icons\"' manifest.json"
    run_test "Manifest contains theme_color" "grep -q '\"theme_color\"' manifest.json"
    run_test "Manifest contains background_color" "grep -q '\"background_color\"' manifest.json"
fi

echo -e "\n${YELLOW}Phase 7: Accessibility Validation${NC}"
echo "================================="

# Test 10: Accessibility metadata
check_accessibility_metadata() {
    local file_path="$1"
    local accessibility_fields=("accessibility_features" "semantic_markup" "screen_reader_compatible")
    
    for field in "${accessibility_fields[@]}"; do
        if ! grep -q "$field" "$file_path"; then
            return 1
        fi
    done
    return 0
}

for chapter_file in "${CHAPTER_FILES[@]}"; do
    if [[ -f "$chapter_file" ]]; then
        run_test "Accessibility metadata in $(basename "$chapter_file")" "check_accessibility_metadata '$chapter_file'"
    fi
done

echo -e "\n${YELLOW}Phase 8: Performance Validation${NC}"
echo "==============================="

# Test 11: Performance targets in content
check_performance_targets() {
    local file_path="$1"
    
    if grep -q "performance_targets" "$file_path" && 
       grep -q "first_contentful_paint" "$file_path" && 
       grep -q "largest_contentful_paint" "$file_path"; then
        return 0
    fi
    return 1
}

for chapter_file in "${CHAPTER_FILES[@]}"; do
    if [[ -f "$chapter_file" ]]; then
        run_test "Performance targets in $(basename "$chapter_file")" "check_performance_targets '$chapter_file'"
    fi
done

echo -e "\n${YELLOW}Phase 9: Offline Functionality Validation${NC}"
echo "=========================================="

# Test 12: Offline functionality metadata
check_offline_functionality() {
    local file_path="$1"
    
    if grep -q "offline_functionality: true" "$file_path" && 
       grep -q "caching_strategy" "$file_path" && 
       grep -q "sync_requirements" "$file_path"; then
        return 0
    fi
    return 1
}

for chapter_file in "${CHAPTER_FILES[@]}"; do
    if [[ -f "$chapter_file" ]]; then
        run_test "Offline functionality in $(basename "$chapter_file")" "check_offline_functionality '$chapter_file'"
    fi
done

echo -e "\n${YELLOW}Phase 10: Integration Testing${NC}"
echo "============================="

# Test 13: Cross-references and integration
run_test "PWA integration specification exists" "check_file_exists 'assets/diagrams/pwa-integration/pwa-integration-specifications.md' 'PWA Integration Specifications'"

# Test 14: Template validation
if command -v npm &> /dev/null; then
    if [[ -f "package.json" ]] && grep -q "lint" package.json; then
        run_test "Code linting passes" "npm run lint --silent"
    fi
fi

echo -e "\n${YELLOW}Phase 11: File Structure Validation${NC}"
echo "===================================="

# Test 15: Essential directory structure
REQUIRED_DIRS=(
    "content/principles"
    "content/templates"
    "content/case-studies"
    "content/advanced"
    "content/elite"
    "assets/diagrams"
    "scripts/integration"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    run_test "Directory exists: $dir" "[[ -d '$dir' ]]"
done

echo -e "\n${YELLOW}Phase 12: Content Validation${NC}"
echo "============================"

# Test 16: Word count validation for major content
validate_word_count() {
    local file_path="$1"
    local min_words="$2"
    
    if [[ -f "$file_path" ]]; then
        local word_count=$(wc -w < "$file_path")
        if [[ $word_count -ge $min_words ]]; then
            echo "Word count: $word_count (minimum: $min_words)"
            return 0
        else
            echo "Word count too low: $word_count (minimum: $min_words)"
            return 1
        fi
    fi
    return 1
}

# Test major content files have adequate word counts
if [[ -f "content/principles/ch03-context-mastery/chapter-03-context-mastery.md" ]]; then
    run_test "Chapter 3 has adequate content (min 5000 words)" "validate_word_count 'content/principles/ch03-context-mastery/chapter-03-context-mastery.md' 5000"
fi

if [[ -f "content/case-studies/foundation/tommy-complete-transformation.md" ]]; then
    run_test "Tommy case study has adequate content (min 2500 words)" "validate_word_count 'content/case-studies/foundation/tommy-complete-transformation.md' 2500"
fi

echo -e "\n${YELLOW}Test Results Summary${NC}"
echo "===================="

echo -e "Total Tests: ${BLUE}$TESTS_TOTAL${NC}"
echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Failed: ${RED}$TESTS_FAILED${NC}"

if [[ $TESTS_FAILED -eq 0 ]]; then
    echo -e "\n${GREEN}🎉 All PWA integration tests passed!${NC}"
    echo -e "${GREEN}✅ Beyond the AI Plateau is ready for PWA deployment${NC}"
    exit 0
else
    echo -e "\n${RED}❌ $TESTS_FAILED test(s) failed${NC}"
    echo -e "${YELLOW}⚠️  Please review and fix the failing tests before deployment${NC}"
    exit 1
fi