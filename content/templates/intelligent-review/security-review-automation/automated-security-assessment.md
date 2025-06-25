---
title: "Automated Security Assessment Template"
description: "Comprehensive framework for automated security code review, vulnerability detection, and security best practices validation"
content_type: "prompt_template"
target_audience: "senior_developers"
integration_requirements: ["security-scanners", "sast-tools", "compliance-frameworks"]
template_category: "security-review-automation"
effectiveness_metrics: ["vulnerability_detection_rate", "false_positive_rate", "security_compliance_score"]
estimated_time_savings: "80-90%"
complexity_level: "expert"
prerequisites: ["security_engineering", "threat_modeling", "compliance_requirements"]
last_updated: "2025-06-25"
---

# Automated Security Assessment Template

## Template Overview

This template provides a comprehensive framework for conducting automated security assessments, identifying vulnerabilities, and ensuring compliance with security best practices across codebases and system architectures.

## Usage Context

Use this template when:
- Conducting comprehensive security code reviews
- Implementing automated security scanning in CI/CD pipelines
- Assessing security compliance with industry standards
- Identifying and prioritizing security vulnerabilities
- Establishing security review processes and guidelines

## Template Structure

### Security Assessment Context Setup

```
**Context**: Automated security assessment for [PROJECT_NAME/SYSTEM_NAME]

**Security Scope and Requirements**:
- Application type: [Web application, API, mobile app, microservices]
- Technology stack: [Languages, frameworks, databases, cloud services]
- Compliance requirements: [OWASP, SOC2, ISO27001, GDPR, HIPAA, PCI DSS]
- Threat model: [External attackers, insider threats, supply chain risks]
- Security classification: [Public, internal, confidential, restricted]

**Assessment Objectives**:
- Vulnerability identification: [OWASP Top 10, CWE classifications]
- Code security analysis: [Static analysis, dependency scanning]
- Architecture security review: [Design patterns, access controls]
- Compliance validation: [Regulatory requirements, industry standards]
- Risk assessment: [Impact analysis, likelihood evaluation]

**Technical Environment**:
- Development environment: [Local, staging, production considerations]
- Deployment model: [Cloud, on-premise, hybrid infrastructure]
- Integration points: [External APIs, third-party services, legacy systems]
- Data handling: [PII, financial data, healthcare records, intellectual property]
```

### Comprehensive Security Analysis Framework

```
**Primary Security Assessment Request**: Conduct thorough security evaluation across the following dimensions:

1. **Input Validation and Injection Prevention**:
   - SQL injection vulnerability assessment and parameterized query validation
   - Cross-site scripting (XSS) prevention and output encoding analysis
   - Command injection and OS command execution security review
   - LDAP, XML, and NoSQL injection vulnerability identification
   - File upload security and path traversal prevention validation

2. **Authentication and Session Management**:
   - Password policy enforcement and secure credential storage
   - Multi-factor authentication implementation and bypass prevention
   - Session management security and token handling validation
   - OAuth/SAML implementation security and flow validation
   - Account lockout and brute force protection mechanisms

3. **Authorization and Access Control**:
   - Role-based access control (RBAC) implementation validation
   - Attribute-based access control (ABAC) logic verification
   - Privilege escalation vulnerability assessment
   - Direct object reference and access control bypass testing
   - API endpoint authorization and rate limiting validation

4. **Data Protection and Cryptography**:
   - Encryption implementation and algorithm strength validation
   - Key management and rotation policy assessment
   - Data at rest and in transit protection verification
   - Cryptographic random number generation security
   - Certificate management and PKI implementation review

5. **Error Handling and Information Disclosure**:
   - Error message information leakage prevention
   - Debug information exposure in production environments
   - Stack trace and system information disclosure assessment
   - Logging security and sensitive data handling in logs
   - API error response security and information minimization

**Code Implementation for Review**:
[PASTE_CODE_SECTIONS_FOR_SECURITY_ANALYSIS_HERE]

**System Architecture Documentation**:
[PASTE_ARCHITECTURE_DIAGRAMS_AND_SECURITY_CONTROLS_HERE]

**Security Assessment Output Format**:
- Executive security summary with risk rating and compliance status
- Vulnerability inventory with CVSS scores and remediation priorities
- Security control effectiveness assessment with improvement recommendations
- Compliance gap analysis with specific requirement mappings
- Threat modeling updates with newly identified attack vectors
- Remediation roadmap with timelines and resource requirements
- Security testing recommendations with automation integration guidelines
```

### Specialized Security Analysis Modules

