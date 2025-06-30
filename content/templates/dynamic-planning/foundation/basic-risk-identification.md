---
title: "Basic Risk Identification Template (DP-F-004)"
description: "Foundational template for identifying and planning around common development project risks using AI assistance"
type: "template"
tier: "foundation"
template_category: "dynamic-planning"
template_subcategory: "risk-management"
use_case: "Identify project risks early and create practical mitigation strategies before problems occur"
target_scenario: "Use during project setup, sprint planning, or when facing uncertainty about project challenges"
complexity_level: "foundation"
skill_level: "foundational"
estimated_reading_time: "8 minutes"
word_count: 2100
content_status: "final"
estimated_time_savings: "75% (2 hours → 30 minutes)"
target_audience: ["developers", "project_managers", "team_leads", "beginners"]
prerequisites: ["project_basics", "claude_code_access"]
integration_requirements: ["pwa-compatible", "offline-accessible", "progressive-loading", "template-testing"]
effectiveness_metrics: ["risk_coverage", "early_detection", "mitigation_success"]
template_id: "DP-F-004"
template_version: "1.0"
validation_status: "verified"
pwa_integration: ["offline_accessible", "copy_to_clipboard", "usage_tracking", "template_sync"]
offline_accessible: true
offline_functionality: true
progressive_loading: true
caching_strategy: "cache_first"
mobile_optimized: true
touch_friendly: true
copy_functionality: true
usage_tracking: true
accessibility_features: ["semantic-markup", "screen-reader-compatible", "keyboard-navigation"]
search_optimization: ["risk identification", "project risks", "foundational", "planning"]
cross_references: ["basic-project-initialization", "simple-sprint-planning", "story-point-estimation"]
last_updated: "2025-06-30"
sync_requirements: ["template_usage", "risk_patterns", "mitigation_strategies"]
claude_code_optimized: true
---

# Basic Risk Identification Template (DP-F-004)

## Template Purpose

Identify common development project risks before they become problems using AI assistance. Perfect for teams learning proactive risk management and mitigation planning.

## Usage Context

Use this template when:
- Starting new projects or major features
- Facing uncertainty about project challenges
- Learning systematic risk management practices
- Preparing for sprint planning sessions
- Training teams on proactive risk identification

## Template Prompt

```
# Project Risk Assessment Assistant

Help me identify potential risks for my development project and suggest practical mitigation strategies.

**Project Type**: {PROJECT_TYPE}
**Technology Stack**: {TECHNOLOGY_STACK}
**Team Experience**: {TEAM_EXPERIENCE_LEVEL}
**Timeline**: {PROJECT_TIMELINE}
**Budget/Resource Constraints**: {RESOURCE_CONSTRAINTS}
**External Dependencies**: {EXTERNAL_DEPENDENCIES}

## Project Context
{PROJECT_DETAILS}

## Specific Areas to Assess
1. **Technical Risks**: What could go wrong with our technology choices?
2. **Timeline Risks**: What might cause delays?
3. **Team Risks**: What people/skill challenges might we face?
4. **External Risks**: What outside factors could impact us?
5. **Quality Risks**: What could compromise our deliverable quality?

For each risk category, please provide:
- Top 3-5 most likely risks
- Simple early warning signs
- Basic mitigation strategies
- Contingency plans if risks materialize

Format as a prioritized risk register with actionable mitigation plans.
```

## Customization Variables

- `{PROJECT_TYPE}`: Web app, mobile app, API, library, etc.
- `{TECHNOLOGY_STACK}`: Main technologies and frameworks
- `{TEAM_EXPERIENCE_LEVEL}`: Beginner, intermediate, mixed with new tech
- `{PROJECT_TIMELINE}`: How long until key deadlines
- `{RESOURCE_CONSTRAINTS}`: Any known budget or resource limitations
- `{EXTERNAL_DEPENDENCIES}`: Third-party services, APIs, etc.
- `{PROJECT_DETAILS}`: Specific project context and requirements

## Expected Output Format

### Risk Assessment Report
- **High Priority Risks**: Immediate attention required
- **Medium Priority Risks**: Regular monitoring needed
- **Low Priority Risks**: Acknowledge and revisit periodically
- **Risk Mitigation Strategies**: Actionable prevention and response plans

## Implementation Guide

### Step 1: Risk Discovery

