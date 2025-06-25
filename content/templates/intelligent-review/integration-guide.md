---
title: "Code Review Tools Integration Guide"
description: "Comprehensive guide for integrating intelligent review templates with GitHub, GitLab, Azure DevOps, and other code review platforms"
type: "integration_guide"
tier: "foundation"
estimated_reading_time: "25 minutes"
word_count: 5800
last_updated: "2025-06-25"
content_status: "complete"
template_category: "intelligent-review"
use_case: "tool-integration"
target_scenario: "development-workflow-optimization"
complexity_level: "intermediate"
effectiveness_metrics: ["integration_success_rate", "workflow_efficiency", "automation_adoption"]
estimated_time_savings: "70-85%"
prerequisites: ["code_review_tools", "ci_cd_knowledge", "automation_setup"]
---

# Code Review Tools Integration Guide

## Overview

This guide provides comprehensive instructions for integrating the Intelligent Review template library with popular code review platforms and development tools. The goal is to embed AI-powered review capabilities directly into existing workflows for seamless adoption and maximum efficiency gains.

## Usage Context

Use this integration guide when:
- Setting up automated AI code review workflows in GitHub, GitLab, or Azure DevOps
- Implementing intelligent template selection based on code changes and complexity
- Creating CI/CD pipeline integration for continuous review optimization
- Establishing cross-platform review automation and consistency
- Configuring team-specific review workflows and approval processes

## Supported Platforms

### Primary Integrations
- **GitHub** - Native pull request workflow enhancement
- **GitLab** - Merge request automation and CI integration
- **Azure DevOps** - Pull request policies and work item linking
- **Bitbucket** - Code review automation and approval workflows

### Secondary Integrations
- **Phabricator** - Differential review enhancement
- **Gerrit** - Change review automation
- **Crucible** - Review workflow optimization
- **Custom Platforms** - API-based integration patterns

## GitHub Integration

### GitHub Actions Workflow

Create automated review triggers using GitHub Actions:

