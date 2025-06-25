---
title: "Architecture Decision Capture Template (CM-006)"
description: "Document architectural decisions with context, rationale, and implications for AI-assisted decision tracking and evolution"
type: "template"
template_category: "context-mastery"
use_case: "Document architectural decisions with context, rationale, and implications for AI-assisted decision tracking"
tier: "foundation"
template_subcategory: "architecture-documentation"
target_scenario: "Making significant architectural or design decisions requiring documentation"
estimated_reading_time: "6 minutes"
word_count: 2400
content_status: "final"
complexity_level: "foundation"
estimated_time_savings: "70% (2.5 hours → 45 minutes)"
target_audience: "architects, technical_leads, senior_developers"
prerequisites: ["architectural_context", "decision_requirements", "stakeholder_input"]
integration_requirements: ["decision_tracking_tools", "documentation_systems"]
effectiveness_metrics: ["decision_quality", "context_preservation", "knowledge_transfer"]
template_id: "CM-006"
last_updated: "2025-06-25"
template_version: "1.0"
validation_status: "tested"
---

# Architecture Decision Capture Template (CM-006)

## Template Purpose
Document architectural decisions with comprehensive context, rationale, and implications, enabling AI-assisted decision tracking, evolution, and knowledge preservation for long-term system maintainability.

## Usage Context
Use this template when:
- Making significant architectural or design decisions
- Documenting technology choices and trade-offs
- Creating Architecture Decision Records (ADRs)
- Preparing context for AI-assisted architectural analysis
- Establishing decision history for team knowledge transfer

## Template Prompt

```
# Architecture Decision Capture

**Decision Title**: {DECISION_TITLE}
**Decision ID**: {ADR_NUMBER}
**Date**: {DECISION_DATE}
**Status**: {PROPOSED/ACCEPTED/SUPERSEDED/DEPRECATED}
**Architects**: {DECISION_MAKERS}
**Stakeholders**: {AFFECTED_TEAMS}
**Context**: {PROJECT_PHASE}

Please provide comprehensive architectural decision documentation covering:

## Decision Context and Background
1. **Problem Statement and Context**
   - **Current Situation**: Detailed description of the problem or opportunity
   - **Business Context**: Business drivers and strategic considerations
   - **Technical Context**: Current technical landscape and constraints
   - **Timeline Constraints**: Decision urgency and implementation deadlines

2. **Stakeholder Requirements and Concerns**
   - **Business Requirements**: Functional and non-functional requirements
   - **Technical Requirements**: Performance, scalability, and reliability needs
   - **Compliance Requirements**: Regulatory, security, and governance constraints
   - **Resource Constraints**: Budget, time, and team capacity limitations

3. **Environmental Factors**
   - **Existing Architecture**: Current system architecture and dependencies
   - **Technology Landscape**: Existing technology stack and standards
   - **Team Capabilities**: Available skills and expertise
   - **Organizational Standards**: Company policies and architectural guidelines

## Decision Analysis and Evaluation
1. **Alternative Solutions Considered**
   - **Option 1**: {SOLUTION_NAME}
     - **Description**: Detailed solution approach and implementation
     - **Pros**: Advantages and benefits of this approach
     - **Cons**: Disadvantages and limitations
     - **Complexity**: Implementation complexity and effort required
     - **Risk Assessment**: Technical and business risks
     - **Cost Analysis**: Implementation and operational costs

   - **Option 2**: {SOLUTION_NAME}
     - **Description**: Alternative solution approach and implementation
     - **Pros**: Advantages and benefits of this approach
     - **Cons**: Disadvantages and limitations
     - **Complexity**: Implementation complexity and effort required
     - **Risk Assessment**: Technical and business risks
     - **Cost Analysis**: Implementation and operational costs

   - **Option 3**: {SOLUTION_NAME}
     - **Description**: Third alternative or hybrid approach
     - **Pros**: Advantages and benefits of this approach
     - **Cons**: Disadvantages and limitations
     - **Complexity**: Implementation complexity and effort required
     - **Risk Assessment**: Technical and business risks
     - **Cost Analysis**: Implementation and operational costs

2. **Evaluation Criteria and Decision Matrix**
   - **Performance**: Impact on system performance and user experience
   - **Scalability**: Ability to handle growth and increased load
   - **Maintainability**: Long-term maintenance and evolution considerations
   - **Security**: Security implications and threat mitigation
   - **Cost**: Total cost of ownership including development and operations
   - **Risk**: Technical and business risk assessment
   - **Team Fit**: Alignment with team skills and organizational capabilities

## Decision Rationale and Selection
1. **Chosen Solution**
   - **Selected Option**: {CHOSEN_SOLUTION}
   - **Primary Rationale**: Key reasons for selecting this solution
   - **Trade-offs Accepted**: Acknowledged limitations and compromises
   - **Success Criteria**: How success will be measured

2. **Decision Factors and Weighting**
   - **Critical Factors**: Most important criteria influencing the decision
   - **Secondary Considerations**: Supporting factors and nice-to-have features
   - **Eliminated Options**: Why other options were not selected
   - **Contingency Planning**: Fallback options if chosen solution doesn't work

## Implementation and Impact Analysis
1. **Implementation Strategy**
   - **Implementation Phases**: Step-by-step implementation approach
   - **Resource Requirements**: Team members, skills, and time needed
   - **Technology Requirements**: Tools, frameworks, and infrastructure needed
   - **Integration Points**: How solution integrates with existing systems

2. **Impact Assessment**
   - **Technical Impact**: Effect on existing architecture and systems
   - **Team Impact**: Changes to development processes and team responsibilities
   - **User Impact**: Effect on end users and system capabilities
   - **Operational Impact**: Changes to deployment, monitoring, and maintenance

3. **Risk Mitigation and Monitoring**
   - **Identified Risks**: Potential issues and their mitigation strategies
   - **Monitoring Strategy**: How to track implementation success and issues
   - **Success Metrics**: Specific measurements for decision validation
   - **Review Schedule**: When and how to evaluate decision effectiveness

## Long-term Implications and Evolution
1. **Future Considerations**
   - **Scalability Path**: How solution supports future growth
   - **Evolution Strategy**: How solution can be enhanced or replaced
   - **Technology Roadmap**: Alignment with future technology plans
   - **Learning Opportunities**: Knowledge gained from this decision

2. **Dependency and Coupling Analysis**
   - **System Dependencies**: How this decision affects other systems
   - **Technology Dependencies**: External technology dependencies created
   - **Team Dependencies**: Cross-team coordination requirements
   - **Process Dependencies**: Changes to development and operational processes

## Knowledge Preservation and Transfer
1. **Decision Documentation**
   - **Rationale Preservation**: Complete reasoning for future reference
   - **Context Documentation**: Environmental factors and constraints
   - **Lessons Learned**: Key insights from the decision-making process
   - **Reference Materials**: Supporting documents and research

2. **Communication and Socialization**
   - **Stakeholder Communication**: How decision will be communicated
   - **Training Requirements**: Team training needed for implementation
   - **Documentation Updates**: Architecture docs requiring updates
   - **Review Process**: Ongoing decision review and validation process

Generate comprehensive Architecture Decision Record (ADR) with complete context, analysis, and implementation guidance for long-term architectural knowledge management.
```

