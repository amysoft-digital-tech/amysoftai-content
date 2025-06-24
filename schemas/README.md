# Content Schema Documentation

This directory contains validation schemas and formatting standards for the Beyond the AI Plateau content repository. These schemas ensure consistency, quality, and integration compatibility across all content types.

## Schema Categories

### Content Validation (`content-validation/`)
Schemas for validating the structure and metadata of different content types including chapters, templates, case studies, and documentation.

### Metadata (`metadata/`)
Standardized metadata schemas for content tagging, categorization, and Progressive Web Application integration requirements.

### Template Formats (`template-formats/`)
Formatting standards and validation rules for prompt templates, ensuring consistency and effectiveness across the template library.

## Schema Usage

### Content Development
All content must validate against the appropriate schema before merge approval. Use the validation scripts in `scripts/content-processing/` to verify compliance.

### Integration Requirements
Schemas define the requirements for PWA integration, including metadata fields needed for offline accessibility and progressive loading.

### Quality Assurance
Automated validation workflows use these schemas to ensure content quality and consistency standards are maintained across all contributions.

## Schema Files

### Chapter Content Schema
- **File**: `content-validation/chapter-schema.json`
- **Purpose**: Validates chapter structure, frontmatter, and content requirements
- **Usage**: All content in `content/principles/` directories

### Template Schema
- **File**: `template-formats/template-schema.json`
- **Purpose**: Validates prompt template structure and formatting
- **Usage**: All files in `content/templates/` directories

### Metadata Schema
- **File**: `metadata/content-metadata-schema.json`
- **Purpose**: Standardizes frontmatter metadata across all content types
- **Usage**: All markdown content files

### Case Study Schema
- **File**: `content-validation/case-study-schema.json`
- **Purpose**: Validates case study structure and metrics documentation
- **Usage**: All content in `content/case-studies/` directory

## Validation Commands

```bash
# Validate all content against schemas
./scripts/content-processing/validate-all-content.sh

# Validate specific content type
./scripts/content-processing/validate-chapters.sh
./scripts/content-processing/validate-templates.sh
./scripts/content-processing/validate-metadata.sh

# Validate individual file
./scripts/content-processing/validate-file.sh path/to/content.md
```

## Schema Development

When updating schemas:
1. Update the relevant JSON schema file
2. Update validation scripts to match new requirements
3. Test against existing content to ensure backward compatibility
4. Document changes in schema changelog
5. Update content guidelines in CONTRIBUTING.md

## Integration Standards

### PWA Requirements
Content must include metadata fields required for Progressive Web Application functionality:
- Offline accessibility markers
- Content categorization for progressive loading
- Interactive element specifications
- Performance optimization flags

### Accessibility Compliance
Schemas enforce WCAG 2.1 AA compliance requirements:
- Alternative text for all visual elements
- Semantic markup structure validation
- Color contrast requirement documentation
- Keyboard navigation compatibility

## Quality Metrics

### Content Validation Coverage
- Chapter content: 100% schema validation required
- Prompt templates: 100% format validation required
- Case studies: 100% metrics validation required
- Documentation: 95% format compliance required

### Schema Maintenance
- Monthly review of schema effectiveness
- Quarterly updates based on content development feedback
- Annual comprehensive review for integration requirements
- Continuous monitoring of validation failure patterns

For detailed schema specifications, see individual JSON schema files in the respective subdirectories.