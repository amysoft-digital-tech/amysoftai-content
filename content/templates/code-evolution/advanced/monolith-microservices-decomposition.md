---
title: "Monolith to Microservices Decomposition Template"
description: "Comprehensive template for systematically decomposing monolithic applications into microservices architecture with domain-driven design principles and gradual migration strategies"
type: "template"
template_category: "code-evolution"
template_subcategory: "architecture-evolution"
tier: "advanced"
template_id: "CE-014"
template_version: "1.0"
validation_status: "tested"
use_case: "microservices-migration"
target_scenario: "Decomposing monolithic applications into microservices using domain-driven design and gradual migration strategies"
complexity_level: "advanced"
risk_level: "high"
effectiveness_metrics: ["scalability_improvement", "deployment_independence", "team_autonomy"]
estimated_time_savings: "60-80%"
prerequisites: ["domain_driven_design", "distributed_systems", "containerization", "api_design"]
estimated_reading_time: "35 minutes"
word_count: 14000
last_updated: "2025-06-25"
content_status: "final"
---

# Monolith to Microservices Decomposition Template

## Template Overview

This template provides a systematic framework for decomposing monolithic applications into microservices architecture using domain-driven design principles, gradual migration strategies, and proven decomposition patterns. The process emphasizes business continuity, risk mitigation, and measurable improvements in scalability, maintainability, and team productivity.

## Usage Context

Use this template when:
- Monolithic application complexity impedes development velocity and team scalability
- Different components require independent scaling and deployment capabilities
- Multiple teams need to work autonomously on different business domains
- Technology stack diversity is needed for optimal component performance
- System resilience requires fault isolation and independent failure handling

## Template Structure

### Monolith Analysis Context Setup

```
**Context**: Monolith to microservices decomposition for {PROJECT_NAME}

**Current Architecture Analysis**:
- Monolith characteristics: {CODEBASE_SIZE_COMPLEXITY_TECHNOLOGY}
- Business domain complexity: {NUMBER_OF_DOMAINS_BOUNDED_CONTEXTS}
- Team structure: {TEAM_SIZE_ORGANIZATION_CONSTRAINTS}
- Performance bottlenecks: {SCALING_DEPLOYMENT_ISSUES}
- Technology debt: {LEGACY_TECHNOLOGY_CONSTRAINTS}

**Decomposition Objectives**:
- Business domains: {IDENTIFIED_BOUNDED_CONTEXTS}
- Scalability requirements: {COMPONENT_SPECIFIC_SCALING_NEEDS}
- Team autonomy goals: {DESIRED_TEAM_INDEPENDENCE}
- Technology diversification: {POLYGLOT_ARCHITECTURE_REQUIREMENTS}
- Deployment independence: {CI_CD_DEPLOYMENT_GOALS}

**Migration Constraints**:
- Business continuity requirements: {DOWNTIME_TOLERANCE}
- Resource limitations: {BUDGET_TIMELINE_TEAM_CONSTRAINTS}
- Risk tolerance: {ACCEPTABLE_RISK_LEVELS}
- Data consistency requirements: {TRANSACTION_CONSISTENCY_NEEDS}
```

### Comprehensive Microservices Decomposition Framework

```
**Primary Microservices Decomposition Request**: Systematically decompose monolithic application into microservices architecture:

**Monolith Analysis Scope**:
[PROVIDE_CURRENT_ARCHITECTURE_CODEBASE_ANALYSIS]

**Decomposition Strategy**:

1. **Domain-Driven Decomposition Analysis**:
   - Identify bounded contexts and business capabilities
   - Map current monolith modules to domain boundaries
   - Analyze data relationships and transaction patterns
   - Define service boundaries using domain-driven design principles

2. **Gradual Migration Planning**:
   - Design strangler fig pattern for gradual extraction
   - Plan database decomposition and data migration strategies
   - Establish API contracts and service interfaces
   - Create migration roadmap with incremental delivery milestones

3. **Service Architecture Design**:
   - Design individual microservice architectures
   - Establish inter-service communication patterns
   - Implement distributed system patterns (circuit breakers, bulkheads, timeouts)
   - Plan service discovery, configuration management, and observability

4. **Data Architecture Transformation**:
   - Decompose shared databases into service-specific stores
   - Implement eventual consistency and saga patterns
   - Design event-driven architectures for data synchronization
   - Establish data governance and schema evolution strategies

5. **Infrastructure and DevOps Evolution**:
   - Design containerization and orchestration strategies
   - Implement independent CI/CD pipelines for each service
   - Establish monitoring, logging, and distributed tracing
   - Plan capacity management and auto-scaling infrastructure

**Generate the following deliverables**:
- Domain-driven service boundary definitions with clear responsibilities
- Gradual migration plan with risk mitigation strategies
- Microservice architecture designs with technology recommendations
- Database decomposition strategy with data consistency patterns
- Infrastructure automation and DevOps pipeline implementations
```

## Implementation Examples

### Java Spring Boot E-commerce Monolith Decomposition

```
**Context**: Java Spring Boot e-commerce monolith decomposition into microservices

**Microservices Decomposition Request**: Decompose this e-commerce monolith into domain-driven microservices:

**Current Monolith Structure**:
```java
// Current monolithic e-commerce application structure
@SpringBootApplication
public class ECommerceMonolithApplication {
    public static void main(String[] args) {
        SpringApplication.run(ECommerceMonolithApplication.class, args);
    }
}

// Monolithic service layer with mixed concerns
@Service
@Transactional
public class ECommerceService {
    
    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private ProductRepository productRepository;
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private InventoryRepository inventoryRepository;
    
    @Autowired
    private PaymentRepository paymentRepository;
    
    @Autowired
    private ShippingRepository shippingRepository;
    
    // Mixed user management and product catalog concerns
    public UserProfile createUserWithRecommendations(UserRegistrationRequest request) {
        // User creation logic
        User user = new User();
        user.setEmail(request.getEmail());
        user.setPassword(passwordEncoder.encode(request.getPassword()));
        user = userRepository.save(user);
        
        // Product recommendation logic (should be separate service)
        List<Product> recommendedProducts = productRepository
            .findByCategory(determineUserCategory(request));
        
        // Create user profile with recommendations
        UserProfile profile = new UserProfile();
        profile.setUser(user);
        profile.setRecommendedProducts(recommendedProducts);
        
        return profile;
    }
    
    // Complex order processing with multiple domain concerns
    public OrderResult processOrder(OrderRequest orderRequest) {
        // User validation (User domain)
        User user = userRepository.findById(orderRequest.getUserId())
            .orElseThrow(() -> new UserNotFoundException("User not found"));
        
        // Product validation (Product Catalog domain)
        List<OrderItem> validatedItems = new ArrayList<>();
        for (OrderItemRequest itemRequest : orderRequest.getItems()) {
            Product product = productRepository.findById(itemRequest.getProductId())
                .orElseThrow(() -> new ProductNotFoundException("Product not found"));
            
            // Inventory check (Inventory domain)
            InventoryItem inventory = inventoryRepository.findByProductId(product.getId());
            if (inventory.getQuantity() < itemRequest.getQuantity()) {
                throw new InsufficientInventoryException("Not enough inventory");
            }
            
            validatedItems.add(new OrderItem(product, itemRequest.getQuantity()));
        }
        
        // Order creation (Order domain)
        Order order = new Order();
        order.setUser(user);
        order.setItems(validatedItems);
        order.setStatus(OrderStatus.PENDING);
        order.setTotalAmount(calculateTotal(validatedItems));
        order = orderRepository.save(order);
        
        // Payment processing (Payment domain)
        PaymentRequest paymentRequest = new PaymentRequest();
        paymentRequest.setAmount(order.getTotalAmount());
        paymentRequest.setPaymentMethod(orderRequest.getPaymentMethod());
        
        Payment payment = processPayment(paymentRequest);
        order.setPayment(payment);
        
        if (payment.getStatus() == PaymentStatus.SUCCESSFUL) {
            // Inventory update (Inventory domain)
            for (OrderItem item : validatedItems) {
                inventoryRepository.decrementQuantity(
                    item.getProduct().getId(), 
                    item.getQuantity()
                );
            }
            
            // Shipping arrangement (Shipping domain)
            ShippingRequest shippingRequest = new ShippingRequest();
            shippingRequest.setOrder(order);
            shippingRequest.setAddress(orderRequest.getShippingAddress());
            
            Shipping shipping = arrangeShipping(shippingRequest);
            order.setShipping(shipping);
            order.setStatus(OrderStatus.CONFIRMED);
        } else {
            order.setStatus(OrderStatus.FAILED);
        }
        
        order = orderRepository.save(order);
        
        return new OrderResult(order, payment, order.getShipping());
    }
    
