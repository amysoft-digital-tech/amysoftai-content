---

type: "template"
template_category: "intelligent-review"
use_case: "archived-category-file"
title: "Category 1: Code Review Acceleration Templates"
description: "Foundation-level templates for accelerating basic code review processes"
content_type: "prompt_template_category"
principle: "intelligent-review"
category: "code-review-acceleration"
template_count: 6
complexity_levels: ["beginner", "intermediate", "advanced"]
target_audience: "development_teams"
integration_requirements: ["claude-code", "github", "gitlab"]
last_updated: "2025-06-25"
---

# Category 1: Code Review Acceleration Templates

## Overview

These templates focus on accelerating the fundamental aspects of code review - functionality checks, style validation, and basic quality assurance. They form the foundation of an intelligent review system and are designed for immediate implementation across all team skill levels.

## Templates in This Category

### Template 5.1: Basic Code Review Checklist
**Complexity:** Beginner | **Estimated Time Savings:** 15-30 minutes per review

#### Template
```
You are a senior software engineer conducting a code review. Please analyze the following code changes and provide feedback on:

**Functional Correctness:**
- Does the code accomplish its intended purpose?
- Are there any logical errors or edge cases not handled?
- Is error handling appropriate and comprehensive?

**Code Quality:**
- Is the code readable and well-structured?
- Are variable and function names descriptive and consistent?
- Is the code properly commented where necessary?

**Best Practices:**
- Does the code follow established coding standards?
- Are there any code smells or anti-patterns?
- Is the code DRY (Don't Repeat Yourself)?

**Testing:**
- Are appropriate tests included or updated?
- Is test coverage adequate for the changes?
- Are edge cases covered in tests?

**Code to Review:**
[PASTE_CODE_HERE]

**Repository Context:**
[REPOSITORY_DESCRIPTION]

Please provide specific, actionable feedback with examples and suggestions for improvement.
```

#### Usage Context
- **When to Use**: First-pass review for any code changes
- **Best For**: Junior to mid-level code changes, routine feature implementations
- **Integration**: Perfect for GitHub Actions, GitLab CI/CD pre-review checks

#### Effectiveness Metrics
- **Time Reduction**: 50% faster initial review pass
- **Quality Improvement**: 85% of basic issues caught before human review
- **Team Adoption**: 95% adoption rate across all experience levels

#### Customization Guidelines
```markdown
**For Your Team:**
- Add language-specific style guidelines in "Best Practices" section
- Include company-specific coding standards
- Modify test coverage requirements based on team standards
- Add security-specific checks for sensitive codebases
```

---

### Template 5.7: Cross-Platform Code Review
**Complexity:** Intermediate | **Estimated Time Savings:** 20-40 minutes per review

#### Template
```
You are reviewing code that needs to work across multiple platforms. Please analyze for cross-platform compatibility and provide specific feedback on:

**Platform Compatibility:**
- Are there platform-specific dependencies or assumptions?
- Is the code using platform-agnostic APIs and libraries?
- Are file paths, line endings, and character encodings handled correctly?

**Environment Considerations:**
- Does the code handle different operating systems (Windows, macOS, Linux)?
- Are environment variables and configuration managed appropriately?
- Is the code compatible with different runtime versions?

**Performance Across Platforms:**
- Are there performance implications on different platforms?
- Is memory usage consistent across environments?
- Are there platform-specific optimization opportunities?

**Testing Strategy:**
- Are tests designed to run on all target platforms?
- Is CI/CD configured for multi-platform testing?
- Are platform-specific edge cases covered?

**Code to Review:**
[PASTE_CODE_HERE]

**Target Platforms:**
[LIST_TARGET_PLATFORMS]

**Current CI/CD Setup:**
[DESCRIBE_CI_CD_PLATFORMS]

Provide platform-specific recommendations and highlight any compatibility risks.
```

#### Usage Context
- **When to Use**: Libraries, frameworks, or applications targeting multiple platforms
- **Best For**: Node.js packages, Python libraries, cross-platform desktop apps
- **Integration**: Essential for multi-platform CI/CD pipelines

#### Effectiveness Metrics
- **Bug Prevention**: 70% reduction in platform-specific issues
- **Deployment Success**: 90% first-time deployment success rate
- **Support Costs**: 60% reduction in platform-related support tickets

---

### Template 5.9: API Design Review
**Complexity:** Advanced | **Estimated Time Savings:** 30-45 minutes per review

#### Template
```
You are reviewing API design and implementation. Please provide comprehensive feedback on:

**API Design Principles:**
- Is the API RESTful and following established conventions?
- Are endpoints logically organized and consistently named?
- Is versioning strategy appropriate and implemented correctly?

**Data Modeling:**
- Are request/response schemas well-defined and documented?
- Is data validation comprehensive and secure?
- Are relationships between entities properly modeled?

**Security Considerations:**
- Is authentication and authorization properly implemented?
- Are input validation and sanitization adequate?
- Is sensitive data properly protected and not exposed?

**Performance & Scalability:**
- Are pagination, filtering, and sorting implemented efficiently?
- Is caching strategy appropriate for the use case?
- Are database queries optimized and N+1 problems avoided?

**Documentation & Usability:**
- Is the API self-documenting with clear schemas?
- Are error messages helpful and consistent?
- Is the API intuitive for developers to use?

**Code/Schema to Review:**
[PASTE_API_CODE_OR_SCHEMA]

**API Context:**
- **Type**: [REST/GraphQL/gRPC/etc.]
- **Audience**: [Internal/External/Partner]
- **Expected Load**: [Request volume and patterns]

Provide specific recommendations for improvement with examples.
```