```yaml
# .github/workflows/intelligent-review.yml
name: Intelligent Code Review

on:
  pull_request:
    types: [opened, synchronize, ready_for_review]

jobs:
  ai-review:
    runs-on: ubuntu-latest
    if: github.event.pull_request.draft == false
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v4
      with:
        fetch-depth: 0
        
    - name: Analyze PR complexity
      id: complexity
      run: |
        # Calculate complexity metrics
        CHANGED_FILES=$(git diff --name-only origin/${{ github.base_ref }}...HEAD | wc -l)
        CHANGED_LINES=$(git diff --stat origin/${{ github.base_ref }}...HEAD | tail -1 | grep -o '[0-9]\+ insertions\|[0-9]\+ deletions' | awk '{sum += $1} END {print sum}')
        
        if [ $CHANGED_LINES -gt 500 ] || [ $CHANGED_FILES -gt 20 ]; then
          echo "complexity=high" >> $GITHUB_OUTPUT
        elif [ $CHANGED_LINES -gt 100 ] || [ $CHANGED_FILES -gt 5 ]; then
          echo "complexity=medium" >> $GITHUB_OUTPUT
        else
          echo "complexity=low" >> $GITHUB_OUTPUT
        fi
        
        echo "changed_files=$CHANGED_FILES" >> $GITHUB_OUTPUT
        echo "changed_lines=$CHANGED_LINES" >> $GITHUB_OUTPUT

    - name: Determine review template
      id: template
      run: |
        TEMPLATE_CATEGORY="code-review-acceleration"
        
        # Analyze file types and changes
        if git diff --name-only origin/${{ github.base_ref }}...HEAD | grep -E '\.(ts|tsx|js|jsx)$' > /dev/null; then
          if git diff origin/${{ github.base_ref }}...HEAD | grep -E 'test|spec' > /dev/null; then
            TEMPLATE_CATEGORY="performance-review-strategies"
          fi
        fi
        
        if git diff --name-only origin/${{ github.base_ref }}...HEAD | grep -E '\.(yml|yaml|json|tf)$' > /dev/null; then
          TEMPLATE_CATEGORY="security-review-automation"
        fi
        
        if git diff origin/${{ github.base_ref }}...HEAD | grep -E 'architecture|design|pattern' > /dev/null; then
          TEMPLATE_CATEGORY="architecture-review-frameworks"
        fi
        
        echo "category=$TEMPLATE_CATEGORY" >> $GITHUB_OUTPUT

    - name: Generate AI review
      id: ai_review
      uses: ./.github/actions/claude-review
      with:
        template_category: ${{ steps.template.outputs.category }}
        complexity: ${{ steps.complexity.outputs.complexity }}
        pr_context: |
          PR Title: ${{ github.event.pull_request.title }}
          PR Description: ${{ github.event.pull_request.body }}
          Changed Files: ${{ steps.complexity.outputs.changed_files }}
          Changed Lines: ${{ steps.complexity.outputs.changed_lines }}
          Base Branch: ${{ github.base_ref }}
          Head Branch: ${{ github.head_ref }}

    - name: Post AI review comment
      uses: actions/github-script@v7
      with:
        script: |
          const { data: comments } = await github.rest.issues.listComments({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: context.issue.number,
          });
          
          // Check if AI review comment already exists
          const existingComment = comments.find(comment => 
            comment.body.includes('🤖 AI Code Review Analysis')
          );
          
          const reviewComment = `## 🤖 AI Code Review Analysis
          
          **Review Complexity**: ${{ steps.complexity.outputs.complexity }}
          **Template Category**: ${{ steps.template.outputs.category }}
          **Analysis Timestamp**: ${new Date().toISOString()}
          
          ### 📊 Change Summary
          - **Files Modified**: ${{ steps.complexity.outputs.changed_files }}
          - **Lines Changed**: ${{ steps.complexity.outputs.changed_lines }}
          
          ### 🔍 AI Review Results
          ${{ steps.ai_review.outputs.review_content }}
          
          ### 📝 Recommendations
          ${{ steps.ai_review.outputs.recommendations }}
          
          ---
          *Generated using Intelligent Review Templates - [View Template](https://github.com/your-org/templates/tree/main/intelligent-review)*`;
          
          if (existingComment) {
            await github.rest.issues.updateComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              comment_id: existingComment.id,
              body: reviewComment
            });
          } else {
            await github.rest.issues.createComment({
              owner: context.repo.owner,
              repo: context.repo.repo,
              issue_number: context.issue.number,
              body: reviewComment
            });
          }

    - name: Update PR labels
      uses: actions/github-script@v7
      with:
        script: |
          const labels = [];
          
          // Add complexity label
          labels.push(`complexity:${{ steps.complexity.outputs.complexity }}`);
          
          // Add category label
          labels.push(`review:${{ steps.template.outputs.category }}`);
          
          // Add AI review label
          labels.push('ai-reviewed');
          
          await github.rest.issues.addLabels({
            owner: context.repo.owner,
            repo: context.repo.repo,
            issue_number: context.issue.number,
            labels: labels
          });
```

### Custom GitHub Action

Create a custom action for Claude Code integration:

```yaml
# .github/actions/claude-review/action.yml
name: 'Claude Code Review'
description: 'AI-powered code review using Claude with intelligent templates'

inputs:
  template_category:
    description: 'Review template category'
    required: true
  complexity:
    description: 'Review complexity level'
    required: true
  pr_context:
    description: 'Pull request context information'
    required: true

outputs:
  review_content:
    description: 'Generated review content'
  recommendations:
    description: 'Specific recommendations'

runs:
  using: 'node20'
  main: 'dist/index.js'
```

```javascript
// .github/actions/claude-review/src/index.js
const core = require('@actions/core');
const github = require('@actions/github');
const { ClaudeAPI } = require('./claude-client');

async function run() {
  try {
    const templateCategory = core.getInput('template_category');
    const complexity = core.getInput('complexity');
    const prContext = core.getInput('pr_context');
    
    // Load appropriate template
    const template = await loadTemplate(templateCategory, complexity);
    
    // Get PR diff
    const token = process.env.GITHUB_TOKEN;
    const octokit = github.getOctokit(token);
    
    const { data: pr } = await octokit.rest.pulls.get({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      pull_number: github.context.issue.number,
    });
    
    const { data: diff } = await octokit.rest.pulls.get({
      owner: github.context.repo.owner,
      repo: github.context.repo.repo,
      pull_number: github.context.issue.number,
      mediaType: {
        format: 'diff'
      }
    });
    
    // Generate review using Claude
    const claude = new ClaudeAPI(process.env.CLAUDE_API_KEY);
    const review = await claude.generateReview({
      template: template,
      prContext: prContext,
      diff: diff,
      complexity: complexity
    });
    
    core.setOutput('review_content', review.content);
    core.setOutput('recommendations', review.recommendations);
    
  } catch (error) {
    core.setFailed(error.message);
  }
}