```markdown
# Project Risk Assessment Assistant

Help me identify potential risks for my development project and suggest practical mitigation strategies.

## Project Context
- **Project Type**: [Web app/Mobile app/API/Library/etc.]
- **Technology Stack**: [Main technologies]
- **Team Experience**: [Beginner/Intermediate/Mixed with new tech]
- **Timeline**: [How long until key deadlines]
- **Budget/Resource Constraints**: [Any known limitations]
- **External Dependencies**: [Third-party services, APIs, etc.]

## Specific Areas to Assess
1. **Technical Risks**: What could go wrong with our technology choices?
2. **Timeline Risks**: What might cause delays?
3. **Team Risks**: What people/skill challenges might we face?
4. **External Risks**: What outside factors could impact us?
5. **Quality Risks**: What could compromise our deliverable quality?

For each risk category, please provide:
- Top 3-5 most likely risks
- Simple early warning signs
- Basic mitigation strategies
- Contingency plans if risks materialize
```

### Step 2: Risk Documentation and Planning

Create a simple risk register:

**High Priority Risks** (Address immediately):
- [ ] Risk 1: [Description]
  - Warning signs: [How you'll know it's happening]
  - Prevention: [What to do now]
  - Response: [What to do if it happens]

- [ ] Risk 2: [Description]
  - Warning signs: [How you'll know it's happening]
  - Prevention: [What to do now]
  - Response: [What to do if it happens]

**Medium Priority Risks** (Monitor regularly):
- [ ] Risk 3: [Description and basic plan]
- [ ] Risk 4: [Description and basic plan]

**Low Priority Risks** (Acknowledge and revisit):
- [ ] Risk 5: [Description]
- [ ] Risk 6: [Description]

## Common Risk Categories for New Projects

### Technical Risks
**New Technology Learning Curve**:
- Warning signs: Taking longer than expected for simple tasks
- Prevention: Allocate extra time for learning, create proof-of-concepts
- Response: Find mentoring, adjust timeline, or consider technology change

**Integration Complexity**:
- Warning signs: APIs don't work as documented, data format mismatches
- Prevention: Test integrations early, read documentation thoroughly
- Response: Build wrapper/adapter layers, contact vendor support

**Performance Issues**:
- Warning signs: Slow response times during development
- Prevention: Test with realistic data volumes early
- Response: Performance profiling, architecture review, caching strategies

### Timeline Risks
**Scope Creep**:
- Warning signs: "Just one more feature" requests
- Prevention: Clear requirements documentation, change request process
- Response: Evaluate impact, negotiate timeline/scope trade-offs

**Underestimation**:
- Warning signs: Consistently missing sprint commitments
- Prevention: Add buffer time, break tasks into smaller pieces
- Response: Re-estimate remaining work, adjust timeline expectations

### Team Risks
**Key Person Dependency**:
- Warning signs: Only one person knows critical parts
- Prevention: Pair programming, documentation, knowledge sharing
- Response: Cross-training, documentation sprints, consultant support

**Skill Gaps**:
- Warning signs: Tasks taking much longer than expected
- Prevention: Honest skill assessment, training time allocation
- Response: Training, mentoring, or bringing in expert help

## Implementation Guide

### Risk Review Schedule

**Weekly Check-ins** (5 minutes):
- Review high-priority risk warning signs
- Update risk status (better/worse/same)
- Decide on any immediate actions

**Sprint Planning Integration** (10 minutes):
- Consider risks when estimating tasks
- Plan risk mitigation activities
- Adjust sprint goals based on current risks

**Monthly Risk Review** (30 minutes):
- Reassess all risks based on project learning
- Add new risks discovered during development
- Celebrate successful risk mitigation
- Update prevention and response strategies

### Risk Mitigation Integration

**Sprint Planning**:
- Include time for risk mitigation activities
- Plan proof-of-concepts for technical risks
- Schedule knowledge-sharing sessions
- Allocate buffer time for high-risk tasks

**Daily Work**:
- Watch for risk warning signs
- Document learning and discoveries
- Communicate concerns early
- Take preventive actions proactively

## Success Metrics

**Risk Management Effectiveness**:
- Fewer unexpected crises
- Faster response to issues when they arise
- Team confidence in handling challenges
- Stakeholder confidence in project execution

**Early Detection Success**:
- Risks identified before becoming critical
- Mitigation strategies ready when needed
- Team develops risk awareness mindset
- Better estimation accuracy over time

## Integration with Other Templates

**Project Setup**:
- Use after "Basic Project Initialization"
- Inform "Simple Sprint Planning" with risk awareness
- Feed into "Basic Timeline Creation"

**Ongoing Planning**:
- Update during "Sprint Retrospectives"
- Consider in "Feature Planning"
- Include in "Stakeholder Communication"

## Customization Options

**For Solo Developers**:
- Focus on technical and timeline risks
- Include personal availability risks
- Consider motivation and learning risks

**For New Teams**:
- Add communication and coordination risks
- Include process adoption risks
- Consider team chemistry and working style risks

**For Client Projects**:
- Add client communication risks
- Include requirement change risks
- Consider approval and feedback timeline risks

This template helps build risk awareness without creating overwhelming process overhead. Start simple and add sophistication as your risk management skills develop.