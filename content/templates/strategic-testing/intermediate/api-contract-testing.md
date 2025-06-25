---
title: "API Contract Testing Template"
description: "Comprehensive framework for API contract testing including consumer-driven contracts, schema validation, and breaking change detection"
type: "template"
tier: "advanced"
template_category: "strategic-testing"
template_subcategory: "integration-test-planning"
template_id: "ST-001"
template_version: "1.0"
validation_status: "tested"
estimated_reading_time: "23 minutes"
word_count: 8700
last_updated: "2025-06-25"
content_status: "final"
use_case: "api-contract-testing"
target_scenario: "API integration validation with consumer-driven contracts"
complexity_level: "intermediate"
effectiveness_metrics: ["contract_compliance", "breaking_change_prevention", "api_reliability"]
estimated_time_savings: "65-80%"
prerequisites: ["api_design", "testing_frameworks", "contract_specifications"]
---

# API Contract Testing Template

## Template Overview

This template provides a systematic framework for API contract testing, covering consumer-driven contracts, schema validation, version compatibility, breaking change detection, and comprehensive API integration validation across different protocols and specifications.

## Usage Context

Use this template when:
- Implementing consumer-driven contract testing between API providers and consumers
- Validating API compliance with OpenAPI, GraphQL, or gRPC specifications
- Detecting breaking changes before deployment to prevent integration failures
- Ensuring API version compatibility and migration strategies
- Establishing comprehensive API testing strategies for microservices and distributed systems

## Template Structure

### API Contract Testing Context Setup

```
**Context**: API contract testing for {PROJECT_NAME}

**API Architecture Context**:
- API types: {API_TYPES} (REST, GraphQL, gRPC, WebSocket, message queues)
- API count: {API_COUNT} (number of APIs to be tested)
- Consumer services: {CONSUMER_SERVICES} (services that consume the APIs)
- Provider services: {PROVIDER_SERVICES} (services that provide the APIs)
- API specification format: {SPEC_FORMAT} (OpenAPI 3.0, GraphQL Schema, Protocol Buffers)

**Integration Complexity**:
- Service dependencies: {DEPENDENCY_GRAPH} (API dependency relationships and interaction patterns)
- Version management: {VERSIONING_STRATEGY} (semantic versioning, API gateway versioning, header-based)
- Authentication patterns: {AUTH_PATTERNS} (OAuth2, JWT, API keys, mutual TLS)
- Data formats: {DATA_FORMATS} (JSON, XML, Protocol Buffers, custom formats)
- Error handling: {ERROR_PATTERNS} (HTTP status codes, custom error schemas, exception handling)

**Testing Requirements**:
- Contract validation scope: {VALIDATION_SCOPE} (request/response schemas, business rules, performance)
- Breaking change tolerance: {CHANGE_TOLERANCE} (strict compatibility, graceful degradation, version migration)
- Test automation level: {AUTOMATION_LEVEL} (manual, semi-automated, fully automated)
- Performance requirements: {PERFORMANCE_CRITERIA} (response times, throughput, concurrency)
- Compliance requirements: {COMPLIANCE_NEEDS} (regulatory standards, security requirements, audit trails)
```

### Comprehensive Contract Testing Framework

```
**Primary Contract Testing Request**: Implement systematic API contract testing across the following dimensions:

1. **Consumer-Driven Contract Testing and Validation**:
   - Consumer contract definition with expected request/response patterns and business rule validation
   - Provider contract verification with implementation compliance and behavioral testing
   - Contract evolution management with backward compatibility validation and migration strategies
   - Consumer expectation validation with realistic usage patterns and edge case coverage
   - Contract-first development with specification-driven implementation and validation

2. **API Schema and Specification Validation**:
   - OpenAPI specification compliance with request/response schema validation and endpoint verification
   - GraphQL schema validation with query complexity analysis and type system verification
   - Protocol Buffer schema validation with message format compliance and field compatibility
   - JSON Schema validation with data type enforcement and constraint verification
   - Custom schema validation with business rule compliance and domain-specific validation

3. **Breaking Change Detection and Prevention**:
   - Backward compatibility analysis with version comparison and impact assessment
   - Schema evolution validation with field addition, removal, and modification impact
   - API endpoint compatibility with URL structure and method validation
   - Data format compatibility with serialization and deserialization verification
   - Business logic compatibility with behavioral consistency and rule validation

4. **API Version Management and Migration Testing**:
   - Multi-version API testing with parallel version validation and compatibility verification
   - Version deprecation testing with graceful degradation and migration path validation
   - API gateway version routing with traffic management and version-specific validation
   - Consumer migration testing with seamless transition and rollback capability validation
   - Version negotiation testing with content negotiation and version selection validation

5. **Performance and Load Contract Validation**:
   - API performance contract testing with response time and throughput validation
   - Load testing with contract compliance under high traffic and concurrent user scenarios
   - Rate limiting validation with throttling behavior and quota management testing
   - Scalability testing with auto-scaling behavior and performance degradation analysis
   - Resource utilization testing with memory, CPU, and network usage validation

**API Specifications and Contracts**:
{PASTE_API_SPECIFICATIONS_AND_CONTRACT_DEFINITIONS_HERE}

**Consumer Requirements and Expectations**:
{PASTE_CONSUMER_REQUIREMENTS_AND_USAGE_PATTERNS_HERE}

**Contract Testing Output Format**:
- Comprehensive contract test suite with consumer-driven validation and provider verification
- Schema compliance validation with specification adherence and data integrity verification
- Breaking change detection with impact analysis and migration guidance
- Version compatibility matrix with support lifecycle and deprecation timeline
- Performance contract validation with SLA compliance and scalability assessment
- Integration testing framework with end-to-end validation and monitoring integration
- Documentation and reporting with contract coverage analysis and compliance dashboards
```

### Specialized Contract Testing Modules

```
**Advanced Contract Testing Modules** (select based on API architecture and integration patterns):

**RESTful API Contract Testing**:
- HTTP method validation with proper verb usage and idempotency verification
- Resource representation testing with HATEOAS compliance and hypermedia validation
- Status code validation with appropriate error handling and success response verification
- Content negotiation testing with media type handling and format conversion validation
- Caching behavior testing with cache headers and invalidation strategy verification

**GraphQL API Contract Testing**:
- Query validation with schema compliance and complexity analysis
- Mutation testing with state change validation and side effect verification
- Subscription testing with real-time data flow and connection management validation
- Fragment validation with reusability and composition correctness verification
- Introspection testing with schema discovery and metadata validation

**gRPC API Contract Testing**:
- Protocol Buffer message validation with type safety and serialization verification
- Service method testing with streaming patterns and error handling validation
- Bidirectional streaming testing with flow control and backpressure validation
- Interceptor testing with cross-cutting concerns and middleware behavior verification
- Load balancing testing with service discovery and health check integration

**Message Queue Contract Testing**:
- Message schema validation with payload structure and format compliance
- Queue behavior testing with message ordering and delivery guarantee validation
- Dead letter queue testing with error handling and retry mechanism verification
- Message routing testing with topic-based and content-based routing validation
- Publisher-subscriber testing with event distribution and subscription management
```

## Implementation Examples

### Example 1: E-commerce REST API Contract Testing

```
**Context**: Consumer-driven contract testing for e-commerce platform REST APIs

**API Architecture Context**:
- API types: REST APIs with JSON payloads, WebSocket for real-time updates
- API count: 15 core APIs (User, Product, Order, Payment, Inventory, etc.)
- Consumer services: Web frontend, mobile apps, partner integrations, internal services
- Provider services: Microservices backend with API gateway
- API specification format: OpenAPI 3.0 with JSON Schema validation

**Expected Contract Testing Output**:

## E-commerce REST API Contract Test Suite

### Consumer-Driven Contract Testing with Pact

**🤝 Consumer Contract Definition and Provider Verification**

```typescript
// Comprehensive consumer-driven contract testing for e-commerce APIs
import { Pact, Matchers } from '@pact-foundation/pact';
import { VerifierOptions, Verifier } from '@pact-foundation/pact';
import { OpenAPIValidator } from 'express-openapi-validator';

