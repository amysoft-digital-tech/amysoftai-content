# Contributing to Beyond the AI Plateau Content Repository

Thank you for contributing to the Beyond the AI Plateau project. This guide outlines the workflow, standards, and procedures for content development and collaboration.

## Table of Contents

- [Getting Started](#getting-started)
- [Content Development Workflow](#content-development-workflow)
- [Content Standards](#content-standards)
- [GitHub Workflow](#github-workflow)
- [Quality Assurance](#quality-assurance)
- [Review Process](#review-process)

## Getting Started

### Prerequisites

Before contributing, ensure you have:
- GitHub CLI installed and configured
- Git with proper user configuration
- Access to the amysoft-digital-tech/amysoftai-content repository
- Text editor with markdown support and syntax highlighting

### Repository Setup

```bash
# Clone repository
gh repo clone amysoft-digital-tech/amysoftai-content
cd amysoftai-content

# Configure Git
git config user.name "Your Name"
git config user.email "your.email@domain.com"

# Verify access
gh auth status
gh repo view amysoft-digital-tech/amysoftai-content
```

### Understanding the Project Structure

Familiarize yourself with the repository structure and content architecture before beginning work. Review the main README.md and CLAUDE.md for comprehensive project context and requirements.

## Content Development Workflow

### 1. Issue Assignment and Planning

Before starting work:
- Check existing issues for your assigned tasks
- Create new issues for untracked work using appropriate templates
- Assign yourself to relevant issues
- Add appropriate labels and milestone assignments

```bash
# View assigned issues
gh issue list --assignee @me --state open

# Create new content issue
gh issue create --title "Complete Chapter X: Title" \
  --body-file .github/ISSUE_TEMPLATE/content-creation.md \
  --label "foundation,chX,writing,high" \
  --milestone "foundation-content-complete" \
  --assignee @me
```

### 2. Branch Creation and Naming

Create feature branches for all content development:

```bash
# Branch naming convention: feature/<content-type>-<specific-identifier>
git checkout -b feature/ch3-context-mastery-content
git push -u origin feature/ch3-context-mastery-content
```

**Branch Naming Patterns:**
- Chapter content: `feature/ch##-chapter-name-content`
- Templates: `feature/templates-principle-category`
- Documentation: `feature/docs-specific-documentation`
- Assets: `feature/assets-visual-components`

### 3. Content Development Process

#### For Chapter Content:
1. Review chapter outline and acceptance criteria
2. Research existing related content for consistency
3. Create content following established templates
4. Include required frontmatter metadata
5. Validate technical accuracy of all examples
6. Test prompt templates in real scenarios

#### For Prompt Templates:
1. Define specific use case and context
2. Create template with clear variable placeholders
3. Include usage instructions and examples
4. Test template effectiveness in development scenarios
5. Document expected outcomes and success metrics

#### For Visual Assets:
1. Follow accessibility guidelines (WCAG 2.1 AA)
2. Use SVG format for diagrams when possible
3. Optimize file sizes for web delivery
4. Include alternative text descriptions
5. Validate across different screen sizes

### 4. Commit Standards

Follow conventional commit format with descriptive messages:

```bash
# Commit message format
git commit -m "type(scope): description

- Detailed change description
- Additional context or reasoning
- Reference to issues or requirements

Resolves: #123
Word count: X,XXX words
Technical review: [Status]"
```

**Commit Types:**
- `feat`: New content or features
- `fix`: Content corrections or bug fixes
- `docs`: Documentation updates
- `style`: Formatting changes
- `refactor`: Content restructuring
- `test`: Template testing and validation
- `chore`: Maintenance tasks

### 5. Pull Request Creation

Create comprehensive pull requests with detailed descriptions:

```bash
gh pr create --title "Complete Chapter X: Title" \
  --body "## Summary
Brief description of changes and additions

## Content Additions
- Detailed list of new content
- Word counts and scope coverage
- Technical components included

## Quality Assurance
- [x] Word count targets met
- [x] Technical accuracy verified
- [x] Prompt templates tested
- [x] Cross-references validated
- [x] Accessibility standards met

## Integration Requirements
- PWA integration readiness
- Metadata schema compliance
- Interactive element specifications

Closes #123" \
  --reviewer @technical-reviewer,@content-lead \
  --label "foundation,chX,ready-for-review"
```

## Content Standards

### Writing Style Guidelines

**Tone and Voice:**
- Professional yet engaging for senior developers
- Technical accuracy takes priority over marketing appeal
- Avoid overly casual language while maintaining accessibility
- Focus on practical implementation and real-world application

**Structure Requirements:**
- Use semantic header hierarchy (H1 for titles, H2 for sections)
- Include clear section transitions and logical flow
- Provide progressive examples from basic to advanced
- Include Quick Win sections for immediate implementation

### Technical Content Standards

**Code Examples:**
- All code must be tested and validated
- Include language specification for syntax highlighting
- Add context comments explaining implementation details
- Provide integration instructions for different environments
- Test across multiple development setups

**Prompt Templates:**
- Include clear context setup instructions
- Use descriptive variable placeholders
- Specify expected output formats
- Provide real-world usage examples
- Document effectiveness metrics where available

### Metadata Requirements

All content files must include frontmatter metadata:

```yaml
---
title: "Content Title"
type: "chapter|template|case-study|documentation"
tier: "foundation|advanced|elite"
chapter: 3
estimated_reading_time: "15 minutes"
prerequisites: ["Previous knowledge required"]
learning_objectives:
  - "Specific learning outcome"
  - "Practical skill development"
integration_requirements:
  - "PWA compatibility"
  - "Interactive elements"
word_count: 4200
last_updated: "2025-01-24"
technical_accuracy_review: "pending|completed"
content_status: "draft|review|final"
---
```

## GitHub Workflow

### Issue Management

**Issue Creation:**
```bash
# Content development issue
gh issue create --title "Descriptive Title" \
  --body-file .github/ISSUE_TEMPLATE/content-creation.md \
  --label "appropriate,labels" \
  --milestone "relevant-milestone" \
  --assignee @username

# Template development issue
gh issue create --title "Validate Template Category" \
  --body-file .github/ISSUE_TEMPLATE/prompt-template.md \
  --label "templates,category,validation"

# Technical review issue
gh issue create --title "Technical Review - Content Area" \
  --body-file .github/ISSUE_TEMPLATE/technical-review.md \
  --label "review,technical-accuracy"
```

**Issue Labels:**
- **Priority**: critical, high, medium, low
- **Content Type**: foundation, advanced, elite
- **Categories**: templates, diagrams, case-studies, interactive
- **Chapters**: ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8, ch9
- **Status**: writing, review, technical-accuracy, ready-for-integration

### Project Board Usage

Track work progress using the project board:
- Move issues through workflow columns
- Update progress status regularly
- Link related pull requests to issues
- Maintain milestone alignment

## Quality Assurance

### Automated Validation

Before submitting pull requests:

```bash
# Run content validation scripts
./scripts/content-processing/validate-content.sh

# Check technical accuracy
./scripts/template-testing/test-templates.sh

# Validate integration readiness
./scripts/integration/validate-pwa-ready.sh
```

### Manual Quality Checks

**Content Quality Checklist:**
- [ ] Word count targets met for content type
- [ ] Technical accuracy verified by subject matter expert
- [ ] Prompt templates tested in real development scenarios
- [ ] Code examples validated across multiple environments
- [ ] Cross-references verified and updated
- [ ] Accessibility standards met (WCAG 2.1 AA)
- [ ] Metadata schema compliance verified
- [ ] Integration requirements documented

**Technical Validation:**
- [ ] All code examples execute without errors
- [ ] Prompt templates produce expected results
- [ ] Technical concepts align with current best practices
- [ ] Tool and framework versions are current
- [ ] Security best practices followed

### Performance Considerations

- Optimize content for Progressive Web Application delivery
- Ensure offline accessibility where applicable
- Validate loading performance for content sections
- Test responsive design across device sizes
- Verify caching strategies for updated content

## Review Process

### Review Requirements

All content requires review approval from:
- **Technical Reviewer**: Validates technical accuracy and implementation feasibility
- **Content Lead**: Ensures quality standards and educational effectiveness
- **Subject Matter Expert**: Verifies advanced technical concepts where applicable

### Review Timeline

- **Initial Review**: Within 2 business days of PR submission
- **Technical Review**: Within 3 business days for complex technical content
- **Final Approval**: Within 1 business day after all feedback addressed
- **Merge Timeline**: Same day as final approval for critical path items

### Review Feedback Process

```bash
# Request specific reviewer
gh pr review 45 --request-changes --body "Specific feedback with actionable items:
1. Technical accuracy issue in section X
2. Code example needs error handling
3. Cross-reference link needs updating"

# Approve with feedback
gh pr review 45 --approve --body "Technical accuracy verified. Content meets quality standards. Suggested enhancement: consider adding advanced example in section Y."

# Re-request review after changes
gh pr ready 45 --comment "All feedback addressed. Ready for final review."
```

### Merge Requirements

Pull requests can be merged when:
- All automated checks pass
- Technical accuracy review completed
- Content quality standards met
- Integration requirements satisfied
- No conflicting changes with main branch

```bash
# Merge approved pull request
gh pr merge 45 --squash --body "Merge Chapter X: Content Title

Quality assurance complete:
- Technical accuracy verified
- Content standards exceeded
- Integration requirements met
- Contributor guidelines followed"
```

## Best Practices

### Content Development
- Start with outline and acceptance criteria review
- Research existing content for consistency and cross-references
- Test all technical examples in real development environments
- Validate prompt templates with actual development workflows
- Include progressive difficulty in examples and exercises

### Collaboration
- Communicate early about potential conflicts or dependencies
- Use issue comments for status updates and questions
- Request help early when encountering technical roadblocks
- Share effective prompt templates with the team
- Document lessons learned for future contributors

### Version Control
- Commit frequently with descriptive messages
- Keep feature branches focused on single content areas
- Rebase branches to maintain clean commit history
- Tag significant content milestones
- Use semantic versioning for major content releases

## Getting Help

### Resources
- Review CLAUDE.md for comprehensive project context
- Check existing issues for similar questions or problems
- Reference established content for formatting and style examples
- Use project documentation for technical specifications

### Support Channels
- Create issues for technical questions or clarification
- Tag appropriate reviewers for urgent questions
- Use pull request comments for review-specific discussions
- Contact project maintainers for workflow questions

### Common Issues
- **Technical Accuracy Questions**: Tag @technical-reviewer
- **Content Strategy Questions**: Tag @content-lead
- **Integration Requirements**: Tag @pwa-integration-lead
- **Process Questions**: Create issue with "question" label

---

By following these guidelines, you contribute to maintaining high-quality content that serves senior developers seeking to overcome AI productivity plateaus. Your attention to detail and commitment to technical accuracy directly impacts the project's success and learner outcomes.