---
title: "API Gateway Implementation and Legacy Integration Template"
description: "Comprehensive template for implementing API gateway solutions to modernize legacy system integration, enable gradual migration, and establish modern API management practices"
type: "template"
template_category: "code-evolution"
template_subcategory: "legacy-modernization"
tier: "advanced"
template_id: "CE-003"
template_version: "1.0"
validation_status: "tested"
use_case: "api-gateway-integration"
target_scenario: "Implementing API gateway solutions to modernize legacy system access and enable gradual architecture evolution"
complexity_level: "intermediate"
risk_level: "moderate"
effectiveness_metrics: ["integration_efficiency", "api_management", "modernization_enablement"]
estimated_time_savings: "60-75%"
prerequisites: ["api_design", "gateway_technologies", "legacy_systems_knowledge", "microservices_patterns"]
estimated_reading_time: "28 minutes"
word_count: 11200
last_updated: "2025-06-25"
content_status: "final"
---

# API Gateway Implementation and Legacy Integration Template

## Template Overview

This template provides a comprehensive framework for implementing API gateway solutions that enable seamless integration with legacy systems while facilitating gradual modernization. The approach emphasizes API standardization, legacy system abstraction, traffic management, and incremental transformation capabilities that preserve business continuity.

## Usage Context

Use this template when:
- Legacy systems need modern API interfaces without internal modifications
- Multiple client applications require unified access to diverse backend systems
- Gradual migration from monolithic to microservices architecture is planned
- API management, security, and monitoring capabilities need to be centralized
- Legacy system integration complexity is impeding new development initiatives

## Template Structure

### API Gateway Integration Context Setup

```
**Context**: API Gateway implementation for legacy system integration in {PROJECT_NAME}

**Current Integration Landscape**:
- Legacy systems: {SYSTEM_TYPES_PROTOCOLS_INTERFACES}
- Client applications: {WEB_MOBILE_PARTNER_INTEGRATIONS}
- Current integration complexity: {POINT_TO_POINT_CONNECTIONS_PROTOCOLS}
- Authentication/authorization: {CURRENT_SECURITY_MECHANISMS}
- Monitoring and observability: {EXISTING_MONITORING_CAPABILITIES}

**API Gateway Objectives**:
- Legacy system abstraction: {API_STANDARDIZATION_GOALS}
- Traffic management: {ROUTING_LOAD_BALANCING_REQUIREMENTS}
- Security centralization: {AUTHENTICATION_AUTHORIZATION_POLICIES}
- Monitoring and analytics: {OBSERVABILITY_METRICS_REQUIREMENTS}
- Migration enablement: {MODERNIZATION_ROADMAP_SUPPORT}

**Integration Requirements**:
- Performance expectations: {LATENCY_THROUGHPUT_AVAILABILITY_TARGETS}
- Security compliance: {REGULATORY_SECURITY_STANDARDS}
- Scalability needs: {TRAFFIC_GROWTH_PROJECTIONS}
- Legacy system constraints: {MODIFICATION_LIMITATIONS_DEPENDENCIES}
```

### Comprehensive API Gateway Framework

```
**Primary API Gateway Implementation Request**: Design and implement API gateway solution for legacy system integration and modernization:

**Legacy Integration Analysis Scope**:
[PROVIDE_CURRENT_SYSTEM_ARCHITECTURE_INTEGRATION_PATTERNS]

**API Gateway Implementation Strategy**:

1. **Gateway Architecture Design and Planning**:
   - Analyze legacy system interfaces and design modern API abstractions
   - Design gateway architecture for high availability and scalability
   - Plan integration patterns for different legacy system types
   - Establish API versioning and backward compatibility strategies

2. **Legacy System Integration and Adaptation**:
   - Implement protocol translation and data format conversion
   - Design adapter patterns for legacy system communication
   - Establish connection pooling and resource management for legacy systems
   - Create fallback and circuit breaker patterns for legacy system resilience

3. **Modern API Management Implementation**:
   - Implement unified API design standards and documentation
   - Establish authentication, authorization, and rate limiting policies
   - Create API lifecycle management and versioning strategies
   - Design developer portal and API discovery mechanisms

4. **Traffic Management and Routing**:
   - Implement intelligent routing based on business rules and system capabilities
   - Design load balancing and failover strategies across legacy and modern systems
   - Establish canary deployment and gradual migration traffic routing
   - Create monitoring and alerting for traffic patterns and system health

5. **Observability and Analytics Implementation**:
   - Implement comprehensive API metrics, logging, and tracing
   - Design analytics dashboards for API usage and performance monitoring
   - Establish SLA monitoring and automated alerting systems
   - Create audit trails and compliance reporting capabilities

**Generate the following deliverables**:
- Comprehensive API gateway architecture with legacy integration design
- Protocol translation and adapter implementations for legacy systems
- Modern API specifications and developer documentation
- Traffic management and routing configuration with monitoring
- Security implementation with centralized authentication and authorization
```

## Implementation Examples

### Kong API Gateway with Legacy Mainframe Integration

```
**Context**: Kong API Gateway implementation for legacy mainframe and modern microservices integration

**API Gateway Implementation Request**: Implement Kong gateway to modernize access to legacy mainframe systems:

**Current Legacy Integration Challenge**:
```yaml
# Current legacy system landscape
legacy_systems:
  mainframe_system:
    type: "IBM z/OS CICS"
    protocols: ["CICS Transaction Gateway", "MQ Series"]
    data_formats: ["COBOL Copybooks", "Fixed-width records"]
    authentication: "RACF/ACF2"
    availability: "24/7 critical"
    
  oracle_database:
    type: "Oracle 11g"
    protocols: ["OCI", "JDBC"]
    data_formats: ["Relational tables", "PL/SQL procedures"]
    authentication: "Database users"
    
  file_transfer_system:
    type: "IBM Connect:Direct"
    protocols: ["NDM", "FTP"]
    data_formats: ["Fixed-width", "CSV", "XML"]
    authentication: "System certificates"

