---
name: Prompt Template Development
about: Create or validate prompt templates for the template library
title: '[Template]: [Template Name] for [Use Case]'
labels: ['templates', 'development']
assignees: ''

---

## Template Overview

**Template Name:** [Descriptive name for the template]  
**Category:** [Context Mastery/Dynamic Planning/Code Evolution/Strategic Testing/Intelligent Review]  
**Use Case:** [Specific problem this template solves]  
**Complexity Level:** [Basic/Intermediate/Advanced/Expert]

## Template Specifications

### Purpose and Scope
**Primary Use Case:**
[Detailed description of when and why developers would use this template]

**Target Scenario:**
[Specific development scenario where this template provides value]

**Expected Outcome:**
[What result the template should produce when used correctly]

### Template Structure
**Required Variables:**
- [ ] `{VARIABLE_NAME}` - [Description of what this variable represents]
- [ ] `{VARIABLE_NAME}` - [Description and example values]
- [ ] `{VARIABLE_NAME}` - [Type of input expected]

**Optional Variables:**
- [ ] `{OPTIONAL_VAR}` - [Description and default behavior]
- [ ] `{OPTIONAL_VAR}` - [When to use this variable]

**Context Requirements:**
- [ ] Project context needed: [What project information is required]
- [ ] Code context needed: [What code files or snippets to include] 
- [ ] Technical context needed: [Framework/tool versions, configurations]

## Acceptance Criteria

### Template Quality
- [ ] Template produces consistent, useful results
- [ ] All variables clearly documented with examples
- [ ] Usage instructions are clear and actionable
- [ ] Template handles edge cases gracefully
- [ ] Error scenarios documented with troubleshooting

### Testing and Validation
- [ ] Template tested in at least 3 different scenarios
- [ ] Effectiveness measured and documented
- [ ] Output quality validated by technical reviewer
- [ ] Integration with Claude Code workflows verified
- [ ] Cross-platform compatibility confirmed

### Documentation Requirements
- [ ] Frontmatter metadata complete
- [ ] Variable documentation includes examples
- [ ] Step-by-step usage instructions provided
- [ ] Expected output format specified
- [ ] Customization guidelines included

### Schema Compliance
- [ ] Template follows established format schema
- [ ] Metadata fields properly populated
- [ ] Variable naming conventions followed
- [ ] Integration requirements documented

## Testing Scenarios

### Basic Testing
**Scenario 1:** [Describe basic use case]
- Input: [Example variable values]
- Expected Output: [What the template should produce]
- Success Criteria: [How to measure success]

**Scenario 2:** [Describe intermediate use case]
- Input: [Example variable values]
- Expected Output: [What the template should produce]
- Success Criteria: [How to measure success]

### Advanced Testing
**Scenario 3:** [Describe complex or edge case]
- Input: [Example variable values]
- Expected Output: [What the template should produce]
- Success Criteria: [How to measure success]

### Framework-Specific Testing
- [ ] Angular project testing completed
- [ ] React project testing completed  
- [ ] Node.js backend testing completed
- [ ] Full-stack integration testing completed

## Template Effectiveness Metrics

**Success Rate:** [Percentage of successful applications]  
**User Feedback Score:** [1-5 rating from initial users]  
**Time Savings:** [Estimated time saved per use]  
**Quality Improvement:** [Measurable improvement in output quality]

## Integration Requirements

### Template Library Integration
- [ ] Template categorized correctly
- [ ] Tags and keywords assigned
- [ ] Search optimization completed
- [ ] Related templates linked

### PWA Integration
- [ ] Offline accessibility confirmed
- [ ] Progressive loading compatibility
- [ ] Interactive elements specified
- [ ] Mobile optimization verified

## Dependencies and Prerequisites

**Content Dependencies:**
- [ ] Related chapter content: [Specify which chapters reference this template]
- [ ] Prerequisite templates: [Templates that should be understood first]
- [ ] Supporting documentation: [Any additional docs needed]

**Technical Dependencies:**
- [ ] Development tools required: [Claude Code, specific IDEs, etc.]
- [ ] Framework compatibility: [Which frameworks this works with]
- [ ] Minimum knowledge requirements: [What developers need to know]

## Template Draft

```markdown
---
title: "[Template Title]"
type: "template"
template_category: "[category]"
use_case: "[specific use case]"
target_scenario: "[when to use]"
complexity_level: "[basic/intermediate/advanced]"
effectiveness_rating: [1-5]
testing_status: "[testing level]"
---

# [Template Title]

## Purpose
[Brief description of what this template accomplishes]

## When to Use
[Specific scenarios where this template is most effective]

## Template

```
[Actual prompt template with {VARIABLE} placeholders]
```

## Variables

### Required Variables
- **{VARIABLE_NAME}**: [Description and examples]
- **{VARIABLE_NAME}**: [Description and examples]

### Optional Variables  
- **{OPTIONAL_VAR}**: [Description, examples, and default behavior]

## Usage Instructions

1. [Step-by-step instructions]
2. [How to customize variables]
3. [How to interpret results]

## Example Usage

### Basic Example
**Scenario:** [Real-world scenario]
**Input:**
- {VARIABLE}: [Example value]
- {VARIABLE}: [Example value]

**Expected Output:** [What the AI should produce]

## Troubleshooting
- **Problem:** [Common issue]
  **Solution:** [How to resolve]
```

## Review Requirements

**Technical Review:**
- [ ] Template effectiveness validated
- [ ] Code output accuracy verified  
- [ ] Best practices compliance confirmed

**Content Review:**
- [ ] Documentation clarity verified
- [ ] Examples tested and validated
- [ ] Integration requirements met

**User Testing:**
- [ ] Template tested by target users
- [ ] Feedback incorporated
- [ ] Usability confirmed

## Timeline

**Estimated Effort:** [Hours for development and testing]
**Target Completion:** [Date]
**Review Deadline:** [Date]

## Additional Notes

[Any special considerations, known limitations, or future enhancement plans]