async function loadTemplate(category, complexity) {
  const templateMap = {
    'code-review-acceleration': {
      'low': 'automated-code-review-acceleration.md',
      'medium': 'collaborative-review-optimization.md',
      'high': 'intelligent-feedback-generation.md'
    },
    'security-review-automation': {
      'low': 'automated-security-assessment.md',
      'medium': 'compliance-validation-framework.md',
      'high': 'threat-modeling-integration.md'
    },
    // ... other template mappings
  };
  
  const templateFile = templateMap[category]?.[complexity] || 
                       templateMap['code-review-acceleration']['medium'];
  
  return await loadTemplateContent(templateFile);
}

run();
```

### GitHub App Integration

For enterprise environments, create a GitHub App:

```javascript
// github-app/review-bot.js
const { App } = require('@octokit/app');
const { ClaudeReviewEngine } = require('./claude-engine');

const app = new App({
  appId: process.env.GITHUB_APP_ID,
  privateKey: process.env.GITHUB_PRIVATE_KEY,
});

// Handle pull request events
app.webhooks.on('pull_request.opened', async ({ payload, octokit }) => {
  const { pull_request, repository } = payload;
  
  // Analyze PR for appropriate template selection
  const analysis = await analyzePullRequest(pull_request, octokit);
  
  // Generate AI review
  const reviewEngine = new ClaudeReviewEngine();
  const review = await reviewEngine.generateReview({
    template: analysis.selectedTemplate,
    pullRequest: pull_request,
    repository: repository,
    context: analysis.context
  });
  
  // Post review as comment
  await octokit.rest.issues.createComment({
    owner: repository.owner.login,
    repo: repository.name,
    issue_number: pull_request.number,
    body: formatReviewComment(review)
  });
  
  // Request specific reviewers based on complexity
  if (analysis.complexity === 'high') {
    await octokit.rest.pulls.requestReviewers({
      owner: repository.owner.login,
      repo: repository.name,
      pull_number: pull_request.number,
      reviewers: analysis.suggestedReviewers
    });
  }
});

async function analyzePullRequest(pullRequest, octokit) {
  // Get changed files and diff
  const { data: files } = await octokit.rest.pulls.listFiles({
    owner: pullRequest.base.repo.owner.login,
    repo: pullRequest.base.repo.name,
    pull_number: pullRequest.number
  });
  
  const complexity = calculateComplexity(files);
  const category = determineCategory(files, pullRequest);
  const template = selectTemplate(category, complexity);
  
  return {
    complexity,
    category,
    selectedTemplate: template,
    context: {
      changedFiles: files.length,
      additions: pullRequest.additions,
      deletions: pullRequest.deletions,
      title: pullRequest.title,
      description: pullRequest.body
    },
    suggestedReviewers: await getSuggestedReviewers(category, complexity)
  };
}
```

## GitLab Integration

### GitLab CI Pipeline

```yaml
# .gitlab-ci.yml
stages:
  - review
  - test
  - deploy

ai-code-review:
  stage: review
  image: node:18
  rules:
    - if: $CI_PIPELINE_SOURCE == "merge_request_event"
  script:
    - npm install -g @your-org/intelligent-review-cli
    - |
      # Analyze MR complexity
      CHANGED_FILES=$(git diff --name-only origin/$CI_MERGE_REQUEST_TARGET_BRANCH_NAME...HEAD | wc -l)
      CHANGED_LINES=$(git diff --numstat origin/$CI_MERGE_REQUEST_TARGET_BRANCH_NAME...HEAD | awk '{add+=$1; del+=$2} END {print add+del}')
      
      # Determine template category
      TEMPLATE_CATEGORY="code-review-acceleration"
      if git diff --name-only origin/$CI_MERGE_REQUEST_TARGET_BRANCH_NAME...HEAD | grep -E '\.(yml|yaml|tf)$' > /dev/null; then
        TEMPLATE_CATEGORY="security-review-automation"
      fi
      
      # Generate review
      intelligent-review generate \
        --template-category="$TEMPLATE_CATEGORY" \
        --mr-title="$CI_MERGE_REQUEST_TITLE" \
        --mr-description="$CI_MERGE_REQUEST_DESCRIPTION" \
        --changed-files="$CHANGED_FILES" \
        --changed-lines="$CHANGED_LINES" \
        --target-branch="$CI_MERGE_REQUEST_TARGET_BRANCH_NAME" \
        --source-branch="$CI_MERGE_REQUEST_SOURCE_BRANCH_NAME" \
        --project-id="$CI_PROJECT_ID" \
        --merge-request-iid="$CI_MERGE_REQUEST_IID" \
        --gitlab-token="$GITLAB_ACCESS_TOKEN"
  artifacts:
    reports:
      junit: review-results.xml
    paths:
      - review-analysis.json
    expire_in: 1 week