```
**Advanced Security Analysis Modules** (select based on application characteristics):

**Web Application Security Deep Dive**:
- Cross-Site Request Forgery (CSRF) protection validation
- Content Security Policy (CSP) implementation and bypass prevention
- Clickjacking and frame-based attack prevention
- Same-origin policy enforcement and CORS configuration security
- Subresource Integrity (SRI) implementation for third-party resources

**API Security Comprehensive Review**:
- REST API security best practices and OWASP API Top 10 compliance
- GraphQL security assessment and query depth/complexity limiting
- API versioning security and backward compatibility considerations
- Rate limiting and throttling implementation effectiveness
- API documentation security and information disclosure prevention

**Cloud Security Architecture Assessment**:
- Cloud service configuration security and misconfiguration detection
- Identity and Access Management (IAM) policy validation
- Network security group and firewall rule assessment
- Data encryption and key management in cloud environments
- Container and Kubernetes security configuration review

**Mobile Application Security Analysis**:
- Mobile-specific OWASP Top 10 vulnerability assessment
- Certificate pinning and transport security validation
- Local data storage security and encryption implementation
- Reverse engineering protection and code obfuscation assessment
- Mobile device management (MDM) and app wrapping security
```

## Implementation Examples

### Example 1: Web Application Security Assessment

```
**Context**: Automated security assessment for e-commerce web application

**Security Scope and Requirements**:
- Application type: Web application with customer portal and admin interface
- Technology stack: Node.js, Express, React, PostgreSQL, Redis, AWS
- Compliance requirements: PCI DSS Level 1, GDPR, SOC2 Type II
- Threat model: External attackers targeting payment data, insider threats
- Security classification: Restricted (payment card data, customer PII)

**Code Implementation for Review**:
```javascript
// Payment processing endpoint
app.post('/api/payments', authenticateUser, async (req, res) => {
  const { cardNumber, expiryDate, cvv, amount } = req.body;
  
  // Input validation
  if (!validateCardNumber(cardNumber)) {
    return res.status(400).json({ error: 'Invalid card number' });
  }
  
  try {
    // Process payment with third-party gateway
    const paymentResult = await paymentGateway.processPayment({
      card: cardNumber,
      expiry: expiryDate,
      cvv: cvv,
      amount: amount,
      merchantId: process.env.MERCHANT_ID
    });
    
    // Log transaction
    logger.info('Payment processed', { 
      transactionId: paymentResult.id,
      amount: amount,
      userId: req.user.id 
    });
    
    res.json({ success: true, transactionId: paymentResult.id });
  } catch (error) {
    logger.error('Payment processing failed', error);
    res.status(500).json({ error: 'Payment processing failed' });
  }
});
```

**Expected Security Assessment Output**:

**🔒 Critical Security Findings**
1. **PCI DSS Violation - Card Data Logging** (CVSS: 9.1 - Critical)
   - **Issue**: Card number potentially logged in payment processing
   - **Impact**: PCI DSS non-compliance, potential data breach
   - **Remediation**: Implement card data masking and secure logging
   ```javascript
   logger.info('Payment processed', { 
     transactionId: paymentResult.id,
     amount: amount,
     userId: req.user.id,
     cardLast4: cardNumber.slice(-4) // Only log last 4 digits
   });
   ```

2. **Insufficient Input Validation** (CVSS: 7.5 - High)
   - **Issue**: Missing validation for expiry date and CVV
   - **Impact**: Potential injection attacks, data corruption
   - **Remediation**: Implement comprehensive input validation
   ```javascript
   const validatePaymentData = (data) => {
     const schema = Joi.object({
       cardNumber: Joi.string().creditCard().required(),
       expiryDate: Joi.string().regex(/^(0[1-9]|1[0-2])\/\d{2}$/).required(),
       cvv: Joi.string().regex(/^\d{3,4}$/).required(),
       amount: Joi.number().positive().precision(2).required()
     });
     return schema.validate(data);
   };
   ```

**🛡️ Security Enhancements**
3. **Rate Limiting Implementation** (Priority: High)
   - **Enhancement**: Implement payment-specific rate limiting
   - **Business Impact**: Prevent brute force attacks on payment endpoints
   ```javascript
   const paymentRateLimit = rateLimit({
     windowMs: 15 * 60 * 1000, // 15 minutes
     max: 5, // 5 payment attempts per window
     message: 'Too many payment attempts, please try again later'
   });
   
   app.post('/api/payments', paymentRateLimit, authenticateUser, ...);
   ```

**📋 Compliance Assessment**
- **PCI DSS Compliance**: 85% compliant (card data handling improvements needed)
- **GDPR Compliance**: 92% compliant (data retention policy clarification required)
- **SOC2 Type II**: 88% compliant (access logging enhancement needed)
```