    // Product management mixed with pricing and inventory
    public Product createProductWithPricing(ProductCreationRequest request) {
        // Product creation (Product Catalog domain)
        Product product = new Product();
        product.setName(request.getName());
        product.setDescription(request.getDescription());
        product.setCategory(request.getCategory());
        product = productRepository.save(product);
        
        // Pricing logic (Pricing domain)
        ProductPrice price = new ProductPrice();
        price.setProduct(product);
        price.setBasePrice(request.getPrice());
        price.setDiscountPrice(calculateDiscount(request.getPrice(), request.getCategory()));
        priceRepository.save(price);
        
        // Initial inventory setup (Inventory domain)
        InventoryItem inventory = new InventoryItem();
        inventory.setProduct(product);
        inventory.setQuantity(request.getInitialQuantity());
        inventory.setWarehouse(request.getWarehouse());
        inventoryRepository.save(inventory);
        
        return product;
    }
}

// Shared database entities across all domains
@Entity
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private LocalDateTime createdAt;
    
    // Relationships to other domains
    @OneToMany(mappedBy = "user")
    private List<Order> orders;
    
    @OneToMany(mappedBy = "user")
    private List<Payment> payments;
    
    // Getters and setters
}

@Entity
@Table(name = "products")
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String name;
    private String description;
    private String category;
    private LocalDateTime createdAt;
    
    // Cross-domain relationships
    @OneToMany(mappedBy = "product")
    private List<OrderItem> orderItems;
    
    @OneToOne(mappedBy = "product")
    private InventoryItem inventory;
    
    @OneToOne(mappedBy = "product")
    private ProductPrice pricing;
    
    // Getters and setters
}

// Large shared database with cross-domain foreign keys
@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL)
    private List<OrderItem> items;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "payment_id")
    private Payment payment;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "shipping_id")
    private Shipping shipping;
    
    private BigDecimal totalAmount;
    private OrderStatus status;
    private LocalDateTime createdAt;
    
    // Getters and setters
}
```

**Current Architecture Issues**:
- Single shared database with complex cross-domain relationships
- Mixed business concerns in single service layer
- Deployment coupling - all changes require full application deployment
- Scaling limitations - cannot scale individual components independently
- Team coupling - changes in one domain affect other teams

**Decomposition Requirements**:
- Identify 6-8 bounded contexts: User Management, Product Catalog, Inventory, Order Management, Payment Processing, Shipping, Notifications
- Design database-per-service pattern with eventual consistency
- Implement API gateway and service discovery
- Establish event-driven communication between services
- Create independent CI/CD pipelines for each microservice

**Expected Deliverables**:
- Domain-driven microservice architecture with clear service boundaries
- Database decomposition strategy with data migration plan
- Event-driven communication design using message queues
- API gateway configuration with routing and security
- Complete infrastructure automation with Kubernetes deployment

Generate the optimized microservices implementation with:
1. Clear service boundary definitions based on domain-driven design
2. Independent database designs for each microservice
3. Event-driven architecture for inter-service communication
4. API gateway implementation with routing and cross-cutting concerns
5. Infrastructure automation and DevOps pipeline for each service
```

### Node.js/Express Content Management System Decomposition

```
**Context**: Node.js content management system monolith to microservices transformation

**Microservices Decomposition Request**: Transform this content management monolith into microservices:

**Current Monolith Structure**:
```javascript
// Monolithic Express.js CMS application
const express = require('express');
const mongoose = require('mongoose');
const app = express();

// Single large database schema with mixed concerns
const userSchema = new mongoose.Schema({
    username: String,
    email: String,
    password: String,
    role: String,
    profile: {
        firstName: String,
        lastName: String,
        avatar: String
    },
    // Content-related fields mixed in
    authoredArticles: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Article' }],
    subscribedCategories: [String],
    contentPreferences: Object,
    // Analytics fields
    lastLoginAt: Date,
    viewHistory: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Article' }],
    engagementMetrics: Object
});

const articleSchema = new mongoose.Schema({
    title: String,
    content: String,
    author: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    category: String,
    tags: [String],
    publishedAt: Date,
    status: String,
    // SEO and analytics mixed in
    seoMetadata: {
        metaTitle: String,
        metaDescription: String,
        keywords: [String]
    },
    analytics: {
        views: Number,
        likes: Number,
        shares: Number,
        averageReadTime: Number
    },
    // Media management mixed in
    featuredImage: String,
    mediaGallery: [String],
    // Comment management
    comments: [{
        user: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
        content: String,
        createdAt: Date,
        moderated: Boolean
    }]
});

// Monolithic service layer with mixed responsibilities
class CMSService {
    // User management mixed with content operations
    async createUserWithProfile(userData) {
        // User creation (User Management domain)
        const user = new User({
            username: userData.username,
            email: userData.email,
            password: await bcrypt.hash(userData.password, 10),
            role: userData.role || 'author'
        });
        
        // Profile creation (Profile Management domain)
        user.profile = {
            firstName: userData.firstName,
            lastName: userData.lastName,
            avatar: userData.avatar
        };
        
        // Content preferences setup (Content Management domain)
        user.contentPreferences = {
            defaultCategory: userData.preferredCategory,
            editorPreferences: userData.editorSettings,
            publishingWorkflow: userData.workflowPreferences
        };
        
        // Analytics initialization (Analytics domain)
        user.engagementMetrics = {
            articlesPublished: 0,
            totalViews: 0,
            averageEngagement: 0
        };
        
        await user.save();
        
        // Welcome email (Notification domain)
        await this.sendWelcomeEmail(user);
        
        return user;
    }
    
    // Complex article creation spanning multiple domains
    async publishArticle(articleData, authorId) {
        // Content creation (Content Management domain)
        const article = new Article({
            title: articleData.title,
            content: articleData.content,
            author: authorId,
            category: articleData.category,
            tags: articleData.tags,
            status: 'draft'
        });
        
        // Media processing (Media Management domain)
        if (articleData.featuredImage) {
            const processedImage = await this.processImage(articleData.featuredImage);
            article.featuredImage = processedImage.url;
        }
        
        if (articleData.mediaFiles) {
            const processedMedia = await Promise.all(
                articleData.mediaFiles.map(file => this.processMediaFile(file))
            );
            article.mediaGallery = processedMedia.map(media => media.url);
        }
        
        // SEO optimization (SEO domain)
        article.seoMetadata = {
            metaTitle: articleData.seoTitle || articleData.title,
            metaDescription: articleData.metaDescription || this.generateMetaDescription(articleData.content),
            keywords: this.extractKeywords(articleData.content)
        };
        
        // Analytics initialization (Analytics domain)
        article.analytics = {
            views: 0,
            likes: 0,
            shares: 0,
            averageReadTime: this.estimateReadTime(articleData.content)
        };
        
        await article.save();
        
        // Publishing workflow (Workflow domain)
        if (articleData.publishImmediately) {
            await this.publishImmediately(article);
        } else {
            await this.schedulePublication(article, articleData.publishAt);
        }
        
        // Notification to subscribers (Notification domain)
        await this.notifySubscribers(article);
        
        // Update author statistics (Analytics domain)
        await this.updateAuthorStats(authorId);
        
        return article;
    }
    