```

### GitLab Webhook Integration

```python
# gitlab-webhook-handler.py
from flask import Flask, request, jsonify
import gitlab
from claude_review_engine import ClaudeReviewEngine

app = Flask(__name__)
gl = gitlab.Gitlab('https://gitlab.com', private_token=os.getenv('GITLAB_TOKEN'))

@app.route('/webhook/merge-request', methods=['POST'])
def handle_merge_request():
    data = request.get_json()
    
    if data['object_kind'] != 'merge_request':
        return jsonify({'status': 'ignored'}), 200
    
    mr_action = data['object_attributes']['action']
    if mr_action not in ['open', 'update']:
        return jsonify({'status': 'ignored'}), 200
    
    project_id = data['project']['id']
    mr_iid = data['object_attributes']['iid']
    
    # Get merge request details
    project = gl.projects.get(project_id)
    mr = project.mergerequests.get(mr_iid)
    
    # Analyze changes
    changes = mr.changes()
    analysis = analyze_mr_changes(changes, mr)
    
    # Generate AI review
    review_engine = ClaudeReviewEngine()
    review = review_engine.generate_review(
        template_category=analysis['category'],
        complexity=analysis['complexity'],
        changes=changes,
        mr_context={
            'title': mr.title,
            'description': mr.description,
            'source_branch': mr.source_branch,
            'target_branch': mr.target_branch
        }
    )
    
    # Post review comment
    mr.notes.create({
        'body': format_review_comment(review, analysis)
    })
    
    return jsonify({'status': 'review_posted'}), 200

def analyze_mr_changes(changes, mr):
    changed_files = len(changes.get('changes', []))
    
    # Calculate complexity
    complexity = 'low'
    if changed_files > 20:
        complexity = 'high'
    elif changed_files > 5:
        complexity = 'medium'
    
    # Determine category based on file types
    category = 'code-review-acceleration'
    file_extensions = set()
    
    for change in changes.get('changes', []):
        file_path = change.get('new_path', '')
        if '.' in file_path:
            file_extensions.add(file_path.split('.')[-1])
    
    if any(ext in file_extensions for ext in ['yml', 'yaml', 'tf', 'json']):
        category = 'security-review-automation'
    elif any(ext in file_extensions for ext in ['sql', 'migration']):
        category = 'performance-review-strategies'
    
    return {
        'complexity': complexity,
        'category': category,
        'changed_files': changed_files,
        'file_extensions': list(file_extensions)
    }

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

## Azure DevOps Integration

### Azure Pipeline Configuration