current_integration_issues:
  - point_to_point_connections: 45
  - protocol_diversity: 8
  - authentication_mechanisms: 12
  - monitoring_gaps: "Limited visibility into integration health"
  - development_complexity: "6 months average for new integrations"
```

**Kong Gateway Architecture Implementation**:
```yaml
# Kong gateway configuration for legacy integration
kong_configuration:
  database: "postgres"
  declarative_config: "/etc/kong/kong.yml"
  
  plugins:
    - name: "request-transformer"
    - name: "response-transformer" 
    - name: "correlation-id"
    - name: "prometheus"
    - name: "jwt"
    - name: "rate-limiting"
    - name: "circuit-breaker"

# Service definitions for legacy systems
services:
  - name: "mainframe-customer-service"
    url: "http://mainframe-adapter:8080"
    protocol: "http"
    host: "mainframe-adapter"
    port: 8080
    path: "/cics/customer"
    
  - name: "oracle-account-service"  
    url: "http://oracle-adapter:8081"
    protocol: "http"
    host: "oracle-adapter"
    port: 8081
    path: "/oracle/accounts"

# Route definitions with modern API design
routes:
  - name: "customer-api-v1"
    service: "mainframe-customer-service"
    protocols: ["http", "https"]
    methods: ["GET", "POST", "PUT", "DELETE"]
    paths: ["/api/v1/customers"]
    strip_path: true
    
  - name: "accounts-api-v1"
    service: "oracle-account-service"
    protocols: ["http", "https"] 
    methods: ["GET", "POST", "PUT"]
    paths: ["/api/v1/accounts"]
    strip_path: true

# Plugin configurations for legacy integration
plugins:
  # JWT authentication for modern API access
  - name: "jwt"
    service: "mainframe-customer-service"
    config:
      key_claim_name: "iss"
      secret_is_base64: false
      
  # Rate limiting to protect legacy systems
  - name: "rate-limiting"
    service: "mainframe-customer-service"
    config:
      minute: 100
      hour: 1000
      policy: "cluster"
      
  # Request transformation for legacy protocol adaptation
  - name: "request-transformer"
    service: "mainframe-customer-service"
    config:
      add:
        headers:
          - "X-Legacy-System: CICS"
          - "X-Transaction-ID: {{correlation_id}}"
        body:
          - "transaction_type: INQUIRY"
      remove:
        headers:
          - "Authorization"
        
  # Response transformation for modern API format
  - name: "response-transformer"
    service: "mainframe-customer-service"
    config:
      add:
        headers:
          - "X-API-Version: 1.0"
          - "X-Response-Time: {{upstream_response_time}}"
      remove:
        headers:
          - "X-Internal-System"
          
  # Circuit breaker for legacy system protection
  - name: "circuit-breaker"
    service: "mainframe-customer-service"
    config:
      failure_threshold: 10
      recovery_timeout: 30
      monitoring_window: 60
```

**Legacy System Adapter Implementation**:
```java
// Java adapter for mainframe CICS integration
@RestController
@RequestMapping("/cics")
public class MainframeCICSAdapter {
    
    @Autowired
    private CICSTransactionGateway cicsGateway;
    
    @Autowired
    private DataTransformationService transformationService;
    
    @Autowired
    private CircuitBreaker circuitBreaker;
    
    // Modern REST API endpoint that adapts to legacy CICS transactions
    @GetMapping("/customer/{customerId}")
    public ResponseEntity<CustomerResponse> getCustomer(
            @PathVariable String customerId,
            @RequestHeader("X-Transaction-ID") String transactionId) {
        
        return circuitBreaker.executeSupplier(() -> {
            try {
                // Transform modern API request to CICS transaction format
                CICSInquiryRequest cicsRequest = CICSInquiryRequest.builder()
                    .transactionCode("CUST")
                    .operationCode("INQ")
                    .customerId(customerId)
                    .terminalId("APIGW")
                    .transactionId(transactionId)
                    .build();
                
                // Execute CICS transaction
                CICSTransactionResponse cicsResponse = cicsGateway.executeTransaction(cicsRequest);
                
                // Transform CICS response to modern API format
                CustomerResponse apiResponse = transformationService.transformCICSToAPI(cicsResponse);
                
                return ResponseEntity.ok(apiResponse);
                
            } catch (CICSException e) {
                log.error("CICS transaction failed for customer {}: {}", customerId, e.getMessage());
                throw new LegacySystemException("Customer inquiry failed", e);
            }
        });
    }
    
    @PostMapping("/customer")
    public ResponseEntity<CustomerCreateResponse> createCustomer(
            @RequestBody @Valid CustomerCreateRequest request,
            @RequestHeader("X-Transaction-ID") String transactionId) {
        
        return circuitBreaker.executeSupplier(() -> {
            try {
                // Validate business rules before calling legacy system
                validateCustomerCreationRequest(request);
                
                // Transform to CICS transaction format
                CICSCustomerCreateRequest cicsRequest = transformationService
                    .transformAPIToCICSCreate(request, transactionId);
                
                // Execute CICS customer creation transaction
                CICSTransactionResponse cicsResponse = cicsGateway.executeTransaction(cicsRequest);
                
                // Transform response
                CustomerCreateResponse apiResponse = transformationService
                    .transformCICSCreateToAPI(cicsResponse);
                
                return ResponseEntity.created(
                    URI.create("/api/v1/customers/" + apiResponse.getCustomerId())
                ).body(apiResponse);
                
            } catch (ValidationException e) {
                return ResponseEntity.badRequest().build();
            } catch (CICSException e) {
                log.error("CICS customer creation failed: {}", e.getMessage());
                throw new LegacySystemException("Customer creation failed", e);
            }
        });
    }
}

// CICS Transaction Gateway Service
@Service
public class CICSTransactionGateway {
    
    @Value("${cics.gateway.host}")
    private String cicsHost;
    
    @Value("${cics.gateway.port}")
    private int cicsPort;
    
    private final ConnectionPool connectionPool;
    
