---

type: "template"
template_category: "intelligent-review"
use_case: "archived-category-file"
title: "Category 2: Architecture Review Frameworks Templates"
description: "Advanced templates for reviewing system architecture, design patterns, and scalability considerations"
content_type: "prompt_template_category"
principle: "intelligent-review"
category: "architecture-review-frameworks"
template_count: 2
complexity_levels: ["advanced", "expert"]
target_audience: "senior_developers,architects"
integration_requirements: ["claude-code", "architecture-tools", "design-reviews"]
last_updated: "2025-06-25"
---

# Category 2: Architecture Review Frameworks Templates

## Overview

These templates focus on high-level architectural concerns including pattern consistency, scalability analysis, and system design validation. They are designed for senior developers and architects who need to evaluate complex system designs and distributed architectures.

## Templates in This Category

### Template 5.5: Architecture Review Focus
**Complexity:** Advanced | **Estimated Time Savings:** 45-60 minutes per review

#### Template
```
You are a senior architect conducting an architecture review. Please analyze the proposed design and provide comprehensive feedback on:

**Architectural Patterns:**
- Is the chosen architectural pattern (MVC, microservices, event-driven, etc.) appropriate for the use case?
- Are design patterns applied correctly and consistently?
- Is the separation of concerns clear and well-defined?

**Scalability Analysis:**
- How will this architecture scale with increased load?
- Are there potential bottlenecks in the design?
- Is horizontal and vertical scaling considered?

**System Integration:**
- How does this component integrate with existing systems?
- Are API contracts and interfaces well-defined?
- Is backward compatibility maintained where required?

**Data Architecture:**
- Is the data model appropriate for the access patterns?
- Are data consistency requirements addressed?
- Is the chosen database technology suitable for the use case?

**Non-Functional Requirements:**
- Are performance, security, and reliability requirements addressed?
- Is monitoring and observability built into the design?
- Are disaster recovery and backup strategies considered?

**Technology Choices:**
- Are the selected technologies appropriate for the problem domain?
- Is the technology stack cohesive and maintainable?
- Are licensing, support, and long-term viability considered?

**Design Documentation to Review:**
[PASTE_ARCHITECTURE_DIAGRAMS_OR_DESCRIPTIONS]

**System Context:**
- **Current Architecture**: [Describe existing system]
- **Business Requirements**: [Key functional requirements]
- **Scale Requirements**: [Expected load, users, data volume]
- **Technology Constraints**: [Existing tech stack, compliance requirements]

Provide specific recommendations for architectural improvements with alternative approaches where applicable.
```

#### Usage Context
- **When to Use**: New system design, major refactoring, architecture decision records
- **Best For**: Microservice architectures, distributed systems, high-scale applications
- **Integration**: Essential for architecture decision documentation and design reviews

#### Effectiveness Metrics
- **Architecture Quality**: 60% improvement in architecture review completeness
- **Scalability Issues**: 75% reduction in post-deployment scalability problems
- **Technical Debt**: 50% reduction in architecture-related technical debt

#### Customization Guidelines
```markdown
**For Your Organization:**
- Add company-specific architecture standards and patterns
- Include compliance requirements (SOC2, HIPAA, PCI-DSS)
- Modify scalability thresholds based on organizational needs
- Add technology approval processes and preferred stacks
```

#### Real-World Application Example
```yaml
# Example: Microservices Architecture Review
System: E-commerce Platform Migration
Pattern: Event-Driven Microservices
Key Concerns:
  - Service boundary definition
  - Event schema evolution
  - Cross-service transaction handling
  - Service discovery and load balancing

Review Focus:
  - Domain-driven design alignment
  - Event sourcing appropriateness
  - SAGA pattern implementation
  - Circuit breaker placement
```

---

### Template 5.8: Distributed System Review
**Complexity:** Expert | **Estimated Time Savings:** 60-90 minutes per review

