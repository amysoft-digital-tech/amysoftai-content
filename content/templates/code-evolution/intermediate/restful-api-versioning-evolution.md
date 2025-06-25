---
title: "RESTful API Versioning and Evolution Strategy Template"
description: "Comprehensive template for designing and implementing RESTful API versioning strategies that enable backward compatibility, seamless evolution, and consumer migration"
type: "template"
template_category: "code-evolution"
template_subcategory: "api-evolution"
tier: "advanced"
template_id: "CE-008"
template_version: "1.0"
validation_status: "tested"
use_case: "api-versioning"
target_scenario: "Designing and implementing API versioning strategies for backward compatibility and seamless consumer migration"
complexity_level: "intermediate"
risk_level: "moderate"
effectiveness_metrics: ["backward_compatibility", "migration_success_rate", "api_adoption"]
estimated_time_savings: "70-85%"
prerequisites: ["rest_api_design", "api_management", "versioning_strategies", "consumer_management"]
estimated_reading_time: "30 minutes"
word_count: 12000
last_updated: "2025-06-25"
content_status: "final"
---

# RESTful API Versioning and Evolution Strategy Template

## Template Overview

This template provides a comprehensive framework for designing and implementing RESTful API versioning strategies that enable backward compatibility, seamless evolution, and efficient consumer migration. The approach emphasizes systematic version management, deprecation strategies, and automated migration tools that minimize disruption while enabling continuous API improvement.

## Usage Context

Use this template when:
- API evolution requires breaking changes that affect existing consumers
- Multiple API versions need to be maintained simultaneously for different consumer groups
- Consumer migration from legacy API versions needs to be managed systematically
- API design patterns need standardization across multiple services and teams
- Backward compatibility requirements create complexity in API development

## Template Structure

### API Versioning Strategy Context Setup

```
**Context**: RESTful API versioning and evolution for {PROJECT_NAME}

**Current API Landscape**:
- Existing API versions: {CURRENT_VERSIONS_USAGE_STATISTICS}
- Consumer applications: {CLIENT_TYPES_INTEGRATION_PATTERNS}
- Breaking change frequency: {CHANGE_PATTERNS_TIMELINE}
- Business requirements: {FEATURE_EVOLUTION_DRIVERS}
- Technical constraints: {INFRASTRUCTURE_COMPATIBILITY_REQUIREMENTS}

**Versioning Objectives**:
- Backward compatibility: {COMPATIBILITY_REQUIREMENTS_TIMELINE}
- Consumer migration: {MIGRATION_STRATEGY_TIMELINE}
- Version lifecycle: {SUPPORT_DEPRECATION_POLICIES}
- API evolution: {FEATURE_ROADMAP_REQUIREMENTS}
- Developer experience: {DOCUMENTATION_TOOLING_EXPECTATIONS}

**Evolution Requirements**:
- Breaking change management: {CHANGE_APPROVAL_PROCESSES}
- Consumer communication: {NOTIFICATION_MIGRATION_SUPPORT}
- Performance requirements: {LATENCY_THROUGHPUT_TARGETS}
- Security evolution: {AUTHENTICATION_AUTHORIZATION_UPDATES}
```

### Comprehensive API Versioning Framework

```
**Primary API Versioning Request**: Design and implement comprehensive API versioning strategy with evolution management:

**API Analysis Scope**:
[PROVIDE_CURRENT_API_STRUCTURE_CONSUMER_ANALYSIS]

**API Versioning Strategy**:

1. **Versioning Strategy Design and Implementation**:
   - Analyze current API structure and consumer usage patterns
   - Design versioning scheme (semantic versioning, date-based, or custom)
   - Implement version negotiation mechanisms (URL, header, or query parameter)
   - Establish version lifecycle policies and support timelines

2. **Backward Compatibility and Migration Planning**:
   - Design backward-compatible change patterns and guidelines
   - Implement API evolution strategies that minimize breaking changes
   - Create consumer migration tools and automated compatibility testing
   - Establish deprecation timelines and communication processes

3. **Version Management Infrastructure**:
   - Implement API gateway configuration for version routing
   - Design automated testing for multiple API versions
   - Create monitoring and analytics for version usage patterns
   - Establish CI/CD pipelines supporting multiple version deployment

4. **Consumer Experience and Documentation**:
   - Design comprehensive API documentation with version-specific examples
   - Implement interactive API explorers and testing tools
   - Create migration guides and automated code generation tools
   - Establish developer support and communication channels

5. **Governance and Lifecycle Management**:
   - Implement API change review and approval processes
   - Design metrics and monitoring for API health and adoption
   - Create automated deprecation warnings and sunset procedures
   - Establish API performance and SLA monitoring across versions

**Generate the following deliverables**:
- Comprehensive API versioning strategy with implementation guidelines
- Version management infrastructure with automated deployment and testing
- Consumer migration tools and backward compatibility validation
- API documentation framework with version-specific guidance
- Governance processes with change management and lifecycle policies
```

## Implementation Examples

### Node.js Express API Versioning with Semantic Versioning

```
**Context**: Node.js Express API implementing semantic versioning with consumer migration support

**API Versioning Implementation Request**: Implement comprehensive versioning strategy for Node.js REST API:

**Current API Structure**:
```javascript
// Legacy unversioned API structure
const express = require('express');
const app = express();

// Current unversioned endpoints
app.get('/users', (req, res) => {
    // Legacy user listing without versioning
    res.json(users);
});

app.get('/users/:id', (req, res) => {
    // Legacy user retrieval
    const user = users.find(u => u.id === req.params.id);
    res.json(user);
});

app.post('/users', (req, res) => {
    // Legacy user creation
    const newUser = createUser(req.body);
    res.status(201).json(newUser);
});
```

**Versioned API Implementation**:
```javascript
// Modern versioned API implementation
const express = require('express');
const semver = require('semver');
const app = express();

// API versioning middleware
class APIVersionManager {
    constructor() {
        this.supportedVersions = ['1.0.0', '1.1.0', '2.0.0'];
        this.defaultVersion = '2.0.0';
        this.deprecatedVersions = new Map([
            ['1.0.0', { deprecatedAt: '2024-01-01', sunsetAt: '2024-06-01' }]
        ]);
    }
    