    public CICSTransactionResponse executeTransaction(CICSInquiryRequest request) throws CICSException {
        CTGConnection connection = null;
        try {
            // Get connection from pool
            connection = connectionPool.getConnection();
            
            // Create CICS transaction
            ECIRequest eciRequest = new ECIRequest();
            eciRequest.setProgram("CUSTINQ");
            eciRequest.setTransid("CUST");
            eciRequest.setCommareaData(request.toCommareaBytes());
            
            // Execute transaction
            connection.flowRequest(eciRequest);
            
            // Process response
            byte[] responseData = eciRequest.getCommareaData();
            return CICSTransactionResponse.fromCommareaBytes(responseData);
            
        } catch (Exception e) {
            throw new CICSException("Transaction execution failed", e);
        } finally {
            if (connection != null) {
                connectionPool.returnConnection(connection);
            }
        }
    }
}

// Data transformation service for legacy format conversion
@Service
public class DataTransformationService {
    
    public CustomerResponse transformCICSToAPI(CICSTransactionResponse cicsResponse) {
        // Transform COBOL copybook format to JSON API format
        CICSCustomerRecord cicsRecord = cicsResponse.getCustomerRecord();
        
        return CustomerResponse.builder()
            .customerId(cicsRecord.getCustomerId().trim())
            .firstName(cicsRecord.getFirstName().trim())
            .lastName(cicsRecord.getLastName().trim())
            .dateOfBirth(parseDate(cicsRecord.getDateOfBirth()))
            .accountStatus(mapAccountStatus(cicsRecord.getAccountStatus()))
            .creditRating(cicsRecord.getCreditRating())
            .lastUpdated(parseTimestamp(cicsRecord.getLastUpdateTimestamp()))
            .build();
    }
    
    public CICSCustomerCreateRequest transformAPIToCICSCreate(
            CustomerCreateRequest apiRequest, String transactionId) {
        
        return CICSCustomerCreateRequest.builder()
            .transactionCode("CUST")
            .operationCode("ADD")
            .customerId(generateCustomerId())
            .firstName(padString(apiRequest.getFirstName(), 20))
            .lastName(padString(apiRequest.getLastName(), 20))
            .dateOfBirth(formatDate(apiRequest.getDateOfBirth()))
            .ssn(apiRequest.getSocialSecurityNumber())
            .transactionId(transactionId)
            .terminalId("APIGW")
            .build();
    }
    
    private String mapAccountStatus(String cicsStatus) {
        // Map CICS status codes to API enum values
        switch (cicsStatus.trim()) {
            case "A": return "ACTIVE";
            case "I": return "INACTIVE"; 
            case "S": return "SUSPENDED";
            case "C": return "CLOSED";
            default: return "UNKNOWN";
        }
    }
}
```

**Kong Integration with Modern Monitoring**:
```yaml
# Prometheus monitoring configuration for Kong
apiVersion: v1
kind: ConfigMap
metadata:
  name: kong-prometheus-config
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
    scrape_configs:
      - job_name: 'kong'
        static_configs:
          - targets: ['kong-admin:8001']
        metrics_path: /metrics
        
      - job_name: 'kong-proxy'
        static_configs:
          - targets: ['kong-proxy:8000']
        metrics_path: /metrics

---
# Grafana dashboard configuration for API gateway metrics
apiVersion: v1
kind: ConfigMap
metadata:
  name: kong-grafana-dashboard
data:
  kong-dashboard.json: |
    {
      "dashboard": {
        "title": "Kong API Gateway - Legacy Integration",
        "panels": [
          {
            "title": "API Request Rate",
            "targets": [
              {"expr": "rate(kong_http_requests_total[5m])"}
            ]
          },
          {
            "title": "Legacy System Response Times",
            "targets": [
              {"expr": "histogram_quantile(0.95, rate(kong_upstream_target_health[5m]))"}
            ]
          },
          {
            "title": "Circuit Breaker Status",
            "targets": [
              {"expr": "kong_circuit_breaker_state"}
            ]
          },
          {
            "title": "Legacy System Availability",
            "targets": [
              {"expr": "kong_upstream_target_health"}
            ]
          }
        ]
      }
    }
```

**Expected Deliverables**:
- Kong API Gateway deployment with legacy system integration
- Protocol adapter implementations for mainframe and database systems
- Modern REST API specifications with OpenAPI documentation
- Comprehensive monitoring and alerting setup for gateway and legacy systems
- Data transformation layer handling legacy format conversion

Generate the implementation focusing on:
1. Kong gateway configuration with legacy-specific plugins and routing
2. Java adapter services providing modern API interfaces to legacy systems
3. Data transformation handling COBOL copybooks and legacy formats
4. Circuit breaker and resilience patterns protecting legacy systems
5. Comprehensive monitoring and observability for the entire integration layer
```

### AWS API Gateway with Legacy SOAP Services Integration

```
**Context**: AWS API Gateway implementation for legacy SOAP services modernization

**API Gateway Implementation Request**: Implement AWS API Gateway to modernize access to legacy SOAP services:

**Current Legacy SOAP Services Landscape**:
```xml
<!-- Legacy SOAP service definitions -->
<!-- Customer Management Service WSDL -->
<definitions xmlns="http://schemas.xmlsoap.org/wsdl/"
             targetNamespace="http://legacy.company.com/customer"
             xmlns:tns="http://legacy.company.com/customer">
             
  <types>
    <schema xmlns="http://www.w3.org/2001/XMLSchema"
            targetNamespace="http://legacy.company.com/customer">
            
      <complexType name="CustomerRequest">
        <sequence>
          <element name="customerId" type="string"/>
          <element name="includeHistory" type="boolean"/>
        </sequence>
      </complexType>
      
      <complexType name="CustomerResponse">
        <sequence>
          <element name="customer" type="tns:Customer"/>
          <element name="errorCode" type="string" minOccurs="0"/>
          <element name="errorMessage" type="string" minOccurs="0"/>
        </sequence>
      </complexType>
      
    </schema>
  </types>
  
  <message name="GetCustomerRequest">
    <part name="parameters" type="tns:CustomerRequest"/>
  </message>
  
  <message name="GetCustomerResponse">
    <part name="parameters" type="tns:CustomerResponse"/>
  </message>
  
  <portType name="CustomerServicePortType">
    <operation name="GetCustomer">
      <input message="tns:GetCustomerRequest"/>
      <output message="tns:GetCustomerResponse"/>
    </operation>
  </portType>
  
  <binding name="CustomerServiceSoapBinding" type="tns:CustomerServicePortType">
    <soap:binding style="rpc" transport="http://schemas.xmlsoap.org/soap/http"/>
    <operation name="GetCustomer">
      <soap:operation soapAction="http://legacy.company.com/customer/GetCustomer"/>
      <input><soap:body use="encoded"/></input>
      <output><soap:body use="encoded"/></output>
    </operation>
  </binding>
  