describe('E-commerce API Consumer-Driven Contracts', () => {
  
  // Consumer side: Web Frontend -> Product API
  describe('Product API Consumer Contract (Web Frontend)', () => {
    let productApiPact: Pact;

    beforeAll(async () => {
      productApiPact = new Pact({
        consumer: 'web-frontend',
        provider: 'product-api',
        port: 3001,
        log: path.resolve(process.cwd(), 'logs', 'pact.log'),
        dir: path.resolve(process.cwd(), 'pacts'),
        spec: 3,
        logLevel: 'INFO'
      });

      await productApiPact.setup();
    });

    it('should get product list with filtering and pagination', async () => {
      // Define consumer expectation
      await productApiPact.addInteraction({
        description: 'get product list with category filter and pagination',
        providerState: 'products exist in electronics category',
        uponReceiving: 'a request for electronics products with pagination',
        withRequest: {
          method: 'GET',
          path: '/api/v1/products',
          query: {
            category: 'electronics',
            page: '1',
            limit: '20',
            sort: 'price_asc'
          },
          headers: {
            'Accept': 'application/json',
            'Authorization': Matchers.regex('Bearer .*', 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...')
          }
        },
        willRespondWith: {
          status: 200,
          headers: {
            'Content-Type': 'application/json',
            'X-Total-Count': Matchers.integer(156),
            'X-Page-Count': Matchers.integer(8)
          },
          body: {
            products: Matchers.eachLike({
              id: Matchers.uuid('123e4567-e89b-12d3-a456-426614174000'),
              name: Matchers.string('Wireless Headphones'),
              description: Matchers.string('High-quality wireless headphones'),
              price: Matchers.decimal(99.99),
              currency: Matchers.string('USD'),
              category: Matchers.string('electronics'),
              inStock: Matchers.boolean(true),
              images: Matchers.eachLike(Matchers.url('https://example.com/image.jpg')),
              specifications: {
                brand: Matchers.string('TechBrand'),
                model: Matchers.string('WH-1000XM4'),
                warranty: Matchers.string('2 years')
              },
              ratings: {
                average: Matchers.decimal(4.5),
                count: Matchers.integer(1247)
              }
            }, { min: 1, max: 20 }),
            pagination: {
              page: Matchers.integer(1),
              limit: Matchers.integer(20),
              total: Matchers.integer(156),
              totalPages: Matchers.integer(8),
              hasNext: Matchers.boolean(true),
              hasPrevious: Matchers.boolean(false)
            },
            filters: {
              appliedFilters: {
                category: Matchers.string('electronics'),
                sort: Matchers.string('price_asc')
              },
              availableFilters: {
                brands: Matchers.eachLike(Matchers.string('TechBrand')),
                priceRanges: Matchers.eachLike({
                  min: Matchers.decimal(0),
                  max: Matchers.decimal(100),
                  count: Matchers.integer(45)
                })
              }
            }
          }
        }
      });

      // Test the contract from consumer perspective
      const productService = new ProductService('http://localhost:3001');
      const productList = await productService.getProducts({
        category: 'electronics',
        page: 1,
        limit: 20,
        sort: 'price_asc'
      });

      // Verify consumer expectations are met
      expect(productList.products).toBeDefined();
      expect(productList.products.length).toBeGreaterThan(0);
      expect(productList.products[0]).toHaveProperty('id');
      expect(productList.products[0]).toHaveProperty('name');
      expect(productList.products[0]).toHaveProperty('price');
      expect(productList.pagination).toHaveProperty('page', 1);
      expect(productList.pagination).toHaveProperty('total');

      await productApiPact.verify();
    });

    it('should get individual product with detailed information', async () => {
      const productId = '123e4567-e89b-12d3-a456-426614174000';

      await productApiPact.addInteraction({
        description: 'get product details by ID',
        providerState: 'product exists with full details',
        uponReceiving: 'a request for specific product details',
        withRequest: {
          method: 'GET',
          path: `/api/v1/products/${productId}`,
          headers: {
            'Accept': 'application/json'
          }
        },
        willRespondWith: {
          status: 200,
          headers: {
            'Content-Type': 'application/json',
            'Cache-Control': 'public, max-age=3600',
            'ETag': Matchers.string('"product-etag-123"')
          },
          body: {
            id: Matchers.uuid(productId),
            name: Matchers.string('Premium Wireless Headphones'),
            description: Matchers.string('Professional-grade wireless headphones with noise cancellation'),
            longDescription: Matchers.string('Detailed product description...'),
            price: Matchers.decimal(299.99),
            originalPrice: Matchers.decimal(399.99),
            discount: {
              percentage: Matchers.decimal(25.0),
              validUntil: Matchers.iso8601DateTime('2025-12-31T23:59:59Z')
            },
            currency: Matchers.string('USD'),
            category: Matchers.string('electronics'),
            subcategory: Matchers.string('headphones'),
            brand: Matchers.string('PremiumAudio'),
            model: Matchers.string('PA-WH-PRO'),
            sku: Matchers.string('PA-WH-PRO-BLK'),
            inStock: Matchers.boolean(true),
            stockQuantity: Matchers.integer(47),
            images: Matchers.eachLike({
              url: Matchers.url('https://cdn.example.com/products/pa-wh-pro-1.jpg'),
              alt: Matchers.string('Premium Wireless Headphones - Front View'),
              isPrimary: Matchers.boolean(true)
            }),
            specifications: {
              dimensions: {
                weight: Matchers.string('250g'),
                dimensions: Matchers.string('20cm x 18cm x 8cm')
              },
              technical: {
                batteryLife: Matchers.string('30 hours'),
                connectivity: Matchers.eachLike('Bluetooth 5.0'),
                features: Matchers.eachLike('Active Noise Cancellation')
              },
              warranty: Matchers.string('3 years international warranty')
            },
            ratings: {
              average: Matchers.decimal(4.8),
              count: Matchers.integer(2156),
              distribution: {
                5: Matchers.integer(1628),
                4: Matchers.integer(432),
                3: Matchers.integer(76),
                2: Matchers.integer(15),
                1: Matchers.integer(5)
              }
            },
            reviews: {
              featured: Matchers.eachLike({
                id: Matchers.uuid(),
                rating: Matchers.integer(5),
                title: Matchers.string('Excellent sound quality'),
                content: Matchers.string('Amazing headphones with great noise cancellation...'),
                author: Matchers.string('VerifiedBuyer123'),
                verified: Matchers.boolean(true),
                helpful: Matchers.integer(24),
                date: Matchers.iso8601DateTime()
              }, { min: 1, max: 3 })
            },
            relatedProducts: Matchers.eachLike({
              id: Matchers.uuid(),
              name: Matchers.string(),
              price: Matchers.decimal(),
              image: Matchers.url()
            }, { min: 3, max: 6 }),
            seo: {
              title: Matchers.string('Premium Wireless Headphones - Best Audio Quality'),
              description: Matchers.string('Shop premium wireless headphones with active noise cancellation...'),
              keywords: Matchers.eachLike('wireless headphones')
            }
          }
        }
      });

      const productService = new ProductService('http://localhost:3001');
      const product = await productService.getProductById(productId);

      // Verify detailed product information
      expect(product.id).toBe(productId);
      expect(product.name).toBeDefined();
      expect(product.price).toBeGreaterThan(0);
      expect(product.specifications).toBeDefined();
      expect(product.ratings).toHaveProperty('average');
      expect(product.images).toBeDefined();
      expect(product.images.length).toBeGreaterThan(0);

      await productApiPact.verify();
    });

    it('should handle product not found scenario', async () => {
      const nonExistentProductId = '999e9999-e99b-99d9-a999-999999999999';

      await productApiPact.addInteraction({
        description: 'get non-existent product',
        providerState: 'product does not exist',
        uponReceiving: 'a request for non-existent product',
        withRequest: {
          method: 'GET',
          path: `/api/v1/products/${nonExistentProductId}`,
          headers: {
            'Accept': 'application/json'
          }
        },
        willRespondWith: {
          status: 404,
          headers: {
            'Content-Type': 'application/json'
          },
          body: {
            error: {
              code: Matchers.string('PRODUCT_NOT_FOUND'),
              message: Matchers.string('Product not found'),
              details: Matchers.string(`Product with ID ${nonExistentProductId} does not exist`),
              timestamp: Matchers.iso8601DateTime(),
              path: Matchers.string(`/api/v1/products/${nonExistentProductId}`)
            }
          }
        }
      });

      const productService = new ProductService('http://localhost:3001');
      
      await expect(productService.getProductById(nonExistentProductId))
        .rejects
        .toThrow('Product not found');

      await productApiPact.verify();
    });

    afterAll(async () => {
      await productApiPact.finalize();
    });
  });

  // Consumer side: Mobile App -> Order API
  describe('Order API Consumer Contract (Mobile App)', () => {
    let orderApiPact: Pact;

    beforeAll(async () => {
      orderApiPact = new Pact({
        consumer: 'mobile-app',
        provider: 'order-api',
        port: 3002
      });

      await orderApiPact.setup();
    });

    it('should create order with mobile-specific requirements', async () => {
      await orderApiPact.addInteraction({
        description: 'create order from mobile app',
        providerState: 'user is authenticated and products are available',
        uponReceiving: 'a mobile order creation request',
        withRequest: {
          method: 'POST',
          path: '/api/v1/orders',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': Matchers.regex('Bearer .*'),
            'X-Client-Type': 'mobile',
            'X-App-Version': Matchers.regex('\\d+\\.\\d+\\.\\d+', '2.1.0')
          },
          body: {
            customerId: Matchers.uuid(),
            items: Matchers.eachLike({
              productId: Matchers.uuid(),
              quantity: Matchers.integer(1),
              price: Matchers.decimal()
            }),
            shippingAddress: {
              type: Matchers.string('home'),
              street: Matchers.string(),
              city: Matchers.string(),
              state: Matchers.string(),
              zipCode: Matchers.string(),
              country: Matchers.string('US'),
              isDefault: Matchers.boolean()
            },
            paymentMethod: {
              type: Matchers.string('credit_card'),
              tokenId: Matchers.string(),
              isDefault: Matchers.boolean()
            },
            preferences: {
              deliveryInstructions: Matchers.string(),
              contactPreference: Matchers.string('sms'),
              packagingPreference: Matchers.string('eco_friendly')
            }
          }
        },
        willRespondWith: {
          status: 201,
          headers: {
            'Content-Type': 'application/json',
            'Location': Matchers.regex('/api/v1/orders/[a-f0-9-]+')
          },
          body: {
            orderId: Matchers.uuid(),
            orderNumber: Matchers.regex('ORD-\\d{8}', 'ORD-20250625'),
            status: Matchers.string('confirmed'),
            totalAmount: Matchers.decimal(),
            currency: Matchers.string('USD'),
            estimatedDelivery: {
              date: Matchers.iso8601Date(),
              timeWindow: Matchers.string('9AM-5PM')
            },
            tracking: {
              trackingNumber: Matchers.string(),
              carrier: Matchers.string(),
              trackingUrl: Matchers.url()
            },
            items: Matchers.eachLike({
              productId: Matchers.uuid(),
              name: Matchers.string(),
              quantity: Matchers.integer(),
              unitPrice: Matchers.decimal(),
              totalPrice: Matchers.decimal(),
              status: Matchers.string('confirmed')
            }),
            payment: {
              status: Matchers.string('completed'),
              transactionId: Matchers.string(),
              method: Matchers.string('credit_card'),
              lastFour: Matchers.regex('\\d{4}', '1234')
            },
            mobileSpecific: {
              pushNotificationEnabled: Matchers.boolean(true),
              smsUpdatesEnabled: Matchers.boolean(true),
              appDeepLink: Matchers.url('myapp://orders/123e4567-e89b-12d3-a456-426614174000')
            }
          }
        }
      });

      const orderService = new OrderService('http://localhost:3002');
      const order = await orderService.createOrder({
        customerId: 'customer-123',
        items: [{ productId: 'product-456', quantity: 2, price: 99.99 }],
        shippingAddress: {
          type: 'home',
          street: '123 Main St',
          city: 'Anytown',
          state: 'CA',
          zipCode: '12345',
          country: 'US'
        },
        paymentMethod: {
          type: 'credit_card',
          tokenId: 'tok_1234567890'
        }
      });

      // Verify mobile-specific order requirements
      expect(order.orderId).toBeDefined();
      expect(order.orderNumber).toMatch(/ORD-\d{8}/);
      expect(order.status).toBe('confirmed');
      expect(order.mobileSpecific).toBeDefined();
      expect(order.mobileSpecific.appDeepLink).toBeDefined();
      expect(order.tracking).toBeDefined();

      await orderApiPact.verify();
    });

    afterAll(async () => {
      await orderApiPact.finalize();
    });
  });
});

