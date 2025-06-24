#!/bin/bash
# Content validation script for Beyond the AI Plateau
# Comprehensive validation of all content types

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONTENT_DIR="./content"
SCHEMAS_DIR="./schemas"
SCRIPTS_DIR="./scripts/content-processing"

echo -e "${BLUE}🔍 Beyond the AI Plateau - Content Validation${NC}"
echo "================================================"

# Function to validate JSON schema files
validate_schemas() {
    echo -e "\n${BLUE}Validating schema files...${NC}"
    
    local schema_errors=0
    
    for schema_file in $(find "$SCHEMAS_DIR" -name "*.json"); do
        echo "Checking schema: $schema_file"
        
        # Basic JSON validation
        if ! python3 -m json.tool "$schema_file" >/dev/null 2>&1; then
            echo -e "${RED}❌ Invalid JSON in $schema_file${NC}"
            schema_errors=$((schema_errors + 1))
        else
            echo -e "${GREEN}✅ Valid JSON schema${NC}"
        fi
    done
    
    return $schema_errors
}

# Function to validate content metadata
validate_metadata() {
    local file="$1"
    local errors=0
    
    echo "Validating metadata in: $file"
    
    # Extract frontmatter
    if ! sed -n '1,/^---$/p' "$file" | head -n -1 | tail -n +2 > /tmp/frontmatter.yml 2>/dev/null; then
        echo -e "${RED}❌ Cannot extract frontmatter from $file${NC}"
        return 1
    fi
    
    # Check required fields
    required_fields=("title" "type" "tier" "estimated_reading_time" "word_count" "last_updated" "content_status")
    
    for field in "${required_fields[@]}"; do
        if grep -q "^$field:" /tmp/frontmatter.yml; then
            echo -e "${GREEN}✅ Required field '$field' present${NC}"
        else
            echo -e "${RED}❌ Missing required field '$field' in $file${NC}"
            errors=$((errors + 1))
        fi
    done
    
    # Validate field values
    if grep -q "^type:" /tmp/frontmatter.yml; then
        type_value=$(grep "^type:" /tmp/frontmatter.yml | cut -d':' -f2 | tr -d ' "')
        valid_types=("chapter" "template" "case-study" "documentation" "advanced-module")
        
        if [[ " ${valid_types[@]} " =~ " ${type_value} " ]]; then
            echo -e "${GREEN}✅ Valid content type: $type_value${NC}"
        else
            echo -e "${RED}❌ Invalid content type '$type_value' in $file${NC}"
            errors=$((errors + 1))
        fi
    fi
    
    if grep -q "^tier:" /tmp/frontmatter.yml; then
        tier_value=$(grep "^tier:" /tmp/frontmatter.yml | cut -d':' -f2 | tr -d ' "')
        valid_tiers=("foundation" "advanced" "elite")
        
        if [[ " ${valid_tiers[@]} " =~ " ${tier_value} " ]]; then
            echo -e "${GREEN}✅ Valid tier: $tier_value${NC}"
        else
            echo -e "${RED}❌ Invalid tier '$tier_value' in $file${NC}"
            errors=$((errors + 1))
        fi
    fi
    
    # Cleanup
    rm -f /tmp/frontmatter.yml
    
    return $errors
}