</definitions>
```

**AWS API Gateway REST API Implementation**:
```yaml
# AWS API Gateway REST API specification (OpenAPI 3.0)
openapi: 3.0.0
info:
  title: "Modernized Customer API"
  version: "1.0.0"
  description: "Modern REST API for legacy SOAP customer services"

servers:
  - url: "https://api.company.com/v1"
    description: "Production API Gateway"

paths:
  /customers/{customerId}:
    get:
      summary: "Get customer information"
      parameters:
        - name: customerId
          in: path
          required: true
          schema:
            type: string
        - name: includeHistory
          in: query
          required: false
          schema:
            type: boolean
            default: false
      responses:
        '200':
          description: "Customer information retrieved successfully"
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Customer'
        '404':
          description: "Customer not found"
        '500':
          description: "Internal server error"
      x-amazon-apigateway-integration:
        type: aws_proxy
        httpMethod: POST
        uri: "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:123456789012:function:soap-adapter/invocations"
        
  /customers:
    post:
      summary: "Create new customer"
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CustomerCreateRequest'
      responses:
        '201':
          description: "Customer created successfully"
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Customer'
      x-amazon-apigateway-integration:
        type: aws_proxy
        httpMethod: POST
        uri: "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:123456789012:function:soap-adapter/invocations"

components:
  schemas:
    Customer:
      type: object
      properties:
        customerId:
          type: string
        firstName:
          type: string
        lastName:
          type: string
        email:
          type: string
        dateOfBirth:
          type: string
          format: date
        accountStatus:
          type: string
          enum: [ACTIVE, INACTIVE, SUSPENDED]
    
    CustomerCreateRequest:
      type: object
      required:
        - firstName
        - lastName
        - email
      properties:
        firstName:
          type: string
        lastName:
          type: string
        email:
          type: string
          format: email
        dateOfBirth:
          type: string
          format: date

  securitySchemes:
    ApiKeyAuth:
      type: apiKey
      in: header
      name: X-API-Key
      
security:
  - ApiKeyAuth: []
```

**Lambda Function for SOAP Integration**:
```python
# Python Lambda function for SOAP service integration
import json
import xml.etree.ElementTree as ET
import requests
from datetime import datetime
import boto3
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

