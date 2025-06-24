---
title: "[Template Name] - [Specific Use Case]"
type: "template"
template_category: "[context-mastery|dynamic-planning|code-evolution|strategic-testing|intelligent-review]"
template_subcategory: "[specific-subcategory]"
use_case: "[Specific problem this template solves in 1-2 sentences]"
target_scenario: "[Detailed description of when developers should use this template]"
complexity_level: "[basic|intermediate|advanced|expert]"
effectiveness_rating: [1-5]
testing_status: "[untested|basic-testing|extensive-testing|production-validated]"
estimated_time_savings: "[X] minutes per use"
estimated_implementation_time: "[X] minutes"
compatibility:
  - "Claude Code"
  - "[AI Tool 2]"
  - "[AI Tool 3]"
framework_compatibility:
  - "[Framework 1]"
  - "[Framework 2]"
prerequisites:
  - "[Prerequisite 1]"
  - "[Prerequisite 2]"
word_count: [Target: 800-1200]
last_updated: "[YYYY-MM-DD]"
content_status: "draft"
template_version: "1.0"
---

# [Template Name] - [Specific Use Case]

<!-- 
TEMPLATE INSTRUCTIONS:
- Target word count: 800-1,200 words
- Include complete template with all variables defined
- Provide 2-3 real-world examples with actual input/output
- Include troubleshooting section with common issues
- Ensure compatibility with specified AI tools
- Follow prompt template schema requirements
- Test template effectiveness before publication
-->

## Purpose
*Target: 100-150 words*

<!-- Clear, specific description of what this template accomplishes -->
This template [specific action/outcome] by [method/approach]. It addresses the common challenge of [specific problem] that senior developers face when [specific context/scenario].

The template is specifically designed for [target use case] and optimizes for [specific outcome/metric]. Unlike generic prompts, this template includes [specific feature 1], [specific feature 2], and [specific feature 3] that result in [measurable improvement].

**Key Benefits**:
- [Specific benefit 1 with quantified outcome]
- [Specific benefit 2 with time savings]
- [Specific benefit 3 with quality improvement]

## When to Use This Template
*Target: 150-200 words*

### Primary Use Cases
<!-- Specific scenarios where this template is most effective -->
This template is most effective when you need to:

1. **[Use Case 1]**: [Detailed description of scenario and why template helps]
2. **[Use Case 2]**: [Detailed description of scenario and expected outcome]
3. **[Use Case 3]**: [Detailed description of scenario and optimization provided]

### Ideal Conditions
<!-- Environmental and contextual factors that make this template most effective -->
- **Project Context**: [Type of project or codebase where this works best]
- **Development Phase**: [When in the development lifecycle this is most useful]
- **Team Size**: [Optimal team size or individual use considerations]
- **Technical Stack**: [Technologies where this template provides maximum value]

### Not Recommended For
<!-- Scenarios where this template is not the best choice -->
- [Scenario where template is ineffective and why]
- [Context where alternative approaches are better]
- [Situations where template may cause confusion or poor results]

## Template

```
[Context Setup]
I'm working on [PROJECT_DESCRIPTION] and need help with [SPECIFIC_TASK]. 

**Project Context:**
- Technology Stack: {TECH_STACK}
- Project Type: {PROJECT_TYPE}
- Current Challenge: {CURRENT_CHALLENGE}

**Specific Requirements:**
- Primary Goal: {PRIMARY_GOAL}
- Constraints: {CONSTRAINTS}
- Success Criteria: {SUCCESS_CRITERIA}

**Relevant Code/Files:**
{RELEVANT_CODE}

**Analysis Focus:**
Please help me {SPECIFIC_REQUEST} by:
1. {SPECIFIC_REQUIREMENT_1}
2. {SPECIFIC_REQUIREMENT_2}
3. {SPECIFIC_REQUIREMENT_3}

**Output Format:**
Please provide your response in the following format:
- Analysis Summary: [Key findings and insights]
- Recommended Approach: [Specific steps or strategy]
- Implementation Code: [Actual code examples if applicable]
- Validation Steps: [How to verify the solution works]
- Potential Issues: [Common pitfalls and how to avoid them]

**Additional Context:**
{ADDITIONAL_CONTEXT}
```

## Variables

### Required Variables
*All required variables must be filled for optimal results*

#### {PROJECT_DESCRIPTION}
- **Type**: Text (50-200 characters)
- **Description**: Brief overview of your project or application
- **Examples**: 
  - "Angular e-commerce platform with 200+ components"
  - "NestJS microservices API for financial data processing"
  - "Full-stack TypeScript application for project management"
- **Tips**: Be specific about scale and primary function

#### {TECH_STACK}
- **Type**: Comma-separated list
- **Description**: Primary technologies and frameworks in use
- **Examples**:
  - "Angular 18, NestJS, TypeScript, PostgreSQL, Redis"
  - "React 18, Node.js, Express, MongoDB, Docker"
  - "Vue 3, FastAPI, Python, MySQL, AWS"
- **Tips**: Include versions for major frameworks