// Provider side: Contract verification
describe('E-commerce API Provider Contract Verification', () => {
  
  it('should verify Product API against all consumer contracts', async () => {
    const verifier = new Verifier({
      providerBaseUrl: 'http://localhost:8080',
      pactUrls: [
        path.resolve(process.cwd(), 'pacts/web-frontend-product-api.json'),
        path.resolve(process.cwd(), 'pacts/mobile-app-product-api.json')
      ],
      providerVersion: process.env.GIT_COMMIT || '1.0.0',
      providerVersionTags: ['master', 'prod'],
      publishVerificationResult: true,
      pactBrokerUrl: 'https://pact-broker.company.com',
      pactBrokerToken: process.env.PACT_BROKER_TOKEN,
      
      // Provider state handlers
      stateHandlers: {
        'products exist in electronics category': async () => {
          await testDataManager.seedProducts([
            {
              id: '123e4567-e89b-12d3-a456-426614174000',
              name: 'Wireless Headphones',
              category: 'electronics',
              price: 99.99,
              inStock: true
            }
          ]);
        },
        
        'product exists with full details': async () => {
          await testDataManager.seedProductWithDetails({
            id: '123e4567-e89b-12d3-a456-426614174000',
            name: 'Premium Wireless Headphones',
            category: 'electronics',
            specifications: { /* full specs */ },
            ratings: { average: 4.8, count: 2156 }
          });
        },
        
        'product does not exist': async () => {
          await testDataManager.clearProducts();
        }
      },
      
      // Request filters for authentication
      requestFilter: (req, res, next) => {
        if (req.headers.authorization) {
          req.headers.authorization = 'Bearer valid-test-token';
        }
        next();
      }
    } as VerifierOptions);

    const verificationResult = await verifier.verifyProvider();
    expect(verificationResult).toBe(0); // 0 indicates success
  });

  it('should verify Order API against all consumer contracts', async () => {
    const verifier = new Verifier({
      providerBaseUrl: 'http://localhost:8081',
      pactUrls: [
        path.resolve(process.cwd(), 'pacts/web-frontend-order-api.json'),
        path.resolve(process.cwd(), 'pacts/mobile-app-order-api.json'),
        path.resolve(process.cwd(), 'pacts/partner-system-order-api.json')
      ],
      providerVersion: process.env.GIT_COMMIT || '1.0.0',
      
      stateHandlers: {
        'user is authenticated and products are available': async () => {
          await testDataManager.seedUserAndProducts({
            userId: 'customer-123',
            products: [
              { id: 'product-456', price: 99.99, inStock: true }
            ]
          });
        }
      }
    } as VerifierOptions);

    const verificationResult = await verifier.verifyProvider();
    expect(verificationResult).toBe(0);
  });
});
```

### OpenAPI Specification Compliance Testing

**📋 Schema and Specification Validation**

```typescript
// Comprehensive OpenAPI specification compliance testing
import { OpenAPIValidator } from 'express-openapi-validator';
import { OpenAPI } from 'openapi-types';
import SwaggerParser from '@apidevtools/swagger-parser';
import Ajv from 'ajv';

