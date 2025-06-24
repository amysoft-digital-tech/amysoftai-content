#!/bin/bash

# Launch Day Content Monitoring Script
# Real-time monitoring and alerting for content delivery during launch

set -e

echo "📊 Launch Day Content Monitoring System"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Configuration
MONITORING_INTERVAL=30  # seconds
LOG_FILE="/tmp/launch-monitoring-$(date +%Y%m%d-%H%M%S).log"
ALERT_THRESHOLD_RESPONSE_TIME=5000  # milliseconds
ALERT_THRESHOLD_ERROR_RATE=5  # percentage

# Initialize counters
TOTAL_CHECKS=0
SUCCESSFUL_CHECKS=0
FAILED_CHECKS=0
WARNINGS=0

# Helper functions
log_message() {
    local level=$1
    local message=$2
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    
    echo -e "$message"
    echo "[$timestamp] [$level] $message" >> "$LOG_FILE"
}

log_success() {
    log_message "SUCCESS" "${GREEN}✓ $1${NC}"
    ((SUCCESSFUL_CHECKS++))
}

log_error() {
    log_message "ERROR" "${RED}✗ $1${NC}"
    ((FAILED_CHECKS++))
}

log_warning() {
    log_message "WARNING" "${YELLOW}⚠ $1${NC}"
    ((WARNINGS++))
}

log_info() {
    log_message "INFO" "${BLUE}ℹ $1${NC}"
}

# Monitoring functions
check_repository_health() {
    log_info "Checking repository health..."
    
    # Check Git status
    if git status >/dev/null 2>&1; then
        log_success "Git repository accessible"
    else
        log_error "Git repository access failed"
        return 1
    fi
    
    # Check remote connectivity
    if git ls-remote origin >/dev/null 2>&1; then
        log_success "Remote repository accessible"
    else
        log_warning "Remote repository connectivity issue"
    fi
    
    # Check for uncommitted changes
    if git diff --quiet && git diff --cached --quiet; then
        log_success "Working directory clean"
    else
        log_warning "Uncommitted changes detected"
    fi
}

check_content_integrity() {
    log_info "Checking content integrity..."
    
    # Run content validation
    if [ -x "scripts/content-processing/validate-content.sh" ]; then
        if ./scripts/content-processing/validate-content.sh >/dev/null 2>&1; then
            log_success "Content validation passed"
        else
            log_error "Content validation failed"
        fi
    else
        log_warning "Content validation script not found or not executable"
    fi
    
    # Check critical files
    local critical_files=("CLAUDE.md" "LAUNCH_READINESS_CHECKLIST.md" "content/marketing/MARKETING_CONTENT_ALIGNMENT.md")
    for file in "${critical_files[@]}"; do
        if [ -f "$file" ]; then
            log_success "Critical file present: $file"
        else
            log_error "Critical file missing: $file"
        fi
    done
}

check_schema_compliance() {
    log_info "Checking schema compliance..."
    
    local schema_files=($(find schemas -name "*.json" -type f 2>/dev/null || true))
    local compliant_schemas=0
    
    for schema in "${schema_files[@]}"; do
        if jq empty "$schema" >/dev/null 2>&1; then
            log_success "Schema valid: $schema"
            ((compliant_schemas++))
        else
            log_error "Schema invalid: $schema"
        fi
    done
    
    log_info "Schema compliance: $compliant_schemas/${#schema_files[@]} schemas valid"
}

check_asset_availability() {
    log_info "Checking asset availability..."
    
    local asset_dirs=("assets/diagrams" "assets/images" "assets/interactive")
    local total_assets=0
    local accessible_assets=0
    
    for dir in "${asset_dirs[@]}"; do
        if [ -d "$dir" ]; then
            local assets=($(find "$dir" -type f 2>/dev/null || true))
            for asset in "${assets[@]}"; do
                ((total_assets++))
                if [ -r "$asset" ]; then
                    ((accessible_assets++))
                else
                    log_warning "Asset not accessible: $asset"
                fi
            done
        fi
    done
    
    if [ "$total_assets" -gt 0 ]; then
        log_info "Asset availability: $accessible_assets/$total_assets assets accessible"
    else
        log_info "No assets found for monitoring"
    fi
}

check_template_functionality() {
    log_info "Checking template functionality..."
    
    local template_files=($(find content/templates -name "*.md" -type f 2>/dev/null || true))
    local functional_templates=0
    
    for template in "${template_files[@]}"; do
        # Check for required template sections
        if grep -q "## Template Usage\|## Variables\|## Example" "$template"; then
            log_success "Template functional: $template"
            ((functional_templates++))
        else
            log_warning "Template incomplete: $template"
        fi
    done
    
    log_info "Template functionality: $functional_templates/${#template_files[@]} templates functional"
}

