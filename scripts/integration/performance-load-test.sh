#!/bin/bash

# Content Performance and Load Testing Script
# Tests content performance characteristics for PWA delivery

set -e

echo "⚡ Starting Content Performance and Load Testing..."

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

# Performance thresholds
MAX_FILE_SIZE_KB=250
MAX_IMAGE_SIZE_KB=500
MAX_TOTAL_CONTENT_MB=50
TARGET_LOAD_TIME_MS=2000

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

# Helper function to convert bytes to human readable format
human_readable_size() {
    local size=$1
    if [ "$size" -ge 1048576 ]; then
        echo "$(echo "scale=1; $size/1048576" | bc)MB"
    elif [ "$size" -ge 1024 ]; then
        echo "$(echo "scale=1; $size/1024" | bc)KB"
    else
        echo "${size}B"
    fi
}

# Test 1: File Size Analysis
echo -e "\n${BLUE}Testing File Size Performance...${NC}"

test_file_sizes() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    local total_size=0
    local large_files=0
    
    if [ ${#content_files[@]} -eq 0 ]; then
        log_result "WARN" "No content files found for size testing"
        return
    fi
    
    for file in "${content_files[@]}"; do
        local size_bytes=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
        local size_kb=$((size_bytes / 1024))
        total_size=$((total_size + size_bytes))
        
        if [ "$size_kb" -gt "$MAX_FILE_SIZE_KB" ]; then
            log_result "WARN" "Large content file detected: $file ($(human_readable_size $size_bytes))"
            ((large_files++))
        else
            log_result "PASS" "File size acceptable: $file ($(human_readable_size $size_bytes))"
        fi
    done
    
    local total_mb=$((total_size / 1048576))
    if [ "$total_mb" -gt "$MAX_TOTAL_CONTENT_MB" ]; then
        log_result "WARN" "Total content size exceeds target: $(human_readable_size $total_size)"
    else
        log_result "PASS" "Total content size within limits: $(human_readable_size $total_size)"
    fi
    
    echo -e "${BLUE}ℹ INFO${NC}: Total files: ${#content_files[@]}, Large files: $large_files"
}

# Test 2: Image and Asset Optimization
echo -e "\n${BLUE}Testing Asset Performance...${NC}"

test_asset_performance() {
    local image_files=($(find assets -type f \( -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.gif" -o -name "*.svg" \) 2>/dev/null || true))
    local unoptimized_images=0
    
    if [ ${#image_files[@]} -eq 0 ]; then
        log_result "WARN" "No image files found for optimization testing"
        return
    fi
    
    for image in "${image_files[@]}"; do
        local size_bytes=$(stat -f%z "$image" 2>/dev/null || stat -c%s "$image" 2>/dev/null || echo 0)
        local size_kb=$((size_bytes / 1024))
        
        if [[ "$image" =~ \.svg$ ]]; then
            log_result "PASS" "SVG format (scalable): $image ($(human_readable_size $size_bytes))"
        elif [ "$size_kb" -gt "$MAX_IMAGE_SIZE_KB" ]; then
            log_result "WARN" "Large image file: $image ($(human_readable_size $size_bytes))"
            ((unoptimized_images++))
        else
            log_result "PASS" "Image size acceptable: $image ($(human_readable_size $size_bytes))"
        fi
    done
    
    echo -e "${BLUE}ℹ INFO${NC}: Total images: ${#image_files[@]}, Need optimization: $unoptimized_images"
}

# Test 3: Content Chunking Analysis
echo -e "\n${BLUE}Testing Content Chunking Strategy...${NC}"

test_content_chunking() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    for file in "${content_files[@]}"; do
        local word_count=$(wc -w < "$file" 2>/dev/null || echo 0)
        local line_count=$(wc -l < "$file" 2>/dev/null || echo 0)
        
        # Check if content should be chunked for progressive loading
        if [ "$word_count" -gt 8000 ]; then
            if grep -q "<!-- CHUNK:" "$file"; then
                log_result "PASS" "Large content has chunking markers: $file ($word_count words)"
            else
                log_result "WARN" "Large content lacks chunking strategy: $file ($word_count words)"
            fi
        else
            log_result "PASS" "Content size appropriate for single load: $file ($word_count words)"
        fi
        
        # Check for lazy loading indicators
        if grep -q "loading.*lazy\|data-lazy" "$file"; then
            log_result "PASS" "Lazy loading implemented in $file"
        fi
    done
}

# Test 4: Caching Strategy Validation
echo -e "\n${BLUE}Testing Caching Strategy...${NC}"

test_caching_strategy() {
    # Check for cache configuration files
    local cache_configs=("sw.js" "manifest.json" ".htaccess" "netlify.toml" "vercel.json")
    local cache_found=false
    
    for config in "${cache_configs[@]}"; do
        if [ -f "$config" ]; then
            log_result "PASS" "Caching configuration found: $config"
            cache_found=true
        fi
    done
    
    if [ "$cache_found" = false ]; then
        log_result "WARN" "No caching configuration files found"
    fi
    
    # Check for cache control headers in content
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    for file in "${content_files[@]}"; do
        if grep -q "cache-control\|expires\|etag" "$file"; then
            log_result "PASS" "Cache control metadata in $file"
        fi
    done
}

# Test 5: Progressive Loading Readiness
echo -e "\n${BLUE}Testing Progressive Loading Readiness...${NC}"

test_progressive_loading() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    
    for file in "${content_files[@]}"; do
        # Check for content prioritization metadata
        if grep -q "priority.*high\|critical.*true\|above-fold" "$file"; then
            log_result "PASS" "Content prioritization metadata in $file"
        fi
        
        # Check for section-based loading
        local section_count=$(grep -c "^## " "$file" 2>/dev/null || echo 0)
        if [ "$section_count" -gt 5 ]; then
            if grep -q "section-loading\|progressive-sections" "$file"; then
                log_result "PASS" "Progressive section loading prepared: $file"
            else
                log_result "WARN" "Multiple sections could benefit from progressive loading: $file ($section_count sections)"
            fi
        fi
    done
}

# Test 6: Minification and Compression Readiness
echo -e "\n${BLUE}Testing Compression Readiness...${NC}"

test_compression_readiness() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    local compressible_content=0
    
    for file in "${content_files[@]}"; do
        local size_bytes=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
        
        if [ "$size_bytes" -gt 1024 ]; then
            ((compressible_content++))
            
            # Check for compression-friendly formatting
            if grep -q "^\s*$" "$file"; then
                log_result "PASS" "Whitespace optimization potential: $file"
            fi
        fi
    done
    
    # Test gzip compression potential
    if command -v gzip >/dev/null 2>&1; then
        local test_file=$(find content -name "*.md" -type f | head -1)
        if [ -n "$test_file" ]; then
            local original_size=$(stat -f%z "$test_file" 2>/dev/null || stat -c%s "$test_file" 2>/dev/null || echo 0)
            local compressed_size=$(gzip -c "$test_file" | wc -c)
            local compression_ratio=$(echo "scale=2; $compressed_size * 100 / $original_size" | bc)
            
            log_result "PASS" "Gzip compression ratio: ${compression_ratio}% (${original_size}B → ${compressed_size}B)"
        fi
    fi
    
    echo -e "${BLUE}ℹ INFO${NC}: Files suitable for compression: $compressible_content"
}

# Test 7: Load Time Simulation
echo -e "\n${BLUE}Testing Load Time Characteristics...${NC}"

test_load_time_simulation() {
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    local slow_loading_files=0
    
    for file in "${content_files[@]}"; do
        local size_bytes=$(stat -f%z "$file" 2>/dev/null || stat -c%s "$file" 2>/dev/null || echo 0)
        
        # Simulate load time based on file size (assuming 1MB/s typical mobile connection)
        local estimated_load_ms=$((size_bytes / 1024))
        
        if [ "$estimated_load_ms" -gt "$TARGET_LOAD_TIME_MS" ]; then
            log_result "WARN" "Potentially slow loading content: $file (estimated ${estimated_load_ms}ms)"
            ((slow_loading_files++))
        else
            log_result "PASS" "Fast loading content: $file (estimated ${estimated_load_ms}ms)"
        fi
    done
    
    echo -e "${BLUE}ℹ INFO${NC}: Files with slow load potential: $slow_loading_files"
}

# Test 8: PWA Performance Requirements
echo -e "\n${BLUE}Testing PWA Performance Requirements...${NC}"

test_pwa_performance() {
    # Check for service worker readiness
    if [ -f "sw.js" ] || [ -f "service-worker.js" ]; then
        log_result "PASS" "Service worker file exists"
    else
        log_result "WARN" "Service worker file not found"
    fi
    
    # Check for manifest file
    if [ -f "manifest.json" ] || [ -f "site.webmanifest" ]; then
        log_result "PASS" "Web app manifest exists"
    else
        log_result "WARN" "Web app manifest not found"
    fi
    
    # Check for offline-ready content indicators
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    local offline_ready=0
    
    for file in "${content_files[@]}"; do
        if grep -q "offline-accessible.*true\|cache-strategy" "$file"; then
            log_result "PASS" "Offline accessibility configured: $file"
            ((offline_ready++))
        fi
    done
    
    if [ "$offline_ready" -gt 0 ]; then
        echo -e "${BLUE}ℹ INFO${NC}: Files configured for offline access: $offline_ready"
    else
        log_result "WARN" "No content explicitly configured for offline access"
    fi
}

# Run all tests
echo -e "\n${BLUE}Starting Performance and Load Test Suite...${NC}"

test_file_sizes
test_asset_performance
test_content_chunking
test_caching_strategy
test_progressive_loading
test_compression_readiness
test_load_time_simulation
test_pwa_performance

# Final summary
echo -e "\n${BLUE}=== Performance Test Summary ===${NC}"
echo -e "${GREEN}Tests Passed: $TESTS_PASSED${NC}"
echo -e "${RED}Tests Failed: $TESTS_FAILED${NC}"
echo -e "${YELLOW}Warnings: $WARNINGS${NC}"

# Generate performance recommendations
echo -e "\n${BLUE}=== Performance Recommendations ===${NC}"

if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}Optimization Opportunities:${NC}"
    echo "• Implement content chunking for files >8000 words"
    echo "• Optimize images larger than ${MAX_IMAGE_SIZE_KB}KB"
    echo "• Configure caching headers for static content"
    echo "• Implement progressive loading for multi-section content"
    echo "• Consider service worker for offline functionality"
    echo "• Enable gzip compression on server"
fi

echo -e "\n${GREEN}Performance Best Practices:${NC}"
echo "• Use SVG format for diagrams and icons"
echo "• Implement lazy loading for images and heavy content"
echo "• Configure appropriate cache control headers"
echo "• Monitor Core Web Vitals in production"
echo "• Use progressive enhancement for interactive elements"

if [ $TESTS_FAILED -eq 0 ] && [ $WARNINGS -lt 5 ]; then
    echo -e "\n${GREEN}🚀 Performance Testing Passed - Content is ready for production!${NC}"
    exit 0
else
    echo -e "\n${YELLOW}⚠️ Performance Testing Completed with Recommendations${NC}"
    echo "Address warnings for optimal user experience"
    exit 0
fi