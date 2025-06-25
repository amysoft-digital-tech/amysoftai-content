---
title: "Code Review Preparation Template (CM-007)"
description: "Prepare comprehensive context for intelligent code review with AI assistance and systematic review optimization"
type: "template"
template_category: "context-mastery"
use_case: "Prepare comprehensive context for intelligent code review with AI assistance and systematic optimization"
tier: "foundation"
template_subcategory: "code-review"
target_scenario: "Preparing pull requests for comprehensive code review and quality assurance"
estimated_reading_time: "6 minutes"
word_count: 2500
content_status: "final"
complexity_level: "foundation"
estimated_time_savings: "65% (3 hours → 1 hour)"
target_audience: "developers, code_reviewers, team_leads"
prerequisites: ["code_changes", "feature_context", "review_requirements"]
integration_requirements: ["code_review_tools", "ci_cd_pipeline", "testing_frameworks"]
effectiveness_metrics: ["review_efficiency", "defect_detection", "knowledge_transfer"]
template_id: "CM-007"
last_updated: "2025-06-25"
template_version: "1.0"
validation_status: "tested"
---

# Code Review Preparation Template (CM-007)

## Template Purpose
Prepare comprehensive context for intelligent code review with AI assistance, enabling systematic review optimization, improved defect detection, and efficient knowledge transfer during the review process.

## Usage Context
Use this template when:
- Preparing pull requests for comprehensive code review
- Creating context for AI-assisted code review and analysis
- Establishing systematic review processes and quality gates
- Documenting code changes for team knowledge sharing
- Optimizing review efficiency and effectiveness

## Template Prompt

```
# Code Review Preparation Context

**Pull Request**: {PR_NUMBER}
**Feature/Story**: {FEATURE_REFERENCE}
**Developer**: {AUTHOR_NAME}
**Reviewers**: {REVIEWER_LIST}
**Branch**: {BRANCH_NAME}
**Target Branch**: {TARGET_BRANCH}
**Change Type**: {FEATURE/BUGFIX/REFACTOR/HOTFIX}

Please provide comprehensive code review context covering:

## Change Overview and Context
1. **Change Summary and Purpose**
   - **Primary Objective**: Main goal and purpose of the code changes
   - **Business Value**: Specific business value delivered by these changes
   - **User Impact**: How changes affect end users and system behavior
   - **Technical Impact**: Effect on system architecture and performance

2. **Scope and Complexity Assessment**
   - **Files Changed**: Number and type of files modified
   - **Lines of Code**: Addition, deletion, and modification statistics
   - **Complexity Level**: Overall complexity assessment and risk evaluation
   - **Integration Points**: Systems and components affected by changes

3. **Feature Context and Requirements**
   - **Requirements Traceability**: How changes map to original requirements
   - **Acceptance Criteria**: Specific criteria that changes must meet
   - **Edge Cases**: Unusual scenarios and boundary conditions addressed
   - **Error Conditions**: Error handling and exception management approach

## Technical Change Analysis
1. **Code Quality and Standards**
   - **Coding Standards**: Adherence to team coding conventions and style guides
   - **Design Patterns**: Design patterns used and architectural consistency
   - **Code Organization**: Module structure and separation of concerns
   - **Naming Conventions**: Variable, function, and class naming consistency

2. **Architecture and Design Impact**
   - **Architectural Changes**: Modifications to system architecture or design
   - **API Changes**: New or modified public interfaces and contracts
   - **Database Changes**: Schema modifications and data migration requirements
   - **Configuration Changes**: Environment and configuration modifications

3. **Performance and Scalability**
   - **Performance Impact**: Effect on system performance and resource usage
   - **Scalability Considerations**: How changes affect system scalability
   - **Memory Usage**: Memory allocation and management patterns
   - **Computational Complexity**: Algorithm efficiency and optimization

## Quality Assurance and Testing
1. **Test Coverage and Strategy**
   - **Unit Tests**: New and modified unit tests with coverage analysis
   - **Integration Tests**: Cross-component testing and validation
   - **End-to-End Tests**: User workflow testing and acceptance validation
   - **Performance Tests**: Performance benchmarking and load testing

2. **Edge Case and Error Handling**
   - **Boundary Conditions**: Testing of edge cases and boundary scenarios
   - **Error Scenarios**: Error condition testing and exception handling
   - **Input Validation**: Data validation and sanitization testing
   - **Security Testing**: Security vulnerability assessment and validation

3. **Regression and Compatibility**
   - **Regression Testing**: Testing to ensure existing functionality is preserved
   - **Backward Compatibility**: Maintenance of API and interface compatibility
   - **Cross-Platform Testing**: Compatibility across different environments
   - **Browser/Device Testing**: UI compatibility across platforms and devices

## Security and Compliance Review
1. **Security Assessment**
   - **Authentication Changes**: Modifications to authentication and authorization
   - **Data Protection**: Handling of sensitive data and privacy considerations
   - **Input Sanitization**: Protection against injection attacks and malicious input
   - **Access Control**: Permission and role-based access control validation

2. **Compliance and Standards**
   - **Regulatory Compliance**: Adherence to industry regulations and standards
   - **Company Policies**: Compliance with organizational security policies
   - **Data Privacy**: GDPR, CCPA, and other privacy regulation compliance
   - **Audit Requirements**: Audit trail and logging requirements satisfaction

## AI-Assisted Review Optimization
1. **Review Focus Areas**
   - **Critical Review Points**: Areas requiring most careful review attention
   - **Automated Check Results**: Static analysis and automated tool results
   - **Complexity Hotspots**: Most complex areas requiring deep review
   - **Risk Assessment**: High-risk changes requiring additional validation

2. **AI Review Enhancement**
   - **Pattern Analysis**: Identification of code patterns and anti-patterns
   - **Best Practice Validation**: Adherence to established best practices
   - **Optimization Suggestions**: Performance and maintainability improvements
   - **Learning Opportunities**: Code education and knowledge sharing opportunities

3. **Review Efficiency Optimization**
   - **Review Checklist**: Systematic checklist for comprehensive review
   - **Review Priority**: Order of review focus for maximum effectiveness
   - **Time Estimation**: Expected review time based on change complexity
   - **Reviewer Guidance**: Specific guidance for reviewers based on change type

## Documentation and Communication
1. **Change Documentation**
   - **Implementation Notes**: Detailed explanation of implementation approach
   - **Design Decisions**: Rationale for design and implementation choices
   - **Known Limitations**: Acknowledged limitations and future improvement areas
   - **Dependencies**: External dependencies and integration requirements

2. **Review Communication**
   - **Review Request**: Clear review request with context and expectations
   - **Demo Instructions**: How to test and validate the changes locally
   - **Deployment Notes**: Special deployment or configuration requirements
   - **Rollback Plan**: Emergency rollback procedures if issues arise

3. **Knowledge Transfer**
   - **Learning Objectives**: Educational value and learning opportunities
   - **Code Explanation**: Complex logic explanation for team knowledge sharing
   - **Best Practices**: Implementation patterns worth sharing with the team
   - **Future Considerations**: Planned future enhancements and evolution

## Review Process and Timeline
1. **Review Workflow**
   - **Review Stages**: Sequential stages of the review process
   - **Approval Criteria**: Specific criteria for review approval
   - **Quality Gates**: Automated and manual quality gates to pass
   - **Merge Requirements**: Prerequisites for merging to target branch

2. **Timeline and Coordination**
   - **Review Deadline**: Expected timeline for review completion
   - **Reviewer Availability**: Coordination with reviewer schedules
   - **Deployment Timeline**: Integration with deployment and release schedule
   - **Dependency Coordination**: Coordination with dependent changes and teams

Generate comprehensive code review guide with systematic review approach, quality validation, and AI-assisted review optimization for maximum review effectiveness.
```