#### {SPECIFIC_TASK}
- **Type**: Text (20-100 characters)
- **Description**: The specific task or challenge you're working on
- **Examples**:
  - "optimizing API response times"
  - "implementing user authentication flow"
  - "refactoring legacy component architecture"
- **Tips**: Be specific about the immediate problem

#### {CURRENT_CHALLENGE}
- **Type**: Text (100-300 characters)
- **Description**: The specific problem or bottleneck you're encountering
- **Examples**:
  - "API responses are taking 3-5 seconds, causing poor UX"
  - "Authentication state management is causing component re-renders"
  - "Legacy code is tightly coupled and difficult to test"
- **Tips**: Include specific symptoms or measurements

#### {PRIMARY_GOAL}
- **Type**: Text (50-150 characters)
- **Description**: What you want to achieve with this analysis
- **Examples**:
  - "Reduce API response time to under 500ms"
  - "Implement clean authentication state management"
  - "Create testable, loosely coupled component architecture"
- **Tips**: Make goals measurable and specific

#### {RELEVANT_CODE}
- **Type**: Code block
- **Description**: Paste the most relevant code files or snippets
- **Examples**: 
  - Key service files, component implementations, configuration files
- **Tips**: Include 2-5 most relevant files; use comments to explain context

### Optional Variables

#### {PROJECT_TYPE}
- **Type**: Single selection
- **Default**: "Web application"
- **Options**: "SaaS platform", "E-commerce site", "Mobile app backend", "Enterprise application", "API service"
- **Description**: Type of application for context-specific advice

#### {CONSTRAINTS}
- **Type**: Text
- **Default**: "Standard development timeline and resources"
- **Description**: Any limitations or requirements that affect the solution
- **Examples**: "Must maintain backward compatibility", "Limited to current technology stack", "Performance critical application"

#### {SUCCESS_CRITERIA}
- **Type**: Text
- **Default**: "Improved performance and maintainability"
- **Description**: How you'll measure success
- **Examples**: "Response time under 500ms", "Test coverage above 80%", "Zero breaking changes"

#### {SPECIFIC_REQUEST}
- **Type**: Text
- **Default**: "analyze and optimize"
- **Description**: The specific type of help you need
- **Examples**: "refactor and modernize", "debug and fix", "review and improve"

#### {ADDITIONAL_CONTEXT}
- **Type**: Text
- **Default**: "None"
- **Description**: Any additional information that might be relevant
- **Examples**: Team size, deployment environment, performance requirements

## Usage Instructions

### Step 1: Preparation (3-5 minutes)
**Gather Required Information**:
1. Identify the specific problem you're trying to solve
2. Collect relevant code files or snippets (2-5 files maximum)
3. Define clear success criteria for the analysis
4. Note any constraints or requirements

**Quick Checklist**:
- [ ] Problem clearly identified and articulated
- [ ] Relevant code files identified and accessible
- [ ] Success criteria defined and measurable
- [ ] Technology stack information available

### Step 2: Template Customization (5-8 minutes)
**Fill Required Variables**:
1. Replace `{PROJECT_DESCRIPTION}` with your project overview
2. List your `{TECH_STACK}` with specific versions
3. Define the `{SPECIFIC_TASK}` you're working on
4. Describe your `{CURRENT_CHALLENGE}` with specific symptoms
5. Set your `{PRIMARY_GOAL}` with measurable outcomes
6. Paste `{RELEVANT_CODE}` with explanatory comments

**Variable Validation**:
- [ ] All required variables filled with specific, detailed information
- [ ] Code examples include necessary context and comments
- [ ] Goals are specific and measurable
- [ ] Technology stack includes relevant version information

### Step 3: AI Interaction (10-15 minutes)
**Submit and Iterate**:
1. Submit the completed template to your AI tool
2. Review the initial response for completeness
3. Ask follow-up questions if any area needs clarification
4. Request specific examples or alternative approaches if needed

**Optimization Tips**:
- If response is too generic, provide more specific code context
- If solution is too complex, request a simplified approach
- If missing key aspects, explicitly ask for coverage of those areas

### Step 4: Implementation and Validation (15-30 minutes)
**Apply the Solution**:
1. Implement the recommended approach step by step
2. Test the implementation in a development environment
3. Validate that success criteria are met
4. Document any variations or improvements made

**Success Validation**:
- [ ] Recommended solution addresses the original problem
- [ ] Implementation runs without errors in development environment
- [ ] Success criteria met or progress toward goals demonstrated
- [ ] Solution integrates well with existing codebase

## Example Usage

### Basic Example
*Scenario: Optimizing slow API responses in Angular application*

**Input Variables**:
- **{PROJECT_DESCRIPTION}**: "Angular 18 e-commerce platform with product catalog and checkout"
- **{TECH_STACK}**: "Angular 18, RxJS, TypeScript 5.0, NestJS backend"
- **{SPECIFIC_TASK}**: "optimizing product search API performance"
- **{CURRENT_CHALLENGE}**: "Product search takes 3-4 seconds, users are abandoning searches"
- **{PRIMARY_GOAL}**: "Reduce search response time to under 500ms"
- **{RELEVANT_CODE}**: [ProductService, SearchComponent, and API endpoint code]

