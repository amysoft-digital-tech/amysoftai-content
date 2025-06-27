---
title: "Basic Code Review Checklist Template"
description: "Foundational template for AI-assisted code reviews that catch common issues and improve code quality"
template_category: "intelligent-review"
skill_level: "foundational"
estimated_time_savings: "30-45 minutes per review"
complexity_level: "low"
prerequisites: ["basic_programming", "claude_code_access", "version_control"]
effectiveness_metrics: {
  "issue_detection": "85%",
  "review_efficiency": "70%",
  "learning_value": "90%"
}
offline_accessible: true
copy_functionality: true
usage_tracking: true
search_optimization: ["code review", "checklist", "foundational", "quality"]
integration_requirements: ["pwa-compatible", "offline-accessible", "progressive-loading"]
cross_references: ["constructive-feedback-generation", "knowledge-sharing-basics", "review-preparation"]
claude_code_optimized: true
last_updated: "2025-06-27"
validation_status: "verified"
---

# Basic Code Review Checklist Template

## Overview

This foundational template provides a systematic approach to code reviews using AI assistance to catch common issues and provide constructive feedback. Perfect for teams establishing code review practices or reviewers wanting to be more thorough and helpful.

**When to use**: Reviewing pull requests, conducting pair programming reviews, or self-reviewing code before submission.

**Time investment**: 15-20 minutes per review, prevents hours of debugging and rework.

**Expected outcome**: Thorough, constructive code reviews that improve code quality and team learning.

## Template Usage

### Step 1: AI-Assisted Review Analysis

```markdown
# Code Review Assistant

Please help me conduct a thorough but constructive code review for this pull request.

## Pull Request Information
- **Title**: [PR title]
- **Description**: [What this PR is trying to accomplish]
- **Files Changed**: [List of main files]
- **Author**: [Who wrote the code - affects feedback style]
- **Context**: [New feature/Bug fix/Refactoring/etc.]

## Code to Review
```[language]
[Paste code changes here - focus on key files first]
```

## Review Focus Areas
1. **Functionality**: Does the code do what it's supposed to do?
2. **Readability**: Is the code easy to understand and maintain?
3. **Best Practices**: Does it follow good coding standards?
4. **Potential Issues**: Are there any bugs or edge cases missed?
5. **Learning Opportunities**: How can this be improved or what can we learn?

Please provide:
1. Overall assessment (approve/needs changes/major concerns)
2. Specific issues found with line numbers where possible
3. Suggestions for improvements
4. Positive feedback on good practices
5. Learning opportunities for the author and team
6. Questions about design decisions that need clarification
```

### Step 2: Review Checklist Execution

**Functionality Review**:
- [ ] Code implements the stated requirements
- [ ] Edge cases and error conditions are handled
- [ ] Business logic is correct and complete
- [ ] Integration with existing code works properly
- [ ] No obvious bugs or logical errors

**Readability and Maintainability**:
- [ ] Variable and function names are clear and descriptive
- [ ] Code structure is logical and easy to follow
- [ ] Comments explain complex logic and business rules
- [ ] Code follows team style and formatting standards
- [ ] Function and class sizes are reasonable

**Quality and Best Practices**:
- [ ] No code duplication or copy-paste programming
- [ ] Appropriate error handling and logging
- [ ] Security considerations addressed
- [ ] Performance implications considered
- [ ] Tests cover the new functionality

**Team and Learning**:
- [ ] Code demonstrates good practices others can learn from
- [ ] Consistent with existing codebase patterns
- [ ] Documentation updated if needed
- [ ] Breaking changes properly communicated

## Review Types and Approaches

### Quick Review (10-15 minutes)
Focus on:
- Obvious bugs or logical errors
- Security vulnerabilities
- Compliance with team standards
- Basic functionality verification

### Thorough Review (20-30 minutes)
Include everything from quick review plus:
- Design pattern appropriateness
- Performance implications
- Edge case handling
- Learning and teaching opportunities
- Suggestions for future improvements

### Mentoring Review (30+ minutes)
Include everything from thorough review plus:
- Detailed explanations of suggestions
- Alternative implementation approaches
- Links to relevant documentation or examples
- Discussion of trade-offs and design decisions

## Constructive Feedback Framework

### Positive Feedback Patterns
- "Great approach to handling [specific scenario]"
- "This makes the code much more readable because..."
- "I learned something new from this implementation"
- "Nice use of [pattern/technique] here"

### Improvement Suggestions
- "Consider [alternative approach] because [reason]"
- "This might be clearer if [specific suggestion]"
- "What do you think about [suggestion]? I'm wondering if..."
- "Could we add [safety check/error handling] for [scenario]?"

### Question Patterns
- "Can you help me understand why [design decision]?"
- "What happens if [edge case scenario]?"
- "Did you consider [alternative approach]? What were the trade-offs?"
- "How does this interact with [existing system component]?"

## Implementation Guide

### Pre-Review Preparation

**Understand Context** (5 minutes):
- Read PR description and linked issues
- Understand what problem is being solved
- Check if this is part of larger feature
- Note any special requirements or constraints

**Set Review Goals**:
- Determine appropriate review depth
- Identify learning opportunities
- Consider author's experience level
- Plan feedback approach

### During Review Process

**First Pass - Big Picture** (10 minutes):
- Overall approach and design
- Major structural issues
- Completeness of implementation
- Integration with existing code

**Second Pass - Details** (15 minutes):
- Line-by-line logic review
- Variable names and code clarity
- Error handling and edge cases
- Performance and security considerations

**Final Pass - Learning** (5 minutes):
- Identify teaching moments
- Note positive patterns to highlight
- Consider broader team learning
- Draft constructive summary

### Post-Review Follow-up

**Discussion and Collaboration**:
- Respond promptly to author questions
- Clarify feedback when requested
- Be open to alternative solutions
- Re-review changes when updated

**Knowledge Sharing**:
- Share interesting patterns with team
- Document common issues for future reference
- Update team guidelines based on learnings
- Celebrate good practices publicly

## Success Metrics

**Review Quality Indicators**:
- Fewer bugs reach production
- Consistent code quality across team
- Authors learn from review feedback
- Reviews completed within reasonable time

**Team Learning Signs**:
- Repeated issues decrease over time
- Authors anticipate common feedback
- Team practices improve through review discussions
- Knowledge spreads effectively across team

**Collaboration Health**:
- Reviews feel supportive, not critical
- Authors appreciate and act on feedback
- Reviewers learn from code they review
- Team communication improves

## Common Review Pitfalls

**Nitpicking**: Focus on significant issues, not minor style preferences
**Overwhelming**: Provide actionable feedback, not exhaustive lists
**Negative tone**: Balance criticism with positive observations
**Inconsistency**: Apply standards fairly across all team members

## Integration with Development Workflow

**Pull Request Process**:
- Use this checklist for all PR reviews
- Require checklist completion before approval
- Include AI analysis in review comments
- Document patterns for team learning

**Team Practices**:
- Share review templates across team
- Discuss review quality in retrospectives
- Update checklist based on common issues
- Train new team members on review practices

## Advanced Variations

Once comfortable with basic reviews:
- "Security-Focused Review Checklist" for security-critical code
- "Performance Review Guidelines" for optimization-focused reviews
- "Architecture Review Framework" for design discussions
- "Cross-Team Review Coordination" for large-scale changes

This template establishes consistent, constructive code review practices that improve code quality while fostering team learning and collaboration.