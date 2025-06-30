---
title: "Peer Review Preparation Template (IR-F-001)"
description: "Foundational template for preparing code for effective peer review with AI assistance"
type: "template"
tier: "foundation"
template_category: "intelligent-review"
template_subcategory: "review-preparation"
use_case: "Prepare code changes for effective peer review to improve quality and team collaboration"
target_scenario: "Use before submitting pull requests, code reviews, or team collaboration sessions"
complexity_level: "foundation"
skill_level: "foundational"
estimated_reading_time: "11 minutes"
word_count: 2500
content_status: "final"
estimated_time_savings: "60% (2 hours → 45 minutes)"
target_audience: ["developers", "junior_developers", "team_members", "code_reviewers"]
prerequisites: ["basic_git", "claude_code_access", "team_collaboration"]
integration_requirements: ["pwa-compatible", "offline-accessible", "template-testing"]
effectiveness_metrics: ["review_efficiency", "feedback_quality", "collaboration_improvement"]
template_id: "IR-F-001"
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
search_optimization: ["peer review", "code review", "pull request", "collaboration"]
cross_references: ["basic-code-review-checklist", "constructive-feedback-generation", "basic-code-cleanup"]
last_updated: "2025-06-30"
sync_requirements: ["template_usage", "review_patterns", "collaboration_data"]
claude_code_optimized: true
---

# Peer Review Preparation Template (IR-F-001)

## Template Purpose
Prepare code changes for effective peer review by self-reviewing, documenting decisions, and providing context that enables productive feedback and collaboration.

## Usage Context
Use this template when:
- Preparing to submit a pull request for team review
- Self-reviewing code before sharing with colleagues
- Documenting changes and decisions for team understanding
- Learning effective code review practices and preparation
- Improving team collaboration and knowledge sharing

## Template Prompt

```
# Code Review Preparation Assistant

Help me prepare this code change for effective peer review by analyzing it for quality, clarity, and completeness.

**Change Type**: {CHANGE_TYPE}
**Feature/Bug Description**: {CHANGE_DESCRIPTION}
**Code Language**: {PROGRAMMING_LANGUAGE}
**Team Context**: {TEAM_CONTEXT}
**Review Goals**: {REVIEW_GOALS}

## Code Changes
```{PROGRAMMING_LANGUAGE}
{CODE_CHANGES}
```

## Context and Background
{BACKGROUND_CONTEXT}

## Areas of Concern
{SPECIFIC_CONCERNS}

Please provide:

1. **Self-Review Analysis**
   - Code quality assessment
   - Potential issues or improvements
   - Readability and maintainability evaluation
   - Best practice adherence

2. **Documentation Recommendations**
   - What context reviewers need to understand
   - Key decisions that should be explained
   - Non-obvious implementation choices
   - Business logic clarification

3. **Review Guidance**
   - Specific areas where feedback would be valuable
   - Questions to ask reviewers
   - Testing considerations for reviewers
   - Integration and deployment notes

4. **Pull Request Description**
   - Summary of changes and their purpose
   - Testing performed and results
   - Known limitations or future work
   - Reviewer checklist and focus areas

5. **Potential Review Questions**
   - Questions reviewers might ask
   - Proactive answers to common concerns
   - Alternative approaches considered
   - Performance and security considerations

Format as a comprehensive review preparation guide that improves review efficiency and quality.
```

## Customization Variables

- `{CHANGE_TYPE}`: New feature, bug fix, refactoring, optimization, etc.
- `{CHANGE_DESCRIPTION}`: Brief description of what was changed and why
- `{PROGRAMMING_LANGUAGE}`: JavaScript, Python, Java, C#, etc.
- `{TEAM_CONTEXT}`: Team size, experience level, review practices
- `{REVIEW_GOALS}`: What kind of feedback you're seeking
- `{CODE_CHANGES}`: The actual code that was modified
- `{BACKGROUND_CONTEXT}`: Business context, requirements, constraints
- `{SPECIFIC_CONCERNS}`: Areas where you want focused feedback

## Expected Output Format

### Self-Review Assessment
- **Code Quality Score**: Overall quality evaluation
- **Readability Analysis**: How clear and understandable the code is
- **Potential Issues**: Problems that should be addressed
- **Improvement Suggestions**: Ways to enhance the code

### Documentation Package
- **Change Summary**: Clear explanation of what and why
- **Context Documentation**: Background information for reviewers
- **Decision Rationale**: Explanation of key implementation choices
- **Testing Notes**: How the change was validated

### Review Strategy
- **Focus Areas**: Where reviewers should concentrate attention
- **Specific Questions**: What feedback would be most valuable
- **Review Checklist**: Items for reviewers to verify
- **Next Steps**: Plans after review completion

## Implementation Guide

### Step 1: Self-Review Process (25 minutes)

1. **Code Quality Check**
   - Read through all changes as if seeing for first time
   - Check for consistent naming and formatting
   - Verify error handling and edge cases
   - Ensure tests cover new functionality

2. **Documentation Review**
   - Update comments and documentation
   - Ensure commit messages are clear
   - Add inline explanations for complex logic
   - Update relevant README or API docs

### Step 2: Context Preparation (15 minutes)

1. **Background Documentation**
   - Explain the problem being solved
   - Note any constraints or requirements
   - Describe the approach taken
   - Mention alternatives considered

