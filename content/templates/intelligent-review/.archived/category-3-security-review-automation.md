---
title: "Category 3: Security Review Automation Templates"
description: "Specialized templates for automated security vulnerability detection and compliance validation"
content_type: "prompt_template_category"
principle: "intelligent-review"
category: "security-review-automation"
template_count: 2
complexity_levels: ["intermediate", "expert"]
target_audience: "security_engineers,senior_developers"
integration_requirements: ["claude-code", "security-scanners", "compliance-tools"]
last_updated: "2025-06-25"
---

# Category 3: Security Review Automation Templates

## Overview

These templates focus on automated security analysis, vulnerability detection, and compliance validation. They are designed to identify security issues early in the development process and ensure code meets security standards and regulatory requirements.

## Templates in This Category

### Template 5.3: Quick Security Review
**Complexity:** Intermediate | **Estimated Time Savings:** 20-35 minutes per review

#### Template
```
You are a security engineer conducting a rapid security assessment. Please analyze the code for security vulnerabilities and provide specific feedback on:

**Input Validation & Sanitization:**
- Are all user inputs properly validated and sanitized?
- Is there protection against injection attacks (SQL, XSS, LDAP, etc.)?
- Are file uploads handled securely with proper validation?

**Authentication & Authorization:**
- Is authentication implemented securely?
- Are authorization checks present and comprehensive?
- Is privilege escalation prevented?

**Data Protection:**
- Is sensitive data properly encrypted at rest and in transit?
- Are secrets and credentials handled securely?
- Is PII (Personally Identifiable Information) protected appropriately?

**Common Vulnerability Patterns:**
- Are there any OWASP Top 10 vulnerabilities present?
- Is error handling implemented without leaking sensitive information?
- Are security headers properly configured?

**Cryptographic Implementation:**
- Are cryptographic functions used correctly?
- Are deprecated or weak algorithms avoided?
- Is random number generation cryptographically secure?

**Session Management:**
- Is session handling secure and tamper-resistant?
- Are session timeouts and invalidation implemented?
- Is cross-site request forgery (CSRF) protection in place?

**Code to Review:**
[PASTE_CODE_HERE]

**Application Context:**
- **Application Type**: [Web app/API/Mobile/Desktop]
- **User Data Handling**: [Types of sensitive data processed]
- **Authentication Method**: [OAuth/JWT/Session-based/etc.]
- **Compliance Requirements**: [GDPR/HIPAA/PCI-DSS/SOX/etc.]

Provide specific security recommendations with remediation steps and code examples where applicable.
```

#### Usage Context
- **When to Use**: All code changes involving user input, authentication, or data handling
- **Best For**: Web applications, APIs, mobile backends, authentication systems
- **Integration**: Essential for CI/CD security gates and automated security scanning

#### Effectiveness Metrics
- **Vulnerability Detection**: 85% of common security issues identified pre-deployment
- **Security Incident Reduction**: 70% fewer security-related production incidents
- **Compliance Readiness**: 90% reduction in security audit findings

#### Security Focus Areas by Application Type

##### Web Applications
```yaml
Critical Checks:
  - XSS prevention in dynamic content
  - CSRF token implementation
  - Content Security Policy (CSP)
  - Secure cookie configuration
  - HTTPS enforcement
  
Common Vulnerabilities:
  - DOM-based XSS
  - Insecure direct object references
  - Missing authentication on sensitive endpoints
  - Weak session management
```

##### API Services
```yaml
Critical Checks:
  - API rate limiting and throttling
  - Input validation on all endpoints
  - Proper HTTP method restrictions
  - API key/token security
  - Response data filtering
  
Common Vulnerabilities:
  - Mass assignment vulnerabilities
  - Insecure API endpoints
  - Information disclosure in error messages
  - Lack of input size limits
```

##### Mobile Applications
```yaml
Critical Checks:
  - Secure storage of sensitive data
  - Certificate pinning implementation
  - Proper keychain/keystore usage
  - Root/jailbreak detection
  - Secure communication protocols
  
Common Vulnerabilities:
  - Hardcoded secrets in code
  - Insecure data storage
  - Man-in-the-middle vulnerabilities
  - Weak encryption implementation
```

#### Customization for Compliance Frameworks

##### GDPR Compliance
```markdown
**Additional GDPR Checks:**
- Is user consent properly obtained and recorded?
- Is data minimization principle followed?
- Are data retention policies implemented?
- Is right to erasure (right to be forgotten) supported?
- Is data portability functionality available?
```

##### HIPAA Compliance
```markdown
**Additional HIPAA Checks:**
- Is PHI (Protected Health Information) identified and protected?
- Are access controls based on minimum necessary standard?
- Is audit logging comprehensive and tamper-resistant?
- Are data encryption standards met (AES-256)?
- Is secure data transmission implemented (TLS 1.2+)?
```

---

### Template 5.10: Security Architecture Review
**Complexity:** Expert | **Estimated Time Savings:** 60-90 minutes per review