describe('E-commerce OpenAPI Specification Compliance', () => {
  let productApiSpec: OpenAPI.Document;
  let orderApiSpec: OpenAPI.Document;
  let validator: OpenAPIValidator;

  beforeAll(async () => {
    // Load and validate OpenAPI specifications
    productApiSpec = await SwaggerParser.validate('./specs/product-api.yaml');
    orderApiSpec = await SwaggerParser.validate('./specs/order-api.yaml');
    
    validator = new OpenAPIValidator({
      apiSpec: productApiSpec,
      validateRequests: true,
      validateResponses: true,
      validateSecurity: true
    });
  });

  describe('OpenAPI Specification Validation', () => {
    it('should validate all API specifications are well-formed', async () => {
      // Validate Product API specification
      const productValidation = await SwaggerParser.validate(productApiSpec);
      expect(productValidation).toBeDefined();
      expect(productValidation.info.version).toMatch(/^\d+\.\d+\.\d+$/);
      expect(productValidation.paths).toBeDefined();
      expect(Object.keys(productValidation.paths).length).toBeGreaterThan(0);

      // Validate Order API specification
      const orderValidation = await SwaggerParser.validate(orderApiSpec);
      expect(orderValidation).toBeDefined();
      expect(orderValidation.info.version).toMatch(/^\d+\.\d+\.\d+$/);
      
      // Verify required OpenAPI 3.0 structure
      expect(productValidation.openapi).toBe('3.0.3');
      expect(productValidation.info).toHaveProperty('title');
      expect(productValidation.info).toHaveProperty('description');
      expect(productValidation.components).toHaveProperty('schemas');
    });

    it('should validate request schemas against specification', async () => {
      const testCases = [
        {
          method: 'POST',
          path: '/api/v1/products',
          body: {
            name: 'Test Product',
            description: 'A test product description',
            price: 29.99,
            currency: 'USD',
            category: 'electronics',
            inStock: true,
            specifications: {
              brand: 'TestBrand',
              model: 'TB-001'
            }
          },
          expectedValid: true
        },
        {
          method: 'POST',
          path: '/api/v1/products',
          body: {
            name: 'Test Product',
            // Missing required fields: price, category
            description: 'A test product description'
          },
          expectedValid: false
        },
        {
          method: 'GET',
          path: '/api/v1/products',
          query: {
            category: 'electronics',
            page: 1,
            limit: 20,
            sort: 'price_asc'
          },
          expectedValid: true
        },
        {
          method: 'GET',
          path: '/api/v1/products',
          query: {
            page: 'invalid', // Should be number
            limit: -5 // Should be positive
          },
          expectedValid: false
        }
      ];

      for (const testCase of testCases) {
        const request = {
          method: testCase.method,
          path: testCase.path,
          body: testCase.body,
          query: testCase.query,
          headers: { 'Content-Type': 'application/json' }
        };

        if (testCase.expectedValid) {
          expect(() => validator.validateRequest(request)).not.toThrow();
        } else {
          expect(() => validator.validateRequest(request)).toThrow();
        }
      }
    });

    it('should validate response schemas against specification', async () => {
      const responseTestCases = [
        {
          method: 'GET',
          path: '/api/v1/products',
          statusCode: 200,
          response: {
            body: {
              products: [
                {
                  id: '123e4567-e89b-12d3-a456-426614174000',
                  name: 'Wireless Headphones',
                  description: 'High-quality wireless headphones',
                  price: 99.99,
                  currency: 'USD',
                  category: 'electronics',
                  inStock: true,
                  images: ['https://example.com/image.jpg'],
                  specifications: {
                    brand: 'TechBrand',
                    model: 'WH-1000XM4'
                  },
                  ratings: {
                    average: 4.5,
                    count: 1247
                  }
                }
              ],
              pagination: {
                page: 1,
                limit: 20,
                total: 156,
                totalPages: 8,
                hasNext: true,
                hasPrevious: false
              }
            },
            headers: {
              'Content-Type': 'application/json',
              'X-Total-Count': '156'
            }
          },
          expectedValid: true
        },
        {
          method: 'GET',
          path: '/api/v1/products/123e4567-e89b-12d3-a456-426614174000',
          statusCode: 404,
          response: {
            body: {
              error: {
                code: 'PRODUCT_NOT_FOUND',
                message: 'Product not found',
                details: 'Product with ID 123e4567-e89b-12d3-a456-426614174000 does not exist',
                timestamp: '2025-06-25T10:30:00Z',
                path: '/api/v1/products/123e4567-e89b-12d3-a456-426614174000'
              }
            },
            headers: {
              'Content-Type': 'application/json'
            }
          },
          expectedValid: true
        }
      ];

      for (const testCase of responseTestCases) {
        const response = {
          statusCode: testCase.statusCode,
          body: testCase.response.body,
          headers: testCase.response.headers
        };

        if (testCase.expectedValid) {
          expect(() => validator.validateResponse(response, {
            method: testCase.method,
            path: testCase.path
          })).not.toThrow();
        } else {
          expect(() => validator.validateResponse(response, {
            method: testCase.method,
            path: testCase.path
          })).toThrow();
        }
      }
    });

    it('should validate security requirements', async () => {
      const securityTestCases = [
        {
          path: '/api/v1/products',
          method: 'POST',
          headers: {
            'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
            'Content-Type': 'application/json'
          },
          expectedValid: true
        },
        {
          path: '/api/v1/products',
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
            // Missing Authorization header
          },
          expectedValid: false
        },
        {
          path: '/api/v1/products',
          method: 'GET',
          headers: {
            // Public endpoint - no auth required
          },
          expectedValid: true
        }
      ];

      for (const testCase of securityTestCases) {
        const request = {
          method: testCase.method,
          path: testCase.path,
          headers: testCase.headers
        };

        if (testCase.expectedValid) {
          expect(() => validator.validateSecurity(request)).not.toThrow();
        } else {
          expect(() => validator.validateSecurity(request)).toThrow();
        }
      }
    });
  });

  describe('Breaking Change Detection', () => {
    it('should detect breaking changes between API versions', async () => {
      const apiV1Spec = await SwaggerParser.validate('./specs/product-api-v1.yaml');
      const apiV2Spec = await SwaggerParser.validate('./specs/product-api-v2.yaml');

      const breakingChanges = await detectBreakingChanges(apiV1Spec, apiV2Spec);

      // Assert no unexpected breaking changes
      const unexpectedBreaking = breakingChanges.filter(change => 
        !change.expectedBreakingChange
      );
      
      expect(unexpectedBreaking).toHaveLength(0);

      // Document expected breaking changes
      const expectedBreaking = breakingChanges.filter(change => 
        change.expectedBreakingChange
      );

      expect(expectedBreaking).toEqual([
        expect.objectContaining({
          type: 'field_removed',
          path: '/components/schemas/Product',
          field: 'deprecated_field',
          severity: 'breaking',
          migration: 'Use new_field instead of deprecated_field'
        })
      ]);
    });

    it('should validate backward compatibility requirements', async () => {
      const compatibilityMatrix = await validateBackwardCompatibility([
        { version: '1.0.0', spec: './specs/product-api-v1.0.0.yaml' },
        { version: '1.1.0', spec: './specs/product-api-v1.1.0.yaml' },
        { version: '1.2.0', spec: './specs/product-api-v1.2.0.yaml' },
        { version: '2.0.0', spec: './specs/product-api-v2.0.0.yaml' }
      ]);

      // Verify minor version compatibility
      expect(compatibilityMatrix['1.0.0']['1.1.0'].compatible).toBe(true);
      expect(compatibilityMatrix['1.1.0']['1.2.0'].compatible).toBe(true);

      // Verify major version breaking changes are documented
      expect(compatibilityMatrix['1.2.0']['2.0.0'].compatible).toBe(false);
      expect(compatibilityMatrix['1.2.0']['2.0.0'].breakingChanges).toEqual(
        expect.arrayContaining([
          expect.objectContaining({
            type: 'api_endpoint_removed',
            details: 'Deprecated endpoint /api/v1/legacy removed in v2.0.0'
          })
        ])
      );
    });
  });

  describe('API Performance Contract Validation', () => {
    it('should validate API performance meets contract requirements', async () => {
      const performanceContracts = [
        {
          endpoint: 'GET /api/v1/products',
          maxResponseTime: 200, // milliseconds
          maxMemoryUsage: 50, // MB
          minThroughput: 1000 // requests per second
        },
        {
          endpoint: 'POST /api/v1/orders',
          maxResponseTime: 500,
          maxMemoryUsage: 100,
          minThroughput: 500
        },
        {
          endpoint: 'GET /api/v1/products/{id}',
          maxResponseTime: 100,
          maxMemoryUsage: 25,
          minThroughput: 2000
        }
      ];

      for (const contract of performanceContracts) {
        const performanceResults = await loadTestAPI({
          endpoint: contract.endpoint,
          duration: '30s',
          virtualUsers: 100,
          rampUpTime: '10s'
        });

        // Validate response time contract
        expect(performanceResults.averageResponseTime).toBeLessThan(contract.maxResponseTime);
        expect(performanceResults.p95ResponseTime).toBeLessThan(contract.maxResponseTime * 1.5);

        // Validate throughput contract
        expect(performanceResults.requestsPerSecond).toBeGreaterThan(contract.minThroughput);

        // Validate memory usage contract
        expect(performanceResults.peakMemoryUsage).toBeLessThan(contract.maxMemoryUsage);

        // Validate error rate
        expect(performanceResults.errorRate).toBeLessThan(0.01); // Less than 1%
      }
    });

    it('should validate API rate limiting behavior', async () => {
      const rateLimitTests = [
        {
          endpoint: 'GET /api/v1/products',
          rateLimitPerMinute: 1000,
          burstLimit: 100
        },
        {
          endpoint: 'POST /api/v1/orders',
          rateLimitPerMinute: 100,
          burstLimit: 10
        }
      ];

      for (const test of rateLimitTests) {
        // Test normal rate limit
        const normalRateResult = await testRateLimit({
          endpoint: test.endpoint,
          requestsPerMinute: test.rateLimitPerMinute * 0.8 // 80% of limit
        });

        expect(normalRateResult.allRequestsSucceeded).toBe(true);
        expect(normalRateResult.rateLimitHeadersPresent).toBe(true);

        // Test rate limit exceeded
        const exceededRateResult = await testRateLimit({
          endpoint: test.endpoint,
          requestsPerMinute: test.rateLimitPerMinute * 1.2 // 120% of limit
        });

        expect(exceededRateResult.rateLimitExceededResponses).toBeGreaterThan(0);
        expect(exceededRateResult.http429Responses).toBeGreaterThan(0);

        // Test burst handling
        const burstResult = await testBurstTraffic({
          endpoint: test.endpoint,
          burstSize: test.burstLimit,
          burstDuration: '5s'
        });

        expect(burstResult.burstHandledCorrectly).toBe(true);
      }
    });
  });
});

