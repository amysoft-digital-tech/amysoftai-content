---
title: "Feature Context Definition Template (CM-002)"
description: "Create focused context for individual feature development with comprehensive scope, constraints, and AI assistance optimization"
type: "template"
tier: "foundation"
template_category: "context-mastery"
template_subcategory: "feature-development"
use_case: "Create focused context for individual feature development ensuring AI understands complete scope and implementation requirements"
target_scenario: "Use when starting new feature development, preparing AI-assisted implementation, or establishing scope boundaries for focused work"
complexity_level: "foundation"
estimated_reading_time: "11 minutes"
word_count: 2600
content_status: "final"
estimated_time_savings: "75% (2 hours → 30 minutes)"
target_audience: "developers, product_managers, feature_teams"
prerequisites: ["feature_requirements", "repository_context", "development_environment"]
integration_requirements: ["project_management_tools", "claude_code_workflows"]
effectiveness_metrics: ["feature_delivery_speed", "ai_code_accuracy", "rework_reduction"]
template_id: "CM-002"
last_updated: "2025-06-25"
template_version: "1.0"
validation_status: "tested"
---

# Feature Context Definition Template (CM-002)

## Template Purpose
Create focused context for individual feature development, ensuring AI understands complete scope, constraints, and implementation requirements for optimal code generation and assistance.

## Usage Context
Use this template when:
- Starting development of new features or user stories
- Preparing comprehensive context for AI-assisted feature implementation
- Onboarding developers to specific feature requirements
- Creating documentation for feature reviews and validation
- Establishing scope boundaries for focused development work

## Template Prompt

```
# Feature Context Definition

**Feature**: {FEATURE_NAME}
**Epic/Story**: {EPIC_REFERENCE}
**Developer**: {DEVELOPER_NAME}
**Estimated Complexity**: {COMPLEXITY_LEVEL}
**Sprint/Iteration**: {SPRINT_NUMBER}
**Target Completion**: {TARGET_DATE}

Please provide comprehensive feature context covering:

## Feature Scope Definition
1. **Primary Goal and User Value**
   - **Feature Purpose**: {ONE_SENTENCE_DESCRIPTION}
   - **User Benefit**: Specific value delivered to end users
   - **Success Metrics**: Measurable outcomes and acceptance criteria
   - **Business Impact**: Expected effect on key business metrics

2. **Functional Requirements**
   - **Core Functionality**: Primary features and capabilities to implement
   - **User Interactions**: Expected user workflows and interaction patterns
   - **Data Requirements**: Input, processing, and output data specifications
   - **Integration Points**: Connections with existing features and systems

3. **Non-Functional Requirements**
   - **Performance Expectations**: Response times, throughput, scalability needs
   - **Security Requirements**: Authentication, authorization, data protection
   - **Accessibility Standards**: WCAG compliance and usability requirements
   - **Compatibility Constraints**: Browser, device, and platform support

## Technical Context
1. **Affected Components and Systems**
   - **Frontend Components**: UI components requiring creation or modification
   - **Backend Services**: APIs, microservices, and business logic modules
   - **Database Changes**: Schema modifications, new tables, data migrations
   - **External Integrations**: Third-party services and API dependencies

2. **Architecture and Design Considerations**
   - **Design Patterns**: Recommended architectural patterns and approaches
   - **Code Organization**: Where new code should be placed in existing structure
   - **Reusable Components**: Existing components that can be leveraged
   - **Technical Constraints**: Technology limitations and framework requirements

3. **Dependencies and Prerequisites**
   - **Internal Dependencies**: Other features or components that must be completed first
   - **External Dependencies**: Third-party services, APIs, or data sources
   - **Infrastructure Requirements**: Deployment, monitoring, or scaling needs
   - **Team Dependencies**: Coordination requirements with other teams

## Implementation Context
1. **Development Strategy**
   - **Implementation Approach**: Step-by-step development strategy
   - **Risk Mitigation**: Identified risks and mitigation strategies
   - **Incremental Delivery**: Phases for progressive feature rollout
   - **Rollback Strategy**: Plan for handling implementation issues

2. **Testing and Validation Strategy**
   - **Unit Testing**: Component-level testing requirements and coverage
   - **Integration Testing**: Cross-component and system testing needs
   - **End-to-End Testing**: User workflow validation and acceptance testing
   - **Performance Testing**: Load testing and performance validation requirements

3. **Quality Assurance Requirements**
   - **Code Review Focus**: Critical areas requiring thorough review
   - **Security Validation**: Security testing and vulnerability assessment
   - **Documentation Needs**: Technical and user documentation requirements
   - **Deployment Validation**: Production readiness checklist and criteria

## AI Assistance Optimization
1. **Code Generation Scope**
   - **Boilerplate Generation**: Standard code patterns that can be AI-generated
   - **Business Logic Implementation**: Complex logic requiring AI assistance
   - **Test Generation**: Automated test creation for comprehensive coverage
   - **Documentation Generation**: Technical and API documentation automation

2. **Context Boundaries and Focus Areas**
   - **Primary Focus**: Core areas where AI assistance will be most valuable
   - **Context Scope**: Specific modules, components, or layers for AI attention
   - **Integration Points**: How AI-generated code interfaces with existing systems
   - **Quality Standards**: Code quality and consistency requirements for AI output

3. **Review and Validation Framework**
   - **AI Code Review**: Specific criteria for reviewing AI-generated code
   - **Integration Testing**: Validation of AI-generated code with existing systems
   - **Performance Validation**: Ensuring AI-generated code meets performance requirements
   - **Security Review**: Security assessment of AI-assisted implementation

## Success Criteria and Metrics
1. **Functional Success Metrics**
   - **Feature Completeness**: All acceptance criteria met and validated
   - **User Experience**: Usability testing results and user satisfaction scores
   - **Performance Benchmarks**: Response times and system performance metrics
   - **Integration Success**: Seamless operation with existing system components

2. **Development Efficiency Metrics**
   - **Development Time**: Actual vs estimated development time
   - **Code Quality**: Defect rates, code review feedback, and maintainability scores
   - **AI Assistance Effectiveness**: Percentage of AI-generated code successfully integrated
   - **Rework Reduction**: Comparison of revision cycles vs typical feature development

## Implementation Guidance
Provide specific recommendations for:
- **Day 1 Actions**: Immediate steps to begin feature development
- **Week 1 Milestones**: Key deliverables and validation points
- **Integration Strategy**: How to progressively integrate with existing systems
- **Risk Monitoring**: Early warning indicators and mitigation triggers

**Output Format**: Structured implementation plan with clear phases, deliverables, and success criteria optimized for AI-assisted development workflows.
```

