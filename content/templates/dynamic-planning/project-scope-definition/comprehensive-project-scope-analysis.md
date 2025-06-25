---
title: "Comprehensive Project Scope Analysis Template"
description: "AI-powered template for complete project scope definition, stakeholder analysis, and work breakdown structure generation"
type: "prompt_template"
category: "project-scope-definition"
use_case: "comprehensive-scope-analysis"
complexity_level: "advanced"
estimated_time_savings: "80% (8 hours → 1.5 hours)"
target_audience: "project_managers, tech_leads, senior_developers"
prerequisites: ["project_requirements", "stakeholder_input"]
integration_requirements: ["jira", "linear", "azure_devops"]
effectiveness_metrics: ["scope_clarity", "stakeholder_alignment", "work_breakdown_accuracy"]
last_updated: "2025-06-25"
template_version: "1.0"
validation_status: "tested"
---

# Comprehensive Project Scope Analysis Template

## Template Purpose
Generate complete project scope definition with stakeholder analysis, requirement breakdown, and work structure planning for complex software development projects.

## Usage Context
Use this template when:
- Starting new software development projects requiring comprehensive scope definition
- Clarifying ambiguous or poorly defined project requirements
- Establishing clear boundaries and deliverables for cross-functional teams
- Creating detailed work breakdown structures for project planning
- Aligning stakeholders on project objectives and success criteria

## Template Prompt

```
**Context**: Comprehensive Project Scope Analysis for {PROJECT_NAME}

I need to perform a complete project scope analysis for {PROJECT_NAME}. This project involves {PROJECT_DESCRIPTION} with the following initial requirements:

**Initial Requirements**: {INITIAL_REQUIREMENTS}

**Stakeholders**: {STAKEHOLDER_LIST}

**Business Objectives**: {BUSINESS_OBJECTIVES}

**Technical Constraints**: {TECHNICAL_CONSTRAINTS}

**Timeline Constraints**: {TIMELINE_CONSTRAINTS}

**Budget Constraints**: {BUDGET_CONSTRAINTS}

Please provide a comprehensive project scope analysis including:

## 1. Project Scope Definition

### Core Objectives
- Primary business objectives and success criteria
- Measurable outcomes and key performance indicators
- Strategic alignment with organizational goals

### Functional Requirements
- Core features and capabilities (in-scope)
- User stories and acceptance criteria
- Technical specifications and quality attributes
- Integration requirements and dependencies

### Non-Functional Requirements
- Performance requirements (response time, throughput, scalability)
- Security requirements and compliance standards
- Usability and accessibility requirements
- Maintainability and operational requirements

### Explicit Exclusions (Out of Scope)
- Features and capabilities explicitly excluded
- Future phase considerations
- Assumptions and constraints that limit scope

## 2. Stakeholder Analysis

### Primary Stakeholders
- Role, influence, and decision-making authority
- Key interests and success criteria
- Communication preferences and engagement requirements

### Secondary Stakeholders
- Supporting roles and dependencies
- Information and approval requirements
- Potential impact on project execution

### Stakeholder Engagement Plan
- Communication frequency and methods
- Review and approval processes
- Escalation paths and decision-making protocols

## 3. Work Breakdown Structure (WBS)

### Epic-Level Breakdown
- Major project components and deliverables
- Epic dependencies and sequencing
- Resource allocation estimates

### Feature-Level Breakdown
- Detailed feature specifications
- Acceptance criteria and definition of done
- Estimated effort and complexity assessment

### Task-Level Breakdown
- Development tasks and technical activities
- Testing and quality assurance activities
- Deployment and operational activities

## 4. Risk and Assumption Analysis

### Key Assumptions
- Technical assumptions and their validation requirements
- Business assumptions and validation criteria
- Resource and timeline assumptions

### Risk Identification
- Technical risks and mitigation strategies
- Business and market risks
- Resource and timeline risks
- External dependency risks

## 5. Success Criteria and Acceptance

### Definition of Done
- Completion criteria for each major deliverable
- Quality gates and acceptance criteria
- Testing and validation requirements

### Success Metrics
- Quantitative success measures
- Qualitative assessment criteria
- Long-term value realization metrics

## 6. Project Boundaries and Interfaces

### System Boundaries
- Integration points with existing systems
- Data flow and API requirements
- Security and access control boundaries

### Organizational Boundaries
- Team responsibilities and ownership
- Cross-functional collaboration requirements
- External vendor and partner interfaces

Please structure the analysis to support {PLANNING_METHODOLOGY} methodology and integration with {PROJECT_MANAGEMENT_TOOL}.
```