    // Version negotiation middleware
    versionMiddleware() {
        return (req, res, next) => {
            // Extract version from multiple sources
            const requestedVersion = this.extractVersion(req);
            const resolvedVersion = this.resolveVersion(requestedVersion);
            
            // Add version context to request
            req.apiVersion = resolvedVersion;
            req.apiVersionInfo = {
                requested: requestedVersion,
                resolved: resolvedVersion,
                deprecated: this.isDeprecated(resolvedVersion),
                sunset: this.getSunsetInfo(resolvedVersion)
            };
            
            // Add version headers to response
            res.set('API-Version', resolvedVersion);
            res.set('API-Supported-Versions', this.supportedVersions.join(','));
            
            // Add deprecation warnings
            if (req.apiVersionInfo.deprecated) {
                res.set('Deprecation', req.apiVersionInfo.sunset.sunsetAt);
                res.set('Sunset', req.apiVersionInfo.sunset.sunsetAt);
            }
            
            next();
        };
    }
    
    extractVersion(req) {
        // Priority: Accept header > URL parameter > Query parameter > Default
        
        // 1. Check Accept header (application/vnd.api+json;version=2.0.0)
        const acceptHeader = req.get('Accept');
        if (acceptHeader) {
            const versionMatch = acceptHeader.match(/version=([0-9.]+)/);
            if (versionMatch) {
                return versionMatch[1];
            }
        }
        
        // 2. Check custom API-Version header
        const versionHeader = req.get('API-Version');
        if (versionHeader) {
            return versionHeader;
        }
        
        // 3. Check URL path (/v2/users)
        const pathMatch = req.path.match(/^\/v([0-9.]+)\//);
        if (pathMatch) {
            return pathMatch[1] + '.0'; // Convert v2 to 2.0.0
        }
        
        // 4. Check query parameter (?version=2.0.0)
        if (req.query.version) {
            return req.query.version;
        }
        
        // 5. Default version
        return this.defaultVersion;
    }
    
    resolveVersion(requestedVersion) {
        // Find best matching supported version
        const satisfied = semver.maxSatisfying(this.supportedVersions, `^${requestedVersion}`);
        return satisfied || this.defaultVersion;
    }
    
    isDeprecated(version) {
        return this.deprecatedVersions.has(version);
    }
    
    getSunsetInfo(version) {
        return this.deprecatedVersions.get(version) || null;
    }
}

// Version-specific route handlers
class VersionedUserController {
    constructor() {
        this.versionHandlers = new Map();
        this.setupVersionHandlers();
    }
    
    setupVersionHandlers() {
        // Version 1.0.0 handlers (deprecated)
        this.versionHandlers.set('1.0.0', {
            getUsers: this.getUsersV1.bind(this),
            getUser: this.getUserV1.bind(this),
            createUser: this.createUserV1.bind(this)
        });
        
        // Version 1.1.0 handlers
        this.versionHandlers.set('1.1.0', {
            getUsers: this.getUsersV1_1.bind(this),
            getUser: this.getUserV1_1.bind(this),
            createUser: this.createUserV1_1.bind(this)
        });
        
        // Version 2.0.0 handlers (current)
        this.versionHandlers.set('2.0.0', {
            getUsers: this.getUsersV2.bind(this),
            getUser: this.getUserV2.bind(this),
            createUser: this.createUserV2.bind(this)
        });
    }
    
    // Version 1.0.0 - Legacy format
    async getUsersV1(req, res) {
        const users = await userService.getAllUsers();
        
        // Transform to v1 format (flat structure)
        const v1Users = users.map(user => ({
            id: user.id,
            name: `${user.firstName} ${user.lastName}`,
            email: user.email,
            created: user.createdAt
        }));
        
        res.json(v1Users);
    }
    
    async getUserV1(req, res) {
        const user = await userService.getUserById(req.params.id);
        
        if (!user) {
            return res.status(404).json({ error: 'User not found' });
        }
        
        // Transform to v1 format
        const v1User = {
            id: user.id,
            name: `${user.firstName} ${user.lastName}`,
            email: user.email,
            created: user.createdAt
        };
        
        res.json(v1User);
    }
    
    async createUserV1(req, res) {
        // Parse v1 format input
        const userData = {
            firstName: req.body.name?.split(' ')[0] || '',
            lastName: req.body.name?.split(' ')[1] || '',
            email: req.body.email
        };
        
        const user = await userService.createUser(userData);
        
        // Return in v1 format
        const v1User = {
            id: user.id,
            name: `${user.firstName} ${user.lastName}`,
            email: user.email,
            created: user.createdAt
        };
        
        res.status(201).json(v1User);
    }
    
    // Version 1.1.0 - Added pagination and filtering
    async getUsersV1_1(req, res) {
        const { page = 1, limit = 10, filter } = req.query;
        const options = { page: parseInt(page), limit: parseInt(limit), filter };
        
        const result = await userService.getUsersPaginated(options);
        
        // Transform to v1.1 format (flat structure with pagination)
        const v1_1Users = result.users.map(user => ({
            id: user.id,
            name: `${user.firstName} ${user.lastName}`,
            email: user.email,
            created: user.createdAt
        }));
        
        res.json({
            users: v1_1Users,
            pagination: {
                page: result.page,
                limit: result.limit,
                total: result.total,
                pages: Math.ceil(result.total / result.limit)
            }
        });
    }
    
    // Version 2.0.0 - Modern structured format with full profile
    async getUsersV2(req, res) {
        const { page = 1, limit = 10, include, sort } = req.query;
        const options = { 
            page: parseInt(page), 
            limit: parseInt(limit), 
            include: include ? include.split(',') : [],
            sort: sort || 'createdAt'
        };
        
        const result = await userService.getUsersAdvanced(options);
        
        // Transform to v2 format (structured with nested objects)
        const v2Users = result.users.map(user => ({
            id: user.id,
            profile: {
                firstName: user.firstName,
                lastName: user.lastName,
                email: user.email,
                avatar: user.avatar
            },
            metadata: {
                createdAt: user.createdAt,
                updatedAt: user.updatedAt,
                lastLoginAt: user.lastLoginAt,
                status: user.status
            },
            ...(options.include.includes('preferences') && {
                preferences: user.preferences
            }),
            ...(options.include.includes('statistics') && {
                statistics: user.statistics
            })
        }));
        
        res.json({
            data: v2Users,
            meta: {
                pagination: {
                    currentPage: result.page,
                    itemsPerPage: result.limit,
                    totalItems: result.total,
                    totalPages: Math.ceil(result.total / result.limit)
                },
                sort: options.sort,
                includes: options.include
            },
            links: {
                self: req.originalUrl,
                ...(result.page > 1 && {
                    prev: this.buildPageUrl(req, result.page - 1)
                }),
                ...(result.page < Math.ceil(result.total / result.limit) && {
                    next: this.buildPageUrl(req, result.page + 1)
                })
            }
        });
    }
    