### Example 2: API Security Comprehensive Review

```
**Context**: Security assessment for RESTful API serving mobile and web clients

**Security Scope and Requirements**:
- Application type: RESTful API with OAuth2 authentication
- Technology stack: Python, FastAPI, PostgreSQL, Redis, Docker, AWS
- Compliance requirements: OWASP API Security Top 10, ISO27001
- Threat model: External attackers, API abuse, data exfiltration
- Security classification: Internal (customer data, business logic)

**API Implementation for Review**:
```python
from fastapi import FastAPI, Depends, HTTPException, Request
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
import jwt
from sqlalchemy.orm import Session

app = FastAPI()
security = HTTPBearer()

@app.get("/api/users/{user_id}/profile")
async def get_user_profile(
    user_id: int,
    request: Request,
    credentials: HTTPAuthorizationCredentials = Depends(security),
    db: Session = Depends(get_database)
):
    # Verify JWT token
    try:
        payload = jwt.decode(credentials.credentials, SECRET_KEY, algorithms=["HS256"])
        current_user_id = payload.get("user_id")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")
    
    # Get user profile
    user_profile = db.query(UserProfile).filter(
        UserProfile.user_id == user_id
    ).first()
    
    if not user_profile:
        raise HTTPException(status_code=404, detail="User not found")
    
    return user_profile
```

**Expected Security Assessment Output**:

**🚨 Critical API Security Issues**
1. **Broken Object Level Authorization** (OWASP API #1 - Critical)
   - **Issue**: No authorization check between requesting user and requested user_id
   - **Impact**: Users can access other users' profiles
   - **Remediation**: Implement proper authorization checks
   ```python
   # Authorization check
   if current_user_id != user_id and not is_admin(current_user_id):
       raise HTTPException(status_code=403, detail="Access denied")
   ```

2. **Missing Rate Limiting** (OWASP API #4 - High)
   - **Issue**: No rate limiting on API endpoints
   - **Impact**: API abuse, DoS attacks, resource exhaustion
   - **Remediation**: Implement per-user rate limiting
   ```python
   from slowapi import Limiter, _rate_limit_exceeded_handler
   from slowapi.util import get_remote_address
   
   limiter = Limiter(key_func=get_remote_address)
   app.state.limiter = limiter
   
   @app.get("/api/users/{user_id}/profile")
   @limiter.limit("100/minute")
   async def get_user_profile(...):
   ```

**🔍 Security Recommendations**
3. **Input Validation Enhancement** (Priority: Medium)
   - **Enhancement**: Add comprehensive input validation
   - **Implementation**: Use Pydantic models for request validation
   ```python
   from pydantic import BaseModel, validator
   
   class UserProfileRequest(BaseModel):
       user_id: int
       
       @validator('user_id')
       def validate_user_id(cls, v):
           if v <= 0:
               raise ValueError('User ID must be positive')
           return v
   ```
```

## Customization Guidelines

### Technology Stack Adaptations

- **Java/Spring**: Focus on Spring Security configurations, OWASP Java security guidelines
- **Python/Django**: Emphasize Django security middleware, ORM security patterns
- **Node.js/Express**: Highlight Helmet.js usage, async security considerations
- **C#/.NET**: Evaluate .NET security features, Identity framework implementation

### Compliance Framework Modifications

- **PCI DSS**: Focus on payment card data protection, secure coding standards
- **HIPAA**: Emphasize healthcare data protection, audit logging requirements
- **GDPR**: Prioritize data privacy, consent management, data minimization
- **SOX**: Focus on financial data integrity, access controls, audit trails

## Integration with Security Tools

### SAST/DAST Integration

```yaml
# Security scanning automation
security_pipeline:
  sast_tools:
    - sonarqube: code-quality-and-security-analysis
    - checkmarx: comprehensive-sast-scanning
    - veracode: enterprise-security-testing
    - semgrep: rule-based-static-analysis
  
  dast_tools:
    - owasp-zap: dynamic-application-security-testing
    - burp-suite: web-application-penetration-testing
    - acunetix: automated-vulnerability-scanning
    - netsparker: comprehensive-web-security-testing
  
  dependency_scanning:
    - snyk: vulnerability-database-scanning
    - npm-audit: node-js-dependency-security
    - safety: python-package-vulnerability-checking
    - retire-js: javascript-library-vulnerability-detection
```