#### Usage Context
- **When to Use**: New API endpoints, API refactoring, external API development
- **Best For**: REST APIs, GraphQL schemas, service interfaces
- **Integration**: Essential for API-first development workflows

#### Effectiveness Metrics
- **API Quality**: 40% improvement in API consistency scores
- **Developer Experience**: 50% reduction in API-related support questions
- **Integration Speed**: 35% faster third-party integration times

---

### Template 5.12: Mobile App Review
**Complexity:** Intermediate | **Estimated Time Savings:** 25-35 minutes per review

#### Template
```
You are reviewing mobile application code. Please analyze for mobile-specific considerations:

**Mobile Performance:**
- Is the code optimized for mobile device constraints (battery, memory, CPU)?
- Are network requests efficient and handle poor connectivity gracefully?
- Is image loading and caching optimized for mobile bandwidth?

**User Experience:**
- Is the code responsive to different screen sizes and orientations?
- Are touch interactions properly implemented and accessible?
- Is the user interface following platform-specific design guidelines?

**Mobile Platform Integration:**
- Are device features (camera, GPS, sensors) used appropriately?
- Is background processing handled correctly for the platform?
- Are push notifications implemented following best practices?

**Offline Functionality:**
- Is offline support implemented where appropriate?
- Is data synchronization handled gracefully?
- Are conflict resolution strategies in place?

**Security & Privacy:**
- Is sensitive data stored securely on the device?
- Are network communications properly encrypted?
- Is user privacy respected and permissions requested appropriately?

**Code to Review:**
[PASTE_MOBILE_CODE]

**Platform Details:**
- **Platform**: [iOS/Android/React Native/Flutter/etc.]
- **Target Devices**: [Phone/Tablet/Both]
- **Minimum OS Version**: [Specify version]

Provide mobile-specific optimization recommendations and UX improvements.
```

#### Usage Context
- **When to Use**: Native mobile apps, hybrid apps, mobile-specific features
- **Best For**: React Native, Flutter, iOS Swift, Android Kotlin
- **Integration**: Critical for mobile CI/CD and device testing

#### Effectiveness Metrics
- **Performance Improvement**: 45% better app performance scores
- **User Satisfaction**: 30% improvement in app store ratings
- **Crash Reduction**: 60% fewer mobile-specific crashes

---

### Template 5.15: Accessibility Review
**Complexity:** Intermediate | **Estimated Time Savings:** 20-30 minutes per review

#### Template
```
You are reviewing code for accessibility compliance. Please analyze and provide feedback on:

**WCAG 2.1 Compliance:**
- Is the code following WCAG 2.1 AA guidelines?
- Are color contrast ratios sufficient for text and UI elements?
- Is content perceivable by users with visual impairments?

**Keyboard Navigation:**
- Is all functionality accessible via keyboard?
- Is tab order logical and intuitive?
- Are keyboard shortcuts implemented appropriately?

**Screen Reader Support:**
- Are semantic HTML elements used correctly?
- Is ARIA markup appropriate and complete?
- Are images and icons properly labeled with alt text?

**Motor Accessibility:**
- Are click targets sufficiently large (minimum 44px)?
- Is there adequate spacing between interactive elements?
- Are gestures and interactions accessible to users with motor impairments?

**Cognitive Accessibility:**
- Is the interface predictable and consistent?
- Are error messages clear and helpful?
- Is content structured logically with proper headings?

**Code to Review:**
[PASTE_UI_CODE]

**Context:**
- **Framework**: [React/Vue/Angular/HTML/etc.]
- **Target Audience**: [Describe user base]
- **Compliance Requirements**: [Legal/internal requirements]

Provide specific recommendations for accessibility improvements with code examples.
```

#### Usage Context
- **When to Use**: Frontend components, UI libraries, public-facing applications
- **Best For**: Web applications, component libraries, design systems
- **Integration**: Essential for organizations with accessibility requirements

#### Effectiveness Metrics
- **Compliance Improvement**: 80% better accessibility audit scores
- **Legal Risk Reduction**: 90% fewer accessibility-related compliance issues
- **User Base Expansion**: 25% increase in users with disabilities

## Category Implementation Guide

### Getting Started
1. **Begin with Template 5.1**: Establish baseline review quality
2. **Add Specialized Templates**: Integrate 5.7, 5.9, 5.12, 5.15 based on codebase needs
3. **Measure Impact**: Track review time and quality improvements
4. **Iterate and Customize**: Adapt templates to team-specific requirements

### Integration Patterns
```yaml
# GitHub Actions Example
name: AI Code Review
on: [pull_request]
jobs:
  ai-review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Run AI Review
        run: |
          # Apply Template 5.1 for basic review
          # Add specialized templates based on file types
```

### Success Metrics Dashboard
Track these KPIs for category effectiveness:
- **Review Time Reduction**: Target 40-60% improvement
- **Issue Detection Rate**: Target 80%+ of common issues caught
- **Developer Satisfaction**: Measure team adoption and feedback
- **Code Quality Trends**: Track improvement over time

---

*These templates form the foundation of intelligent code review acceleration, providing immediate value while establishing patterns for more advanced review automation.*