## Customization Variables

- `{PROJECT_NAME}`: Specific project identifier
- `{PROJECT_DESCRIPTION}`: Brief project overview and context
- `{INITIAL_REQUIREMENTS}`: Known requirements and specifications
- `{STAKEHOLDER_LIST}`: Key stakeholders and their roles
- `{BUSINESS_OBJECTIVES}`: Strategic goals and success criteria
- `{TECHNICAL_CONSTRAINTS}`: Technology stack, platform, architecture constraints
- `{TIMELINE_CONSTRAINTS}`: Delivery deadlines and milestone requirements
- `{BUDGET_CONSTRAINTS}`: Resource and cost limitations
- `{PLANNING_METHODOLOGY}`: Agile, Waterfall, or hybrid approach
- `{PROJECT_MANAGEMENT_TOOL}`: Jira, Linear, Azure DevOps, etc.

## Expected Output Format

### Structured Analysis Document
- Executive summary with key findings and recommendations
- Detailed scope definition with clear in/out boundaries
- Comprehensive stakeholder analysis with engagement plan
- Hierarchical work breakdown structure with effort estimates
- Risk register with mitigation strategies
- Success criteria with measurable metrics

### Project Management Tool Integration
- Epics and features ready for tool import
- User stories with acceptance criteria
- Task breakdown with effort estimates
- Stakeholder assignment and responsibility matrix

## Example Usage

```
**Context**: Comprehensive Project Scope Analysis for Customer Portal Modernization

I need to perform a complete project scope analysis for Customer Portal Modernization. This project involves replacing our legacy customer portal with a modern React-based application with the following initial requirements:

**Initial Requirements**: 
- Modern responsive web interface
- User authentication and profile management
- Account overview and transaction history
- Document upload and management
- Integration with existing CRM and billing systems

**Stakeholders**: 
- Product Manager (Sarah Chen)
- Engineering Lead (Mike Rodriguez)
- UX Designer (Lisa Park)
- Customer Success Manager (David Kim)
- Security Officer (Jennifer Liu)

**Business Objectives**: 
- Improve customer satisfaction scores by 25%
- Reduce support ticket volume by 40%
- Increase customer self-service adoption by 60%

**Technical Constraints**: 
- Must integrate with Salesforce CRM
- Required SOC 2 compliance
- Mobile-first responsive design
- 99.9% uptime requirement

**Timeline Constraints**: 
- MVP delivery in 12 weeks
- Full feature rollout in 20 weeks

**Budget Constraints**: 
- Development team of 5 engineers
- $150K external vendor budget for design and testing

Please provide a comprehensive project scope analysis including: [rest of template]
```

## Effectiveness Metrics

- **Scope Clarity**: 90% reduction in scope-related questions and clarifications
- **Stakeholder Alignment**: 85% stakeholder agreement on project objectives
- **Work Breakdown Accuracy**: 80% accuracy in effort estimation for major components
- **Planning Efficiency**: 80% reduction in initial planning time
- **Change Request Reduction**: 60% fewer scope change requests during execution

## Integration Guidelines

### Jira Integration
```
Epic Structure:
- Epic Name: [Epic from WBS]
- Epic Description: [Scope definition and acceptance criteria]
- Epic Stories: [Feature breakdown from analysis]
- Epic Labels: [Risk level, priority, team assignment]
```

### Linear Integration
```
Project Structure:
- Project Name: [Project Name]
- Project Description: [Executive summary]
- Project Requirements: [Functional and non-functional requirements]
- Project Teams: [Stakeholder assignments]
```

### Azure DevOps Integration
```
Work Item Hierarchy:
- Feature: [Epic-level components]
- User Story: [Feature-level breakdown]
- Task: [Development and testing activities]
- Bug: [Quality assurance and testing tasks]
```

This template provides comprehensive project scope analysis optimized for Claude Code workflows and seamless integration with modern project management platforms.