### Continuous Security Monitoring

```python
# Security monitoring integration
class SecurityMonitor:
    def __init__(self, application_config):
        self.config = application_config
        self.threat_intelligence = ThreatIntelligenceAPI()
        self.siem_integration = SIEMConnector()
    
    def monitor_security_events(self):
        """Continuous security event monitoring"""
        return {
            'authentication_anomalies': self.detect_auth_anomalies(),
            'injection_attempts': self.monitor_injection_attacks(),
            'privilege_escalation': self.detect_privilege_escalation(),
            'data_exfiltration': self.monitor_data_access_patterns(),
            'threat_intelligence': self.correlate_threat_indicators()
        }
    
    def generate_security_alerts(self, events):
        """Generate actionable security alerts"""
        critical_events = self.prioritize_security_events(events)
        return self.create_incident_response_actions(critical_events)
```

## Success Metrics and Effectiveness

### Security Assessment Quality Metrics

- **Vulnerability Detection Rate**: Percentage of known vulnerabilities identified
- **False Positive Rate**: Rate of incorrect vulnerability reports
- **Coverage Completeness**: Percentage of codebase and attack surface analyzed
- **Time to Detection**: Speed of vulnerability identification in CI/CD pipeline

### Compliance and Risk Metrics

- **Compliance Score**: Percentage alignment with regulatory requirements
- **Risk Reduction**: Quantified reduction in security risk exposure
- **Remediation Rate**: Speed of vulnerability fix implementation
- **Security Debt**: Accumulation of unaddressed security issues over time

### Process Improvement Indicators

- **Automation Effectiveness**: Reduction in manual security review time
- **Developer Security Awareness**: Improvement in secure coding practices
- **Security Integration**: Seamless security process integration in development workflow
- **Incident Prevention**: Reduction in security incidents through proactive assessment

## Best Practices

### Assessment Preparation

1. **Threat Model Alignment**: Ensure assessment scope matches identified threats
2. **Compliance Mapping**: Map assessment criteria to specific compliance requirements
3. **Tool Configuration**: Properly configure security tools for maximum effectiveness
4. **Baseline Establishment**: Document current security posture for comparison

### Assessment Execution

1. **Comprehensive Coverage**: Assess all components of the application ecosystem
2. **Risk-Based Prioritization**: Focus on highest-risk vulnerabilities first
3. **Context-Aware Analysis**: Consider business context in security recommendations
4. **Collaborative Approach**: Involve development and security teams in assessment

### Remediation Planning

1. **Prioritized Roadmap**: Create risk-based remediation priority list
2. **Resource Allocation**: Ensure adequate resources for security improvements
3. **Timeline Management**: Set realistic timelines for vulnerability remediation
4. **Verification Process**: Implement verification steps for remediation effectiveness

## Common Pitfalls and Solutions

### Alert Fatigue

**Problem**: Too many low-priority security alerts overwhelming teams
**Solution**: Implement intelligent alert prioritization and risk-based filtering

### Tool Sprawl

**Problem**: Multiple security tools with inconsistent results and management overhead
**Solution**: Consolidate tools and implement unified security dashboard

### Compliance Theater

**Problem**: Focus on compliance checkboxes rather than actual security improvement
**Solution**: Emphasize risk reduction and business impact alongside compliance metrics

### Developer Resistance

**Problem**: Security assessments seen as impediment to development velocity
**Solution**: Integrate security seamlessly into development workflow with clear value proposition

## Advanced Optimization Strategies

### AI-Enhanced Security Analysis

- **Behavioral Anomaly Detection**: ML-powered identification of unusual security patterns
- **Threat Intelligence Integration**: AI-powered correlation of threats with codebase vulnerabilities
- **Automated Remediation**: AI-suggested fixes for common vulnerability patterns
- **Predictive Security**: Forecasting potential security issues based on code changes

### DevSecOps Integration

- **Shift-Left Security**: Early-stage security integration in development lifecycle
- **Security as Code**: Infrastructure and security policy management through code
- **Continuous Compliance**: Automated compliance monitoring and reporting
- **Security Feedback Loops**: Real-time security feedback to developers during coding

### Threat-Informed Defense

- **Attack Path Analysis**: Mapping potential attack paths through system architecture
- **Red Team Integration**: Incorporating offensive security insights into assessments
- **Threat Hunting**: Proactive searching for indicators of compromise
- **Intelligence-Driven Security**: Using threat intelligence to prioritize security efforts