#### Template
```
You are reviewing a distributed system design. Please provide expert-level analysis on:

**Distributed System Fundamentals:**
- Is the CAP theorem trade-off (Consistency, Availability, Partition tolerance) appropriate?
- Are consistency models (eventual, strong, causal) correctly chosen and implemented?
- Is the system resilient to network partitions and node failures?

**Communication Patterns:**
- Are synchronous vs asynchronous communication patterns appropriately chosen?
- Is message serialization and protocol selection optimal?
- Are communication timeouts and retry mechanisms properly implemented?

**Data Distribution:**
- Is data partitioning/sharding strategy appropriate?
- Are data replication and consistency mechanisms correctly designed?
- Is conflict resolution strategy defined for distributed data?

**Fault Tolerance & Resilience:**
- Are circuit breakers, bulkheads, and timeout patterns implemented?
- Is graceful degradation possible when dependencies fail?
- Are fallback mechanisms and error handling comprehensive?

**Service Discovery & Load Balancing:**
- Is service discovery mechanism appropriate for the deployment environment?
- Are load balancing strategies suitable for the traffic patterns?
- Is service health checking and automatic failover implemented?

**Observability & Monitoring:**
- Is distributed tracing implemented for request flow visibility?
- Are metrics and logging designed for distributed debugging?
- Is alerting and incident response planned for distributed failures?

**Security in Distribution:**
- Is inter-service communication secured (mTLS, service mesh)?
- Are authentication and authorization distributed appropriately?
- Is security maintained across service boundaries?

**Design Documentation to Review:**
[PASTE_DISTRIBUTED_SYSTEM_DESIGN]

**System Specifications:**
- **Service Count**: [Number of services]
- **Expected Scale**: [RPS, concurrent users, data volume]
- **Geographic Distribution**: [Multi-region, edge deployment]
- **Consistency Requirements**: [Strong/eventual consistency needs]
- **Deployment Environment**: [Kubernetes, cloud provider, on-premises]

Provide expert recommendations for distributed system optimization and risk mitigation.
```

#### Usage Context
- **When to Use**: Microservices deployments, distributed databases, multi-region systems
- **Best For**: High-scale systems, mission-critical applications, complex service meshes
- **Integration**: Critical for enterprise architecture reviews and system reliability assessments

#### Effectiveness Metrics
- **System Reliability**: 80% improvement in distributed system uptime
- **Failure Recovery**: 70% faster mean time to recovery (MTTR)
- **Operational Complexity**: 40% reduction in distributed system operational issues

#### Advanced Implementation Patterns

##### Pattern 1: Event-Driven Architecture Review
```yaml
Focus Areas:
  - Event schema design and evolution
  - Event ordering and idempotency
  - Dead letter queue handling
  - Event store design and partitioning
  
Critical Questions:
  - Is event sourcing appropriate for the domain?
  - Are event handlers idempotent?
  - How is event schema evolution handled?
  - What is the event retention and replay strategy?
```

##### Pattern 2: CQRS (Command Query Responsibility Segregation) Review
```yaml
Focus Areas:
  - Command and query model separation
  - Read model consistency strategies
  - Command validation and business rules
  - Event store and projection management
  
Critical Questions:
  - Is the read/write workload split justified?
  - How is eventual consistency communicated to users?
  - Are projections resilient to replay scenarios?
  - What is the strategy for projection rebuilds?
```

##### Pattern 3: Service Mesh Architecture Review
```yaml
Focus Areas:
  - Service-to-service communication security
  - Traffic management and routing
  - Observability and monitoring
  - Performance impact assessment
  
Critical Questions:
  - Is the service mesh overhead justified?
  - Are security policies correctly configured?
  - Is traffic splitting/canary deployment supported?
  - How is mesh configuration managed and versioned?
```

#### Integration with Enterprise Tools
```yaml
# Architecture Documentation Integration
Tools:
  - C4 Model diagrams (Context, Container, Component, Code)
  - ADR (Architecture Decision Records)
  - Service dependency mapping
  - Performance benchmarking results

Review Checklist:
  - Service ownership and responsibility clarity
  - Inter-service contract versioning
  - Deployment pipeline dependencies
  - Rollback and disaster recovery procedures
```

#### Success Metrics for Enterprise Adoption
- **Architecture Documentation Quality**: 90% completion rate for ADRs
- **Cross-Team Understanding**: 75% reduction in architecture-related questions
- **System Evolution**: 60% faster feature delivery with architectural consistency
- **Incident Reduction**: 50% fewer architecture-related production incidents

---

## Category Implementation Strategy

### Adoption Roadmap
1. **Phase 1**: Start with Template 5.5 for standard architecture reviews
2. **Phase 2**: Introduce Template 5.8 for complex distributed systems
3. **Phase 3**: Customize templates based on organizational architecture patterns
4. **Phase 4**: Integrate with ADR processes and architecture governance

### Integration with Architecture Governance
```yaml
# Governance Integration Pattern
Architecture Review Gates:
  - Design Phase: Template 5.5 for initial architecture validation
  - Implementation Phase: Template 5.8 for detailed technical review
  - Pre-Production: Both templates for comprehensive assessment
  
Documentation Requirements:
  - ADR creation triggered by architecture reviews
  - C4 diagrams updated based on review feedback
  - Security and compliance sign-offs incorporated
```

### Team Training and Adoption
- **Senior Developers**: Focus on Template 5.5 for general architecture awareness
- **Principal Engineers**: Master Template 5.8 for complex system design
- **Architects**: Use both templates as foundation for custom review processes
- **Product Teams**: Understand review outcomes for informed decision-making

---

*These architecture review templates ensure systematic evaluation of complex system designs, promoting consistency, scalability, and reliability across distributed systems.*