class SOAPAdapter:
    def __init__(self):
        self.soap_endpoint = 'http://legacy-soap-service.company.com/CustomerService'
        self.soap_action_base = 'http://legacy.company.com/customer/'
        self.namespace = 'http://legacy.company.com/customer'
        
        # CloudWatch metrics client
        self.cloudwatch = boto3.client('cloudwatch')
        
    def lambda_handler(self, event, context):
        """Main Lambda handler for API Gateway integration"""
        try:
            # Extract request information
            http_method = event['httpMethod']
            resource_path = event['resource']
            path_parameters = event.get('pathParameters', {})
            query_parameters = event.get('queryStringParameters', {}) or {}
            body = event.get('body')
            
            # Route to appropriate handler
            if resource_path == '/customers/{customerId}' and http_method == 'GET':
                return self.handle_get_customer(path_parameters, query_parameters)
            elif resource_path == '/customers' and http_method == 'POST':
                return self.handle_create_customer(body)
            else:
                return self.create_error_response(404, 'Not Found', 'Endpoint not found')
                
        except Exception as e:
            logger.error(f"Unexpected error: {str(e)}")
            self.record_metric('LegacyIntegrationError', 1)
            return self.create_error_response(500, 'Internal Server Error', 'An unexpected error occurred')
    
    def handle_get_customer(self, path_parameters, query_parameters):
        """Handle GET customer request"""
        customer_id = path_parameters.get('customerId')
        include_history = query_parameters.get('includeHistory', 'false').lower() == 'true'
        
        if not customer_id:
            return self.create_error_response(400, 'Bad Request', 'Customer ID is required')
        
        try:
            # Create SOAP request
            soap_request = self.create_get_customer_soap_request(customer_id, include_history)
            
            # Call legacy SOAP service
            soap_response = self.call_soap_service('GetCustomer', soap_request)
            
            # Transform SOAP response to REST JSON
            customer_data = self.transform_soap_to_json(soap_response)
            
            self.record_metric('SuccessfulLegacyCall', 1)
            
            return {
                'statusCode': 200,
                'headers': {
                    'Content-Type': 'application/json',
                    'X-API-Version': '1.0'
                },
                'body': json.dumps(customer_data)
            }
            
        except CustomerNotFoundException as e:
            return self.create_error_response(404, 'Not Found', f'Customer {customer_id} not found')
        except SOAPException as e:
            logger.error(f"SOAP service error: {str(e)}")
            self.record_metric('LegacyServiceError', 1)
            return self.create_error_response(502, 'Bad Gateway', 'Legacy service error')
    
    def handle_create_customer(self, body):
        """Handle POST customer creation request"""
        try:
            request_data = json.loads(body) if body else {}
            
            # Validate required fields
            required_fields = ['firstName', 'lastName', 'email']
            for field in required_fields:
                if field not in request_data:
                    return self.create_error_response(400, 'Bad Request', f'Missing required field: {field}')
            
            # Create SOAP request
            soap_request = self.create_create_customer_soap_request(request_data)
            
            # Call legacy SOAP service
            soap_response = self.call_soap_service('CreateCustomer', soap_request)
            
            # Transform response
            customer_data = self.transform_create_response_to_json(soap_response)
            
            self.record_metric('SuccessfulCustomerCreation', 1)
            
            return {
                'statusCode': 201,
                'headers': {
                    'Content-Type': 'application/json',
                    'Location': f'/customers/{customer_data["customerId"]}'
                },
                'body': json.dumps(customer_data)
            }
            
        except ValidationException as e:
            return self.create_error_response(400, 'Bad Request', str(e))
        except SOAPException as e:
            logger.error(f"SOAP service error during creation: {str(e)}")
            self.record_metric('LegacyServiceError', 1)
            return self.create_error_response(502, 'Bad Gateway', 'Customer creation failed')
    
    def create_get_customer_soap_request(self, customer_id, include_history):
        """Create SOAP request XML for customer lookup"""
        soap_envelope = f"""<?xml version="1.0" encoding="utf-8"?>
        <soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
                       xmlns:cust="{self.namespace}">
            <soap:Header/>
            <soap:Body>
                <cust:GetCustomer>
                    <cust:customerId>{customer_id}</cust:customerId>
                    <cust:includeHistory>{str(include_history).lower()}</cust:includeHistory>
                </cust:GetCustomer>
            </soap:Body>
        </soap:Envelope>"""
        
        return soap_envelope
    
    def call_soap_service(self, operation, soap_request):
        """Call legacy SOAP service with proper error handling"""
        headers = {
            'Content-Type': 'text/xml; charset=utf-8',
            'SOAPAction': f'{self.soap_action_base}{operation}'
        }
        
        try:
            response = requests.post(
                self.soap_endpoint,
                data=soap_request,
                headers=headers,
                timeout=30
            )
            
            if response.status_code == 200:
                return response.text
            elif response.status_code == 404:
                raise CustomerNotFoundException("Customer not found")
            else:
                raise SOAPException(f"SOAP service returned status {response.status_code}")
                
        except requests.Timeout:
            raise SOAPException("SOAP service timeout")
        except requests.ConnectionError:
            raise SOAPException("SOAP service connection error")
    
    def transform_soap_to_json(self, soap_response):
        """Transform SOAP XML response to JSON format"""
        try:
            # Parse XML response
            root = ET.fromstring(soap_response)
            
            # Navigate to customer data (namespace handling)
            customer_elem = root.find('.//{http://legacy.company.com/customer}customer')
            
            if customer_elem is None:
                raise SOAPException("Invalid SOAP response format")
            
            # Extract customer data
            customer_data = {
                'customerId': self.get_element_text(customer_elem, 'customerId'),
                'firstName': self.get_element_text(customer_elem, 'firstName'),
                'lastName': self.get_element_text(customer_elem, 'lastName'),
                'email': self.get_element_text(customer_elem, 'email'),
                'dateOfBirth': self.get_element_text(customer_elem, 'dateOfBirth'),
                'accountStatus': self.map_account_status(self.get_element_text(customer_elem, 'status'))
            }
            
            return customer_data
            
        except ET.ParseError as e:
            raise SOAPException(f"XML parsing error: {str(e)}")
    
    def get_element_text(self, parent, element_name):
        """Safely extract text from XML element"""
        elem = parent.find(f'.//{{{self.namespace}}}{element_name}')
        return elem.text if elem is not None else None
    
    def map_account_status(self, legacy_status):
        """Map legacy status codes to modern API enum values"""
        status_mapping = {
            'A': 'ACTIVE',
            'I': 'INACTIVE',
            'S': 'SUSPENDED',
            'C': 'CLOSED'
        }
        return status_mapping.get(legacy_status, 'UNKNOWN')
    
    def record_metric(self, metric_name, value):
        """Record custom CloudWatch metric"""
        try:
            self.cloudwatch.put_metric_data(
                Namespace='LegacyIntegration',
                MetricData=[
                    {
                        'MetricName': metric_name,
                        'Value': value,
                        'Unit': 'Count',
                        'Timestamp': datetime.utcnow()
                    }
                ]
            )
        except Exception as e:
            logger.warning(f"Failed to record metric: {str(e)}")
    
    def create_error_response(self, status_code, error, message):
        """Create standardized error response"""
        return {
            'statusCode': status_code,
            'headers': {'Content-Type': 'application/json'},
            'body': json.dumps({
                'error': error,
                'message': message,
                'timestamp': datetime.utcnow().isoformat()
            })
        }

# Custom exception classes
class CustomerNotFoundException(Exception):
    pass

class SOAPException(Exception):
    pass

class ValidationException(Exception):
    pass

# Lambda handler function
def lambda_handler(event, context):
    adapter = SOAPAdapter()
    return adapter.lambda_handler(event, context)
```

**CloudFormation Template for AWS Infrastructure**:
```yaml
AWSTemplateFormatVersion: '2010-09-09'
Description: 'API Gateway with Lambda for Legacy SOAP Integration'

Parameters:
  ApiName:
    Type: String
    Default: 'legacy-soap-api'
  StageName:
    Type: String
    Default: 'v1'

