#!/bin/bash

# Technical Accuracy Review Script for Beyond the AI Plateau Content
# Comprehensive validation of technical content, code examples, and accuracy standards

set -e

echo "🔍 Technical Accuracy Review - Beyond the AI Plateau"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
CONTENT_DIR="./content"
SCHEMAS_DIR="./schemas"
SCRIPTS_DIR="./scripts"

# Test counters
TESTS_PASSED=0
TESTS_FAILED=0
WARNINGS=0
TOTAL_FILES_REVIEWED=0

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

# Function to validate code examples
validate_code_examples() {
    local file="$1"
    log_result "INFO" "Validating code examples in $file"
    
    # Extract code blocks and validate syntax
    local code_blocks=($(grep -n "^```" "$file" 2>/dev/null || true))
    local total_blocks=$((${#code_blocks[@]} / 2))
    
    if [ "$total_blocks" -eq 0 ]; then
        log_result "WARN" "No code examples found in $file"
        return
    fi
    
    log_result "INFO" "Found $total_blocks code blocks in $file"
    
    # Check for language specifications
    local unspecified=$(grep -c "^```$" "$file" 2>/dev/null || echo 0)
    if [ "$unspecified" -gt 0 ]; then
        log_result "WARN" "$unspecified code blocks missing language specification in $file"
    else
        log_result "PASS" "All code blocks have language specification in $file"
    fi
    
    # Validate specific language syntaxes
    validate_typescript_examples "$file"
    validate_bash_examples "$file"
    validate_json_examples "$file"
}

# Function to validate TypeScript code examples
validate_typescript_examples() {
    local file="$1"
    
    # Extract TypeScript code blocks
    if grep -q "```typescript\|```ts" "$file"; then
        log_result "INFO" "Validating TypeScript examples in $file"
        
        # Check for common TypeScript patterns and best practices
        if grep -A10 "```typescript\|```ts" "$file" | grep -q "interface\|type\|class"; then
            log_result "PASS" "TypeScript examples include proper type definitions"
        else
            log_result "WARN" "TypeScript examples may lack type definitions"
        fi
        
        # Check for async/await patterns
        if grep -A10 "```typescript\|```ts" "$file" | grep -q "async\|await"; then
            log_result "PASS" "TypeScript examples include modern async patterns"
        fi
        
        # Check for proper imports
        if grep -A10 "```typescript\|```ts" "$file" | grep -q "import.*from"; then
            log_result "PASS" "TypeScript examples include proper imports"
        fi
    fi
}

# Function to validate Bash code examples
validate_bash_examples() {
    local file="$1"
    
    if grep -q "```bash\|```sh" "$file"; then
        log_result "INFO" "Validating Bash examples in $file"
        
        # Extract bash code and check for basic syntax
        local temp_script="/tmp/bash_validation_$$"
        grep -A20 "```bash\|```sh" "$file" | grep -v "```" | head -20 > "$temp_script"
        
        if [ -s "$temp_script" ]; then
            if bash -n "$temp_script" 2>/dev/null; then
                log_result "PASS" "Bash examples have valid syntax"
            else
                log_result "WARN" "Bash examples may have syntax issues"
            fi
        fi
        
        rm -f "$temp_script"
    fi
}

# Function to validate JSON examples
validate_json_examples() {
    local file="$1"
    
    if grep -q "```json" "$file"; then
        log_result "INFO" "Validating JSON examples in $file"
        
        # Extract JSON and validate syntax
        local temp_json="/tmp/json_validation_$$"
        grep -A50 "```json" "$file" | grep -v "```" | head -50 > "$temp_json"
        
        if [ -s "$temp_json" ]; then
            if jq empty "$temp_json" 2>/dev/null; then
                log_result "PASS" "JSON examples have valid syntax"
            else
                log_result "WARN" "JSON examples may have syntax issues"
            fi
        fi
        
        rm -f "$temp_json"
    fi
}

# Function to validate prompt templates
validate_prompt_templates() {
    local file="$1"
    log_result "INFO" "Validating prompt template effectiveness in $file"
    
    # Check for template structure
    if grep -q "## Template Usage\|## Variables\|## Example" "$file"; then
        log_result "PASS" "Prompt template has proper structure in $file"
    else
        log_result "WARN" "Prompt template missing required sections in $file"
    fi
    
    # Check for variable placeholders
    if grep -q "{{.*}}\|<.*>\|\[.*\]" "$file"; then
        log_result "PASS" "Template includes variable placeholders in $file"
    else
        log_result "WARN" "Template may lack customizable variables in $file"
    fi
    
    # Check for usage instructions
    if grep -qi "how to use\|instructions\|steps" "$file"; then
        log_result "PASS" "Template includes usage instructions in $file"
    else
        log_result "WARN" "Template lacks clear usage instructions in $file"
    fi
    
    # Check for expected outcomes
    if grep -qi "expected.*output\|result\|outcome" "$file"; then
        log_result "PASS" "Template documents expected outcomes in $file"
    else
        log_result "WARN" "Template lacks expected outcome documentation in $file"
    fi
}

# Function to validate technology references
validate_technology_references() {
    local file="$1"
    log_result "INFO" "Validating technology references in $file"
    
    # Check for current version references
    local outdated_refs=false
    
    # Angular version checks
    if grep -qi "angular.*[0-9]" "$file"; then
        if grep -qi "angular.*1[0-7]\|angular.*[0-9]\..*" "$file"; then
            log_result "WARN" "Potentially outdated Angular version reference in $file"
            outdated_refs=true
        else
            log_result "PASS" "Angular version references appear current in $file"
        fi
    fi
    
    # TypeScript version checks
    if grep -qi "typescript.*[0-9]" "$file"; then
        if grep -qi "typescript.*[0-4]\.\|typescript.*3\." "$file"; then
            log_result "WARN" "Potentially outdated TypeScript version reference in $file"
            outdated_refs=true
        else
            log_result "PASS" "TypeScript version references appear current in $file"
        fi
    fi
    
    # Node.js version checks
    if grep -qi "node.*[0-9]" "$file"; then
        if grep -qi "node.*1[0-7]\|node.*[0-9]\.\|nodejs.*1[0-7]" "$file"; then
            log_result "WARN" "Potentially outdated Node.js version reference in $file"
            outdated_refs=true
        else
            log_result "PASS" "Node.js version references appear current in $file"
        fi
    fi
    
    if [ "$outdated_refs" = false ]; then
        log_result "PASS" "No outdated technology references detected in $file"
    fi
}

# Function to validate AI tool integration references
validate_ai_tool_references() {
    local file="$1"
    log_result "INFO" "Validating AI tool references in $file"
    
    # Check for Claude Code references
    if grep -qi "claude.*code\|claude code" "$file"; then
        log_result "PASS" "Claude Code integration documented in $file"
        
        # Check for specific features
        if grep -qi "nx.*workspace\|angular.*workspace" "$file"; then
            log_result "PASS" "Nx workspace integration mentioned in $file"
        fi
    fi
    
    # Check for GitHub Copilot references
    if grep -qi "github.*copilot\|copilot" "$file"; then
        log_result "PASS" "GitHub Copilot integration documented in $file"
    fi
    
    # Check for prompt engineering best practices
    if grep -qi "context.*window\|prompt.*engineering\|system.*prompt" "$file"; then
        log_result "PASS" "Prompt engineering concepts present in $file"
    fi
    
    # Check for AI-specific terminology accuracy
    if grep -qi "llm\|large.*language.*model\|token.*limit" "$file"; then
        log_result "PASS" "AI terminology properly used in $file"
    fi
}

# Function to validate content consistency
validate_content_consistency() {
    local file="$1"
    log_result "INFO" "Validating content consistency in $file"
    
    # Check for consistent terminology
    local terminology_issues=false
    
    # Check for consistent naming conventions
    if grep -qi "ai.*plateau\|AI.*plateau" "$file"; then
        if grep -q "AI.*Plateau\|ai.*plateau" "$file" && ! grep -q "Beyond the AI Plateau" "$file"; then
            log_result "WARN" "Inconsistent capitalization of 'AI Plateau' in $file"
            terminology_issues=true
        fi
    fi
    
    # Check for framework name consistency
    if grep -qi "nestjs\|nest\.js\|nest js" "$file"; then
        if grep -q "nest\.js\|nest js" "$file" && ! grep -q "NestJS" "$file"; then
            log_result "WARN" "Inconsistent NestJS naming convention in $file"
            terminology_issues=true
        fi
    fi
    
    if [ "$terminology_issues" = false ]; then
        log_result "PASS" "Terminology consistency maintained in $file"
    fi
    
    # Check for voice and tone consistency
    if grep -qi "you.*will\|you.*can\|you.*should" "$file"; then
        log_result "PASS" "Consistent second-person voice in $file"
    elif grep -qi "we.*will\|we.*can\|developers.*should" "$file"; then
        log_result "PASS" "Consistent instructional voice in $file"
    else
        log_result "WARN" "Voice and tone may be inconsistent in $file"
    fi
}

# Function to validate accessibility compliance
validate_accessibility_compliance() {
    local file="$1"
    log_result "INFO" "Validating accessibility compliance in $file"
    
    # Check for proper heading hierarchy
    local h1_count=$(grep -c "^# " "$file" 2>/dev/null || echo 0)
    local h2_count=$(grep -c "^## " "$file" 2>/dev/null || echo 0)
    
    if [ "$h1_count" -eq 1 ]; then
        log_result "PASS" "Proper H1 usage (single title) in $file"
    elif [ "$h1_count" -gt 1 ]; then
        log_result "WARN" "Multiple H1 headers found ($h1_count) in $file - accessibility concern"
    fi
    
    if [ "$h2_count" -gt 0 ]; then
        log_result "PASS" "Structured content with H2 sections in $file"
    fi
    
    # Check for alt text on images
    if grep -q "!\[.*\]" "$file"; then
        if grep -q "!\[\s*\]" "$file"; then
            log_result "FAIL" "Images missing alt text in $file - accessibility violation"
        else
            log_result "PASS" "Images include alt text in $file"
        fi
    fi
    
    # Check for inclusive language
    if grep -qi "guys\|master.*slave\|blacklist\|whitelist\|sanity.*check" "$file"; then
        log_result "WARN" "Potentially non-inclusive language found in $file"
    else
        log_result "PASS" "Inclusive language check passed for $file"
    fi
    
    # Check for descriptive link text
    if grep -q "\[click here\]\|\[here\]\|\[read more\]" "$file"; then
        log_result "WARN" "Non-descriptive link text found in $file - accessibility concern"
    else
        log_result "PASS" "Descriptive link text used in $file"
    fi
}

# Function to validate cross-references and links
validate_cross_references() {
    local file="$1"
    log_result "INFO" "Validating cross-references and links in $file"
    
    # Check internal links
    local internal_links=($(grep -o '\[.*\](.*\.md\|#.*\|ch[0-9]\+)' "$file" 2>/dev/null || true))
    
    if [ ${#internal_links[@]} -gt 0 ]; then
        log_result "PASS" "Internal navigation links found in $file"
        
        # Validate internal links (basic check)
        for link in "${internal_links[@]}"; do
            if echo "$link" | grep -q "\.md"; then
                local target_file=$(echo "$link" | sed 's/.*(\(.*\.md\)).*/\1/')
                if [ -f "$target_file" ] || [ -f "$CONTENT_DIR/$target_file" ]; then
                    log_result "PASS" "Valid internal link: $link"
                else
                    log_result "WARN" "Potentially broken internal link: $link in $file"
                fi
            fi
        done
    fi
    
    # Check external links (basic format validation)
    local external_links=($(grep -o 'https\?://[^)]*' "$file" 2>/dev/null || true))
    
    if [ ${#external_links[@]} -gt 0 ]; then
        log_result "INFO" "Found ${#external_links[@]} external links in $file"
        
        # Check for suspicious or potentially temporary links
        for link in "${external_links[@]}"; do
            if echo "$link" | grep -qi "localhost\|127\.0\.0\.1\|example\.com"; then
                log_result "WARN" "Placeholder/temporary link found: $link in $file"
            fi
        done
    fi
}

# Function to validate PWA integration requirements
validate_pwa_integration() {
    local file="$1"
    log_result "INFO" "Validating PWA integration requirements in $file"
    
    # Check for PWA metadata
    if grep -q "pwa-compatible\|offline-accessible\|progressive-loading" "$file"; then
        log_result "PASS" "PWA integration metadata present in $file"
    else
        log_result "WARN" "PWA integration metadata missing in $file"
    fi
    
    # Check for performance considerations
    if grep -qi "performance\|load.*time\|optimization" "$file"; then
        log_result "PASS" "Performance considerations documented in $file"
    fi
    
    # Check for mobile-first content
    if grep -qi "mobile\|responsive\|touch\|viewport" "$file"; then
        log_result "PASS" "Mobile considerations present in $file"
    fi
}

# Function to validate individual content file
validate_content_file() {
    local file="$1"
    ((TOTAL_FILES_REVIEWED++))
    
    echo -e "\n${PURPLE}=== Reviewing: $file ===${NC}"
    
    # Skip non-markdown files
    if [[ ! "$file" =~ \.md$ ]]; then
        log_result "INFO" "Skipping non-markdown file: $file"
        return
    fi
    
    # Check if file exists and is readable
    if [ ! -r "$file" ]; then
        log_result "FAIL" "Cannot read file: $file"
        return
    fi
    
    # Check if file has content
    if [ ! -s "$file" ]; then
        log_result "WARN" "File is empty: $file"
        return
    fi
    
    # Run all validation functions
    validate_code_examples "$file"
    validate_prompt_templates "$file" 
    validate_technology_references "$file"
    validate_ai_tool_references "$file"
    validate_content_consistency "$file"
    validate_accessibility_compliance "$file"
    validate_cross_references "$file"
    validate_pwa_integration "$file"
    
    log_result "INFO" "Completed review of $file"
}

# Function to generate technical accuracy report
generate_technical_report() {
    echo -e "\n${PURPLE}=== Technical Accuracy Review Report ===${NC}"
    echo -e "${BLUE}Files Reviewed:${NC} $TOTAL_FILES_REVIEWED"
    echo -e "${GREEN}Tests Passed:${NC} $TESTS_PASSED"
    echo -e "${RED}Tests Failed:${NC} $TESTS_FAILED"
    echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
    
    local success_rate=$((TESTS_PASSED * 100 / (TESTS_PASSED + TESTS_FAILED + WARNINGS)))
    echo -e "${BLUE}Success Rate:${NC} $success_rate%"
    
    # Determine overall technical accuracy status
    if [ "$TESTS_FAILED" -eq 0 ] && [ "$WARNINGS" -lt 5 ]; then
        echo -e "${GREEN}Overall Status: ✅ TECHNICALLY ACCURATE${NC}"
    elif [ "$TESTS_FAILED" -eq 0 ] && [ "$WARNINGS" -lt 10 ]; then
        echo -e "${YELLOW}Overall Status: ⚠️ NEEDS MINOR IMPROVEMENTS${NC}"
    else
        echo -e "${RED}Overall Status: ❌ REQUIRES TECHNICAL REVIEW${NC}"
    fi
    
    # Generate recommendations
    echo -e "\n${BLUE}=== Technical Accuracy Recommendations ===${NC}"
    
    if [ "$TESTS_FAILED" -gt 0 ]; then
        echo -e "${RED}Critical Issues:${NC}"
        echo "• Fix accessibility violations (missing alt text)"
        echo "• Validate all code examples for syntax accuracy"
        echo "• Ensure all external links are functional"
    fi
    
    if [ "$WARNINGS" -gt 0 ]; then
        echo -e "${YELLOW}Improvement Opportunities:${NC}"
        echo "• Update outdated technology version references"
        echo "• Improve prompt template documentation"
        echo "• Enhance content consistency and terminology"
        echo "• Add PWA integration metadata where missing"
        echo "• Include more comprehensive code examples"
    fi
    
    echo -e "\n${GREEN}Best Practices:${NC}"
    echo "• Include language specification for all code blocks"
    echo "• Document expected outcomes for all prompt templates"
    echo "• Use current technology versions in all examples"
    echo "• Maintain consistent terminology throughout content"
    echo "• Ensure accessibility compliance in all content"
    echo "• Test all code examples in clean environments"
}

# Main execution function
main() {
    echo -e "${BLUE}Starting technical accuracy review...${NC}"
    
    # Find all content files
    local content_files=()
    
    # Check content directory
    if [ -d "$CONTENT_DIR" ]; then
        while IFS= read -r -d '' file; do
            content_files+=("$file")
        done < <(find "$CONTENT_DIR" -name "*.md" -type f -print0 2>/dev/null)
    fi
    
    # Check for other markdown files in project root
    for file in *.md; do
        if [ -f "$file" ]; then
            content_files+=("$file")
        fi
    done
    
    if [ ${#content_files[@]} -eq 0 ]; then
        log_result "WARN" "No content files found for technical review"
        log_result "INFO" "Content directories appear to be empty - this is expected for initial setup"
        log_result "INFO" "Technical review framework is ready for content validation"
    else
        log_result "INFO" "Found ${#content_files[@]} content files for review"
        
        # Review each content file
        for file in "${content_files[@]}"; do
            validate_content_file "$file"
        done
    fi
    
    # Generate final report
    generate_technical_report
}

# Run main function
main "$@"