    // Route handler that delegates to version-specific implementation
    async handleGetUsers(req, res) {
        const version = req.apiVersion;
        const handler = this.versionHandlers.get(version);
        
        if (!handler) {
            return res.status(400).json({
                error: 'Unsupported API version',
                version: version,
                supportedVersions: Array.from(this.versionHandlers.keys())
            });
        }
        
        try {
            await handler.getUsers(req, res);
        } catch (error) {
            console.error(`Error in getUsersV${version}:`, error);
            res.status(500).json({
                error: 'Internal server error',
                version: version
            });
        }
    }
}

// API Documentation generator for versioned endpoints
class APIDocumentationGenerator {
    constructor(versionManager) {
        this.versionManager = versionManager;
    }
    
    generateOpenAPISpec(version) {
        const baseSpec = {
            openapi: '3.0.0',
            info: {
                title: 'User Management API',
                version: version,
                description: `User Management API v${version}`
            },
            servers: [
                {
                    url: `https://api.example.com/v${version.split('.')[0]}`,
                    description: `Production server for v${version}`
                }
            ]
        };
        
        // Version-specific paths and schemas
        switch (version) {
            case '1.0.0':
                return this.generateV1Spec(baseSpec);
            case '1.1.0':
                return this.generateV1_1Spec(baseSpec);
            case '2.0.0':
                return this.generateV2Spec(baseSpec);
            default:
                throw new Error(`Unsupported version: ${version}`);
        }
    }
    
    generateV1Spec(baseSpec) {
        return {
            ...baseSpec,
            paths: {
                '/users': {
                    get: {
                        summary: 'Get all users',
                        responses: {
                            '200': {
                                description: 'List of users',
                                content: {
                                    'application/json': {
                                        schema: {
                                            type: 'array',
                                            items: { $ref: '#/components/schemas/UserV1' }
                                        }
                                    }
                                }
                            }
                        }
                    },
                    post: {
                        summary: 'Create a new user',
                        requestBody: {
                            required: true,
                            content: {
                                'application/json': {
                                    schema: { $ref: '#/components/schemas/CreateUserV1' }
                                }
                            }
                        },
                        responses: {
                            '201': {
                                description: 'User created successfully',
                                content: {
                                    'application/json': {
                                        schema: { $ref: '#/components/schemas/UserV1' }
                                    }
                                }
                            }
                        }
                    }
                }
            },
            components: {
                schemas: {
                    UserV1: {
                        type: 'object',
                        properties: {
                            id: { type: 'string' },
                            name: { type: 'string' },
                            email: { type: 'string', format: 'email' },
                            created: { type: 'string', format: 'date-time' }
                        }
                    },
                    CreateUserV1: {
                        type: 'object',
                        required: ['name', 'email'],
                        properties: {
                            name: { type: 'string' },
                            email: { type: 'string', format: 'email' }
                        }
                    }
                }
            }
        };
    }
    