```yaml
# azure-pipelines.yml
trigger:
  - main
  - develop

pr:
  - main
  - develop

pool:
  vmImage: 'ubuntu-latest'

variables:
  - group: intelligent-review-secrets

stages:
- stage: CodeReview
  displayName: 'AI Code Review'
  condition: eq(variables['Build.Reason'], 'PullRequest')
  jobs:
  - job: IntelligentReview
    displayName: 'Generate AI Review'
    steps:
    - checkout: self
      fetchDepth: 0
      
    - task: NodeTool@0
      inputs:
        versionSpec: '18.x'
      displayName: 'Install Node.js'
      
    - script: |
        npm install -g @your-org/azure-devops-review-extension
      displayName: 'Install Review Extension'
      
    - script: |
        # Get PR information
        PR_ID=$(echo "$(System.PullRequest.PullRequestId)")
        SOURCE_BRANCH=$(echo "$(System.PullRequest.SourceBranch)")
        TARGET_BRANCH=$(echo "$(System.PullRequest.TargetBranch)")
        
        # Analyze changes
        git diff --name-only origin/$TARGET_BRANCH...HEAD > changed_files.txt
        CHANGED_FILES=$(cat changed_files.txt | wc -l)
        
        # Generate review
        azure-review generate \
          --pr-id="$PR_ID" \
          --source-branch="$SOURCE_BRANCH" \
          --target-branch="$TARGET_BRANCH" \
          --changed-files="$CHANGED_FILES" \
          --organization="$(System.TeamFoundationCollectionUri)" \
          --project="$(System.TeamProject)" \
          --access-token="$(AZURE_DEVOPS_TOKEN)"
      displayName: 'Generate AI Review'
      env:
        CLAUDE_API_KEY: $(CLAUDE_API_KEY)
        
    - task: PublishTestResults@2
      inputs:
        testResultsFormat: 'JUnit'
        testResultsFiles: 'review-results.xml'
        testRunTitle: 'AI Code Review Results'
      condition: always()
```

### Azure DevOps Extension

```typescript
// azure-extension/review-service.ts
import { GitRestClient } from 'azure-devops-node-api/GitApi';
import { WebApi } from 'azure-devops-node-api';
import { ClaudeReviewEngine } from './claude-engine';

export class AzureDevOpsReviewService {
  private gitApi: GitRestClient;
  private reviewEngine: ClaudeReviewEngine;

  constructor(organizationUrl: string, accessToken: string) {
    const authHandler = WebApi.getPersonalAccessTokenHandler(accessToken);
    const connection = new WebApi(organizationUrl, authHandler);
    this.gitApi = connection.getGitApi();
    this.reviewEngine = new ClaudeReviewEngine();
  }

  async processPullRequest(
    projectId: string, 
    repositoryId: string, 
    pullRequestId: number
  ): Promise<void> {
    // Get pull request details
    const pullRequest = await this.gitApi.getPullRequest(
      repositoryId,
      pullRequestId,
      projectId
    );

    // Get pull request changes
    const changes = await this.gitApi.getPullRequestIterationChanges(
      repositoryId,
      pullRequestId,
      1,
      projectId
    );

    // Analyze changes for template selection
    const analysis = this.analyzeChanges(changes, pullRequest);

    // Generate AI review
    const review = await this.reviewEngine.generateReview({
      template: analysis.selectedTemplate,
      pullRequest: pullRequest,
      changes: changes,
      context: analysis.context
    });

    // Post review as comment thread
    await this.postReviewComment(
      projectId,
      repositoryId,
      pullRequestId,
      review
    );

    // Add review labels
    await this.addPullRequestLabels(
      projectId,
      repositoryId,
      pullRequestId,
      analysis
    );
  }

  private async postReviewComment(
    projectId: string,
    repositoryId: string,
    pullRequestId: number,
    review: any
  ): Promise<void> {
    const thread = {
      comments: [{
        content: this.formatReviewComment(review),
        commentType: 1 // Text comment
      }],
      status: 1 // Active
    };

    await this.gitApi.createThread(
      thread,
      repositoryId,
      pullRequestId,
      projectId
    );
  }

  private analyzeChanges(changes: any, pullRequest: any): any {
    const changeCount = changes.changeEntries?.length || 0;
    
    let complexity = 'low';
    if (changeCount > 20) {
      complexity = 'high';
    } else if (changeCount > 5) {
      complexity = 'medium';
    }

    // Determine category based on file types
    let category = 'code-review-acceleration';
    const fileExtensions = new Set<string>();

    changes.changeEntries?.forEach((change: any) => {
      const path = change.item?.path || '';
      const extension = path.split('.').pop()?.toLowerCase();
      if (extension) {
        fileExtensions.add(extension);
      }
    });

    if (fileExtensions.has('yml') || fileExtensions.has('yaml') || fileExtensions.has('tf')) {
      category = 'security-review-automation';
    } else if (fileExtensions.has('sql') || path.includes('migration')) {
      category = 'performance-review-strategies';
    }

    return {
      complexity,
      category,
      selectedTemplate: this.selectTemplate(category, complexity),
      context: {
        changeCount,
        fileExtensions: Array.from(fileExtensions),
        title: pullRequest.title,
        description: pullRequest.description
      }
    };
  }
}
```