2. **Change Impact Assessment**
   - Identify affected systems or components
   - Note any breaking changes
   - List new dependencies or requirements
   - Document migration or deployment needs

### Step 3: Review Facilitation (5 minutes)

1. **Create Review Checklist**
   - Specific items for reviewers to verify
   - Areas where feedback is most needed
   - Testing scenarios to validate
   - Integration considerations

2. **Prepare for Discussion**
   - Anticipate questions and prepare answers
   - Identify areas open to alternative approaches
   - Note any known limitations or future work
   - Plan for addressing feedback

## Usage Examples

### Example 1: New Feature Implementation
```markdown
**Change Type**: New feature
**Feature Description**: User authentication with OAuth integration
**Code Language**: TypeScript/React
**Team Context**: 4-person frontend team, mixed experience levels
**Review Goals**: Security review, UX feedback, code organization

**Areas of Concern**:
- Security of token handling
- Error handling for failed authentication
- User experience during auth flow
- Integration with existing state management
```

### Example 2: Bug Fix
```markdown
**Change Type**: Bug fix
**Bug Description**: Race condition in data loading causing inconsistent UI state
**Code Language**: JavaScript/Vue.js
**Team Context**: 6-person full-stack team, experienced with Vue
**Review Goals**: Verify fix completeness, check for similar issues elsewhere

**Areas of Concern**:
- Whether fix addresses root cause
- Potential impact on other components
- Test coverage for race condition scenarios
- Performance impact of solution
```

### Example 3: Refactoring
```markdown
**Change Type**: Code refactoring
**Refactoring Description**: Extract business logic from component into separate service
**Code Language**: Angular/TypeScript
**Team Context**: Large enterprise team, strict code standards
**Review Goals**: Architecture review, maintainability assessment

**Areas of Concern**:
- Service design and interface clarity
- Proper dependency injection setup
- Impact on existing tests
- Backward compatibility
```

## Claude Code Optimization

### Pre-Review Workflow
```bash
# Create review branch
git checkout -b feature/{feature-name}

# Self-review with AI assistance
claude-code --template=IR-F-001 --input=git-diff.patch

# Update based on self-review
git add .
git commit -m "Address self-review feedback"

# Create pull request with AI-generated description
gh pr create --title "Feature: {title}" --body-file pr-description.md
```

### Review Enhancement
- **Faster Preparation**: 60% reduction in review prep time
- **Better Context**: Reviewers have clear understanding of changes
- **Focused Feedback**: Reviews concentrate on important aspects
- **Reduced Iterations**: Fewer back-and-forth review cycles

## Effectiveness Metrics

### Review Quality
- **Review Efficiency**: 40% faster review completion
- **Feedback Quality**: More actionable and specific comments
- **Issue Detection**: 50% increase in meaningful issues found
- **Team Learning**: Better knowledge sharing through context

### Collaboration Benefits
- **Reduced Confusion**: Clearer understanding of changes
- **Faster Approval**: Less time spent clarifying intent
- **Better Decisions**: More informed feedback and suggestions
- **Team Alignment**: Shared understanding of code quality

## Review Preparation Checklist

### Before Submitting
- [ ] **Self-review complete**: Read through all changes thoroughly
- [ ] **Tests passing**: All automated tests pass locally
- [ ] **Documentation updated**: Comments, README, and docs current
- [ ] **Formatting consistent**: Code follows team style guidelines
- [ ] **Commit messages clear**: Each commit has descriptive message

### Context Documentation
- [ ] **Change purpose explained**: Why this change was needed
- [ ] **Approach documented**: How the problem was solved
- [ ] **Alternatives considered**: Other approaches evaluated
- [ ] **Impact assessed**: What systems or users are affected
- [ ] **Testing described**: How changes were validated

### Review Guidance
- [ ] **Focus areas identified**: Where reviewers should pay attention
- [ ] **Specific questions asked**: What feedback is needed
- [ ] **Context provided**: Background information included
- [ ] **Checklist created**: Items for reviewers to verify
- [ ] **Timeline communicated**: When review is needed

## Common Preparation Patterns

### Feature Development
- Explain the user story and acceptance criteria
- Document design decisions and trade-offs
- Include screenshots or demos for UI changes
- Note any new dependencies or configuration

### Bug Fixes
- Describe the bug and its impact
- Explain root cause analysis
- Show before/after behavior
- Include regression test strategy

### Refactoring
- Explain the motivation for refactoring
- Document what changed and what stayed the same
- Show performance or maintainability improvements
- Address backward compatibility concerns

## Integration with Other Templates

**Foundation Workflow**:
1. **Basic Code Cleanup**: Clean code before review
2. **Peer Review Preparation**: Apply this template
3. **Basic Code Review Checklist**: Guide reviewers

**Quality Enhancement**:
- **Error Handling Basics**: Ensure robust error handling
- **Function Decomposition**: Clean function structure
- **Variable Naming Optimization**: Clear, descriptive names

**Advanced Progression**:
- **Constructive Feedback Generation**: Learn to give good feedback
- **Automated Code Review Acceleration**: Enhance with tools
- **Collaborative Review Optimization**: Team-wide improvements

This template builds review preparation habits that enhance team collaboration while ensuring high-quality, well-documented code changes.