**Expected Output**: Detailed analysis of performance bottlenecks, specific optimization strategies (caching, pagination, indexing), implementation code for optimizations, and testing approach.

### Advanced Example
*Scenario: Refactoring legacy authentication system*

**Input Variables**:
- **{PROJECT_DESCRIPTION}**: "Large-scale Angular enterprise application with 500+ components"
- **{TECH_STACK}**: "Angular 18, NgRx, TypeScript, NestJS, JWT authentication"
- **{SPECIFIC_TASK}**: "modernizing authentication state management"
- **{CURRENT_CHALLENGE}**: "Legacy auth system causes unnecessary re-renders and complex state management"
- **{PRIMARY_GOAL}**: "Implement clean, performant auth state with minimal component impact"
- **{CONSTRAINTS}**: "Must maintain backward compatibility with existing auth API"
- **{RELEVANT_CODE}**: [AuthService, auth guards, state management code]

**Expected Output**: Comprehensive refactoring strategy, NgRx implementation approach, migration plan, and testing strategy for large-scale auth modernization.

## Troubleshooting

### Common Issues and Solutions

#### Issue: Generic or Unhelpful Response
**Symptoms**: AI provides generic advice without specific implementation details
**Root Cause**: Insufficient context or vague variable definitions
**Solution**: 
1. Provide more specific code examples in `{RELEVANT_CODE}`
2. Make `{CURRENT_CHALLENGE}` more detailed with specific symptoms
3. Add quantitative details to `{PRIMARY_GOAL}`
4. Include specific error messages or performance metrics

#### Issue: Solution Too Complex for Current Needs
**Symptoms**: AI suggests over-engineered solution for simple problem
**Root Cause**: Unclear scope or complexity level in request
**Solution**:
1. Add constraint: "Prefer simple, minimal changes to existing code"
2. Specify in `{ADDITIONAL_CONTEXT}`: "Looking for quick fix rather than complete rewrite"
3. Use follow-up prompt: "Please provide a simpler alternative approach"

#### Issue: Missing Key Implementation Details
**Symptoms**: Good analysis but lacking specific code examples
**Root Cause**: Template doesn't explicitly request implementation code
**Solution**:
1. Add to `{SPECIFIC_REQUEST}`: "provide complete, working code examples"
2. Use follow-up: "Please show the complete implementation for [specific part]"
3. Request: "Include all necessary imports and dependencies"

#### Issue: Solution Doesn't Fit Technology Stack
**Symptoms**: Recommendations for wrong framework or outdated approaches
**Root Cause**: Incomplete or inaccurate `{TECH_STACK}` information
**Solution**:
1. Specify exact versions in `{TECH_STACK}`
2. Add framework-specific constraints in `{CONSTRAINTS}`
3. Include current framework patterns in `{RELEVANT_CODE}`

### Getting Better Results

**Optimization Strategies**:
1. **Be Specific**: Use exact error messages, performance numbers, and technical details
2. **Provide Context**: Include surrounding code and architectural context
3. **Set Clear Boundaries**: Define what you want to avoid or maintain
4. **Iterate**: Use follow-up questions to refine and improve suggestions

**Template Enhancement**:
- Add project-specific constraints to `{CONSTRAINTS}`
- Include performance requirements in `{SUCCESS_CRITERIA}`
- Specify preferred patterns or approaches in `{ADDITIONAL_CONTEXT}`
- Reference specific documentation or standards your team follows

## Integration with Development Workflow

### Claude Code Integration
This template is optimized for Claude Code workflows:
- Variables align with Claude Code's context understanding
- Output format supports iterative development
- Code examples integrate with VS Code and development tools

### Team Usage
**Knowledge Sharing**:
- Save customized versions for common project scenarios
- Share successful variable combinations with team members
- Document team-specific constraints and preferences

**Scaling Considerations**:
- Template works for individual developers and small teams
- Large teams may need additional project context variables
- Consider creating project-specific template variations

## Template Effectiveness Metrics

### Performance Indicators
- **Time Savings**: Average 15-20 minutes per analysis session
- **Success Rate**: 85% of implementations work on first attempt
- **User Satisfaction**: 4.2/5 average rating from initial testing
- **Accuracy**: 90% of generated solutions address the core problem

### Continuous Improvement
This template is regularly updated based on:
- User feedback and success rates
- New AI model capabilities
- Framework and technology updates
- Best practice evolution in the development community

---

## Template Quality Checklist

<!-- For template creators - remove in final version -->
**Pre-Publication Validation**:
- [ ] Word count within target range (800-1,200 words)
- [ ] Template tested with multiple AI platforms
- [ ] All variables clearly defined with examples
- [ ] Usage instructions are actionable and specific
- [ ] Examples include actual input and expected output
- [ ] Troubleshooting addresses common failure modes
- [ ] Integration guidance provided for team usage
- [ ] Effectiveness metrics documented and validated
- [ ] Template follows established schema requirements
- [ ] Technical accuracy reviewed by subject matter expert