// Utility functions for contract testing
async function detectBreakingChanges(oldSpec: OpenAPI.Document, newSpec: OpenAPI.Document) {
  const changes = [];
  
  // Compare paths
  for (const path in oldSpec.paths) {
    if (!(path in newSpec.paths)) {
      changes.push({
        type: 'path_removed',
        path: path,
        severity: 'breaking',
        expectedBreakingChange: false
      });
    }
  }
  
  // Compare schemas
  const oldSchemas = oldSpec.components?.schemas || {};
  const newSchemas = newSpec.components?.schemas || {};
  
  for (const schemaName in oldSchemas) {
    if (schemaName in newSchemas) {
      const schemaChanges = compareSchemas(oldSchemas[schemaName], newSchemas[schemaName]);
      changes.push(...schemaChanges.map(change => ({
        ...change,
        path: `/components/schemas/${schemaName}`
      })));
    }
  }
  
  return changes;
}

async function validateBackwardCompatibility(versions: Array<{version: string, spec: string}>) {
  const matrix: any = {};
  
  for (let i = 0; i < versions.length; i++) {
    for (let j = i + 1; j < versions.length; j++) {
      const oldVersion = versions[i];
      const newVersion = versions[j];
      
      const oldSpec = await SwaggerParser.validate(oldVersion.spec);
      const newSpec = await SwaggerParser.validate(newVersion.spec);
      
      const changes = await detectBreakingChanges(oldSpec, newSpec);
      const breakingChanges = changes.filter(c => c.severity === 'breaking');
      
      matrix[oldVersion.version] = matrix[oldVersion.version] || {};
      matrix[oldVersion.version][newVersion.version] = {
        compatible: breakingChanges.length === 0,
        breakingChanges: breakingChanges
      };
    }
  }
  
  return matrix;
}

function compareSchemas(oldSchema: any, newSchema: any) {
  const changes = [];
  
  if (oldSchema.required && newSchema.required) {
    const addedRequired = newSchema.required.filter((field: string) => 
      !oldSchema.required.includes(field)
    );
    
    addedRequired.forEach((field: string) => {
      changes.push({
        type: 'field_required_added',
        field: field,
        severity: 'breaking'
      });
    });
  }
  
  if (oldSchema.properties && newSchema.properties) {
    for (const field in oldSchema.properties) {
      if (!(field in newSchema.properties)) {
        changes.push({
          type: 'field_removed',
          field: field,
          severity: 'breaking'
        });
      }
    }
  }
  
  return changes;
}
```

**📊 E-commerce API Contract Testing Results:**
- **Consumer Contract Compliance**: 100% contract adherence across 3 consumer applications
- **OpenAPI Specification Validation**: Full schema compliance with automated validation
- **Breaking Change Prevention**: Zero unexpected breaking changes detected in production deployments
- **Performance Contract Adherence**: All APIs meet response time and throughput requirements
- **Version Compatibility**: Seamless backward compatibility maintained across minor versions
- **Security Contract Validation**: 100% authentication and authorization requirement compliance
```

### Example 2: GraphQL API Contract Testing

```
**Context**: GraphQL API contract testing for content management system

**API Architecture Context**:
- API types: GraphQL API with real-time subscriptions
- Consumer services: Content management dashboard, mobile content app, partner integrations
- Schema complexity: 45 types, 120 fields, nested relationships
- Real-time features: Live content updates, collaborative editing

**Expected GraphQL Contract Testing Output**:

## GraphQL Schema Contract Testing

**🔍 GraphQL Schema Validation and Query Testing**

```typescript
// Comprehensive GraphQL contract testing
import { buildSchema, validate, parse } from 'graphql';
import { makeExecutableSchema } from '@graphql-tools/schema';
import { addMocksToSchema } from '@graphql-tools/mock';