Resources:
  # Lambda function for SOAP adaptation
  SOAPAdapterFunction:
    Type: AWS::Lambda::Function
    Properties:
      FunctionName: !Sub '${ApiName}-soap-adapter'
      Runtime: python3.9
      Handler: lambda_function.lambda_handler
      Code:
        ZipFile: |
          # Lambda function code would be deployed here
          def lambda_handler(event, context):
              return {'statusCode': 200, 'body': 'Hello World'}
      Environment:
        Variables:
          SOAP_ENDPOINT: 'http://legacy-soap-service.company.com/CustomerService'
          LOG_LEVEL: 'INFO'
      Timeout: 30
      MemorySize: 512
      Role: !GetAtt LambdaExecutionRole.Arn

  # IAM role for Lambda execution
  LambdaExecutionRole:
    Type: AWS::IAM::Role
    Properties:
      AssumeRolePolicyDocument:
        Version: '2012-10-17'
        Statement:
          - Effect: Allow
            Principal:
              Service: lambda.amazonaws.com
            Action: sts:AssumeRole
      ManagedPolicyArns:
        - arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole
      Policies:
        - PolicyName: CloudWatchMetrics
          PolicyDocument:
            Version: '2012-10-17'
            Statement:
              - Effect: Allow
                Action:
                  - cloudwatch:PutMetricData
                Resource: '*'

  # API Gateway REST API
  LegacyIntegrationAPI:
    Type: AWS::ApiGateway::RestApi
    Properties:
      Name: !Ref ApiName
      Description: 'API Gateway for Legacy SOAP Integration'
      EndpointConfiguration:
        Types:
          - REGIONAL

  # API Gateway resources and methods
  CustomersResource:
    Type: AWS::ApiGateway::Resource
    Properties:
      RestApiId: !Ref LegacyIntegrationAPI
      ParentId: !GetAtt LegacyIntegrationAPI.RootResourceId
      PathPart: 'customers'

  CustomerIdResource:
    Type: AWS::ApiGateway::Resource
    Properties:
      RestApiId: !Ref LegacyIntegrationAPI
      ParentId: !Ref CustomersResource
      PathPart: '{customerId}'

  # GET /customers/{customerId}
  GetCustomerMethod:
    Type: AWS::ApiGateway::Method
    Properties:
      RestApiId: !Ref LegacyIntegrationAPI
      ResourceId: !Ref CustomerIdResource
      HttpMethod: GET
      AuthorizationType: AWS_IAM
      Integration:
        Type: AWS_PROXY
        IntegrationHttpMethod: POST
        Uri: !Sub 'arn:aws:apigateway:${AWS::Region}:lambda:path/2015-03-31/functions/${SOAPAdapterFunction.Arn}/invocations'

  # POST /customers
  CreateCustomerMethod:
    Type: AWS::ApiGateway::Method
    Properties:
      RestApiId: !Ref LegacyIntegrationAPI
      ResourceId: !Ref CustomersResource
      HttpMethod: POST
      AuthorizationType: AWS_IAM
      Integration:
        Type: AWS_PROXY
        IntegrationHttpMethod: POST
        Uri: !Sub 'arn:aws:apigateway:${AWS::Region}:lambda:path/2015-03-31/functions/${SOAPAdapterFunction.Arn}/invocations'

  # Lambda permission for API Gateway
  LambdaApiGatewayPermission:
    Type: AWS::Lambda::Permission
    Properties:
      Action: lambda:InvokeFunction
      FunctionName: !Ref SOAPAdapterFunction
      Principal: apigateway.amazonaws.com
      SourceArn: !Sub '${LegacyIntegrationAPI}/*/ANY/*'

  # API Gateway deployment
  ApiDeployment:
    Type: AWS::ApiGateway::Deployment
    DependsOn:
      - GetCustomerMethod
      - CreateCustomerMethod
    Properties:
      RestApiId: !Ref LegacyIntegrationAPI
      StageName: !Ref StageName

Outputs:
  ApiEndpoint:
    Description: 'API Gateway endpoint URL'
    Value: !Sub 'https://${LegacyIntegrationAPI}.execute-api.${AWS::Region}.amazonaws.com/${StageName}'
    
  LambdaFunctionArn:
    Description: 'Lambda function ARN'
    Value: !GetAtt SOAPAdapterFunction.Arn
```

**Expected Deliverables**:
- AWS API Gateway configuration with modern REST API design
- Lambda function providing SOAP-to-REST translation layer
- CloudFormation infrastructure-as-code deployment
- CloudWatch monitoring and alerting for legacy integration health
- OpenAPI specification and developer documentation

Generate the implementation with:
1. AWS API Gateway REST API with modern OpenAPI specification
2. Lambda function handling SOAP service integration and transformation
3. CloudFormation template for complete infrastructure deployment
4. CloudWatch metrics and monitoring for legacy system health
5. Comprehensive error handling and circuit breaker patterns for resilience
```

## Advanced API Gateway Patterns

### Traffic Management and Canary Deployment

```
**Advanced Traffic Management Implementation**:

Sophisticated traffic routing for gradual legacy migration:

**Kong Canary Deployment Configuration**:
```yaml
# Kong configuration for canary deployments
services:
  - name: "legacy-customer-service"
    url: "http://legacy-system:8080"
    tags: ["legacy", "customer"]
    
  - name: "modern-customer-service"
    url: "http://modern-service:8080"
    tags: ["modern", "customer"]

# Canary deployment plugin configuration
plugins:
  - name: "canary"
    config:
      start: 0.0
      duration: 3600  # 1 hour canary period
      steps: 10       # 10% increments
      rules:
        - condition: "headers.X-Canary-User == 'true'"
          percentage: 100  # Route canary users to new service
        - condition: "headers.X-User-Tier == 'premium'"
          percentage: 50   # Route 50% of premium users to new service
      fallback:
        service: "legacy-customer-service"
        
  # Advanced routing based on request characteristics
  - name: "request-termination"
    route: "customer-api-v1"
    config:
      status_code: 503
      message: "Service temporarily unavailable"
    enabled: false  # Enable during maintenance windows

# Custom Kong plugin for intelligent routing
kong_plugins:
  intelligent_router:
    priority: 1000
    schema:
      properties:
        legacy_service:
          type: string
        modern_service: 
          type: string
        routing_rules:
          type: array
          items:
            type: object
            properties:
              condition:
                type: string
              target:
                type: string
              weight:
                type: number
```

**Intelligent Routing Logic**:
```lua
-- Custom Kong plugin for intelligent legacy/modern routing
local typedefs = require "kong.db.schema.typedefs"

local schema = {
  name = "intelligent-router",
  fields = {
    { config = {
        type = "record",
        fields = {
          { legacy_service = { type = "string", required = true } },
          { modern_service = { type = "string", required = true } },
          { routing_percentage = { type = "number", default = 0 } },
          { user_based_routing = { type = "boolean", default = false } },
          { feature_flags = { type = "array", elements = { type = "string" } } },
          { fallback_service = { type = "string", default = "legacy" } }
        }
      }
    }
  }
}