# Function to validate chapter content structure
validate_chapter_structure() {
    local file="$1"
    local errors=0
    
    echo "Validating chapter structure: $file"
    
    # Check word count
    word_count=$(wc -w < "$file")
    
    if [[ "$file" == *"/principles/"* ]]; then
        # Foundation tier chapters should be 4000-6000 words
        if [ "$word_count" -lt 4000 ]; then
            echo -e "${YELLOW}⚠️  Chapter may be too short ($word_count words, minimum 4000)${NC}"
        elif [ "$word_count" -gt 6000 ]; then
            echo -e "${YELLOW}⚠️  Chapter is quite long ($word_count words, target maximum 6000)${NC}"
        else
            echo -e "${GREEN}✅ Word count appropriate ($word_count words)${NC}"
        fi
    fi
    
    # Check for required sections
    required_sections=("Introduction" "Quick Win" "Conclusion")
    
    for section in "${required_sections[@]}"; do
        if grep -qi "## $section\|# $section" "$file"; then
            echo -e "${GREEN}✅ Found '$section' section${NC}"
        else
            echo -e "${YELLOW}⚠️  Missing '$section' section in $file${NC}"
        fi
    done
    
    # Check header hierarchy
    h1_count=$(grep -c "^# " "$file" || true)
    if [ "$h1_count" -eq 1 ]; then
        echo -e "${GREEN}✅ Proper H1 usage (single title)${NC}"
    elif [ "$h1_count" -gt 1 ]; then
        echo -e "${RED}❌ Multiple H1 headers found ($h1_count) in $file${NC}"
        errors=$((errors + 1))
    else
        echo -e "${YELLOW}⚠️  No H1 header found in $file${NC}"
    fi
    
    # Check for code examples
    code_blocks=$(grep -c "^```" "$file" || true)
    if [ "$code_blocks" -gt 0 ]; then
        echo -e "${GREEN}✅ Contains $code_blocks code examples${NC}"
        
        # Check for language specification
        unspecified_blocks=$(grep -c "^```$" "$file" || true)
        if [ "$unspecified_blocks" -gt 0 ]; then
            echo -e "${YELLOW}⚠️  $unspecified_blocks code blocks without language specification${NC}"
        fi
    fi
    
    return $errors
}

# Function to validate template structure
validate_template_structure() {
    local file="$1"
    local errors=0
    
    echo "Validating template structure: $file"
    
    # Check for template-specific metadata
    template_fields=("template_category" "use_case" "target_scenario" "complexity_level")
    
    for field in "${template_fields[@]}"; do
        if grep -q "^$field:" "$file"; then
            echo -e "${GREEN}✅ Template field '$field' present${NC}"
        else
            echo -e "${RED}❌ Missing template field '$field' in $file${NC}"
            errors=$((errors + 1))
        fi
    done
    
    # Check for usage instructions
    if grep -qi "## Usage\|## Instructions\|## How to Use" "$file"; then
        echo -e "${GREEN}✅ Usage instructions found${NC}"
    else
        echo -e "${RED}❌ Missing usage instructions in $file${NC}"
        errors=$((errors + 1))
    fi
    
    # Check for template variables
    variables=$(grep -o "{[A-Z_][A-Z0-9_]*}" "$file" | sort -u || true)
    if [ -n "$variables" ]; then
        var_count=$(echo "$variables" | wc -l)
        echo -e "${GREEN}✅ Found $var_count unique template variables${NC}"
        
        # List variables for verification
        echo "Variables found:"
        echo "$variables" | sed 's/^/  - /'
    else
        echo -e "${YELLOW}⚠️  No template variables found in $file${NC}"
    fi
    
    # Check for examples
    if grep -qi "## Example\|## Examples" "$file"; then
        echo -e "${GREEN}✅ Examples section found${NC}"
    else
        echo -e "${YELLOW}⚠️  No examples section found in $file${NC}"
    fi
    
    return $errors
}