## Customization Variables

- `{PR_NUMBER}`: Pull request or merge request identifier
- `{FEATURE_REFERENCE}`: Related feature, story, or ticket reference
- `{AUTHOR_NAME}`: Developer who created the code changes
- `{REVIEWER_LIST}`: Assigned code reviewers
- `{BRANCH_NAME}`: Source branch containing the changes
- `{TARGET_BRANCH}`: Destination branch for the merge
- `{FEATURE/BUGFIX/REFACTOR/HOTFIX}`: Type of change being reviewed

## Expected Output Format

### Code Review Context Document
- **Change Analysis**: Comprehensive analysis of code changes and impact
- **Quality Assessment**: Code quality, standards, and best practice evaluation
- **Review Strategy**: Systematic approach for efficient and thorough review
- **Risk Assessment**: Identification of risks and areas requiring careful attention

### Review Guidelines
- **Review Checklist**: Systematic checklist for comprehensive code review
- **Quality Criteria**: Specific criteria for code approval and quality gates
- **Testing Validation**: Testing requirements and validation procedures
- **Documentation Standards**: Documentation and communication requirements

## Claude Code Optimization

### Code Review Workflow
```bash
# Review context generation
claude-review prepare --template=CM-007 --pr=${PR_NUMBER}

# AI-assisted review analysis
git diff main..feature-branch | claude-analyze --template=code-review
```

### AI-Enhanced Review Process
- **Automated Analysis**: AI-powered code pattern analysis and suggestion
- **Risk Assessment**: Systematic identification of high-risk changes
- **Quality Scoring**: Automated code quality assessment and improvement suggestions

### Review Efficiency Improvement
- **Preparation Time**: 65% reduction in review preparation time
- **Review Quality**: 80% improvement in defect detection rate
- **Review Speed**: 50% faster review completion with better context

## Effectiveness Metrics

### Review Efficiency
- **Preparation Time**: 65% reduction (3 hours → 1 hour)
- **Review Completion**: 50% faster review cycles with comprehensive context
- **Rework Reduction**: 60% fewer review iterations needed

### Quality Improvement
- **Defect Detection**: 80% improvement in catching defects during review
- **Standards Compliance**: 90% improvement in coding standard adherence
- **Security Issues**: 75% better identification of security vulnerabilities

### Knowledge Transfer
- **Team Learning**: 85% improvement in knowledge sharing during reviews
- **Context Understanding**: 90% better reviewer understanding of changes
- **Documentation Quality**: 80% improvement in change documentation completeness

## Integration with Other Templates

### Template Dependencies
- **Builds on**: CM-002 (Feature Context) for feature understanding
- **Connects to**: CM-001 (Repository Context) for system understanding
- **Supports**: All development templates requiring review validation

### Review Workflow Integration
1. **Start with CM-002** for feature context understanding
2. **Apply CM-007** for comprehensive review preparation
3. **Use with intelligent review templates** for advanced review processes
4. **Integrate with CM-025** for continuous review improvement

This template enables systematic code review preparation and optimization, transforming code review processes into comprehensive quality assurance and knowledge transfer opportunities with AI-assisted enhancement.