local IntelligentRouter = {}

function IntelligentRouter:access(conf)
  local routing_decision = self:determine_routing(conf)
  
  if routing_decision.target == "modern" then
    kong.service.set_target(conf.modern_service, 8080)
  else
    kong.service.set_target(conf.legacy_service, 8080)
  end
  
  -- Add routing context headers
  kong.service.request.set_header("X-Routed-To", routing_decision.target)
  kong.service.request.set_header("X-Routing-Reason", routing_decision.reason)
end

function IntelligentRouter:determine_routing(conf)
  local headers = kong.request.get_headers()
  local query_params = kong.request.get_query()
  
  -- User-based routing
  if conf.user_based_routing then
    local user_id = headers["x-user-id"]
    if user_id then
      local user_hash = ngx.crc32_long(user_id)
      local routing_bucket = user_hash % 100
      
      if routing_bucket < conf.routing_percentage then
        return { target = "modern", reason = "user_based_canary" }
      end
    end
  end
  
  -- Feature flag based routing
  if conf.feature_flags then
    for _, flag in ipairs(conf.feature_flags) do
      if headers["x-feature-" .. flag] == "true" then
        return { target = "modern", reason = "feature_flag_" .. flag }
      end
    end
  end
  
  -- Request characteristic based routing
  local content_type = headers["content-type"]
  if content_type and string.find(content_type, "application/json") then
    -- Route JSON requests to modern service
    local random_value = math.random(100)
    if random_value <= conf.routing_percentage then
      return { target = "modern", reason = "json_request_canary" }
    end
  end
  
  -- Default fallback
  return { target = conf.fallback_service, reason = "default_fallback" }
end

return {
  schema = schema,
  handler = IntelligentRouter
}
```
```

### Legacy Protocol Translation

```
**Multi-Protocol Gateway Implementation**:

Support for diverse legacy protocols through unified API gateway:

**Protocol Adapter Framework**:
```java
// Java framework for legacy protocol adaptation
public interface ProtocolAdapter<T, R> {
    R adaptRequest(T legacyRequest, APIGatewayRequest apiRequest) throws AdaptationException;
    APIGatewayResponse adaptResponse(R legacyResponse) throws AdaptationException;
    boolean supportsProtocol(String protocol);
    HealthStatus checkHealth();
}

@Component
public class SOAPProtocolAdapter implements ProtocolAdapter<SOAPMessage, SOAPMessage> {
    
    @Autowired
    private SOAPConnectionFactory connectionFactory;
    
    @Autowired
    private DataTransformationService transformationService;
    
    @Override
    public SOAPMessage adaptRequest(SOAPMessage legacyFormat, APIGatewayRequest apiRequest) throws AdaptationException {
        try {
            // Transform REST JSON to SOAP XML
            MessageFactory messageFactory = MessageFactory.newInstance();
            SOAPMessage soapMessage = messageFactory.createMessage();
            
            SOAPPart soapPart = soapMessage.getSOAPPart();
            SOAPEnvelope envelope = soapPart.getEnvelope();
            SOAPHeader header = envelope.getHeader();
            SOAPBody body = envelope.getBody();
            
            // Add authentication headers from API Gateway
            if (apiRequest.getHeaders().containsKey("Authorization")) {
                SOAPHeaderElement authHeader = header.addHeaderElement(
                    envelope.createName("Authentication", "auth", "http://company.com/auth"));
                authHeader.addTextNode(apiRequest.getHeaders().get("Authorization"));
            }
            
            // Transform request body
            JSONObject requestJson = new JSONObject(apiRequest.getBody());
            Element requestElement = transformationService.jsonToSOAP(requestJson, envelope);
            body.appendChild(requestElement);
            
            soapMessage.saveChanges();
            return soapMessage;
            
        } catch (Exception e) {
            throw new AdaptationException("SOAP request adaptation failed", e);
        }
    }
    
    @Override
    public APIGatewayResponse adaptResponse(SOAPMessage soapResponse) throws AdaptationException {
        try {
            // Extract SOAP body
            SOAPBody body = soapResponse.getSOAPBody();
            
            // Transform SOAP XML to JSON
            JSONObject responseJson = transformationService.soapToJSON(body);
            
            // Create API Gateway response
            return APIGatewayResponse.builder()
                .statusCode(200)
                .headers(Map.of(
                    "Content-Type", "application/json",
                    "X-Protocol-Adapter", "SOAP"
                ))
                .body(responseJson.toString())
                .build();
                
        } catch (Exception e) {
            throw new AdaptationException("SOAP response adaptation failed", e);
        }
    }
    
    @Override
    public boolean supportsProtocol(String protocol) {
        return "SOAP".equalsIgnoreCase(protocol) || "WSDL".equalsIgnoreCase(protocol);
    }
    
    @Override
    public HealthStatus checkHealth() {
        try {
            // Perform health check against SOAP endpoint
            SOAPConnectionFactory factory = SOAPConnectionFactory.newInstance();
            SOAPConnection connection = factory.createConnection();
            
            // Simple ping operation
            MessageFactory messageFactory = MessageFactory.newInstance();
            SOAPMessage pingMessage = createPingMessage(messageFactory);
            
            SOAPMessage response = connection.call(pingMessage, soapEndpoint);
            connection.close();
            
            return HealthStatus.UP;
            
        } catch (Exception e) {
            return HealthStatus.DOWN.withDetail("SOAP endpoint unreachable", e.getMessage());
        }
    }
}

@Component
public class MQProtocolAdapter implements ProtocolAdapter<byte[], byte[]> {
    
    @Autowired
    private MQConnectionFactory mqConnectionFactory;
    