    generateV2Spec(baseSpec) {
        return {
            ...baseSpec,
            paths: {
                '/users': {
                    get: {
                        summary: 'Get users with advanced filtering and pagination',
                        parameters: [
                            {
                                name: 'page',
                                in: 'query',
                                schema: { type: 'integer', minimum: 1, default: 1 }
                            },
                            {
                                name: 'limit',
                                in: 'query',
                                schema: { type: 'integer', minimum: 1, maximum: 100, default: 10 }
                            },
                            {
                                name: 'include',
                                in: 'query',
                                schema: { type: 'string' },
                                description: 'Comma-separated list of additional data to include'
                            }
                        ],
                        responses: {
                            '200': {
                                description: 'Paginated list of users',
                                content: {
                                    'application/json': {
                                        schema: { $ref: '#/components/schemas/PaginatedUsersV2' }
                                    }
                                }
                            }
                        }
                    }
                }
            },
            components: {
                schemas: {
                    UserV2: {
                        type: 'object',
                        properties: {
                            id: { type: 'string' },
                            profile: { $ref: '#/components/schemas/UserProfile' },
                            metadata: { $ref: '#/components/schemas/UserMetadata' },
                            preferences: { $ref: '#/components/schemas/UserPreferences' },
                            statistics: { $ref: '#/components/schemas/UserStatistics' }
                        }
                    },
                    UserProfile: {
                        type: 'object',
                        properties: {
                            firstName: { type: 'string' },
                            lastName: { type: 'string' },
                            email: { type: 'string', format: 'email' },
                            avatar: { type: 'string', format: 'uri' }
                        }
                    },
                    UserMetadata: {
                        type: 'object',
                        properties: {
                            createdAt: { type: 'string', format: 'date-time' },
                            updatedAt: { type: 'string', format: 'date-time' },
                            lastLoginAt: { type: 'string', format: 'date-time' },
                            status: { type: 'string', enum: ['active', 'inactive', 'suspended'] }
                        }
                    },
                    PaginatedUsersV2: {
                        type: 'object',
                        properties: {
                            data: {
                                type: 'array',
                                items: { $ref: '#/components/schemas/UserV2' }
                            },
                            meta: { $ref: '#/components/schemas/PaginationMeta' },
                            links: { $ref: '#/components/schemas/PaginationLinks' }
                        }
                    }
                }
            }
        };
    }
}

// Application setup with versioning
const versionManager = new APIVersionManager();
const userController = new VersionedUserController();
const docGenerator = new APIDocumentationGenerator(versionManager);

// Apply versioning middleware globally
app.use(versionManager.versionMiddleware());

// Version-agnostic routes that delegate to version-specific handlers
app.get('/users', userController.handleGetUsers.bind(userController));
app.get('/users/:id', userController.handleGetUser.bind(userController));
app.post('/users', userController.handleCreateUser.bind(userController));

// API documentation endpoints
app.get('/docs/:version/openapi.json', (req, res) => {
    try {
        const spec = docGenerator.generateOpenAPISpec(req.params.version);
        res.json(spec);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
});

// Version information endpoint
app.get('/version', (req, res) => {
    res.json({
        currentVersion: req.apiVersion,
        supportedVersions: versionManager.supportedVersions,
        deprecationInfo: req.apiVersionInfo.deprecated ? {
            deprecated: true,
            sunsetDate: req.apiVersionInfo.sunset.sunsetAt
        } : null
    });
});
```

**Consumer Migration Tools**:
```javascript
// Migration helper tools for API consumers
class APIMigrationHelper {
    constructor(baseUrl) {
        this.baseUrl = baseUrl;
        this.migrationRules = new Map();
        this.setupMigrationRules();
    }
    
    setupMigrationRules() {
        // Migration from v1.0.0 to v2.0.0
        this.migrationRules.set('1.0.0->2.0.0', {
            requestTransform: this.transformV1RequestToV2.bind(this),
            responseTransform: this.transformV2ResponseToV1.bind(this),
            breakingChanges: [
                'Response structure changed from flat to nested',
                'Pagination format changed',
                'Date fields renamed and format changed',
                'Error response format updated'
            ]
        });
    }
    
    // Backward compatibility layer for existing v1 clients
    async callV1CompatibleEndpoint(endpoint, options = {}) {
        const { method = 'GET', data, headers = {} } = options;
        
        // Call v2 API
        const v2Response = await this.makeAPICall(endpoint, {
            method,
            data: this.transformV1RequestToV2(data),
            headers: {
                ...headers,
                'API-Version': '2.0.0'
            }
        });
        
        // Transform v2 response back to v1 format
        return this.transformV2ResponseToV1(v2Response);
    }
    
    transformV1RequestToV2(v1Data) {
        if (!v1Data) return v1Data;
        
        // Transform v1 user creation request to v2 format
        if (v1Data.name && v1Data.email) {
            const nameParts = v1Data.name.split(' ');
            return {
                profile: {
                    firstName: nameParts[0] || '',
                    lastName: nameParts.slice(1).join(' ') || '',
                    email: v1Data.email
                }
            };
        }
        
        return v1Data;
    }
    
    transformV2ResponseToV1(v2Response) {
        if (!v2Response) return v2Response;
        
        // Transform v2 user response to v1 format
        if (v2Response.data && Array.isArray(v2Response.data)) {
            // Handle paginated response
            return v2Response.data.map(user => ({
                id: user.id,
                name: `${user.profile.firstName} ${user.profile.lastName}`,
                email: user.profile.email,
                created: user.metadata.createdAt
            }));
        } else if (v2Response.profile) {
            // Handle single user response
            return {
                id: v2Response.id,
                name: `${v2Response.profile.firstName} ${v2Response.profile.lastName}`,
                email: v2Response.profile.email,
                created: v2Response.metadata.createdAt
            };
        }
        
        return v2Response;
    }
    
    // Generate migration code for different programming languages
    generateMigrationCode(fromVersion, toVersion, language = 'javascript') {
        const migrationKey = `${fromVersion}->${toVersion}`;
        const migration = this.migrationRules.get(migrationKey);
        
        if (!migration) {
            throw new Error(`No migration path from ${fromVersion} to ${toVersion}`);
        }
        
        switch (language) {
            case 'javascript':
                return this.generateJavaScriptMigration(fromVersion, toVersion, migration);
            case 'python':
                return this.generatePythonMigration(fromVersion, toVersion, migration);
            case 'java':
                return this.generateJavaMigration(fromVersion, toVersion, migration);
            default:
                throw new Error(`Unsupported language: ${language}`);
        }
    }
    
    generateJavaScriptMigration(fromVersion, toVersion, migration) {
        return `
// Migration from API v${fromVersion} to v${toVersion}
// Breaking changes:
${migration.breakingChanges.map(change => `// - ${change}`).join('\n')}

class APIClient {
    constructor(baseUrl) {
        this.baseUrl = baseUrl;
        this.version = '${toVersion}';
    }
    
    async getUsers(page = 1, limit = 10) {
        const response = await fetch(\`\${this.baseUrl}/users?page=\${page}&limit=\${limit}\`, {
            headers: {
                'API-Version': this.version,
                'Accept': 'application/json'
            }
        });
        
        const data = await response.json();
        
        // v${toVersion} returns structured response
        return {
            users: data.data,
            pagination: data.meta.pagination
        };
    }
    
    async createUser(userData) {
        // v${toVersion} expects structured profile data
        const requestData = {
            profile: {
                firstName: userData.firstName,
                lastName: userData.lastName,
                email: userData.email
            }
        };
        
        const response = await fetch(\`\${this.baseUrl}/users\`, {
            method: 'POST',
            headers: {
                'API-Version': this.version,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(requestData)
        });
        
        return response.json();
    }
}

// Usage example
const client = new APIClient('https://api.example.com');
const users = await client.getUsers(1, 20);
`;
    }
}

// Automated testing for API version compatibility
class APIVersionCompatibilityTester {
    constructor() {
        this.testSuites = new Map();
    }
    
    async runCompatibilityTests(versions) {
        const results = new Map();
        
        for (const version of versions) {
            const testSuite = this.testSuites.get(version);
            if (testSuite) {
                results.set(version, await this.runTestSuite(testSuite, version));
            }
        }
        
        return results;
    }
    
    async runTestSuite(testSuite, version) {
        const results = {
            version,
            totalTests: testSuite.length,
            passed: 0,
            failed: 0,
            errors: []
        };
        
        for (const test of testSuite) {
            try {
                await test.run(version);
                results.passed++;
            } catch (error) {
                results.failed++;
                results.errors.push({
                    test: test.name,
                    error: error.message
                });
            }
        }
        
        return results;
    }
}
```

**Expected Deliverables**:
- Comprehensive semantic versioning implementation with automated version resolution
- Version-specific route handlers maintaining backward compatibility
- Migration tools and compatibility layers for consumer applications
- Automated API documentation generation for all supported versions
- Deprecation management with sunset timelines and warning systems

Generate the implementation focusing on:
1. Semantic versioning with intelligent version negotiation and resolution
2. Backward compatibility maintenance through version-specific transformers
3. Consumer migration tools with automated code generation capabilities
4. Comprehensive API documentation with version-specific examples
5. Governance processes with deprecation management and lifecycle policies
```

### Spring Boot Java API Versioning with Content Negotiation

```
**Context**: Spring Boot Java API implementing content negotiation versioning with enterprise governance

**API Versioning Implementation Request**: Implement enterprise-grade API versioning for Spring Boot application:

**Current Unversioned Spring Boot API**:
```java
// Legacy unversioned Spring Boot controllers
@RestController
@RequestMapping("/api/users")
public class UserController {
    
    @Autowired
    private UserService userService;
    
    // Legacy unversioned endpoint
    @GetMapping
    public List<User> getUsers() {
        return userService.getAllUsers();
    }
    
    @GetMapping("/{id}")
    public User getUser(@PathVariable Long id) {
        return userService.getUserById(id);
    }
    
    @PostMapping
    public User createUser(@RequestBody User user) {
        return userService.createUser(user);
    }
}
```

**Versioned Spring Boot Implementation**:
```java
// API versioning infrastructure
@Component
public class APIVersionResolver {
    
    private static final String DEFAULT_VERSION = "2.0";
    private static final List<String> SUPPORTED_VERSIONS = Arrays.asList("1.0", "1.1", "2.0");
    private static final Map<String, String> DEPRECATED_VERSIONS = Map.of(
        "1.0", "2024-06-01"  // version -> sunset date
    );
    
    public String resolveVersion(HttpServletRequest request) {
        // Priority: Accept header > Custom header > Query param > Default
        
        // 1. Check Accept header (application/vnd.api.v2+json)
        String acceptHeader = request.getHeader("Accept");
        if (acceptHeader != null) {
            Pattern pattern = Pattern.compile("application/vnd\\.api\\.v([0-9.]+)\\+json");
            Matcher matcher = pattern.matcher(acceptHeader);
            if (matcher.find()) {
                return matcher.group(1);
            }
        }
        
        // 2. Check custom API-Version header
        String versionHeader = request.getHeader("API-Version");
        if (versionHeader != null && SUPPORTED_VERSIONS.contains(versionHeader)) {
            return versionHeader;
        }
        
        // 3. Check query parameter
        String versionParam = request.getParameter("version");
        if (versionParam != null && SUPPORTED_VERSIONS.contains(versionParam)) {
            return versionParam;
        }
        
        return DEFAULT_VERSION;
    }
    
    public boolean isVersionSupported(String version) {
        return SUPPORTED_VERSIONS.contains(version);
    }
    
    public boolean isVersionDeprecated(String version) {
        return DEPRECATED_VERSIONS.containsKey(version);
    }
    
    public String getDeprecationDate(String version) {
        return DEPRECATED_VERSIONS.get(version);
    }
}

// Custom annotation for API versioning
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface APIVersion {
    String[] value();
    boolean deprecated() default false;
    String deprecationDate() default "";
}

// Aspect for API version handling
@Aspect
@Component
public class APIVersionAspect {
    
    @Autowired
    private APIVersionResolver versionResolver;
    
    @Around("@annotation(apiVersion) || @within(apiVersion)")
    public Object handleVersioning(ProceedingJoinPoint joinPoint, APIVersion apiVersion) throws Throwable {
        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        HttpServletRequest request = attributes.getRequest();
        HttpServletResponse response = attributes.getResponse();
        
        String requestedVersion = versionResolver.resolveVersion(request);
        
        // Check if version is supported
        if (!versionResolver.isVersionSupported(requestedVersion)) {
            throw new UnsupportedAPIVersionException("API version " + requestedVersion + " is not supported");
        }
        
        // Check if version is compatible with endpoint
        boolean versionCompatible = Arrays.asList(apiVersion.value()).contains(requestedVersion);
        if (!versionCompatible) {
            throw new APIVersionMismatchException("Endpoint does not support version " + requestedVersion);
        }
        
        // Add version headers to response
        response.setHeader("API-Version", requestedVersion);
        response.setHeader("API-Supported-Versions", String.join(",", versionResolver.SUPPORTED_VERSIONS));
        
        // Add deprecation warnings if needed
        if (versionResolver.isVersionDeprecated(requestedVersion)) {
            response.setHeader("Deprecation", "true");
            response.setHeader("Sunset", versionResolver.getDeprecationDate(requestedVersion));
        }
        
        // Store version in request context for use in method
        request.setAttribute("apiVersion", requestedVersion);
        
        return joinPoint.proceed();
    }
}

// Versioned controller implementation
@RestController
@RequestMapping("/api/users")
public class VersionedUserController {
    
    @Autowired
    private UserService userService;
    
    @Autowired
    private UserVersionTransformer userTransformer;
    
    // Version 1.0 endpoint (deprecated)
    @GetMapping
    @APIVersion({"1.0"})
    public ResponseEntity<List<UserV1DTO>> getUsersV1(HttpServletRequest request) {
        List<User> users = userService.getAllUsers();
        List<UserV1DTO> v1Users = users.stream()
            .map(userTransformer::toV1DTO)
            .collect(Collectors.toList());
        
        return ResponseEntity.ok(v1Users);
    }
    
    // Version 1.1 endpoint
    @GetMapping
    @APIVersion({"1.1"})
    public ResponseEntity<PagedResponse<UserV1DTO>> getUsersV1_1(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            HttpServletRequest request) {
        
        Pageable pageable = PageRequest.of(page, size);
        Page<User> userPage = userService.getUsersPaginated(pageable);
        
        List<UserV1DTO> v1Users = userPage.getContent().stream()
            .map(userTransformer::toV1DTO)
            .collect(Collectors.toList());
        
        PagedResponse<UserV1DTO> response = PagedResponse.<UserV1DTO>builder()
            .content(v1Users)
            .page(page)
            .size(size)
            .totalElements(userPage.getTotalElements())
            .totalPages(userPage.getTotalPages())
            .build();
        
        return ResponseEntity.ok(response);
    }
    
    // Version 2.0 endpoint (current)
    @GetMapping
    @APIVersion({"2.0"})
    public ResponseEntity<APIResponse<List<UserV2DTO>>> getUsersV2(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String include,
            @RequestParam(required = false) String sort,
            HttpServletRequest request) {
        
        UserQueryOptions options = UserQueryOptions.builder()
            .page(page)
            .size(size)
            .includes(include != null ? Arrays.asList(include.split(",")) : List.of())
            .sort(sort)
            .build();
        
        Page<User> userPage = userService.getUsersAdvanced(options);
        
        List<UserV2DTO> v2Users = userPage.getContent().stream()
            .map(user -> userTransformer.toV2DTO(user, options.getIncludes()))
            .collect(Collectors.toList());
        
        PaginationMeta meta = PaginationMeta.builder()
            .currentPage(page)
            .itemsPerPage(size)
            .totalItems(userPage.getTotalElements())
            .totalPages(userPage.getTotalPages())
            .build();
        
        APIResponse<List<UserV2DTO>> response = APIResponse.<List<UserV2DTO>>builder()
            .data(v2Users)
            .meta(meta)
            .links(buildPaginationLinks(request, userPage))
            .build();
        
        return ResponseEntity.ok(response);
    }
    
    // Create user with version-specific handling
    @PostMapping
    @APIVersion({"1.0", "1.1", "2.0"})
    public ResponseEntity<?> createUser(@RequestBody Object userData, HttpServletRequest request) {
        String version = (String) request.getAttribute("apiVersion");
        
        try {
            User user;
            
            switch (version) {
                case "1.0":
                case "1.1":
                    CreateUserV1Request v1Request = objectMapper.convertValue(userData, CreateUserV1Request.class);
                    user = userService.createUser(userTransformer.fromV1Request(v1Request));
                    return ResponseEntity.status(HttpStatus.CREATED)
                        .body(userTransformer.toV1DTO(user));
                
                case "2.0":
                    CreateUserV2Request v2Request = objectMapper.convertValue(userData, CreateUserV2Request.class);
                    user = userService.createUser(userTransformer.fromV2Request(v2Request));
                    
                    UserV2DTO userV2DTO = userTransformer.toV2DTO(user, List.of());
                    APIResponse<UserV2DTO> response = APIResponse.<UserV2DTO>builder()
                        .data(userV2DTO)
                        .meta(null)
                        .links(Map.of("self", "/api/users/" + user.getId()))
                        .build();
                    
                    return ResponseEntity.status(HttpStatus.CREATED)
                        .location(URI.create("/api/users/" + user.getId()))
                        .body(response);
                
                default:
                    throw new UnsupportedAPIVersionException("Unsupported version: " + version);
            }
        } catch (Exception e) {
            throw new APIProcessingException("Failed to create user", e);
        }
    }
}

// Data Transfer Objects for different API versions
public class UserV1DTO {
    private Long id;
    private String name;
    private String email;
    private LocalDateTime created;
    
    // Constructors, getters, setters
}

public class UserV2DTO {
    private Long id;
    private UserProfile profile;
    private UserMetadata metadata;
    private UserPreferences preferences;
    private UserStatistics statistics;
    
    // Constructors, getters, setters
}

public class UserProfile {
    private String firstName;
    private String lastName;
    private String email;
    private String avatar;
    
    // Constructors, getters, setters
}

// Version transformation service
@Service
public class UserVersionTransformer {
    
    public UserV1DTO toV1DTO(User user) {
        return UserV1DTO.builder()
            .id(user.getId())
            .name(user.getFirstName() + " " + user.getLastName())
            .email(user.getEmail())
            .created(user.getCreatedAt())
            .build();
    }
    
    public UserV2DTO toV2DTO(User user, List<String> includes) {
        UserV2DTO.Builder builder = UserV2DTO.builder()
            .id(user.getId())
            .profile(UserProfile.builder()
                .firstName(user.getFirstName())
                .lastName(user.getLastName())
                .email(user.getEmail())
                .avatar(user.getAvatar())
                .build())
            .metadata(UserMetadata.builder()
                .createdAt(user.getCreatedAt())
                .updatedAt(user.getUpdatedAt())
                .lastLoginAt(user.getLastLoginAt())
                .status(user.getStatus())
                .build());
        
        // Include optional data based on request
        if (includes.contains("preferences")) {
            builder.preferences(user.getPreferences());
        }
        
        if (includes.contains("statistics")) {
            builder.statistics(user.getStatistics());
        }
        
        return builder.build();
    }
    
    public User fromV1Request(CreateUserV1Request request) {
        String[] nameParts = request.getName().split(" ", 2);
        return User.builder()
            .firstName(nameParts[0])
            .lastName(nameParts.length > 1 ? nameParts[1] : "")
            .email(request.getEmail())
            .build();
    }
    
    public User fromV2Request(CreateUserV2Request request) {
        return User.builder()
            .firstName(request.getProfile().getFirstName())
            .lastName(request.getProfile().getLastName())
            .email(request.getProfile().getEmail())
            .build();
    }
}

// API governance and metrics
@Component
public class APIGovernanceService {
    
    @Autowired
    private MeterRegistry meterRegistry;
    
    @EventListener
    public void handleAPIVersionUsage(APIVersionUsageEvent event) {
        // Record metrics for version usage
        Counter.builder("api.version.usage")
            .tag("version", event.getVersion())
            .tag("endpoint", event.getEndpoint())
            .register(meterRegistry)
            .increment();
        
        // Log deprecated version usage
        if (event.isDeprecated()) {
            log.warn("Deprecated API version {} used for endpoint {} by client {}",
                event.getVersion(), event.getEndpoint(), event.getClientId());
            
            // Send notification for sunset timeline
            sendDeprecationNotification(event);
        }
    }
    
    @Scheduled(cron = "0 0 9 * * MON") // Every Monday at 9 AM
    public void generateWeeklyVersioningReport() {
        APIVersioningReport report = APIVersioningReport.builder()
            .reportDate(LocalDate.now())
            .versionUsageStatistics(calculateVersionUsageStats())
            .deprecationWarnings(calculateDeprecationWarnings())
            .migrationRecommendations(generateMigrationRecommendations())
            .build();
        
        // Send report to stakeholders
        reportNotificationService.sendVersioningReport(report);
    }
}

// Configuration for API versioning
@Configuration
@EnableWebMvc
public class APIVersioningConfiguration implements WebMvcConfigurer {
    
    @Bean
    public APIVersionResolver apiVersionResolver() {
        return new APIVersionResolver();
    }
    
    @Override
    public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
        configurer
            .favorParameter(true)
            .parameterName("version")
            .favorPathExtension(false)
            .favorParameter(true)
            .ignoreAcceptHeader(false)
            .useRegisteredExtensionsOnly(false)
            .defaultContentType(MediaType.APPLICATION_JSON)
            .mediaType("json", MediaType.APPLICATION_JSON)
            .mediaType("v1", MediaType.valueOf("application/vnd.api.v1+json"))
            .mediaType("v2", MediaType.valueOf("application/vnd.api.v2+json"));
    }
    
    @Bean
    public OpenAPI customOpenAPI() {
        return new OpenAPI()
            .info(new Info()
                .title("User Management API")
                .version("2.0")
                .description("Multi-version User Management API with backward compatibility"))
            .servers(List.of(
                new Server().url("https://api.example.com").description("Production server"),
                new Server().url("https://staging-api.example.com").description("Staging server")
            ));
    }
}
```

**Expected Deliverables**:
- Spring Boot API versioning with content negotiation and custom annotations
- Aspect-oriented version handling with automatic response header management
- Version-specific DTOs and transformation services for backward compatibility
- Enterprise governance with automated metrics and deprecation management
- OpenAPI specification generation with version-specific documentation

Generate the implementation with:
1. Content negotiation versioning with multiple resolution strategies
2. Aspect-oriented programming for cross-cutting version concerns
3. Comprehensive DTO transformation for maintaining API contracts
4. Enterprise governance with metrics, monitoring, and automated reporting
5. Integration with Spring Boot ecosystem and OpenAPI documentation
```

## Advanced API Evolution Strategies

### Breaking Change Management

```
**Systematic Breaking Change Framework**:

Comprehensive approaches to manage breaking changes with minimal consumer disruption:

**Breaking Change Analysis and Planning**:
```typescript
// TypeScript framework for breaking change analysis
interface BreakingChange {
    id: string;
    type: BreakingChangeType;
    description: string;
    affectedEndpoints: string[];
    impact: ChangeImpact;
    mitigation: MitigationStrategy;
    timeline: MigrationTimeline;
    consumerAnalysis: ConsumerImpactAnalysis;
}

enum BreakingChangeType {
    SCHEMA_CHANGE = 'schema_change',
    ENDPOINT_REMOVAL = 'endpoint_removal',
    PARAMETER_CHANGE = 'parameter_change',
    RESPONSE_FORMAT_CHANGE = 'response_format_change',
    AUTHENTICATION_CHANGE = 'authentication_change',
    BEHAVIORAL_CHANGE = 'behavioral_change'
}

class BreakingChangeAnalyzer {
    private consumerRegistry: ConsumerRegistry;
    private schemaComparator: SchemaComparator;
    
    constructor(consumerRegistry: ConsumerRegistry) {
        this.consumerRegistry = consumerRegistry;
        this.schemaComparator = new SchemaComparator();
    }
    
    analyzeProposedChanges(currentSpec: OpenAPISpec, proposedSpec: OpenAPISpec): BreakingChange[] {
        const changes: BreakingChange[] = [];
        
        // Analyze schema changes
        changes.push(...this.analyzeSchemaChanges(currentSpec, proposedSpec));
        
        // Analyze endpoint changes
        changes.push(...this.analyzeEndpointChanges(currentSpec, proposedSpec));
        
        // Analyze parameter changes
        changes.push(...this.analyzeParameterChanges(currentSpec, proposedSpec));
        
        // Analyze response changes
        changes.push(...this.analyzeResponseChanges(currentSpec, proposedSpec));
        
        return changes.map(change => this.enrichWithConsumerAnalysis(change));
    }
    
    private analyzeSchemaChanges(current: OpenAPISpec, proposed: OpenAPISpec): BreakingChange[] {
        const changes: BreakingChange[] = [];
        
        for (const [schemaName, currentSchema] of Object.entries(current.components?.schemas || {})) {
            const proposedSchema = proposed.components?.schemas?.[schemaName];
            
            if (!proposedSchema) {
                // Schema removed
                changes.push({
                    id: `schema-removed-${schemaName}`,
                    type: BreakingChangeType.SCHEMA_CHANGE,
                    description: `Schema '${schemaName}' was removed`,
                    affectedEndpoints: this.findEndpointsUsingSchema(current, schemaName),
                    impact: ChangeImpact.HIGH,
                    mitigation: this.generateSchemaMitigation(schemaName, 'removed'),
                    timeline: this.generateDefaultTimeline(),
                    consumerAnalysis: null // Will be enriched later
                });
            } else {
                // Compare schema properties
                const schemaChanges = this.schemaComparator.compare(currentSchema, proposedSchema);
                
                for (const schemaChange of schemaChanges) {
                    if (schemaChange.breaking) {
                        changes.push({
                            id: `schema-change-${schemaName}-${schemaChange.property}`,
                            type: BreakingChangeType.SCHEMA_CHANGE,
                            description: `Schema '${schemaName}' property '${schemaChange.property}' ${schemaChange.changeType}`,
                            affectedEndpoints: this.findEndpointsUsingSchema(current, schemaName),
                            impact: this.calculateSchemaChangeImpact(schemaChange),
                            mitigation: this.generateSchemaMitigation(schemaName, schemaChange.changeType),
                            timeline: this.generateDefaultTimeline(),
                            consumerAnalysis: null
                        });
                    }
                }
            }
        }
        
        return changes;
    }
    
    private enrichWithConsumerAnalysis(change: BreakingChange): BreakingChange {
        const consumers = this.consumerRegistry.getConsumersForEndpoints(change.affectedEndpoints);
        
        const analysis: ConsumerImpactAnalysis = {
            totalConsumers: consumers.length,
            highImpactConsumers: consumers.filter(c => this.isHighImpactConsumer(c, change)).length,
            estimatedMigrationEffort: this.calculateMigrationEffort(consumers, change),
            riskLevel: this.calculateRiskLevel(consumers, change),
            communicationPlan: this.generateCommunicationPlan(consumers, change)
        };
        
        return {
            ...change,
            consumerAnalysis: analysis
        };
    }
    
    generateMigrationPlan(changes: BreakingChange[]): MigrationPlan {
        // Group changes by impact and dependencies
        const highImpactChanges = changes.filter(c => c.impact === ChangeImpact.HIGH);
        const mediumImpactChanges = changes.filter(c => c.impact === ChangeImpact.MEDIUM);
        const lowImpactChanges = changes.filter(c => c.impact === ChangeImpact.LOW);
        
        const phases: MigrationPhase[] = [
            {
                phase: 1,
                name: 'Preparation and Communication',
                duration: '2 weeks',
                changes: [],
                activities: [
                    'Notify all affected consumers',
                    'Publish migration guides',
                    'Set up monitoring for deprecated endpoints',
                    'Create backward compatibility layers'
                ]
            },
            {
                phase: 2,
                name: 'Low Impact Changes',
                duration: '1 week',
                changes: lowImpactChanges,
                activities: [
                    'Deploy low-risk changes',
                    'Monitor consumer health',
                    'Provide migration support'
                ]
            },
            {
                phase: 3,
                name: 'Medium Impact Changes',
                duration: '2 weeks',
                changes: mediumImpactChanges,
                activities: [
                    'Deploy medium-risk changes with feature flags',
                    'Gradual rollout to consumer segments',
                    'Monitor error rates and performance'
                ]
            },
            {
                phase: 4,
                name: 'High Impact Changes',
                duration: '4 weeks',
                changes: highImpactChanges,
                activities: [
                    'Deploy high-risk changes with extensive monitoring',
                    'Canary deployment to small consumer subset',
                    'Full rollout with rollback capability',
                    'Post-deployment validation'
                ]
            }
        ];
        
        return {
            totalDuration: '9 weeks',
            phases,
            rollbackStrategy: this.generateRollbackStrategy(changes),
            successCriteria: this.generateSuccessCriteria(changes)
        };
    }
}

// Consumer impact tracking
class ConsumerRegistry {
    private consumers: Map<string, APIConsumer> = new Map();
    private usageAnalytics: UsageAnalyticsService;
    
    constructor(usageAnalytics: UsageAnalyticsService) {
        this.usageAnalytics = usageAnalytics;
    }
    
    registerConsumer(consumer: APIConsumer): void {
        this.consumers.set(consumer.id, consumer);
    }
    
    getConsumersForEndpoints(endpoints: string[]): APIConsumer[] {
        const consumers: APIConsumer[] = [];
        
        for (const consumer of this.consumers.values()) {
            const usageData = this.usageAnalytics.getConsumerUsage(consumer.id);
            
            const affectedEndpoints = endpoints.filter(endpoint => 
                usageData.endpointUsage.has(endpoint));
            
            if (affectedEndpoints.length > 0) {
                consumers.push({
                    ...consumer,
                    affectedEndpoints,
                    usageFrequency: this.calculateUsageFrequency(usageData, affectedEndpoints)
                });
            }
        }
        
        return consumers;
    }
    
    private calculateUsageFrequency(usageData: ConsumerUsageData, endpoints: string[]): number {
        return endpoints.reduce((total, endpoint) => {
            return total + (usageData.endpointUsage.get(endpoint)?.dailyRequests || 0);
        }, 0);
    }
}

// Automated migration assistance
class APIConsumerMigrationAssistant {
    private codeGenerators: Map<string, CodeGenerator> = new Map();
    
    constructor() {
        this.setupCodeGenerators();
    }
    
    private setupCodeGenerators(): void {
        this.codeGenerators.set('javascript', new JavaScriptCodeGenerator());
        this.codeGenerators.set('python', new PythonCodeGenerator());
        this.codeGenerators.set('java', new JavaCodeGenerator());
        this.codeGenerators.set('csharp', new CSharpCodeGenerator());
    }
    
    generateMigrationCode(fromVersion: string, toVersion: string, language: string): MigrationCodeResult {
        const generator = this.codeGenerators.get(language);
        if (!generator) {
            throw new Error(`Code generator not available for language: ${language}`);
        }
        
        const migrationContext = this.buildMigrationContext(fromVersion, toVersion);
        return generator.generateMigrationCode(migrationContext);
    }
    
    generateSDKUpdate(consumerInfo: APIConsumer, targetVersion: string): SDKUpdateResult {
        const changes = this.analyzeRequiredChanges(consumerInfo.currentVersion, targetVersion);
        
        return {
            sdkVersion: targetVersion,
            breaking changes,
            migrationSteps: this.generateMigrationSteps(changes),
            codeExamples: this.generateCodeExamples(changes, consumerInfo.language),
            testingGuidance: this.generateTestingGuidance(changes),
            rollbackInstructions: this.generateRollbackInstructions(consumerInfo)
        };
    }
    
    createAutomatedMigrationPR(consumerRepo: GitRepository, migrationCode: MigrationCodeResult): PullRequestResult {
        return {
            prUrl: this.gitService.createPullRequest(consumerRepo, {
                title: `API Migration: ${migrationCode.fromVersion} → ${migrationCode.toVersion}`,
                body: this.generatePRDescription(migrationCode),
                branch: `api-migration-${migrationCode.toVersion}`,
                files: migrationCode.files,
                reviewers: consumerRepo.maintainers
            }),
            migrationValidation: this.generateMigrationValidation(migrationCode),
            testSuite: this.generateMigrationTestSuite(migrationCode)
        };
    }
}
```
```

This comprehensive RESTful API versioning and evolution strategy template provides systematic approaches to managing API lifecycles, consumer migrations, and breaking changes while maintaining backward compatibility and minimizing disruption to existing integrations.