    // Content discovery mixed with analytics and personalization
    async getPersonalizedContent(userId, page = 1, limit = 10) {
        // User preference retrieval (User Management domain)
        const user = await User.findById(userId);
        
        // Analytics-based personalization (Analytics domain)
        const userEngagement = await this.analyzeUserEngagement(userId);
        const trendingCategories = await this.getTrendingCategories();
        
        // Content recommendation algorithm (Recommendation domain)
        const recommendationScore = await this.calculateRecommendationScores(
            user.contentPreferences,
            user.viewHistory,
            userEngagement,
            trendingCategories
        );
        
        // Content filtering (Content Management domain)
        const articles = await Article.find({
            status: 'published',
            category: { $in: user.subscribedCategories.length > 0 ? user.subscribedCategories : trendingCategories }
        })
        .populate('author', 'username profile')
        .sort(recommendationScore)
        .skip((page - 1) * limit)
        .limit(limit);
        
        // View tracking (Analytics domain)
        await this.trackContentViews(userId, articles.map(a => a._id));
        
        // A/B testing (Experimentation domain)
        const experimentVariant = await this.getExperimentVariant(userId);
        if (experimentVariant) {
            articles.forEach(article => {
                article.displayVariant = experimentVariant;
            });
        }
        
        return articles;
    }
    
    // Comment system with moderation and analytics
    async handleComment(articleId, userId, commentData) {
        // Comment creation (Comment Management domain)
        const article = await Article.findById(articleId);
        
        const comment = {
            user: userId,
            content: commentData.content,
            createdAt: new Date(),
            moderated: false
        };
        
        // Content moderation (Moderation domain)
        const moderationResult = await this.moderateContent(commentData.content);
        if (moderationResult.requiresReview) {
            comment.moderated = false;
            await this.queueForModeration(comment, moderationResult.flags);
        } else {
            comment.moderated = true;
        }
        
        article.comments.push(comment);
        await article.save();
        
        // Analytics tracking (Analytics domain)
        await this.trackEngagement(articleId, 'comment', userId);
        
        // Notification to author (Notification domain)
        await this.notifyAuthor(article.author, 'new_comment', { article, comment });
        
        return comment;
    }
}

// Single large Express.js application handling all domains
app.use('/api/users', userRoutes);
app.use('/api/articles', articleRoutes);
app.use('/api/media', mediaRoutes);
app.use('/api/analytics', analyticsRoutes);
app.use('/api/comments', commentRoutes);
app.use('/api/admin', adminRoutes);

// All routes in single application with shared middleware
app.get('/api/dashboard/:userId', async (req, res) => {
    // Mixed dashboard data from multiple domains
    const user = await User.findById(req.params.userId);
    const userArticles = await Article.find({ author: req.params.userId });
    const analytics = await this.getUserAnalytics(req.params.userId);
    const pendingComments = await this.getPendingComments(req.params.userId);
    const systemNotifications = await this.getSystemNotifications(req.params.userId);
    
    res.json({
        user,
        articles: userArticles,
        analytics,
        pendingComments,
        notifications: systemNotifications
    });
});
```

**Current Architecture Issues**:
- Single MongoDB database with complex embedded documents and cross-references
- Mixed business domains in single service layer and API routes
- Monolithic deployment prevents independent scaling of content vs analytics vs media processing
- Shared codebase creates conflicts between teams working on different features
- Single point of failure affects all CMS functionality

**Decomposition Requirements**:
- Identify bounded contexts: User Management, Content Management, Media Processing, Analytics, Comment System, Notification Service, SEO Optimization
- Design event-driven architecture for real-time updates and notifications
- Implement API composition for dashboard and aggregated views
- Create independent data stores optimized for each domain (MongoDB, PostgreSQL, Redis, Elasticsearch)
- Establish service mesh for secure inter-service communication

**Expected Deliverables**:
- Domain-driven microservice architecture with clear API boundaries
- Event-driven communication using message brokers (RabbitMQ/Apache Kafka)
- API gateway with request routing, rate limiting, and authentication
- Database decomposition with appropriate technology choices per service
- Container orchestration with Docker and Kubernetes deployment

Generate the optimized microservices implementation focusing on:
1. Domain-driven service boundaries with single responsibility principle
2. Event-driven architecture for loose coupling between services
3. API composition patterns for aggregated data requirements
4. Database-per-service with appropriate technology choices
5. Infrastructure automation and service mesh implementation
```

### Python Django Multi-tenant SaaS Decomposition

```
**Context**: Python Django multi-tenant SaaS platform decomposition into microservices

**Microservices Decomposition Request**: Decompose this multi-tenant SaaS platform into scalable microservices:

**Current Monolith Structure**:
```python
# Django monolithic SaaS application with mixed concerns
from django.db import models
from django.contrib.auth.models import AbstractUser

# Single shared database with tenant isolation at row level
class Tenant(models.Model):
    name = models.CharField(max_length=100)
    domain = models.CharField(max_length=100, unique=True)
    created_at = models.DateTimeField(auto_now_add=True)
    # Billing information mixed in
    subscription_plan = models.CharField(max_length=50)
    billing_email = models.EmailField()
    # Feature flags mixed in
    feature_flags = models.JSONField(default=dict)
    # Analytics mixed in
    usage_metrics = models.JSONField(default=dict)

class User(AbstractUser):
    tenant = models.ForeignKey(Tenant, on_delete=models.CASCADE)
    # Profile information
    profile = models.JSONField(default=dict)
    # Billing role mixed in
    is_billing_admin = models.BooleanField(default=False)
    # Usage tracking mixed in
    last_activity = models.DateTimeField(null=True)
    feature_usage = models.JSONField(default=dict)