describe('Content Management GraphQL API Contract Testing', () => {
  let schema: GraphQLSchema;
  let mockedSchema: GraphQLSchema;

  beforeAll(async () => {
    const typeDefs = await loadGraphQLSchema('./schemas/content-management.graphql');
    schema = buildSchema(typeDefs);
    
    mockedSchema = addMocksToSchema({
      schema,
      mocks: {
        String: () => 'Test String',
        Int: () => 42,
        ID: () => '123e4567-e89b-12d3-a456-426614174000'
      }
    });
  });

  describe('Schema Structure Validation', () => {
    it('should validate GraphQL schema is well-formed', () => {
      expect(schema).toBeDefined();
      
      // Verify root types exist
      expect(schema.getQueryType()).toBeDefined();
      expect(schema.getMutationType()).toBeDefined();
      expect(schema.getSubscriptionType()).toBeDefined();
      
      // Verify core types are defined
      const typeMap = schema.getTypeMap();
      expect(typeMap['Article']).toBeDefined();
      expect(typeMap['Author']).toBeDefined();
      expect(typeMap['Category']).toBeDefined();
      expect(typeMap['Comment']).toBeDefined();
    });

    it('should validate field types and relationships', () => {
      const articleType = schema.getType('Article');
      expect(articleType).toBeDefined();
      
      if (articleType && 'getFields' in articleType) {
        const fields = articleType.getFields();
        
        // Verify required fields
        expect(fields['id']).toBeDefined();
        expect(fields['title']).toBeDefined();
        expect(fields['content']).toBeDefined();
        expect(fields['author']).toBeDefined();
        expect(fields['publishedAt']).toBeDefined();
        
        // Verify field types
        expect(fields['id'].type.toString()).toBe('ID!');
        expect(fields['title'].type.toString()).toBe('String!');
        expect(fields['author'].type.toString()).toBe('Author!');
        expect(fields['comments'].type.toString()).toBe('[Comment!]!');
      }
    });
  });

  describe('Query Contract Validation', () => {
    it('should validate article listing query with filtering and pagination', async () => {
      const query = `
        query GetArticles($filter: ArticleFilter, $pagination: PaginationInput) {
          articles(filter: $filter, pagination: $pagination) {
            edges {
              node {
                id
                title
                excerpt
                publishedAt
                author {
                  id
                  name
                  avatar
                }
                category {
                  id
                  name
                  slug
                }
                tags {
                  id
                  name
                }
                metrics {
                  views
                  likes
                  comments
                  shares
                }
              }
              cursor
            }
            pageInfo {
              hasNextPage
              hasPreviousPage
              startCursor
              endCursor
            }
            totalCount
          }
        }
      `;

      const variables = {
        filter: {
          status: 'PUBLISHED',
          categoryId: 'cat-123',
          authorId: 'auth-456',
          publishedAfter: '2025-01-01T00:00:00Z'
        },
        pagination: {
          first: 20,
          after: 'cursor-123'
        }
      };

      // Validate query syntax
      const document = parse(query);
      const errors = validate(schema, document);
      expect(errors).toHaveLength(0);

      // Execute query against mocked schema
      const result = await graphql(mockedSchema, query, null, null, variables);
      expect(result.errors).toBeUndefined();
      expect(result.data).toBeDefined();
      expect(result.data.articles).toBeDefined();
      expect(result.data.articles.edges).toBeDefined();
      expect(result.data.articles.pageInfo).toBeDefined();
    });

    it('should validate complex nested query with fragments', async () => {
      const query = `
        fragment AuthorInfo on Author {
          id
          name
          email
          bio
          avatar
          socialLinks {
            platform
            url
          }
          stats {
            totalArticles
            totalViews
            totalLikes
          }
        }

        fragment ArticleContent on Article {
          id
          title
          slug
          content
          excerpt
          featuredImage
          publishedAt
          updatedAt
          status
          seo {
            title
            description
            keywords
            ogImage
          }
        }

        query GetArticleWithDetails($id: ID!) {
          article(id: $id) {
            ...ArticleContent
            author {
              ...AuthorInfo
            }
            category {
              id
              name
              description
              parent {
                id
                name
              }
            }
            tags {
              id
              name
              color
            }
            comments(first: 10, orderBy: CREATED_AT_DESC) {
              edges {
                node {
                  id
                  content
                  createdAt
                  author {
                    name
                    avatar
                  }
                  replies(first: 5) {
                    edges {
                      node {
                        id
                        content
                        createdAt
                        author {
                          name
                          avatar
                        }
                      }
                    }
                  }
                }
              }
            }
            relatedArticles(limit: 5) {
              id
              title
              excerpt
              publishedAt
              author {
                name
              }
            }
          }
        }
      `;

      const variables = { id: 'article-123' };

      const document = parse(query);
      const errors = validate(schema, document);
      expect(errors).toHaveLength(0);

      const result = await graphql(mockedSchema, query, null, null, variables);
      expect(result.errors).toBeUndefined();
      expect(result.data.article).toBeDefined();
      expect(result.data.article.author).toBeDefined();
      expect(result.data.article.comments).toBeDefined();
    });

    it('should validate query complexity and depth limits', async () => {
      // Test query that exceeds complexity limits
      const complexQuery = `
        query ExcessivelyComplexQuery {
          articles(first: 100) {
            edges {
              node {
                author {
                  articles(first: 100) {
                    edges {
                      node {
                        comments(first: 100) {
                          edges {
                            node {
                              author {
                                articles(first: 100) {
                                  edges {
                                    node {
                                      id
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      `;

      const document = parse(complexQuery);
      
      // Custom complexity analysis
      const complexity = calculateQueryComplexity(document, schema);
      expect(complexity).toBeGreaterThan(1000); // Exceeds limit

      // Should be rejected by complexity limiter
      const result = await graphql(schema, complexQuery);
      expect(result.errors).toBeDefined();
      expect(result.errors[0].message).toContain('Query complexity');
    });
  });

  describe('Mutation Contract Validation', () => {
    it('should validate article creation mutation', async () => {
      const mutation = `
        mutation CreateArticle($input: CreateArticleInput!) {
          createArticle(input: $input) {
            article {
              id
              title
              slug
              content
              status
              author {
                id
                name
              }
              category {
                id
                name
              }
              tags {
                id
                name
              }
              createdAt
            }
            errors {
              field
              message
              code
            }
          }
        }
      `;

      const variables = {
        input: {
          title: 'New Article Title',
          content: 'Article content here...',
          excerpt: 'Article excerpt',
          categoryId: 'cat-123',
          tagIds: ['tag-1', 'tag-2'],
          status: 'DRAFT',
          seo: {
            title: 'SEO Title',
            description: 'SEO Description',
            keywords: ['keyword1', 'keyword2']
          }
        }
      };

      const document = parse(mutation);
      const errors = validate(schema, document);
      expect(errors).toHaveLength(0);

      const result = await graphql(mockedSchema, mutation, null, null, variables);
      expect(result.errors).toBeUndefined();
      expect(result.data.createArticle).toBeDefined();
      expect(result.data.createArticle.article).toBeDefined();
    });

    it('should validate input validation and error handling', async () => {
      const mutation = `
        mutation CreateArticleWithValidation($input: CreateArticleInput!) {
          createArticle(input: $input) {
            article {
              id
              title
            }
            errors {
              field
              message
              code
            }
          }
        }
      `;

      // Test cases with various validation scenarios
      const invalidInputs = [
        {
          name: 'missing required title',
          input: {
            content: 'Content without title',
            categoryId: 'cat-123'
          },
          expectedError: { field: 'title', code: 'REQUIRED' }
        },
        {
          name: 'invalid category ID',
          input: {
            title: 'Valid Title',
            content: 'Valid content',
            categoryId: 'invalid-category'
          },
          expectedError: { field: 'categoryId', code: 'NOT_FOUND' }
        },
        {
          name: 'title too long',
          input: {
            title: 'A'.repeat(256), // Exceeds 255 character limit
            content: 'Valid content',
            categoryId: 'cat-123'
          },
          expectedError: { field: 'title', code: 'TOO_LONG' }
        }
      ];

      for (const testCase of invalidInputs) {
        const result = await graphql(mockedSchema, mutation, null, null, {
          input: testCase.input
        });

        expect(result.data.createArticle.errors).toBeDefined();
        expect(result.data.createArticle.errors).toContainEqual(
          expect.objectContaining(testCase.expectedError)
        );
        expect(result.data.createArticle.article).toBeNull();
      }
    });
  });

  describe('Subscription Contract Validation', () => {
    it('should validate real-time article updates subscription', async () => {
      const subscription = `
        subscription ArticleUpdates($articleId: ID!) {
          articleUpdated(articleId: $articleId) {
            mutation
            node {
              id
              title
              content
              status
              updatedAt
              author {
                id
                name
              }
            }
            previousValues {
              title
              content
              status
            }
          }
        }
      `;

      const variables = { articleId: 'article-123' };

      const document = parse(subscription);
      const errors = validate(schema, document);
      expect(errors).toHaveLength(0);

      // Test subscription setup
      const subscriptionResult = await subscribe(schema, document, null, null, variables);
      expect(subscriptionResult).toBeDefined();
    });

    it('should validate comment notifications subscription', async () => {
      const subscription = `
        subscription CommentNotifications($userId: ID!) {
          commentNotification(userId: $userId) {
            type
            comment {
              id
              content
              createdAt
              author {
                id
                name
                avatar
              }
              article {
                id
                title
                slug
              }
            }
            read
            notificationId
          }
        }
      `;

      const document = parse(subscription);
      const errors = validate(schema, document);
      expect(errors).toHaveLength(0);
    });
  });

  describe('Schema Evolution and Breaking Changes', () => {
    it('should detect breaking changes in schema evolution', async () => {
      const oldTypeDefs = `
        type Article {
          id: ID!
          title: String!
          content: String!
          author: Author!
          publishedAt: String
        }
        
        type Author {
          id: ID!
          name: String!
          email: String!
        }
        
        type Query {
          articles: [Article!]!
          article(id: ID!): Article
        }
      `;

      const newTypeDefs = `
        type Article {
          id: ID!
          title: String!
          content: String!
          author: Author!
          publishedAt: DateTime
          # Breaking: removed email field from Author
          # Breaking: changed publishedAt from String to DateTime
        }
        
        type Author {
          id: ID!
          name: String!
          # email field removed - BREAKING CHANGE
          bio: String # Added new optional field - NON-BREAKING
        }
        
        type Query {
          articles(filter: ArticleFilter): [Article!]! # Added optional parameter - NON-BREAKING
          article(id: ID!): Article
          # Removed getArticleBySlug query - BREAKING CHANGE
        }
        
        input ArticleFilter {
          status: String
          authorId: ID
        }
        
        scalar DateTime
      `;

      const oldSchema = buildSchema(oldTypeDefs);
      const newSchema = buildSchema(newTypeDefs);

      const breakingChanges = detectGraphQLBreakingChanges(oldSchema, newSchema);

      expect(breakingChanges).toEqual([
        expect.objectContaining({
          type: 'FIELD_REMOVED',
          description: 'Author.email was removed',
          severity: 'BREAKING'
        }),
        expect.objectContaining({
          type: 'FIELD_TYPE_CHANGED',
          description: 'Article.publishedAt changed type from String to DateTime',
          severity: 'BREAKING'
        })
      ]);

      const nonBreakingChanges = detectGraphQLNonBreakingChanges(oldSchema, newSchema);

      expect(nonBreakingChanges).toEqual([
        expect.objectContaining({
          type: 'FIELD_ADDED',
          description: 'Author.bio was added',
          severity: 'NON_BREAKING'
        }),
        expect.objectContaining({
          type: 'ARG_ADDED',
          description: 'Query.articles arg filter was added',
          severity: 'NON_BREAKING'
        })
      ]);
    });
  });

  describe('Performance Contract Validation', () => {
    it('should validate query performance meets SLA requirements', async () => {
      const performanceQueries = [
        {
          name: 'Article listing',
          query: `
            query GetArticles($first: Int!) {
              articles(first: $first) {
                edges {
                  node {
                    id
                    title
                    author { name }
                  }
                }
              }
            }
          `,
          variables: { first: 20 },
          maxExecutionTime: 100 // milliseconds
        },
        {
          name: 'Complex article with relationships',
          query: `
            query GetArticleDetails($id: ID!) {
              article(id: $id) {
                id
                title
                content
                author {
                  name
                  articles(first: 5) {
                    edges {
                      node {
                        id
                        title
                      }
                    }
                  }
                }
                comments(first: 10) {
                  edges {
                    node {
                      id
                      content
                      author { name }
                    }
                  }
                }
              }
            }
          `,
          variables: { id: 'article-123' },
          maxExecutionTime: 200
        }
      ];

      for (const perfTest of performanceQueries) {
        const startTime = Date.now();
        const result = await graphql(schema, perfTest.query, null, null, perfTest.variables);
        const executionTime = Date.now() - startTime;

        expect(result.errors).toBeUndefined();
        expect(executionTime).toBeLessThan(perfTest.maxExecutionTime);
      }
    });
  });
});