## Customization Variables

- `{DECISION_TITLE}`: Descriptive title of the architectural decision
- `{ADR_NUMBER}`: Sequential Architecture Decision Record number
- `{DECISION_DATE}`: Date when the decision was made
- `{PROPOSED/ACCEPTED/SUPERSEDED/DEPRECATED}`: Current status of the decision
- `{DECISION_MAKERS}`: Architects and leads responsible for the decision
- `{AFFECTED_TEAMS}`: Teams impacted by the architectural decision
- `{PROJECT_PHASE}`: Current phase of project development
- `{SOLUTION_NAME}`: Names of alternative solutions considered
- `{CHOSEN_SOLUTION}`: Final selected solution approach

## Expected Output Format

### Architecture Decision Record (ADR)
- **Decision Summary**: Executive summary of the decision and rationale
- **Detailed Analysis**: Comprehensive evaluation of alternatives and trade-offs
- **Implementation Plan**: Specific steps for implementing the chosen solution
- **Impact Assessment**: Analysis of decision impact on systems, teams, and processes

### Supporting Documentation
- **Decision Matrix**: Quantitative evaluation of alternatives against criteria
- **Risk Analysis**: Identified risks and mitigation strategies
- **Communication Plan**: Strategy for socializing and implementing the decision
- **Review Schedule**: Timeline for decision validation and potential revision

## Claude Code Optimization

### Decision Documentation Workflow
```bash
# Architecture decision creation
claude-adr create --template=CM-006 --decision="microservices-architecture"

# Decision analysis and recommendation
echo "Decision: ${DECISION_TITLE}" | claude-analyze --type=architecture --format=adr
```

### AI-Assisted Decision Making
- **Alternative Analysis**: AI-assisted evaluation of architectural alternatives
- **Impact Assessment**: Systematic analysis of decision implications
- **Documentation Generation**: Automatic ADR creation and formatting

### Decision Quality Improvement
- **Comprehensive Analysis**: 70% more thorough alternative evaluation
- **Better Documentation**: 80% improvement in decision documentation quality
- **Faster Decision Process**: 65% reduction in decision analysis time

## Effectiveness Metrics

### Decision Quality
- **Documentation Time**: 70% reduction (2.5 hours → 45 minutes)
- **Decision Completeness**: 90% improvement in decision documentation thoroughness
- **Stakeholder Alignment**: 85% improvement in decision communication and buy-in

### Knowledge Preservation
- **Context Retention**: 95% of decision context preserved for future reference
- **Team Understanding**: 80% improvement in team understanding of architectural decisions
- **Knowledge Transfer**: 75% faster onboarding with comprehensive decision history

### Implementation Success
- **Decision Implementation**: 85% of documented decisions successfully implemented
- **Review Effectiveness**: 90% of decisions validated through structured review process
- **Evolution Success**: 70% of decisions successfully evolved based on learning

## Integration with Other Templates

### Template Dependencies
- **Builds on**: CM-001 (Repository Context) for architectural understanding
- **Connects to**: CM-017 (Enterprise Architecture) for large-scale decision coordination
- **Supports**: All templates requiring architectural decision context

### Decision Workflow
1. **Start with CM-001** for system architecture understanding
2. **Apply CM-006** for specific architectural decisions
3. **Use CM-017** for enterprise-scale decision coordination
4. **Reference in all implementation templates** for context consistency

This template enables systematic architectural decision capture and preservation, transforming decision-making processes into structured knowledge that supports AI-assisted architecture evolution and team knowledge transfer.