## Universal CLI Tool

Create a universal command-line interface for all platforms:

```javascript
#!/usr/bin/env node
// cli/intelligent-review.js

const { Command } = require('commander');
const { ClaudeReviewEngine } = require('./engines/claude-engine');
const { TemplateManager } = require('./templates/template-manager');
const { PlatformAdapters } = require('./adapters');

const program = new Command();

program
  .name('intelligent-review')
  .description('AI-powered code review using intelligent templates')
  .version('1.0.0');

program
  .command('generate')
  .description('Generate AI review for code changes')
  .option('-p, --platform <platform>', 'Platform: github, gitlab, azure, bitbucket')
  .option('-t, --template-category <category>', 'Template category')
  .option('-c, --complexity <level>', 'Complexity level: low, medium, high')
  .option('--pr-id <id>', 'Pull/Merge request ID')
  .option('--repo <repository>', 'Repository identifier')
  .option('--diff-file <file>', 'Path to diff file')
  .option('--config <config>', 'Configuration file path')
  .action(async (options) => {
    try {
      const config = await loadConfig(options.config);
      const adapter = PlatformAdapters.create(options.platform, config);
      
      // Get changes from platform
      const changes = await adapter.getChanges({
        prId: options.prId,
        repository: options.repo,
        diffFile: options.diffFile
      });
      
      // Analyze and select template
      const templateManager = new TemplateManager();
      const template = await templateManager.selectTemplate({
        category: options.templateCategory,
        complexity: options.complexity,
        changes: changes
      });
      
      // Generate review
      const reviewEngine = new ClaudeReviewEngine(config.claude);
      const review = await reviewEngine.generateReview({
        template: template,
        changes: changes,
        context: await adapter.getContext()
      });
      
      // Post review
      await adapter.postReview(review);
      
      console.log('✅ AI review generated and posted successfully');
      
    } catch (error) {
      console.error('❌ Error generating review:', error.message);
      process.exit(1);
    }
  });

program
  .command('templates')
  .description('Manage review templates')
  .option('-l, --list', 'List available templates')
  .option('-c, --category <category>', 'Filter by category')
  .option('--validate', 'Validate template syntax')
  .action(async (options) => {
    const templateManager = new TemplateManager();
    
    if (options.list) {
      const templates = await templateManager.listTemplates(options.category);
      console.table(templates);
    }
    
    if (options.validate) {
      const results = await templateManager.validateTemplates();
      console.log(results);
    }
  });

program
  .command('setup')
  .description('Setup integration for a platform')
  .option('-p, --platform <platform>', 'Platform to setup')
  .option('--interactive', 'Interactive setup wizard')
  .action(async (options) => {
    const setupWizard = new SetupWizard();
    await setupWizard.run(options.platform, options.interactive);
  });

async function loadConfig(configPath) {
  const defaultConfig = {
    claude: {
      apiKey: process.env.CLAUDE_API_KEY,
      model: 'claude-3-sonnet-20240229'
    },
    templates: {
      directory: './templates',
      customizations: {}
    },
    platforms: {}
  };
  
  if (configPath) {
    const fs = require('fs').promises;
    const userConfig = JSON.parse(await fs.readFile(configPath, 'utf8'));
    return { ...defaultConfig, ...userConfig };
  }
  
  return defaultConfig;
}

if (require.main === module) {
  program.parse();
}

module.exports = { program };
```

## Configuration and Best Practices

### Template Selection Logic

```javascript
// template-selector.js
class TemplateSelector {
  static selectTemplate(context) {
    const { changes, complexity, teamStandards } = context;
    
    // Primary categorization
    let category = 'code-review-acceleration';
    
    if (this.hasSecurityImplications(changes)) {
      category = 'security-review-automation';
    } else if (this.hasArchitecturalChanges(changes)) {
      category = 'architecture-review-frameworks';
    } else if (this.hasPerformanceImplications(changes)) {
      category = 'performance-review-strategies';
    }
    
    // Select specific template within category
    const templates = this.getTemplatesForCategory(category);
    return this.selectByComplexity(templates, complexity);
  }
  
  static hasSecurityImplications(changes) {
    const securityPatterns = [
      /auth|login|password|token|key|secret/i,
      /security|encrypt|decrypt|hash/i,
      /permission|role|access|cors/i,
      /\.env|config|settings/i
    ];
    
    return changes.some(change => 
      securityPatterns.some(pattern => 
        pattern.test(change.filename) || pattern.test(change.content)
      )
    );
  }
  
  static hasArchitecturalChanges(changes) {
    const architecturalPatterns = [
      /architecture|design|pattern/i,
      /interface|abstract|base/i,
      /service|repository|factory/i,
      /migration|schema|model/i
    ];
    
    return changes.some(change =>
      architecturalPatterns.some(pattern =>
        pattern.test(change.filename) || pattern.test(change.content)
      )
    );
  }
}
```