    @Override
    public byte[] adaptRequest(byte[] legacyFormat, APIGatewayRequest apiRequest) throws AdaptationException {
        try {
            // Create MQ message from REST request
            JSONObject requestJson = new JSONObject(apiRequest.getBody());
            
            // Add correlation ID for tracking
            String correlationId = UUID.randomUUID().toString();
            requestJson.put("correlationId", correlationId);
            
            // Add routing information
            requestJson.put("sourceSystem", "API_GATEWAY");
            requestJson.put("targetQueue", determineTargetQueue(apiRequest.getPath()));
            
            return requestJson.toString().getBytes(StandardCharsets.UTF_8);
            
        } catch (Exception e) {
            throw new AdaptationException("MQ request adaptation failed", e);
        }
    }
    
    @Override
    public APIGatewayResponse adaptResponse(byte[] mqResponse) throws AdaptationException {
        try {
            String responseString = new String(mqResponse, StandardCharsets.UTF_8);
            JSONObject responseJson = new JSONObject(responseString);
            
            // Extract status and error information
            int statusCode = responseJson.optInt("statusCode", 200);
            String errorMessage = responseJson.optString("errorMessage");
            
            APIGatewayResponse.Builder responseBuilder = APIGatewayResponse.builder()
                .statusCode(statusCode)
                .headers(Map.of(
                    "Content-Type", "application/json",
                    "X-Protocol-Adapter", "MQ",
                    "X-Message-Id", responseJson.optString("messageId", "")
                ));
            
            if (statusCode >= 400 && !errorMessage.isEmpty()) {
                responseBuilder.body(createErrorResponse(statusCode, errorMessage));
            } else {
                responseBuilder.body(responseJson.toString());
            }
            
            return responseBuilder.build();
            
        } catch (Exception e) {
            throw new AdaptationException("MQ response adaptation failed", e);
        }
    }
    
    @Override
    public boolean supportsProtocol(String protocol) {
        return "MQ".equalsIgnoreCase(protocol) || "JMS".equalsIgnoreCase(protocol);
    }
}

// Protocol adapter registry and factory
@Service
public class ProtocolAdapterRegistry {
    
    private final Map<String, ProtocolAdapter<?, ?>> adapters = new ConcurrentHashMap<>();
    
    @Autowired
    public ProtocolAdapterRegistry(List<ProtocolAdapter<?, ?>> adapterList) {
        for (ProtocolAdapter<?, ?> adapter : adapterList) {
            registerAdapter(adapter);
        }
    }
    
    private void registerAdapter(ProtocolAdapter<?, ?> adapter) {
        // Register adapter for all supported protocols
        for (String protocol : getSupportedProtocols(adapter)) {
            adapters.put(protocol.toUpperCase(), adapter);
        }
    }
    
    public ProtocolAdapter<?, ?> getAdapter(String protocol) {
        return adapters.get(protocol.toUpperCase());
    }
    
    public List<String> getSupportedProtocols() {
        return new ArrayList<>(adapters.keySet());
    }
    
    public Map<String, HealthStatus> checkAllAdaptersHealth() {
        Map<String, HealthStatus> healthStatus = new HashMap<>();
        
        for (Map.Entry<String, ProtocolAdapter<?, ?>> entry : adapters.entrySet()) {
            try {
                HealthStatus status = entry.getValue().checkHealth();
                healthStatus.put(entry.getKey(), status);
            } catch (Exception e) {
                healthStatus.put(entry.getKey(), HealthStatus.DOWN.withDetail("Health check failed", e.getMessage()));
            }
        }
        
        return healthStatus;
    }
}

// API Gateway integration service
@RestController
@RequestMapping("/api/v1")
public class APIGatewayController {
    
    @Autowired
    private ProtocolAdapterRegistry adapterRegistry;
    
    @Autowired
    private LegacySystemConfigurationService configService;
    
    @PostMapping("/{service}/{operation}")
    public ResponseEntity<?> proxyToLegacySystem(
            @PathVariable String service,
            @PathVariable String operation,
            @RequestBody String requestBody,
            HttpServletRequest request) {
        
        try {
            // Determine target legacy system and protocol
            LegacySystemConfiguration config = configService.getConfiguration(service);
            
            // Get appropriate protocol adapter
            ProtocolAdapter<Object, Object> adapter = 
                (ProtocolAdapter<Object, Object>) adapterRegistry.getAdapter(config.getProtocol());
            
            if (adapter == null) {
                return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
                    .body(createErrorResponse("Unsupported protocol: " + config.getProtocol()));
            }
            
            // Create API Gateway request object
            APIGatewayRequest apiRequest = createAPIGatewayRequest(request, requestBody);
            
            // Adapt request to legacy protocol
            Object legacyRequest = adapter.adaptRequest(null, apiRequest);
            
            // Call legacy system (implementation depends on protocol)
            Object legacyResponse = callLegacySystem(config, legacyRequest);
            
            // Adapt response back to REST format
            APIGatewayResponse apiResponse = adapter.adaptResponse(legacyResponse);
            
            return ResponseEntity.status(apiResponse.getStatusCode())
                .headers(createHttpHeaders(apiResponse.getHeaders()))
                .body(apiResponse.getBody());
                
        } catch (AdaptationException e) {
            return ResponseEntity.status(HttpStatus.BAD_GATEWAY)
                .body(createErrorResponse("Protocol adaptation failed: " + e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(createErrorResponse("Internal server error: " + e.getMessage()));
        }
    }
    
    @GetMapping("/health/adapters")
    public ResponseEntity<Map<String, HealthStatus>> getAdapterHealth() {
        Map<String, HealthStatus> healthStatus = adapterRegistry.checkAllAdaptersHealth();
        
        boolean allHealthy = healthStatus.values().stream()
            .allMatch(status -> status.getStatus() == HealthStatus.Status.UP);
        
        HttpStatus responseStatus = allHealthy ? HttpStatus.OK : HttpStatus.SERVICE_UNAVAILABLE;
        
        return ResponseEntity.status(responseStatus).body(healthStatus);
    }
}
```
```

This comprehensive API Gateway implementation and legacy integration template provides systematic approaches to modernizing legacy system access while enabling gradual migration and maintaining business continuity through intelligent routing, protocol adaptation, and comprehensive monitoring.