// Helper functions for GraphQL testing
function calculateQueryComplexity(document: DocumentNode, schema: GraphQLSchema): number {
  // Implementation of query complexity calculation
  // This would analyze the AST and calculate complexity based on fields and nesting
  let complexity = 0;
  
  visit(document, {
    Field: {
      enter(node) {
        complexity += 1;
        if (node.selectionSet) {
          complexity += node.selectionSet.selections.length;
        }
      }
    }
  });
  
  return complexity;
}

function detectGraphQLBreakingChanges(oldSchema: GraphQLSchema, newSchema: GraphQLSchema) {
  const changes = [];
  
  // Compare types
  const oldTypes = oldSchema.getTypeMap();
  const newTypes = newSchema.getTypeMap();
  
  for (const typeName in oldTypes) {
    const oldType = oldTypes[typeName];
    const newType = newTypes[typeName];
    
    if (!newType) {
      changes.push({
        type: 'TYPE_REMOVED',
        description: `${typeName} was removed`,
        severity: 'BREAKING'
      });
      continue;
    }
    
    if ('getFields' in oldType && 'getFields' in newType) {
      const oldFields = oldType.getFields();
      const newFields = newType.getFields();
      
      for (const fieldName in oldFields) {
        const oldField = oldFields[fieldName];
        const newField = newFields[fieldName];
        
        if (!newField) {
          changes.push({
            type: 'FIELD_REMOVED',
            description: `${typeName}.${fieldName} was removed`,
            severity: 'BREAKING'
          });
        } else if (oldField.type.toString() !== newField.type.toString()) {
          changes.push({
            type: 'FIELD_TYPE_CHANGED',
            description: `${typeName}.${fieldName} changed type from ${oldField.type} to ${newField.type}`,
            severity: 'BREAKING'
          });
        }
      }
    }
  }
  
  return changes;
}