### Environment Configuration

```yaml
# config/review-config.yml
default:
  claude:
    model: "claude-3-sonnet-20240229"
    max_tokens: 4000
    temperature: 0.1
  
  templates:
    directory: "./templates/intelligent-review"
    fallback_template: "code-review-acceleration/automated-code-review-acceleration.md"
  
  complexity_thresholds:
    low:
      max_files: 5
      max_lines: 100
    medium:
      max_files: 20
      max_lines: 500
    high:
      max_files: 999
      max_lines: 999

github:
  webhook_secret: ${GITHUB_WEBHOOK_SECRET}
  app_id: ${GITHUB_APP_ID}
  private_key_path: ${GITHUB_PRIVATE_KEY_PATH}
  
  review_settings:
    auto_assign_reviewers: true
    require_approval: true
    dismiss_stale_reviews: true

gitlab:
  token: ${GITLAB_ACCESS_TOKEN}
  webhook_token: ${GITLAB_WEBHOOK_TOKEN}
  
  merge_request_settings:
    remove_source_branch: true
    squash: false

azure:
  organization: ${AZURE_DEVOPS_ORG}
  token: ${AZURE_DEVOPS_TOKEN}
  
  pull_request_settings:
    auto_complete: false
    delete_source_branch: true
```

## Monitoring and Analytics

### Review Effectiveness Tracking

```javascript
// analytics/review-analytics.js
class ReviewAnalytics {
  constructor(config) {
    this.config = config;
    this.metrics = new Map();
  }
  
  trackReview(reviewData) {
    const metric = {
      timestamp: new Date(),
      platform: reviewData.platform,
      template: reviewData.template,
      complexity: reviewData.complexity,
      reviewTime: reviewData.reviewTime,
      implementationRate: reviewData.implementationRate,
      satisfaction: reviewData.satisfaction
    };
    
    this.metrics.set(reviewData.id, metric);
    this.exportMetrics(metric);
  }
  
  generateReport(timeframe) {
    const filteredMetrics = Array.from(this.metrics.values())
      .filter(m => m.timestamp >= timeframe.start && m.timestamp <= timeframe.end);
    
    return {
      totalReviews: filteredMetrics.length,
      averageReviewTime: this.calculateAverage(filteredMetrics, 'reviewTime'),
      averageImplementationRate: this.calculateAverage(filteredMetrics, 'implementationRate'),
      templateEffectiveness: this.analyzeTemplateEffectiveness(filteredMetrics),
      platformComparison: this.comparePlatformPerformance(filteredMetrics)
    };
  }
  
  analyzeTemplateEffectiveness(metrics) {
    const templateGroups = this.groupBy(metrics, 'template');
    
    return Object.entries(templateGroups).map(([template, data]) => ({
      template,
      usage: data.length,
      averageTime: this.calculateAverage(data, 'reviewTime'),
      implementationRate: this.calculateAverage(data, 'implementationRate'),
      satisfaction: this.calculateAverage(data, 'satisfaction')
    }));
  }
}
```

## Troubleshooting and Support

### Common Integration Issues

1. **Authentication Problems**
   - Verify API tokens and permissions
   - Check webhook configurations
   - Validate SSL certificates

2. **Template Selection Issues**
   - Review file pattern matching logic
   - Verify template availability
   - Check complexity calculation

3. **Performance Issues**
   - Monitor API rate limits
   - Optimize template content length
   - Implement caching strategies

### Support Resources

- **Documentation**: Comprehensive setup guides for each platform
- **Community Forum**: Peer support and best practices sharing
- **Issue Tracking**: GitHub repository for bug reports and feature requests
- **Professional Support**: Enterprise support options available

This integration guide provides the foundation for seamlessly incorporating intelligent review templates into existing development workflows across all major code review platforms.