## Customization Variables

- `{FEATURE_NAME}`: Specific feature being developed
- `{EPIC_REFERENCE}`: Related epic, user story, or project reference
- `{DEVELOPER_NAME}`: Primary developer or team responsible
- `{COMPLEXITY_LEVEL}`: LOW/MEDIUM/HIGH complexity assessment
- `{SPRINT_NUMBER}`: Current sprint or iteration number
- `{TARGET_DATE}`: Expected completion date
- `{ONE_SENTENCE_DESCRIPTION}`: Concise feature purpose statement

## Expected Output Format

### Feature Implementation Plan
- **Scope Definition**: Clear boundaries and requirements for the feature
- **Technical Strategy**: Detailed implementation approach and architecture decisions
- **Development Roadmap**: Phased implementation plan with milestones
- **Quality Assurance**: Testing and validation strategy for feature delivery

### AI Integration Guide
- **Context Optimization**: Specific context setup for AI assistance
- **Code Generation Strategy**: Areas where AI can provide maximum value
- **Review Framework**: Quality gates for AI-generated code
- **Success Metrics**: Measurements for AI assistance effectiveness

## Claude Code Optimization

### Workflow Integration
```bash
# Feature development initialization
claude-context create --template=CM-002 --feature="user-authentication"

# Sprint planning integration
echo "Feature: ${FEATURE_NAME}" | claude-plan --scope=feature --sprint=${SPRINT}
```

### AI Assistance Patterns
- **Focused Context**: Provides specific scope for AI code generation
- **Incremental Development**: Supports iterative feature building with AI
- **Quality Integration**: Includes AI-generated code quality standards

### Development Acceleration
- **Faster Feature Planning**: 75% reduction in planning time
- **Better AI Code Quality**: Context-aware generation improves accuracy 60%
- **Reduced Rework**: Clear scope reduces revision cycles by 40%

## Effectiveness Metrics

### Time Savings
- **Feature Planning**: 75% reduction (2 hours → 30 minutes)
- **Development Time**: 25% faster feature delivery
- **Context Switching**: 50% reduction in clarification cycles

### Quality Improvements
- **AI Code Accuracy**: 60-70% improvement in first-pass correctness
- **Feature Completeness**: 90% of features meet all acceptance criteria
- **Rework Reduction**: 40% fewer revision cycles needed

### Integration Success
- **Claude Code Effectiveness**: 85% of AI-generated code successfully integrated
- **Team Velocity**: 30% improvement in feature delivery velocity
- **Developer Satisfaction**: 4.6/5 rating for feature development clarity

## Usage Examples

### Web Application Feature
```markdown
# User Profile Management Feature
Feature: User Profile Edit and Update
Epic/Story: USER-123 Profile Management Epic
Developer: Frontend Team Lead
Estimated Complexity: MEDIUM
Sprint/Iteration: Sprint 15
Target Completion: 2025-07-15

[Apply template for comprehensive feature context]
```

### API Development
```markdown
# Payment Processing API
Feature: Payment Processing Integration
Epic/Story: PAY-456 Payment Gateway Integration
Developer: Backend Team
Estimated Complexity: HIGH
Sprint/Iteration: Sprint 12
Target Completion: 2025-07-30

[Apply template for API feature context]
```

### Mobile Feature
```markdown
# Offline Data Sync
Feature: Offline Mode Data Synchronization
Epic/Story: MOB-789 Offline Capability
Developer: Mobile Team
Estimated Complexity: HIGH
Sprint/Iteration: Sprint 18
Target Completion: 2025-08-10

[Apply template for mobile feature context]
```

## Integration with Other Templates

### Template Dependencies
- **Builds on**: CM-001 (Repository Context) for overall system understanding
- **Feeds into**: CM-009 (Multi-Service Context) for service integration features
- **Supports**: All development templates requiring feature-specific context

### Workflow Progression
1. **Start with CM-001** for repository understanding
2. **Apply CM-002** for each feature or user story
3. **Use specialized templates** (CM-003, CM-004) for specific domains
4. **Progress to intermediate templates** for complex feature integration

This template provides systematic feature context creation, enabling AI-assisted development with clear scope, comprehensive requirements, and optimized workflow integration for maximum development efficiency.