function detectGraphQLNonBreakingChanges(oldSchema: GraphQLSchema, newSchema: GraphQLSchema) {
  const changes = [];
  
  const oldTypes = oldSchema.getTypeMap();
  const newTypes = newSchema.getTypeMap();
  
  // Check for added types
  for (const typeName in newTypes) {
    if (!oldTypes[typeName]) {
      changes.push({
        type: 'TYPE_ADDED',
        description: `${typeName} was added`,
        severity: 'NON_BREAKING'
      });
    }
  }
  
  // Check for added fields
  for (const typeName in oldTypes) {
    const oldType = oldTypes[typeName];
    const newType = newTypes[typeName];
    
    if (newType && 'getFields' in oldType && 'getFields' in newType) {
      const oldFields = oldType.getFields();
      const newFields = newType.getFields();
      
      for (const fieldName in newFields) {
        if (!oldFields[fieldName]) {
          changes.push({
            type: 'FIELD_ADDED',
            description: `${typeName}.${fieldName} was added`,
            severity: 'NON_BREAKING'
          });
        }
      }
    }
  }
  
  return changes;
}
```

**📊 GraphQL API Contract Testing Results:**
- **Schema Validation**: 100% GraphQL schema compliance with type safety verification
- **Query Complexity Control**: Automated detection and prevention of excessive query complexity
- **Breaking Change Prevention**: Zero unexpected schema changes in production deployments
- **Performance Contract Adherence**: All queries meet sub-200ms response time requirements
- **Subscription Reliability**: 99.9% real-time subscription delivery success rate
- **Error Handling**: Comprehensive input validation with detailed error messaging
```

## Customization Guidelines

### API Protocol Adaptations

- **REST APIs**: Focus on HTTP method semantics, status codes, and resource representations
- **GraphQL APIs**: Emphasize schema evolution, query complexity, and subscription testing
- **gRPC APIs**: Concentrate on Protocol Buffer compatibility and streaming patterns
- **Message Queue APIs**: Prioritize message schema validation and delivery guarantees

### Contract Testing Strategies

- **Consumer-Driven Contracts**: Use Pact or similar tools for consumer-driven testing
- **Provider-First Contracts**: Start with OpenAPI specifications and validate implementations
- **Hybrid Approaches**: Combine specification-first with consumer feedback
- **Contract Versioning**: Implement semantic versioning with compatibility matrices

## Integration with API Development Workflows

### API Development Lifecycle

```yaml
# API contract testing automation in development workflows
api_contract_automation:
  design_phase:
    - specification_first: openapi-schema-definition-before-implementation
    - contract_review: stakeholder-review-of-api-contracts
    - mock_generation: automatic-mock-server-generation-from-specs
    - consumer_feedback: early-consumer-validation-of-proposed-contracts
  
  development_phase:
    - contract_validation: continuous-validation-against-specifications
    - breaking_change_detection: automated-breaking-change-prevention
    - consumer_contract_testing: pact-based-consumer-driven-testing
    - provider_verification: automated-provider-contract-verification
  
  deployment_phase:
    - compatibility_testing: version-compatibility-validation
    - performance_contract: sla-compliance-verification
    - monitoring_integration: contract-compliance-monitoring-in-production
```

### Contract Testing Analytics

```typescript
// API contract testing analytics and monitoring
class APIContractAnalytics {
  
  constructor(
    private contractRegistry: ContractRegistry,
    private testResultsStorage: TestResultsStorage,
    private apiUsageMetrics: APIUsageMetrics
  ) {}
  
  async generateContractComplianceReport(): Promise<ContractComplianceReport> {
    const contracts = await this.contractRegistry.getAllContracts();
    const testResults = await this.testResultsStorage.getRecentResults('30d');
    const usageData = await this.apiUsageMetrics.getUsagePatterns('30d');
    
    return {
      overallCompliance: this.calculateOverallCompliance(testResults),
      contractCoverage: this.analyzeCoverageTrends(contracts, testResults),
      breakingChangeHistory: this.trackBreakingChanges(testResults),
      performanceCompliance: this.analyzePerformanceCompliance(testResults),
      consumerSatisfaction: this.measureConsumerSatisfaction(usageData),
      riskAssessment: this.assessContractRisks(contracts, usageData)
    };
  }
  
  async identifyContractOptimizationOpportunities(): Promise<OptimizationOpportunities> {
    return {
      redundantTests: this.findRedundantContractTests(),
      coverageGaps: this.identifyTestingGaps(),
      performanceIssues: this.identifyPerformanceBottlenecks(),
      maintenanceOpportunities: this.findMaintenanceOpportunities()
    };
  }
}
```

## Success Metrics and Effectiveness

### Contract Testing Quality Indicators

- **Contract Coverage**: Percentage of API endpoints covered by contract tests
- **Breaking Change Prevention**: Success rate in preventing breaking changes from reaching production
- **Consumer Satisfaction**: Feedback scores from API consumers regarding contract clarity
- **Specification Compliance**: Percentage of API implementations that fully comply with specifications

### API Reliability Measurements

- **Contract Violation Rate**: Frequency of contract violations in production
- **Version Compatibility**: Success rate of backward compatibility maintenance
- **Performance Contract Adherence**: Percentage of APIs meeting performance SLAs
- **Error Rate**: Frequency of contract-related integration failures

### Development Efficiency Impact

- **Integration Time**: Reduction in time to integrate with new API versions
- **Debugging Efficiency**: Faster resolution of integration issues through clear contracts
- **Development Velocity**: Improved development speed through reliable API contracts
- **Documentation Quality**: Improved API documentation through contract-driven development

## Best Practices

### Contract Definition Excellence

1. **Specification-First Design**: Define API contracts before implementation
2. **Consumer Input Integration**: Include consumer requirements in contract design
3. **Version Management**: Implement clear versioning and compatibility strategies
4. **Comprehensive Documentation**: Maintain detailed contract documentation with examples

### Testing Strategy Optimization

1. **Automated Validation**: Fully automated contract validation in CI/CD pipelines
2. **Comprehensive Coverage**: Test all contract aspects including edge cases and error scenarios
3. **Performance Integration**: Include performance requirements in contract testing
4. **Real-world Scenarios**: Test with realistic data and usage patterns

### Change Management

1. **Breaking Change Prevention**: Rigorous validation before introducing breaking changes
2. **Migration Support**: Provide clear migration paths for contract changes
3. **Communication Strategy**: Proactive communication of contract changes to consumers
4. **Rollback Capability**: Maintain ability to rollback problematic contract changes

## Common Pitfalls and Solutions

### Over-Specification

**Problem**: Creating overly detailed contracts that constrain implementation flexibility
**Solution**: Balance contract specificity with implementation flexibility, focusing on essential behaviors

### Insufficient Consumer Input

**Problem**: Defining contracts without adequate input from API consumers
**Solution**: Implement consumer-driven contract testing and regular stakeholder feedback

### Version Management Complexity

**Problem**: Complex version management leading to compatibility issues
**Solution**: Clear versioning strategy with automated compatibility validation

### Test Maintenance Overhead

**Problem**: High maintenance overhead for contract tests
**Solution**: Automated test generation and maintenance tools with clear ownership responsibilities

## Advanced Contract Testing Strategies

### AI-Enhanced Contract Testing

- **Intelligent Contract Generation**: AI-powered generation of comprehensive contract tests
- **Breaking Change Prediction**: Machine learning prediction of potential breaking changes
- **Usage Pattern Analysis**: AI analysis of API usage patterns for contract optimization
- **Automated Contract Evolution**: AI-driven contract evolution based on usage patterns

### Continuous Contract Evolution

- **Real-Time Contract Monitoring**: Continuous monitoring of contract compliance in production
- **Adaptive Contract Testing**: Dynamic test generation based on API usage patterns
- **Predictive Contract Management**: Proactive identification of contract evolution needs
- **Self-Healing Contract Tests**: Automatic adaptation of contract tests to specification changes