# Complex model mixing multiple domains
class Project(models.Model):
    tenant = models.ForeignKey(Tenant, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    description = models.TextField()
    owner = models.ForeignKey(User, on_delete=models.CASCADE)
    
    # Team management mixed in
    members = models.ManyToManyField(User, through='ProjectMembership')
    
    # Analytics mixed in
    analytics_config = models.JSONField(default=dict)
    performance_metrics = models.JSONField(default=dict)
    
    # Billing tracking mixed in
    resource_usage = models.JSONField(default=dict)
    billing_category = models.CharField(max_length=50)
    
    # Notification preferences mixed in
    notification_settings = models.JSONField(default=dict)

# Monolithic service layer with mixed responsibilities
class SaaSPlatformService:
    
    def create_tenant_with_setup(self, tenant_data, admin_data):
        """Complex tenant creation spanning multiple domains"""
        # Tenant creation (Tenant Management domain)
        tenant = Tenant.objects.create(
            name=tenant_data['name'],
            domain=tenant_data['domain'],
            subscription_plan=tenant_data['plan']
        )
        
        # Billing setup (Billing domain)
        billing_profile = self.setup_billing_profile(tenant, tenant_data['billing_info'])
        
        # Feature flag initialization (Feature Management domain)
        feature_flags = self.initialize_feature_flags(tenant_data['plan'])
        tenant.feature_flags = feature_flags
        tenant.save()
        
        # Admin user creation (User Management domain)
        admin_user = User.objects.create_user(
            username=admin_data['username'],
            email=admin_data['email'],
            password=admin_data['password'],
            tenant=tenant,
            is_billing_admin=True
        )
        
        # Workspace initialization (Project Management domain)
        default_project = Project.objects.create(
            tenant=tenant,
            name="Default Project",
            description="Initial project setup",
            owner=admin_user
        )
        
        # Analytics setup (Analytics domain)
        analytics_config = self.setup_analytics_tracking(tenant)
        
        # Notification setup (Notification domain)
        self.setup_default_notifications(tenant, admin_user)
        
        # Welcome email and onboarding (Communication domain)
        self.send_onboarding_email(admin_user, tenant)
        
        return tenant, admin_user
    
    def process_user_activity(self, user_id, activity_data):
        """Complex user activity processing across domains"""
        user = User.objects.get(id=user_id)
        
        # Activity tracking (Analytics domain)
        self.track_user_activity(user, activity_data)
        
        # Feature usage tracking (Feature Management domain)
        self.update_feature_usage(user, activity_data['features_used'])
        
        # Billing usage tracking (Billing domain)
        if activity_data['billable_actions']:
            self.track_billable_usage(user.tenant, activity_data['billable_actions'])
        
        # Real-time notifications (Notification domain)
        if activity_data['notification_triggers']:
            self.send_realtime_notifications(user, activity_data['notification_triggers'])
        
        # Collaboration updates (Collaboration domain)
        if activity_data['project_updates']:
            self.update_project_collaboration(user, activity_data['project_updates'])
        
        # Performance monitoring (Monitoring domain)
        self.update_performance_metrics(user.tenant, activity_data['performance_data'])
        
        return activity_data
    
    def generate_tenant_analytics_report(self, tenant_id, date_range):
        """Complex analytics aggregation across multiple domains"""
        tenant = Tenant.objects.get(id=tenant_id)
        
        # User analytics (User Management domain)
        user_metrics = self.calculate_user_engagement_metrics(tenant, date_range)
        
        # Project analytics (Project Management domain)
        project_metrics = self.calculate_project_performance_metrics(tenant, date_range)
        
        # Billing analytics (Billing domain)
        billing_metrics = self.calculate_billing_analytics(tenant, date_range)
        
        # Feature usage analytics (Feature Management domain)
        feature_metrics = self.calculate_feature_usage_analytics(tenant, date_range)
        
        # System performance analytics (Infrastructure domain)
        performance_metrics = self.calculate_system_performance_metrics(tenant, date_range)
        
        # Collaboration analytics (Collaboration domain)
        collaboration_metrics = self.calculate_collaboration_metrics(tenant, date_range)
        
        # Aggregate report generation (Reporting domain)
        report = {
            'tenant': tenant.name,
            'date_range': date_range,
            'user_metrics': user_metrics,
            'project_metrics': project_metrics,
            'billing_metrics': billing_metrics,
            'feature_metrics': feature_metrics,
            'performance_metrics': performance_metrics,
            'collaboration_metrics': collaboration_metrics,
            'recommendations': self.generate_optimization_recommendations(
                user_metrics, project_metrics, billing_metrics
            )
        }
        
        # Report caching (Caching domain)
        self.cache_analytics_report(tenant_id, date_range, report)
        
        return report
    
    def handle_subscription_change(self, tenant_id, new_plan_data):
        """Complex subscription management across domains"""
        tenant = Tenant.objects.get(id=tenant_id)
        
        # Billing plan change (Billing domain)
        billing_change = self.process_plan_change(tenant, new_plan_data)
        
        # Feature flag updates (Feature Management domain)
        new_features = self.update_feature_flags_for_plan(tenant, new_plan_data['plan'])
        
        # Usage limit adjustments (Usage Management domain)
        usage_limits = self.update_usage_limits(tenant, new_plan_data['plan'])
        
        # User permission updates (User Management domain)
        self.update_user_permissions_for_plan(tenant, new_plan_data['plan'])
        
        # Project quota adjustments (Project Management domain)
        self.adjust_project_quotas(tenant, new_plan_data['plan'])
        
        # Analytics tracking (Analytics domain)
        self.track_subscription_change(tenant, billing_change)
        
        # Notification to users (Notification domain)
        self.notify_plan_change(tenant, new_plan_data)
        
        return {
            'billing_change': billing_change,
            'new_features': new_features,
            'usage_limits': usage_limits
        }

# Django views handling multiple domains
from django.http import JsonResponse
from django.views.decorators.http import require_http_methods

@require_http_methods(["GET"])
def tenant_dashboard(request, tenant_id):
    """Monolithic dashboard aggregating data from all domains"""
    # User management data
    users = User.objects.filter(tenant_id=tenant_id)
    active_users = users.filter(last_activity__gte=timezone.now() - timedelta(days=30))
    
    # Project management data
    projects = Project.objects.filter(tenant_id=tenant_id)
    recent_projects = projects.filter(created_at__gte=timezone.now() - timedelta(days=7))
    
    # Billing data
    billing_info = get_billing_summary(tenant_id)
    usage_statistics = calculate_current_usage(tenant_id)
    
    # Analytics data
    analytics_summary = generate_analytics_summary(tenant_id)
    
    # Notification data
    recent_notifications = get_recent_notifications(tenant_id)
    
    return JsonResponse({
        'users': {
            'total': users.count(),
            'active': active_users.count(),
            'recent_activity': get_recent_user_activity(tenant_id)
        },
        'projects': {
            'total': projects.count(),
            'recent': recent_projects.count(),
            'performance': get_project_performance_summary(tenant_id)
        },
        'billing': billing_info,
        'usage': usage_statistics,
        'analytics': analytics_summary,
        'notifications': recent_notifications
    })
```

**Current Architecture Issues**:
- Single PostgreSQL database with tenant isolation causing performance bottlenecks
- Mixed domain concerns in Django models and service layer
- Monolithic deployment prevents independent scaling of analytics vs billing vs user management
- Shared database schema changes affect all tenants simultaneously
- Cross-domain transactions create tight coupling and complexity

**Decomposition Requirements**:
- Identify tenant-specific services: Tenant Management, User Management, Project Management, Billing, Analytics, Notifications, Feature Management
- Design multi-tenant data isolation strategies per service
- Implement event sourcing for audit trails and data consistency
- Create tenant-aware API gateway with routing and isolation
- Establish independent scaling for compute-intensive services (analytics, billing)

**Expected Deliverables**:
- Multi-tenant microservice architecture with tenant isolation strategies
- Event sourcing implementation for cross-service data consistency
- API gateway with tenant-aware routing and security
- Service-specific databases with appropriate multi-tenancy patterns
- Kubernetes-based auto-scaling infrastructure per service

Generate the optimized microservices implementation with:
1. Multi-tenant service designs with appropriate isolation patterns
2. Event sourcing and CQRS for data consistency across services
3. Tenant-aware API gateway with intelligent routing
4. Service-specific database designs optimized for multi-tenancy
5. Infrastructure automation with tenant-aware scaling and resource allocation
```

## Advanced Decomposition Strategies

### Domain-Driven Design Application

```
**Systematic Domain Identification Framework**:

Comprehensive approaches to identify service boundaries using domain-driven design:

**Bounded Context Analysis**:
```python
# Domain-driven design analysis framework
class DomainAnalyzer:
    def __init__(self, monolith_codebase):
        self.codebase = monolith_codebase
        self.domains = {}
        self.shared_concepts = {}
        self.service_boundaries = {}
    
    def identify_bounded_contexts(self):
        """Systematic identification of domain boundaries"""
        
        # Step 1: Business capability analysis
        business_capabilities = self.extract_business_capabilities()
        
        # Step 2: Data model analysis
        entity_relationships = self.analyze_entity_relationships()
        
        # Step 3: Team organizational structure analysis
        team_boundaries = self.analyze_team_boundaries()
        
        # Step 4: Change frequency analysis
        change_patterns = self.analyze_change_patterns()
        
        # Step 5: Performance and scaling requirements
        scaling_requirements = self.analyze_scaling_requirements()
        
        # Combine analysis results
        bounded_contexts = self.synthesize_boundaries(
            business_capabilities,
            entity_relationships,
            team_boundaries,
            change_patterns,
            scaling_requirements
        )
        
        return bounded_contexts
    
    def extract_business_capabilities(self):
        """Extract business capabilities from codebase"""
        capabilities = {}
        
        # Analyze service layer methods
        for service_class in self.codebase.get_service_classes():
            for method in service_class.get_methods():
                capability = self.extract_business_capability(method)
                if capability:
                    capabilities[capability.name] = capability
        
        # Analyze API endpoints
        for endpoint in self.codebase.get_api_endpoints():
            capability = self.extract_capability_from_endpoint(endpoint)
            if capability:
                capabilities[capability.name] = capability
        
        return capabilities
    
    def analyze_entity_relationships(self):
        """Analyze data model relationships for natural boundaries"""
        relationships = {}
        
        entities = self.codebase.get_entity_classes()
        
        for entity in entities:
            entity_info = {
                'name': entity.name,
                'attributes': entity.get_attributes(),
                'relationships': entity.get_relationships(),
                'lifecycle': self.analyze_entity_lifecycle(entity),
                'access_patterns': self.analyze_access_patterns(entity)
            }
            relationships[entity.name] = entity_info
        
        # Identify aggregates and aggregate roots
        aggregates = self.identify_aggregates(relationships)
        
        return {
            'entities': relationships,
            'aggregates': aggregates,
            'cohesion_metrics': self.calculate_cohesion_metrics(relationships)
        }
    
    def analyze_team_boundaries(self):
        """Analyze organizational structure for Conway's Law application"""
        return {
            'current_teams': self.get_current_team_structure(),
            'code_ownership': self.analyze_code_ownership(),
            'change_coordination': self.analyze_change_coordination_patterns(),
            'communication_patterns': self.analyze_team_communication()
        }
    
    def synthesize_boundaries(self, capabilities, entities, teams, changes, scaling):
        """Synthesize analysis results into service boundaries"""
        
        boundary_candidates = []
        
        # Business capability grouping
        for capability_group in self.group_related_capabilities(capabilities):
            boundary_candidates.append({
                'type': 'business_capability',
                'entities': capability_group.entities,
                'capabilities': capability_group.capabilities,
                'score': capability_group.cohesion_score
            })
        
        # Data model grouping
        for aggregate in entities['aggregates']:
            boundary_candidates.append({
                'type': 'data_aggregate',
                'entities': aggregate.entities,
                'root_entity': aggregate.root,
                'score': aggregate.cohesion_score
            })
        
        # Team ownership grouping
        for team_domain in teams['code_ownership']:
            boundary_candidates.append({
                'type': 'team_ownership',
                'entities': team_domain.entities,
                'team': team_domain.team,
                'score': team_domain.ownership_strength
            })
        
        # Select optimal boundaries
        optimal_boundaries = self.select_optimal_boundaries(boundary_candidates)
        
        return optimal_boundaries

# Service boundary definition framework
class ServiceBoundaryDefinition:
    def __init__(self, domain_name, entities, capabilities):
        self.domain_name = domain_name
        self.entities = entities
        self.capabilities = capabilities
        self.api_contracts = {}
        self.data_contracts = {}
        self.event_contracts = {}
    
    def define_service_api(self):
        """Define external API for the service"""
        api_operations = []
        
        for capability in self.capabilities:
            operation = {
                'name': capability.name,
                'method': capability.http_method,
                'path': capability.api_path,
                'input_schema': capability.input_schema,
                'output_schema': capability.output_schema,
                'business_rules': capability.business_rules
            }
            api_operations.append(operation)
        
        self.api_contracts = {
            'service_name': self.domain_name,
            'version': '1.0.0',
            'operations': api_operations,
            'data_types': self.extract_data_types(),
            'error_types': self.extract_error_types()
        }
        
        return self.api_contracts
    
    def define_domain_events(self):
        """Define domain events published by the service"""
        events = []
        
        for entity in self.entities:
            entity_events = self.extract_entity_events(entity)
            events.extend(entity_events)
        
        for capability in self.capabilities:
            capability_events = self.extract_capability_events(capability)
            events.extend(capability_events)
        
        self.event_contracts = {
            'service_name': self.domain_name,
            'events': events,
            'event_schema_version': '1.0.0'
        }
        
        return self.event_contracts
    
    def define_data_model(self):
        """Define internal data model for the service"""
        service_entities = []
        
        for entity in self.entities:
            service_entity = {
                'name': entity.name,
                'attributes': entity.attributes,
                'business_rules': entity.business_rules,
                'invariants': entity.invariants,
                'lifecycle': entity.lifecycle
            }
            service_entities.append(service_entity)
        
        self.data_contracts = {
            'service_name': self.domain_name,
            'entities': service_entities,
            'value_objects': self.extract_value_objects(),
            'aggregates': self.define_aggregates()
        }
        
        return self.data_contracts
```

**Service Dependency Analysis**:
```java
// Java service dependency analysis framework
public class ServiceDependencyAnalyzer {
    
    public class ServiceDependencyMap {
        private Map<String, Set<String>> directDependencies = new HashMap<>();
        private Map<String, Set<String>> dataDependencies = new HashMap<>();
        private Map<String, Set<String>> eventDependencies = new HashMap<>();
        
        public DependencyAnalysisResult analyze() {
            // Identify circular dependencies
            Set<List<String>> circularDependencies = findCircularDependencies();
            
            // Calculate coupling metrics
            Map<String, Double> couplingMetrics = calculateCouplingMetrics();
            
            // Identify shared data concerns
            Map<String, Set<String>> sharedDataConcerns = identifySharedDataConcerns();
            
            // Generate dependency optimization recommendations
            List<DependencyOptimization> optimizations = generateOptimizations();
            
            return new DependencyAnalysisResult(
                circularDependencies,
                couplingMetrics,
                sharedDataConcerns,
                optimizations
            );
        }
        
        private Set<List<String>> findCircularDependencies() {
            Set<List<String>> cycles = new HashSet<>();
            Set<String> visited = new HashSet<>();
            Set<String> recursionStack = new HashSet<>();
            
            for (String service : directDependencies.keySet()) {
                if (!visited.contains(service)) {
                    findCycles(service, visited, recursionStack, new ArrayList<>(), cycles);
                }
            }
            
            return cycles;
        }
        
        private void findCycles(String service, Set<String> visited, Set<String> recursionStack,
                              List<String> currentPath, Set<List<String>> cycles) {
            visited.add(service);
            recursionStack.add(service);
            currentPath.add(service);
            
            Set<String> dependencies = directDependencies.getOrDefault(service, new HashSet<>());
            
            for (String dependency : dependencies) {
                if (!visited.contains(dependency)) {
                    findCycles(dependency, visited, recursionStack, currentPath, cycles);
                } else if (recursionStack.contains(dependency)) {
                    // Found cycle
                    int cycleStart = currentPath.indexOf(dependency);
                    List<String> cycle = new ArrayList<>(currentPath.subList(cycleStart, currentPath.size()));
                    cycles.add(cycle);
                }
            }
            
            recursionStack.remove(service);
            currentPath.remove(currentPath.size() - 1);
        }
        
        private Map<String, Double> calculateCouplingMetrics() {
            Map<String, Double> metrics = new HashMap<>();
            
            for (String service : directDependencies.keySet()) {
                double afferentCoupling = calculateAfferentCoupling(service);
                double efferentCoupling = calculateEfferentCoupling(service);
                double instability = efferentCoupling / (afferentCoupling + efferentCoupling);
                
                metrics.put(service + "_instability", instability);
                metrics.put(service + "_afferent", afferentCoupling);
                metrics.put(service + "_efferent", efferentCoupling);
            }
            
            return metrics;
        }
        
        private List<DependencyOptimization> generateOptimizations() {
            List<DependencyOptimization> optimizations = new ArrayList<>();
            
            // Identify services with high coupling
            for (Map.Entry<String, Set<String>> entry : directDependencies.entrySet()) {
                if (entry.getValue().size() > 5) {  // Threshold for high coupling
                    optimizations.add(new DependencyOptimization(
                        OptimizationType.REDUCE_COUPLING,
                        entry.getKey(),
                        "Service has " + entry.getValue().size() + " dependencies. Consider facade pattern or service aggregation."
                    ));
                }
            }
            
            // Identify shared data concerns
            Map<String, Set<String>> sharedEntities = identifySharedEntities();
            for (Map.Entry<String, Set<String>> entry : sharedEntities.entrySet()) {
                if (entry.getValue().size() > 2) {
                    optimizations.add(new DependencyOptimization(
                        OptimizationType.EXTRACT_SHARED_SERVICE,
                        entry.getKey(),
                        "Entity " + entry.getKey() + " is used by " + entry.getValue().size() + " services. Consider extracting to dedicated service."
                    ));
                }
            }
            
            return optimizations;
        }
    }
    
    public class MigrationPathPlanner {
        
        public MigrationPlan generateMigrationPlan(List<ServiceBoundaryDefinition> targetServices) {
            // Order services by dependency relationships
            List<String> migrationOrder = calculateMigrationOrder(targetServices);
            
            // Generate phase-by-phase migration plan
            List<MigrationPhase> phases = planMigrationPhases(migrationOrder, targetServices);
            
            // Identify migration risks and mitigation strategies
            List<MigrationRisk> risks = identifyMigrationRisks(phases);
            
            // Generate rollback strategies
            Map<String, RollbackStrategy> rollbackStrategies = generateRollbackStrategies(phases);
            
            return new MigrationPlan(phases, risks, rollbackStrategies);
        }
        
        private List<String> calculateMigrationOrder(List<ServiceBoundaryDefinition> services) {
            // Build dependency graph
            Map<String, Set<String>> dependencies = buildDependencyGraph(services);
            
            // Topological sort to determine migration order
            return topologicalSort(dependencies);
        }
        
        private List<MigrationPhase> planMigrationPhases(List<String> migrationOrder, 
                                                        List<ServiceBoundaryDefinition> services) {
            List<MigrationPhase> phases = new ArrayList<>();
            
            // Group services into phases based on dependencies and complexity
            int currentPhase = 1;
            Set<String> migratedServices = new HashSet<>();
            
            while (migratedServices.size() < services.size()) {
                List<String> currentPhaseServices = new ArrayList<>();
                
                for (String service : migrationOrder) {
                    if (!migratedServices.contains(service)) {
                        if (canMigrateInCurrentPhase(service, migratedServices, services)) {
                            currentPhaseServices.add(service);
                        }
                    }
                }
                
                if (!currentPhaseServices.isEmpty()) {
                    MigrationPhase phase = new MigrationPhase(
                        currentPhase++,
                        currentPhaseServices,
                        estimatePhaseDuration(currentPhaseServices),
                        generatePhaseValidationCriteria(currentPhaseServices)
                    );
                    phases.add(phase);
                    migratedServices.addAll(currentPhaseServices);
                } else {
                    break; // Prevent infinite loop
                }
            }
            
            return phases;
        }
        
        private boolean canMigrateInCurrentPhase(String service, Set<String> migratedServices,
                                               List<ServiceBoundaryDefinition> allServices) {
            // Check if all dependencies are already migrated or can be mocked
            ServiceBoundaryDefinition serviceDef = findServiceDefinition(service, allServices);
            
            for (String dependency : serviceDef.getDependencies()) {
                if (!migratedServices.contains(dependency) && !canBeMocked(dependency)) {
                    return false;
                }
            }
            
            return true;
        }
    }
}
```
```

### Gradual Migration Patterns

```
**Strangler Fig Pattern Implementation**:

Systematic approach to gradually replace monolithic functionality:

**API Gateway Migration Strategy**:
```javascript
// Node.js API Gateway for gradual migration
const express = require('express');
const httpProxy = require('http-proxy-middleware');
const app = express();

class StranglerFigGateway {
    constructor() {
        this.migrationConfig = {
            routes: new Map(),
            featureFlags: new Map(),
            canaryConfig: new Map()
        };
        
        this.monolithUrl = process.env.MONOLITH_URL || 'http://localhost:8080';
        this.microservices = new Map();
        
        this.initializeRouting();
    }
    
    // Configure progressive migration routing
    configureMigrationRoute(path, microserviceUrl, migrationStrategy = 'immediate') {
        const routeConfig = {
            path,
            microserviceUrl,
            strategy: migrationStrategy,
            monolithFallback: true,
            healthCheck: `${microserviceUrl}/health`,
            migrationPercentage: 0
        };
        
        this.migrationConfig.routes.set(path, routeConfig);
        
        // Set up health monitoring for the microservice
        this.monitorMicroserviceHealth(path, microserviceUrl);
    }
    
    // Gradual traffic migration with canary deployment
    async migrateTrafficGradually(path, initialPercentage = 10) {
        const routeConfig = this.migrationConfig.routes.get(path);
        if (!routeConfig) {
            throw new Error(`Route ${path} not configured for migration`);
        }
        
        // Start with small percentage
        routeConfig.migrationPercentage = initialPercentage;
        
        // Monitor success metrics
        const migrationMonitor = setInterval(async () => {
            const metrics = await this.getMigrationMetrics(path);
            
            if (metrics.successRate > 0.95 && metrics.errorRate < 0.01) {
                // Increase traffic gradually
                routeConfig.migrationPercentage = Math.min(
                    routeConfig.migrationPercentage + 10, 
                    100
                );
                
                console.log(`Increased migration percentage for ${path} to ${routeConfig.migrationPercentage}%`);
                
                if (routeConfig.migrationPercentage >= 100) {
                    console.log(`Migration completed for ${path}`);
                    clearInterval(migrationMonitor);
                }
            } else if (metrics.errorRate > 0.05) {
                // Rollback on high error rate
                console.warn(`High error rate detected for ${path}, rolling back`);
                routeConfig.migrationPercentage = 0;
                clearInterval(migrationMonitor);
            }
        }, 30000); // Check every 30 seconds
    }
    
    // Smart routing middleware
    createRoutingMiddleware() {
        return async (req, res, next) => {
            const routeConfig = this.findMatchingRoute(req.path);
            
            if (!routeConfig) {
                // No migration configured, route to monolith
                return this.proxyToMonolith(req, res, next);
            }
            
            // Determine routing destination
            const destination = await this.determineRoutingDestination(req, routeConfig);
            
            if (destination === 'microservice') {
                return this.proxyToMicroservice(req, res, next, routeConfig);
            } else {
                return this.proxyToMonolith(req, res, next);
            }
        };
    }
    
    async determineRoutingDestination(req, routeConfig) {
        // Check microservice health
        if (!await this.isMicroserviceHealthy(routeConfig.microserviceUrl)) {
            return 'monolith';
        }
        
        // Apply migration percentage
        const random = Math.random() * 100;
        if (random < routeConfig.migrationPercentage) {
            return 'microservice';
        }
        
        // Check feature flags
        const userId = this.extractUserId(req);
        if (userId && this.isUserInCanaryGroup(userId, routeConfig.path)) {
            return 'microservice';
        }
        
        return 'monolith';
    }
    
    proxyToMicroservice(req, res, next, routeConfig) {
        const proxy = httpProxy({
            target: routeConfig.microserviceUrl,
            changeOrigin: true,
            onError: (err, req, res) => {
                console.error(`Microservice error for ${req.path}:`, err);
                // Fallback to monolith on error
                this.proxyToMonolith(req, res, next);
            },
            onProxyRes: (proxyRes, req, res) => {
                // Track metrics
                this.trackMigrationMetrics(req.path, 'microservice', proxyRes.statusCode);
            }
        });
        
        proxy(req, res, next);
    }
    
    proxyToMonolith(req, res, next) {
        const proxy = httpProxy({
            target: this.monolithUrl,
            changeOrigin: true,
            onProxyRes: (proxyRes, req, res) => {
                // Track metrics
                this.trackMigrationMetrics(req.path, 'monolith', proxyRes.statusCode);
            }
        });
        
        proxy(req, res, next);
    }
    
    // Migration metrics and monitoring
    trackMigrationMetrics(path, destination, statusCode) {
        const metrics = this.migrationConfig.metrics || new Map();
        const key = `${path}:${destination}`;
        
        if (!metrics.has(key)) {
            metrics.set(key, {
                totalRequests: 0,
                successfulRequests: 0,
                errorRequests: 0,
                lastUpdated: new Date()
            });
        }
        
        const pathMetrics = metrics.get(key);
        pathMetrics.totalRequests++;
        
        if (statusCode >= 200 && statusCode < 400) {
            pathMetrics.successfulRequests++;
        } else {
            pathMetrics.errorRequests++;
        }
        
        pathMetrics.lastUpdated = new Date();
        this.migrationConfig.metrics = metrics;
    }
    
    async getMigrationMetrics(path) {
        const metrics = this.migrationConfig.metrics || new Map();
        const microserviceKey = `${path}:microservice`;
        const monolithKey = `${path}:monolith`;
        
        const microserviceMetrics = metrics.get(microserviceKey) || { totalRequests: 0, successfulRequests: 0, errorRequests: 0 };
        const monolithMetrics = metrics.get(monolithKey) || { totalRequests: 0, successfulRequests: 0, errorRequests: 0 };
        
        return {
            microservice: {
                successRate: microserviceMetrics.totalRequests > 0 ? 
                    microserviceMetrics.successfulRequests / microserviceMetrics.totalRequests : 0,
                errorRate: microserviceMetrics.totalRequests > 0 ? 
                    microserviceMetrics.errorRequests / microserviceMetrics.totalRequests : 0,
                totalRequests: microserviceMetrics.totalRequests
            },
            monolith: {
                successRate: monolithMetrics.totalRequests > 0 ? 
                    monolithMetrics.successfulRequests / monolithMetrics.totalRequests : 0,
                errorRate: monolithMetrics.totalRequests > 0 ? 
                    monolithMetrics.errorRequests / monolithMetrics.totalRequests : 0,
                totalRequests: monolithMetrics.totalRequests
            }
        };
    }
}

// Usage example
const gateway = new StranglerFigGateway();

// Configure gradual migration for user service
gateway.configureMigrationRoute('/api/users/*', 'http://user-service:3001');
gateway.configureMigrationRoute('/api/products/*', 'http://product-service:3002');

// Start gradual migration
gateway.migrateTrafficGradually('/api/users/*', 5); // Start with 5% traffic

app.use(gateway.createRoutingMiddleware());

app.listen(3000, () => {
    console.log('Strangler Fig Gateway running on port 3000');
});
```

**Database Decomposition Strategy**:
```sql
-- Database decomposition using event sourcing and CQRS
-- Step 1: Create event store for data synchronization

CREATE TABLE event_store (
    id SERIAL PRIMARY KEY,
    aggregate_id VARCHAR(255) NOT NULL,
    aggregate_type VARCHAR(255) NOT NULL,
    event_type VARCHAR(255) NOT NULL,
    event_data JSONB NOT NULL,
    metadata JSONB,
    version INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(aggregate_id, version)
);

CREATE INDEX idx_event_store_aggregate ON event_store(aggregate_id, aggregate_type);
CREATE INDEX idx_event_store_type ON event_store(event_type);
CREATE INDEX idx_event_store_created ON event_store(created_at);

-- Step 2: Create service-specific databases
-- User Service Database
CREATE DATABASE user_service;
\c user_service;

CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    profile JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_preferences (
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    preference_key VARCHAR(100) NOT NULL,
    preference_value JSONB,
    PRIMARY KEY (user_id, preference_key)
);

-- Product Service Database
CREATE DATABASE product_service;
\c product_service;

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    category VARCHAR(100),
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE product_variants (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID REFERENCES products(id) ON DELETE CASCADE,
    variant_name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    attributes JSONB
);

-- Order Service Database
CREATE DATABASE order_service;
\c order_service;

CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    customer_id UUID NOT NULL, -- Reference to user service
    status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL, -- Reference to product service
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    product_snapshot JSONB -- Store product data at time of order
);