simulate_user_journey() {
    log_info "Simulating user journey..."
    
    # Simulate content access patterns
    local content_files=($(find content -name "*.md" -type f 2>/dev/null || true))
    local accessible_content=0
    
    for file in "${content_files[@]}"; do
        if [ -r "$file" ] && [ -s "$file" ]; then
            ((accessible_content++))
        else
            log_warning "Content access issue: $file"
        fi
    done
    
    if [ ${#content_files[@]} -gt 0 ]; then
        local access_rate=$((accessible_content * 100 / ${#content_files[@]}))
        if [ "$access_rate" -ge 95 ]; then
            log_success "User journey simulation: $access_rate% content accessible"
        else
            log_warning "User journey simulation: $access_rate% content accessible (below 95%)"
        fi
    fi
}

check_performance_metrics() {
    log_info "Checking performance metrics..."
    
    # Run performance tests
    if [ -x "scripts/integration/performance-load-test.sh" ]; then
        local start_time=$(date +%s%3N)
        if ./scripts/integration/performance-load-test.sh >/dev/null 2>&1; then
            local end_time=$(date +%s%3N)
            local duration=$((end_time - start_time))
            
            if [ "$duration" -lt "$ALERT_THRESHOLD_RESPONSE_TIME" ]; then
                log_success "Performance test completed in ${duration}ms"
            else
                log_warning "Performance test slow: ${duration}ms (threshold: ${ALERT_THRESHOLD_RESPONSE_TIME}ms)"
            fi
        else
            log_error "Performance test failed"
        fi
    else
        log_warning "Performance test script not available"
    fi
}

generate_health_report() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    local success_rate=$((SUCCESSFUL_CHECKS * 100 / (SUCCESSFUL_CHECKS + FAILED_CHECKS + WARNINGS)))
    
    echo -e "\n${PURPLE}=== Launch Day Health Report ===${NC}"
    echo -e "${BLUE}Timestamp:${NC} $timestamp"
    echo -e "${GREEN}Successful Checks:${NC} $SUCCESSFUL_CHECKS"
    echo -e "${RED}Failed Checks:${NC} $FAILED_CHECKS"
    echo -e "${YELLOW}Warnings:${NC} $WARNINGS"
    echo -e "${BLUE}Success Rate:${NC} $success_rate%"
    
    # Determine overall health status
    if [ "$FAILED_CHECKS" -eq 0 ] && [ "$WARNINGS" -lt 3 ]; then
        echo -e "${GREEN}Overall Status: ✅ HEALTHY${NC}"
    elif [ "$FAILED_CHECKS" -eq 0 ] && [ "$WARNINGS" -lt 6 ]; then
        echo -e "${YELLOW}Overall Status: ⚠️ CAUTION${NC}"
    else
        echo -e "${RED}Overall Status: ❌ CRITICAL${NC}"
    fi
    
    echo -e "${BLUE}Log File:${NC} $LOG_FILE"
}

send_alert() {
    local level=$1
    local message=$2
    
    # In a real implementation, this would send alerts via:
    # - Slack webhook
    # - Email notification
    # - SMS alert
    # - Discord webhook
    # - PagerDuty incident
    
    log_message "ALERT" "[$level] $message"
    echo -e "${RED}🚨 ALERT [$level]: $message${NC}"
}

# Main monitoring loop
run_monitoring_cycle() {
    log_info "Starting monitoring cycle #$((TOTAL_CHECKS + 1))"
    ((TOTAL_CHECKS++))
    
    # Reset counters for this cycle
    SUCCESSFUL_CHECKS=0
    FAILED_CHECKS=0
    WARNINGS=0
    
    # Run all checks
    check_repository_health
    check_content_integrity
    check_schema_compliance
    check_asset_availability
    check_template_functionality
    simulate_user_journey
    check_performance_metrics
    
    # Generate report
    generate_health_report
    
    # Check for critical issues
    if [ "$FAILED_CHECKS" -gt 0 ]; then
        send_alert "CRITICAL" "$FAILED_CHECKS critical issues detected"
    elif [ "$WARNINGS" -gt 5 ]; then
        send_alert "WARNING" "$WARNINGS warnings detected"
    fi
    
    log_info "Monitoring cycle completed. Next check in ${MONITORING_INTERVAL} seconds."
}

# Signal handlers for graceful shutdown
cleanup() {
    log_info "Monitoring system shutting down..."
    log_info "Total monitoring cycles completed: $TOTAL_CHECKS"
    log_info "Final log saved to: $LOG_FILE"
    exit 0
}

trap cleanup SIGINT SIGTERM

# Main execution
main() {
    echo -e "${PURPLE}🚀 Launch Day Content Monitoring Started${NC}"
    echo -e "${BLUE}Monitoring interval: ${MONITORING_INTERVAL} seconds${NC}"
    echo -e "${BLUE}Log file: $LOG_FILE${NC}"
    echo -e "${BLUE}Press Ctrl+C to stop monitoring${NC}\n"
    
    # Initial setup
    log_info "Launch Day Content Monitoring System Started"
    log_info "Configuration: Interval=${MONITORING_INTERVAL}s, ResponseThreshold=${ALERT_THRESHOLD_RESPONSE_TIME}ms"
    
    # Continuous monitoring loop
    while true; do
        run_monitoring_cycle
        echo -e "\n${BLUE}Waiting ${MONITORING_INTERVAL} seconds for next check...${NC}\n"
        sleep "$MONITORING_INTERVAL"
    done
}

# Command line options
case "${1:-monitor}" in
    "monitor")
        main
        ;;
    "single")
        echo -e "${BLUE}Running single monitoring check...${NC}"
        run_monitoring_cycle
        ;;
    "test")
        echo -e "${BLUE}Testing monitoring functions...${NC}"
        MONITORING_INTERVAL=1
        run_monitoring_cycle
        ;;
    "help")
        echo "Launch Day Content Monitoring Script"
        echo ""
        echo "Usage: $0 [command]"
        echo ""
        echo "Commands:"
        echo "  monitor (default)  - Start continuous monitoring"
        echo "  single            - Run single monitoring check"
        echo "  test              - Test monitoring functions"
        echo "  help              - Show this help message"
        echo ""
        echo "Features:"
        echo "  - Repository health monitoring"
        echo "  - Content integrity validation"
        echo "  - Schema compliance checking"
        echo "  - Asset availability monitoring"
        echo "  - Template functionality testing"
        echo "  - User journey simulation"
        echo "  - Performance metrics tracking"
        echo "  - Real-time alerting"
        echo "  - Comprehensive logging"
        ;;
    *)
        echo "Unknown command: $1"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac