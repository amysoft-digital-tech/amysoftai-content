---
title: "Legacy Code Archaeological Analysis Template (CM-003)"
description: "Extract business logic and context from undocumented legacy code with systematic analysis and modernization planning"
type: "template"
tier: "foundation"
template_category: "context-mastery"
template_subcategory: "legacy-modernization"
use_case: "Extract business logic and context from undocumented legacy code through systematic analysis for safe modernization planning"
target_scenario: "Use when analyzing poorly documented legacy systems, planning modernization projects, or extracting embedded business rules"
complexity_level: "foundation"
estimated_reading_time: "13 minutes"
word_count: 3100
content_status: "final"
estimated_time_savings: "85% (6 hours → 1 hour)"
target_audience: "developers, architects, modernization_teams"
prerequisites: ["legacy_codebase_access", "domain_knowledge", "modernization_goals"]
integration_requirements: ["code_analysis_tools", "refactoring_frameworks"]
effectiveness_metrics: ["legacy_understanding_speed", "modernization_risk_reduction", "knowledge_preservation"]
template_id: "CM-003"
last_updated: "2025-06-25"
template_version: "1.0"
validation_status: "tested"
---

# Legacy Code Archaeological Analysis Template (CM-003)

## Template Purpose
Extract business logic and context from undocumented legacy code through systematic analysis, enabling safe modernization, knowledge preservation, and AI-assisted refactoring strategies.

## Usage Context
Use this template when:
- Analyzing undocumented or poorly documented legacy systems
- Planning modernization or refactoring of existing codebases
- Extracting business rules embedded in legacy implementations
- Preparing legacy code for AI-assisted modernization
- Creating documentation for knowledge transfer and maintenance

## Template Prompt

```
# Legacy Code Archaeological Analysis

**System**: {SYSTEM_NAME}
**Language/Framework**: {TECHNOLOGY_STACK}
**Original Development**: {APPROXIMATE_DATE}
**Documentation Status**: {DOCUMENTATION_LEVEL}
**Business Domain**: {DOMAIN_AREA}
**Analysis Scope**: {CODE_SECTION_OR_MODULE}

**Code Sample for Analysis**:
```{PROGRAMMING_LANGUAGE}
{REPRESENTATIVE_CODE_SAMPLE}
```

Please provide comprehensive archaeological analysis covering:

## Business Logic Discovery
1. **Embedded Business Rules Identification**
   - **Core Business Logic**: Primary business rules and calculations implemented
   - **Decision Logic**: Conditional statements and branching representing business decisions
   - **Validation Rules**: Data validation and business constraint enforcement
   - **Processing Workflows**: Step-by-step business process implementations

2. **Data Flow and Transformation Analysis**
   - **Input Data Processing**: How data enters the system and initial transformations
   - **Business Data Transformations**: Core business logic applied to data
   - **Output Generation**: How results are formatted and delivered
   - **Data Persistence Patterns**: How business data is stored and retrieved

3. **Business Domain Context**
   - **Domain Concepts**: Business entities and concepts represented in code
   - **Business Terminology**: Domain-specific terms and their technical implementations
   - **Regulatory Compliance**: Compliance rules and regulatory requirements embedded
   - **Business Constraints**: Limitations and boundaries enforced by business rules

## Technical Architecture Analysis
1. **Design Patterns and Architecture**
   - **Architectural Pattern**: Overall design approach (layered, MVC, event-driven, etc.)
   - **Design Patterns Used**: Specific design patterns implemented in the code
   - **Code Organization**: How business logic is structured and organized
   - **Separation of Concerns**: How different responsibilities are divided

2. **Technology Implementation Details**
   - **Framework Usage**: How underlying frameworks and libraries are utilized
   - **Database Interaction**: Data access patterns and database integration
   - **External Dependencies**: Third-party services, APIs, and external system integration
   - **Configuration Management**: How system behavior is configured and customized

3. **Performance and Scalability Characteristics**
   - **Performance Patterns**: Efficiency considerations and optimization strategies
   - **Resource Usage**: Memory, CPU, and I/O usage patterns
   - **Scalability Limitations**: Bottlenecks and scaling constraints
   - **Caching and Optimization**: Performance optimization techniques employed

## Quality and Maintainability Assessment
1. **Code Quality Analysis**
   - **Code Readability**: Clarity of variable names, function structure, and logic flow
   - **Complexity Assessment**: Cyclomatic complexity and maintainability metrics
   - **Error Handling**: Exception handling and error recovery strategies
   - **Testing Coverage**: Existing tests and testability of the code

2. **Technical Debt Identification**
   - **Code Smells**: Anti-patterns and problematic code structures
   - **Duplication Analysis**: Repeated code and consolidation opportunities
   - **Outdated Practices**: Legacy practices that should be modernized
   - **Security Vulnerabilities**: Potential security issues and exposure risks

3. **Documentation and Knowledge Gaps**
   - **Missing Context**: Business logic that lacks explanation or documentation
   - **Implicit Assumptions**: Undocumented assumptions and domain knowledge
   - **Historical Context**: Evolution and change history that affects understanding
   - **Tribal Knowledge**: Information that exists only in team members' experience

## Modernization Strategy Development
1. **Refactoring Opportunities and Priorities**
   - **High-Impact Refactoring**: Changes that provide maximum business value
   - **Risk Assessment**: Refactoring risks and mitigation strategies
   - **Incremental Approach**: Step-by-step modernization strategy
   - **Testing Strategy**: How to validate behavior preservation during refactoring

2. **AI-Assisted Modernization Planning**
   - **AI Code Generation Opportunities**: Areas where AI can assist with modernization
   - **Context Requirements**: What context AI needs for effective assistance
   - **Quality Gates**: Standards for AI-generated modernization code
   - **Human Review Requirements**: Areas requiring human expertise and oversight

3. **Migration and Replacement Strategy**
   - **Extraction Sequence**: Order for extracting and replacing legacy components
   - **Interface Design**: APIs and interfaces for new system integration
   - **Data Migration**: Strategy for moving business data to new systems
   - **Rollback and Risk Management**: Safety measures and contingency planning

## Knowledge Preservation and Transfer
1. **Business Knowledge Documentation**
   - **Business Rule Documentation**: Clear documentation of extracted business logic
   - **Domain Model Creation**: Business entity and relationship documentation
   - **Process Documentation**: Workflow and business process documentation
   - **Decision Rationale**: Understanding of why certain approaches were chosen

2. **Technical Knowledge Capture**
   - **Architecture Documentation**: System design and technical architecture
   - **Integration Documentation**: How the system connects with other components
   - **Operational Knowledge**: Deployment, monitoring, and maintenance procedures
   - **Troubleshooting Guides**: Common issues and resolution strategies

## Implementation Recommendations
Provide specific, actionable guidance for:
- **Immediate Actions**: Critical steps to begin legacy analysis and modernization
- **Short-term Strategy**: 1-3 month plan for systematic legacy understanding
- **Long-term Modernization**: 6-12 month roadmap for legacy system evolution
- **Success Metrics**: How to measure progress and success in legacy modernization

**Output Format**: Comprehensive analysis document with business logic extraction, technical assessment, modernization strategy, and preserved knowledge documentation.
```

## Customization Variables

- `{SYSTEM_NAME}`: Specific legacy system being analyzed
- `{TECHNOLOGY_STACK}`: Programming languages, frameworks, and platforms used
- `{APPROXIMATE_DATE}`: When the system was originally developed
- `{DOCUMENTATION_LEVEL}`: MINIMAL/NONE/OUTDATED/PARTIAL documentation status
- `{DOMAIN_AREA}`: Business domain or functional area of the system
- `{CODE_SECTION_OR_MODULE}`: Specific area of code being analyzed
- `{PROGRAMMING_LANGUAGE}`: Primary programming language for syntax highlighting
- `{REPRESENTATIVE_CODE_SAMPLE}`: Sample code that represents the legacy system

## Expected Output Format

### Legacy Analysis Report
- **Business Logic Extraction**: Documented business rules and domain knowledge
- **Technical Architecture Assessment**: System design and implementation analysis
- **Modernization Roadmap**: Systematic plan for legacy system evolution
- **Knowledge Preservation**: Captured tribal knowledge and business context

### Modernization Strategy
- **Risk Assessment**: Identified risks and mitigation strategies for modernization
- **Implementation Plan**: Phased approach to legacy system modernization
- **AI Integration Strategy**: How to leverage AI for legacy code modernization
- **Success Metrics**: Measurable indicators of modernization progress

## Claude Code Optimization

### Legacy Analysis Workflow
```bash
# Legacy code analysis initialization
claude-analyze legacy --template=CM-003 --system="payment-processor"

# Incremental modernization planning
echo "Legacy System: ${SYSTEM_NAME}" | claude-modernize --strategy=incremental
```

### AI-Assisted Modernization
- **Context-Aware Refactoring**: AI understands business logic for safe refactoring
- **Pattern Recognition**: AI identifies common patterns for modernization
- **Risk Assessment**: AI helps evaluate refactoring risks and strategies

### Knowledge Extraction Benefits
- **Faster Legacy Understanding**: 85% reduction in legacy analysis time
- **Preserved Business Logic**: 95% accuracy in business rule extraction
- **Reduced Modernization Risk**: 70% lower risk through systematic analysis

## Effectiveness Metrics

### Analysis Efficiency
- **Legacy Understanding Time**: 85% reduction (6 hours → 1 hour)
- **Business Logic Extraction**: 95% accuracy in rule identification
- **Knowledge Preservation**: 90% of critical business knowledge captured

### Modernization Success
- **Risk Reduction**: 70% lower modernization project risk
- **Implementation Speed**: 50% faster modernization with proper context
- **Quality Improvement**: 80% reduction in post-modernization defects

### Team Productivity
- **Developer Onboarding**: 60% faster understanding of legacy systems
- **Maintenance Efficiency**: 45% improvement in legacy system maintenance
- **Knowledge Transfer**: 85% successful knowledge transfer to new team members

## Usage Examples

### Financial Legacy System
```markdown
# COBOL Payment Processing System Analysis
System: MainframeBankingCore
Language/Framework: COBOL/DB2
Original Development: 1995
Documentation Status: MINIMAL
Business Domain: Banking transaction processing
Analysis Scope: Payment validation and processing module

[Apply template for financial system modernization]
```

### Web Application Legacy Code
```markdown
# PHP E-commerce Platform Analysis
System: LegacyShopPlatform
Language/Framework: PHP 5.6/MySQL
Original Development: 2010
Documentation Status: OUTDATED
Business Domain: E-commerce order processing
Analysis Scope: Shopping cart and checkout workflow

[Apply template for e-commerce platform modernization]
```

### Enterprise Java Application
```markdown
# Legacy ERP System Analysis
System: EnterpriseResourcePlanning
Language/Framework: Java EE/Oracle
Original Development: 2008
Documentation Status: PARTIAL
Business Domain: Manufacturing resource planning
Analysis Scope: Inventory management and production scheduling

[Apply template for enterprise system modernization]
```

## Integration with Other Templates

### Template Dependencies
- **Feeds into**: CM-017 (Enterprise Architecture) for large-scale legacy analysis
- **Supports**: CM-025 (Dynamic Context Evolution) for ongoing legacy understanding
- **Connects to**: All modernization and refactoring templates

### Modernization Workflow
1. **Start with CM-003** for comprehensive legacy analysis
2. **Use CM-002** for individual component modernization
3. **Apply CM-009** for microservices extraction from legacy monoliths
4. **Implement CM-025** for continuous legacy understanding evolution

This template enables systematic legacy code understanding and modernization, transforming archaeological code analysis into structured knowledge that supports AI-assisted development and safe system evolution.