-- Step 3: Data migration procedures
-- Create migration tracking table
CREATE TABLE migration_progress (
    table_name VARCHAR(255) PRIMARY KEY,
    last_migrated_id BIGINT,
    total_records BIGINT,
    migrated_records BIGINT,
    migration_status VARCHAR(50),
    started_at TIMESTAMP,
    completed_at TIMESTAMP
);

-- Step 4: Event-driven synchronization procedures
CREATE OR REPLACE FUNCTION publish_user_event()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO event_store (
        aggregate_id,
        aggregate_type,
        event_type,
        event_data,
        version
    ) VALUES (
        NEW.id::text,
        'User',
        CASE
            WHEN TG_OP = 'INSERT' THEN 'UserCreated'
            WHEN TG_OP = 'UPDATE' THEN 'UserUpdated'
            WHEN TG_OP = 'DELETE' THEN 'UserDeleted'
        END,
        CASE
            WHEN TG_OP = 'DELETE' THEN to_jsonb(OLD)
            ELSE to_jsonb(NEW)
        END,
        1 -- Version management to be implemented
    );
    
    RETURN COALESCE(NEW, OLD);
END;
$$ LANGUAGE plpgsql;

-- Apply triggers for event publishing
CREATE TRIGGER user_event_trigger
    AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW EXECUTE FUNCTION publish_user_event();