#### Template
```
You are conducting a comprehensive security architecture review. Please provide expert analysis on:

**Security Architecture Patterns:**
- Is the security architecture following defense-in-depth principles?
- Are security boundaries clearly defined and enforced?
- Is the principle of least privilege implemented throughout?

**Threat Modeling:**
- Has threat modeling been conducted for this system?
- Are the most critical threats identified and mitigated?
- Is the attack surface minimized appropriately?

**Identity & Access Management:**
- Is the IAM strategy comprehensive and centralized?
- Are identity providers integrated securely?
- Is multi-factor authentication implemented where required?

**Network Security:**
- Are network segmentation and firewall rules appropriate?
- Is traffic encryption implemented end-to-end?
- Are VPNs and secure tunnels configured correctly?

**Data Security Architecture:**
- Is data classification and labeling implemented?
- Are encryption key management practices secure?
- Is data loss prevention (DLP) considered?

**Security Monitoring & Incident Response:**
- Is security monitoring and SIEM integration planned?
- Are incident response procedures defined and tested?
- Is forensic data collection capability built in?

**Compliance & Governance:**
- Does the architecture meet regulatory requirements?
- Are security policies and standards enforced architecturally?
- Is security governance integrated into the SDLC?

**Supply Chain Security:**
- Are third-party dependencies assessed for security risks?
- Is software bill of materials (SBOM) maintained?
- Are container and infrastructure images scanned for vulnerabilities?

**Architecture Documentation to Review:**
[PASTE_SECURITY_ARCHITECTURE_DIAGRAMS]

**System Security Context:**
- **Threat Level**: [High/Medium/Low risk classification]
- **Regulatory Requirements**: [Specific compliance frameworks]
- **Data Sensitivity**: [Classification levels handled]
- **User Base**: [Internal/External/Partner access patterns]
- **Deployment Environment**: [Cloud/On-premises/Hybrid]

Provide comprehensive security architecture recommendations with implementation roadmap and risk assessment.
```

#### Usage Context
- **When to Use**: New system architecture, security redesign, compliance assessments
- **Best For**: Enterprise systems, high-security environments, regulated industries
- **Integration**: Critical for security architecture governance and compliance audits

#### Effectiveness Metrics
- **Security Posture**: 75% improvement in security architecture maturity
- **Compliance Success**: 95% first-time compliance audit pass rate
- **Incident Prevention**: 80% reduction in architecture-related security incidents

#### Enterprise Security Architecture Patterns

##### Zero Trust Architecture Review
```yaml
Core Principles Validation:
  - Never trust, always verify
  - Least privilege access
  - Assume breach mentality
  - Verify explicitly
  
Key Components:
  - Identity verification
  - Device compliance
  - Application access controls
  - Data protection
  - Network micro-segmentation
  
Implementation Checks:
  - Multi-factor authentication everywhere
  - Continuous authentication and authorization
  - Encrypted communications
  - Analytics and monitoring
```

##### Cloud Security Architecture Review
```yaml
Cloud Security Pillars:
  - Identity and access management
  - Detective controls
  - Infrastructure protection
  - Data protection in transit and at rest
  - Incident response
  
AWS Security Best Practices:
  - IAM roles and policies
  - VPC security groups and NACLs
  - CloudTrail logging
  - KMS key management
  - GuardDuty threat detection
  
Azure Security Framework:
  - Azure AD integration
  - Network security groups
  - Azure Security Center
  - Key Vault management
  - Sentinel SIEM integration
```

##### Microservices Security Architecture
```yaml
Service-to-Service Security:
  - mTLS implementation
  - Service mesh security policies
  - API gateway authentication
  - Inter-service authorization
  
Container Security:
  - Image vulnerability scanning
  - Runtime security monitoring
  - Network policies
  - Secrets management
  
Kubernetes Security:
  - RBAC implementation
  - Pod security policies
  - Network policies
  - Admission controllers
```

#### Advanced Security Assessment Framework

##### Threat Intelligence Integration
```yaml
Intelligence Sources:
  - CVE databases
  - Threat actor TTPs
  - Industry threat reports
  - Internal security incidents
  
Risk Assessment:
  - Likelihood assessment
  - Impact analysis
  - Risk appetite alignment
  - Mitigation strategy
```

##### Security Metrics and KPIs
```yaml
Architecture Metrics:
  - Security control coverage
  - Threat model completeness
  - Compliance score
  - Security debt tracking
  
Operational Metrics:
  - Mean time to detection (MTTD)
  - Mean time to response (MTTR)
  - False positive rates
  - Security tool effectiveness
```

#### Implementation Roadmap Template

##### Phase 1: Foundation (Weeks 1-4)
- Identity and access management
- Basic encryption implementation
- Security monitoring setup
- Incident response procedures

##### Phase 2: Enhanced Controls (Weeks 5-8)
- Advanced threat detection
- Network segmentation
- Data loss prevention
- Security automation

##### Phase 3: Advanced Security (Weeks 9-12)
- Zero trust implementation
- Advanced analytics
- Threat hunting capabilities
- Security orchestration

---

## Category Implementation Guide

### Security Review Integration Strategy
```yaml
Development Workflow Integration:
  - Pre-commit hooks for Template 5.3
  - PR automation for security checks
  - Architecture review gates using Template 5.10
  - Security sprint planning integration

Tools Integration:
  - SAST (Static Application Security Testing)
  - DAST (Dynamic Application Security Testing)
  - Container scanning
  - Infrastructure as Code security
```

### Team Training and Adoption
- **Development Teams**: Mandatory Template 5.3 training for secure coding
- **Security Teams**: Advanced Template 5.10 for architecture assessments
- **DevOps Teams**: Integration of security templates in CI/CD pipelines
- **Management**: Security metrics and compliance reporting based on template usage

### Success Metrics for Security Automation
- **Vulnerability Reduction**: 60% fewer security vulnerabilities in production
- **Compliance Efficiency**: 80% faster compliance audit preparation
- **Security Awareness**: 90% of developers trained on security templates
- **Incident Response**: 50% faster security incident resolution

---

*These security review templates provide comprehensive coverage of security concerns from basic vulnerability detection to enterprise-grade security architecture assessment.*