# Function to validate links
validate_links() {
    local file="$1"
    local errors=0
    
    echo "Validating links in: $file"
    
    # Check internal links
    internal_links=$(grep -o '\[.*\](\.\/.*\.md\|\.\.\/.*\.md\|[^h][^t][^t][^p].*\.md)' "$file" || true)
    
    if [ -n "$internal_links" ]; then
        echo "Checking internal links..."
        while IFS= read -r link; do
            # Extract the file path
            link_path=$(echo "$link" | sed 's/.*](\(.*\))/\1/')
            
            # Convert relative path to absolute
            if [[ "$link_path" == ./* ]]; then
                full_path="$(dirname "$file")/${link_path#./}"
            elif [[ "$link_path" == ../* ]]; then
                full_path="$(dirname "$file")/$link_path"
            else
                full_path="$link_path"
            fi
            
            if [ -f "$full_path" ]; then
                echo -e "${GREEN}✅ Internal link valid: $link_path${NC}"
            else
                echo -e "${RED}❌ Broken internal link: $link_path (resolved to: $full_path)${NC}"
                errors=$((errors + 1))
            fi
        done <<< "$internal_links"
    fi
    
    return $errors
}

# Function to validate content accessibility
validate_accessibility() {
    local file="$1"
    local errors=0
    
    echo "Validating accessibility in: $file"
    
    # Check for images without alt text
    images_without_alt=$(grep -c '!\[]\(' "$file" || true)
    if [ "$images_without_alt" -gt 0 ]; then
        echo -e "${RED}❌ Found $images_without_alt images without alt text in $file${NC}"
        errors=$((errors + 1))
    fi
    
    # Check for proper image alt text
    images_with_alt=$(grep -c '!\[.*\](' "$file" || true)
    if [ "$images_with_alt" -gt 0 ]; then
        echo -e "${GREEN}✅ Found $images_with_alt images with alt text${NC}"
    fi
    
    # Check for heading structure
    headings=$(grep '^#' "$file" | head -10 || true)
    if [ -n "$headings" ]; then
        echo -e "${GREEN}✅ Proper heading structure detected${NC}"
    fi
    
    return $errors
}

# Main validation function
validate_file() {
    local file="$1"
    local total_errors=0
    
    echo -e "\n${BLUE}📄 Validating: $file${NC}"
    echo "----------------------------------------"
    
    # Basic file checks
    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ File not found: $file${NC}"
        return 1
    fi
    
    if [ ! -s "$file" ]; then
        echo -e "${RED}❌ File is empty: $file${NC}"
        return 1
    fi
    
    # Validate metadata
    validate_metadata "$file"
    metadata_errors=$?
    total_errors=$((total_errors + metadata_errors))
    
    # Content-specific validation
    if [[ "$file" == *"/templates/"* ]]; then
        validate_template_structure "$file"
        template_errors=$?
        total_errors=$((total_errors + template_errors))
    elif [[ "$file" == *"/principles/"* ]] || [[ "$file" == *"/ch"*"/"* ]]; then
        validate_chapter_structure "$file"
        chapter_errors=$?
        total_errors=$((total_errors + chapter_errors))
    fi
    
    # Common validations
    validate_links "$file"
    link_errors=$?
    total_errors=$((total_errors + link_errors))
    
    validate_accessibility "$file"
    accessibility_errors=$?
    total_errors=$((total_errors + accessibility_errors))
    
    if [ $total_errors -eq 0 ]; then
        echo -e "${GREEN}✅ File validation passed${NC}"
    else
        echo -e "${RED}❌ File validation failed with $total_errors errors${NC}"
    fi
    
    return $total_errors
}

# Main execution
main() {
    local total_errors=0
    local files_validated=0
    
    # Validate schemas first
    echo -e "${BLUE}Step 1: Schema Validation${NC}"
    validate_schemas
    schema_errors=$?
    total_errors=$((total_errors + schema_errors))
    
    # Find and validate all markdown content files
    echo -e "\n${BLUE}Step 2: Content Validation${NC}"
    
    # Validate specific content directories
    content_dirs=("$CONTENT_DIR/principles" "$CONTENT_DIR/templates" "$CONTENT_DIR/case-studies" "$CONTENT_DIR/advanced")
    
    for dir in "${content_dirs[@]}"; do
        if [ -d "$dir" ]; then
            echo -e "\n${BLUE}Validating directory: $dir${NC}"
            
            while IFS= read -r -d '' file; do
                validate_file "$file"
                file_errors=$?
                total_errors=$((total_errors + file_errors))
                files_validated=$((files_validated + 1))
            done < <(find "$dir" -name "*.md" -type f -print0)
        fi
    done
    
    # Validate root markdown files
    for file in README.md CONTRIBUTING.md; do
        if [ -f "$file" ]; then
            validate_file "$file"
            file_errors=$?
            total_errors=$((total_errors + file_errors))
            files_validated=$((files_validated + 1))
        fi
    done
    
    # Summary
    echo -e "\n${BLUE}📊 Validation Summary${NC}"
    echo "================================================"
    echo "Files validated: $files_validated"
    echo "Schema errors: $schema_errors"
    echo "Total errors: $total_errors"
    
    if [ $total_errors -eq 0 ]; then
        echo -e "${GREEN}✅ All content validation checks passed!${NC}"
        return 0
    else
        echo -e "${RED}❌ Content validation failed with $total_errors errors${NC}"
        echo "Please review and fix the errors above."
        return 1
    fi
}

# Check if specific file provided
if [ $# -eq 1 ]; then
    validate_file "$1"
    exit $?
fi

# Run main validation
main