```

**Migration Validation Framework**:
```python
# Python migration validation and testing framework
import asyncio
import aiohttp
import asyncpg
from typing import Dict, List, Any
from dataclasses import dataclass
from datetime import datetime

@dataclass
class MigrationValidationResult:
    test_name: str
    success: bool
    response_time_ms: float
    error_message: str = None
    data_consistency: bool = True
    
class MigrationValidator:
    def __init__(self, monolith_url: str, microservice_urls: Dict[str, str]):
        self.monolith_url = monolith_url
        self.microservice_urls = microservice_urls
        self.test_results = []
    
    async def validate_functional_equivalence(self, test_cases: List[Dict]) -> List[MigrationValidationResult]:
        """Validate that microservices provide functionally equivalent responses"""
        results = []
        
        async with aiohttp.ClientSession() as session:
            for test_case in test_cases:
                result = await self.run_equivalence_test(session, test_case)
                results.append(result)
        
        return results
    
    async def run_equivalence_test(self, session: aiohttp.ClientSession, test_case: Dict) -> MigrationValidationResult:
        """Run a single functional equivalence test"""
        try:
            # Get response from monolith
            monolith_start = datetime.now()
            monolith_response = await self.call_api(session, self.monolith_url, test_case)
            monolith_time = (datetime.now() - monolith_start).total_seconds() * 1000
            
            # Get response from microservice
            service_name = test_case['service']
            microservice_url = self.microservice_urls[service_name]
            
            microservice_start = datetime.now()
            microservice_response = await self.call_api(session, microservice_url, test_case)
            microservice_time = (datetime.now() - microservice_start).total_seconds() * 1000
            
            # Compare responses
            equivalence_result = self.compare_responses(
                monolith_response, 
                microservice_response, 
                test_case.get('comparison_rules', {})
            )
            
            return MigrationValidationResult(
                test_name=test_case['name'],
                success=equivalence_result['equivalent'],
                response_time_ms=microservice_time,
                error_message=equivalence_result.get('differences'),
                data_consistency=equivalence_result['data_consistent']
            )
            
        except Exception as e:
            return MigrationValidationResult(
                test_name=test_case['name'],
                success=False,
                response_time_ms=0,
                error_message=str(e),
                data_consistency=False
            )
    
    async def call_api(self, session: aiohttp.ClientSession, base_url: str, test_case: Dict) -> Dict:
        """Make API call and return response"""
        url = f"{base_url}{test_case['endpoint']}"
        method = test_case.get('method', 'GET')
        headers = test_case.get('headers', {})
        data = test_case.get('data')
        
        async with session.request(method, url, headers=headers, json=data) as response:
            return {
                'status_code': response.status,
                'headers': dict(response.headers),
                'body': await response.json() if response.content_type == 'application/json' else await response.text()
            }
    
    def compare_responses(self, monolith_response: Dict, microservice_response: Dict, rules: Dict) -> Dict:
        """Compare two API responses for functional equivalence"""
        differences = []
        
        # Compare status codes
        if monolith_response['status_code'] != microservice_response['status_code']:
            differences.append(f"Status code mismatch: {monolith_response['status_code']} vs {microservice_response['status_code']}")
        
        # Compare response bodies
        if isinstance(monolith_response['body'], dict) and isinstance(microservice_response['body'], dict):
            body_differences = self.compare_json_objects(
                monolith_response['body'], 
                microservice_response['body'], 
                rules.get('ignore_fields', [])
            )
            differences.extend(body_differences)
        
        return {
            'equivalent': len(differences) == 0,
            'differences': differences,
            'data_consistent': self.validate_data_consistency(monolith_response, microservice_response, rules)
        }
    
    def compare_json_objects(self, obj1: Dict, obj2: Dict, ignore_fields: List[str]) -> List[str]:
        """Compare two JSON objects and return differences"""
        differences = []
        
        # Filter out ignored fields
        filtered_obj1 = {k: v for k, v in obj1.items() if k not in ignore_fields}
        filtered_obj2 = {k: v for k, v in obj2.items() if k not in ignore_fields}
        
        # Check for missing/extra keys
        keys1 = set(filtered_obj1.keys())
        keys2 = set(filtered_obj2.keys())
        
        missing_keys = keys1 - keys2
        extra_keys = keys2 - keys1
        
        if missing_keys:
            differences.append(f"Missing keys in microservice response: {missing_keys}")
        if extra_keys:
            differences.append(f"Extra keys in microservice response: {extra_keys}")
        
        # Compare common keys
        common_keys = keys1 & keys2
        for key in common_keys:
            if filtered_obj1[key] != filtered_obj2[key]:
                differences.append(f"Value mismatch for key '{key}': {filtered_obj1[key]} vs {filtered_obj2[key]}")
        
        return differences
    
    async def validate_performance_requirements(self, performance_tests: List[Dict]) -> List[MigrationValidationResult]:
        """Validate that microservices meet performance requirements"""
        results = []
        
        for test in performance_tests:
            result = await self.run_performance_test(test)
            results.append(result)
        
        return results
    
    async def run_performance_test(self, test: Dict) -> MigrationValidationResult:
        """Run performance test against microservice"""
        service_name = test['service']
        microservice_url = self.microservice_urls[service_name]
        target_response_time = test['max_response_time_ms']
        
        try:
            async with aiohttp.ClientSession() as session:
                start_time = datetime.now()
                response = await self.call_api(session, microservice_url, test)
                end_time = datetime.now()
                
                response_time_ms = (end_time - start_time).total_seconds() * 1000
                meets_requirement = response_time_ms <= target_response_time
                
                return MigrationValidationResult(
                    test_name=f"Performance - {test['name']}",
                    success=meets_requirement and response['status_code'] < 400,
                    response_time_ms=response_time_ms,
                    error_message=None if meets_requirement else f"Response time {response_time_ms}ms exceeds requirement {target_response_time}ms"
                )
                
        except Exception as e:
            return MigrationValidationResult(
                test_name=f"Performance - {test['name']}",
                success=False,
                response_time_ms=0,
                error_message=str(e)
            )
    
    def generate_validation_report(self) -> str:
        """Generate comprehensive validation report"""
        total_tests = len(self.test_results)
        passed_tests = sum(1 for result in self.test_results if result.success)
        failed_tests = total_tests - passed_tests
        
        avg_response_time = sum(result.response_time_ms for result in self.test_results) / total_tests if total_tests > 0 else 0
        
        report = f"""
Migration Validation Report
==========================

Summary:
- Total Tests: {total_tests}
- Passed: {passed_tests}
- Failed: {failed_tests}
- Success Rate: {(passed_tests / total_tests * 100):.2f}%
- Average Response Time: {avg_response_time:.2f}ms

Failed Tests:
"""
        
        for result in self.test_results:
            if not result.success:
                report += f"- {result.test_name}: {result.error_message}\n"
        
        return report

# Usage example
async def main():
    validator = MigrationValidator(
        monolith_url="http://monolith:8080",
        microservice_urls={
            "user_service": "http://user-service:3001",
            "product_service": "http://product-service:3002",
            "order_service": "http://order-service:3003"
        }
    )
    
    # Define test cases
    test_cases = [
        {
            "name": "Get User Profile",
            "service": "user_service",
            "endpoint": "/api/users/123",
            "method": "GET",
            "comparison_rules": {
                "ignore_fields": ["last_updated", "created_at"]
            }
        },
        {
            "name": "Create Order",
            "service": "order_service",
            "endpoint": "/api/orders",
            "method": "POST",
            "data": {
                "user_id": "123",
                "items": [{"product_id": "456", "quantity": 2}]
            }
        }
    ]
    
    # Run validation tests
    results = await validator.validate_functional_equivalence(test_cases)
    validator.test_results.extend(results)
    
    # Generate report
    print(validator.generate_validation_report())

if __name__ == "__main__":
    asyncio.run(main())
```
```

This comprehensive monolith to microservices decomposition template provides systematic approaches to analyzing domain boundaries, planning gradual migration, and validating the transformation process while maintaining business continuity and minimizing risks throughout the decomposition journey.