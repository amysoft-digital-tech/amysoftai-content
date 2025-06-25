---
title: "Database Query Optimization Template"
description: "Systematic template for identifying and optimizing database performance bottlenecks through query analysis, indexing strategy, and execution plan optimization"
type: "template"
tier: "foundation"
estimated_reading_time: "28 minutes"
word_count: 11200
last_updated: "2025-06-25"
content_status: "complete"
template_category: "performance-optimization"
use_case: "database-optimization"
target_scenario: "query-performance-enhancement"
complexity_level: "intermediate"
risk_level: "moderate"
effectiveness_metrics: ["query_performance", "response_time_reduction", "resource_utilization"]
estimated_time_savings: "70-85%"
prerequisites: ["database_proficiency", "sql_knowledge", "performance_monitoring_tools"]
---

# Database Query Optimization Template

## Template Overview

This template provides a comprehensive approach to identifying, analyzing, and optimizing database performance bottlenecks through systematic query analysis, strategic indexing, and execution plan optimization. The process emphasizes data-driven decisions and measurable performance improvements while maintaining data integrity and system stability.

## Usage Context

Use this template when:
- Application response times degrade under normal or increased load
- Database CPU utilization consistently exceeds 70-80%
- Query execution times exceed acceptable thresholds
- Memory usage patterns indicate inefficient query operations
- User experience suffers due to database performance issues

## Template Structure

### Database Performance Analysis Context Setup

```
**Context**: Database query optimization for {PROJECT_NAME}

**Performance Analysis Scope**:
- Database system: {DATABASE_TYPE_VERSION}
- Application framework: {FRAMEWORK_AND_ORM}
- Current load characteristics: {CONCURRENT_USERS_TPS}
- Performance baseline: {CURRENT_RESPONSE_TIMES}
- Optimization targets: {TARGET_PERFORMANCE_METRICS}

**Current Performance Issues**:
- Slow query patterns: {IDENTIFIED_SLOW_QUERIES}
- Resource bottlenecks: {CPU_MEMORY_IO_CONSTRAINTS}
- Peak usage scenarios: {HIGH_LOAD_CHARACTERISTICS}
- User impact areas: {AFFECTED_FUNCTIONALITY}

**Optimization Objectives**:
- Response time targets: {TARGET_RESPONSE_TIMES}
- Throughput goals: {QUERIES_PER_SECOND_TARGETS}
- Resource efficiency: {CPU_MEMORY_OPTIMIZATION_GOALS}
- Scalability requirements: {FUTURE_LOAD_PROJECTIONS}
```

### Comprehensive Database Optimization Framework

```
**Primary Database Query Optimization Request**: Systematically identify and optimize database performance bottlenecks:

**Performance Analysis Scope**:
[PASTE_SLOW_QUERY_LOG_OR_PERFORMANCE_METRICS]

**Database Optimization Strategy**:

1. **Query Performance Analysis and Profiling**:
   - Identify slow-running queries through performance monitoring
   - Analyze query execution patterns and frequency
   - Examine resource consumption (CPU, memory, I/O) per query
   - Profile application-level database interaction patterns

2. **Execution Plan Analysis and Optimization**:
   - Generate and analyze execution plans for problematic queries
   - Identify table scan operations and missing index opportunities
   - Optimize join strategies and operation sequencing
   - Eliminate redundant operations and unnecessary data retrieval

3. **Strategic Indexing Design and Implementation**:
   - Design composite indexes for multi-column query patterns
   - Implement covering indexes for frequently accessed data combinations
   - Balance index benefits against maintenance overhead
   - Create specialized indexes (partial, functional, spatial) where appropriate

4. **Query Structure Optimization and Refactoring**:
   - Rewrite inefficient queries using optimal SQL patterns
   - Implement query result caching where beneficial
   - Optimize subqueries and common table expressions
   - Apply database-specific optimization techniques

5. **Data Architecture and Schema Optimization**:
   - Optimize table structures and data types for query performance
   - Implement partitioning strategies for large datasets
   - Design materialized views for complex analytical queries
   - Optimize foreign key relationships and constraints

**Generate the following deliverables**:
- Comprehensive query performance analysis with specific bottleneck identification
- Optimized queries with before/after performance comparisons
- Strategic indexing plan with implementation priorities
- Database schema optimization recommendations
- Performance monitoring and alerting setup instructions
```

## Implementation Examples

### JavaScript/Node.js with PostgreSQL E-commerce Optimization

```
**Context**: E-commerce platform database optimization with Node.js and PostgreSQL

**Database Optimization Request**: Optimize this e-commerce database performance:

**Current Performance Issues**:
```javascript
// Problematic query patterns in Node.js application
const { Pool } = require('pg');
const pool = new Pool();

// Issue 1: N+1 Query Problem in Product Listing
async function getProductsWithReviews(categoryId) {
    // Initial query to get products (efficient)
    const products = await pool.query(`
        SELECT id, name, price, description 
        FROM products 
        WHERE category_id = $1 
        ORDER BY created_at DESC 
        LIMIT 20
    `, [categoryId]);
    
    // N+1 Problem: Separate query for each product (inefficient)
    for (let product of products.rows) {
        const reviews = await pool.query(`
            SELECT rating, comment, created_at 
            FROM reviews 
            WHERE product_id = $1 
            ORDER BY created_at DESC 
            LIMIT 5
        `, [product.id]);
        
        product.reviews = reviews.rows;
    }
    
    return products.rows;
}

// Issue 2: Inefficient Search Query
async function searchProducts(searchTerm, filters) {
    // Problematic full-text search without proper indexing
    const query = `
        SELECT p.*, c.name as category_name,
               AVG(r.rating) as avg_rating,
               COUNT(r.id) as review_count
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.id
        LEFT JOIN reviews r ON p.id = r.product_id
        WHERE (p.name ILIKE '%' || $1 || '%' 
               OR p.description ILIKE '%' || $1 || '%')
        ${filters.category ? 'AND p.category_id = $2' : ''}
        ${filters.minPrice ? 'AND p.price >= $3' : ''}
        ${filters.maxPrice ? 'AND p.price <= $4' : ''}
        GROUP BY p.id, c.name
        ORDER BY avg_rating DESC
        LIMIT 50
    `;
    
    const params = [searchTerm];
    if (filters.category) params.push(filters.category);
    if (filters.minPrice) params.push(filters.minPrice);
    if (filters.maxPrice) params.push(filters.maxPrice);
    
    return await pool.query(query, params);
}

// Issue 3: Expensive Analytics Query
async function getDailySalesReport(startDate, endDate) {
    // Resource-intensive aggregation without optimization
    const query = `
        SELECT 
            DATE(o.created_at) as sale_date,
            COUNT(o.id) as order_count,
            SUM(oi.quantity * oi.price) as total_revenue,
            COUNT(DISTINCT o.user_id) as unique_customers,
            AVG(oi.quantity * oi.price) as avg_order_value
        FROM orders o
        JOIN order_items oi ON o.id = oi.order_id
        JOIN products p ON oi.product_id = p.id
        WHERE o.created_at >= $1 AND o.created_at <= $2
        AND o.status = 'completed'
        GROUP BY DATE(o.created_at)
        ORDER BY sale_date DESC
    `;
    
    return await pool.query(query, [startDate, endDate]);
}
```

**Performance Metrics**:
- Product listing with reviews: 3.2s average response time
- Product search: 5.8s average response time
- Daily sales report: 12.4s average response time
- Database CPU utilization: 85% during peak hours

**Optimization Requirements**:
- Eliminate N+1 query problems through optimized joins
- Implement proper full-text search indexing
- Create efficient aggregation strategies for analytics
- Design caching layer for frequently accessed data
- Target sub-second response times for all queries

**Expected Deliverables**:
- Optimized queries with JOIN-based data retrieval
- Strategic indexing plan for search and filtering
- Materialized views for analytics queries
- Caching implementation with Redis integration
- Performance benchmarks showing 80%+ improvement

Generate the optimized implementation with:
1. Efficient JOIN-based queries eliminating N+1 problems
2. Full-text search optimization with proper PostgreSQL indexes
3. Analytics query optimization with materialized views
4. Comprehensive caching strategy for performance enhancement
5. Monitoring and alerting setup for ongoing performance management
```

### Python Django with MySQL E-learning Platform Optimization

```
**Context**: E-learning platform database optimization with Django ORM and MySQL

**Database Optimization Request**: Optimize this educational platform's database performance:

**Current Performance Issues**:
```python
# Django models with performance problems
from django.db import models
from django.contrib.auth.models import User

class Course(models.Model):
    title = models.CharField(max_length=200)
    instructor = models.ForeignKey(User, on_delete=models.CASCADE)
    category = models.ForeignKey('Category', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    
class Enrollment(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    enrolled_at = models.DateTimeField(auto_now_add=True)
    progress = models.FloatField(default=0.0)

class Lesson(models.Model):
    course = models.ForeignKey(Course, on_delete=models.CASCADE)
    title = models.CharField(max_length=200)
    content = models.TextField()
    order = models.IntegerField()

# Problem 1: Inefficient course listing with instructor details
def get_popular_courses():
    # Causes multiple queries for instructor information
    courses = Course.objects.filter(
        enrollment__isnull=False
    ).annotate(
        enrollment_count=models.Count('enrollment')
    ).order_by('-enrollment_count')[:20]
    
    course_data = []
    for course in courses:
        # Additional query for each course (N+1 problem)
        instructor_profile = course.instructor.userprofile
        
        course_data.append({
            'id': course.id,
            'title': course.title,
            'instructor_name': course.instructor.get_full_name(),
            'instructor_bio': instructor_profile.bio,
            'enrollment_count': course.enrollment_count,
            'category': course.category.name  # Another N+1 query
        })
    
    return course_data

# Problem 2: Expensive student dashboard query
def get_student_dashboard(user_id):
    # Inefficient query for student progress
    enrollments = Enrollment.objects.filter(user_id=user_id)
    
    dashboard_data = []
    for enrollment in enrollments:
        # Multiple queries per enrollment
        course = enrollment.course
        lessons = course.lesson_set.all()
        completed_lessons = lessons.filter(
            lessoncompletion__user_id=user_id,
            lessoncompletion__completed=True
        ).count()
        
        # Expensive calculation per course
        progress_percentage = (completed_lessons / lessons.count()) * 100 if lessons.count() > 0 else 0
        
        dashboard_data.append({
            'course_title': course.title,
            'instructor': course.instructor.get_full_name(),
            'total_lessons': lessons.count(),
            'completed_lessons': completed_lessons,
            'progress_percentage': progress_percentage,
            'last_accessed': enrollment.last_accessed
        })
    
    return dashboard_data

# Problem 3: Complex analytics query without optimization
def get_course_analytics(course_id, date_range):
    # Resource-intensive analytics calculation
    enrollments = Enrollment.objects.filter(
        course_id=course_id,
        enrolled_at__range=date_range
    )
    
    analytics = {
        'total_enrollments': enrollments.count(),
        'completion_rate': 0,
        'average_progress': 0,
        'daily_activity': {},
        'lesson_completion_rates': {}
    }
    
    # Inefficient completion rate calculation
    completed_enrollments = 0
    total_progress = 0
    
    for enrollment in enrollments:
        # Multiple queries for each enrollment
        user_progress = enrollment.progress
        total_progress += user_progress
        
        if user_progress >= 100:
            completed_enrollments += 1
            
        # Daily activity calculation (very expensive)
        daily_activities = LessonCompletion.objects.filter(
            user=enrollment.user,
            lesson__course_id=course_id,
            completed_at__range=date_range
        ).values('completed_at__date').annotate(
            completions=models.Count('id')
        )
        
        for activity in daily_activities:
            date_str = activity['completed_at__date'].strftime('%Y-%m-%d')
            analytics['daily_activity'][date_str] = analytics['daily_activity'].get(date_str, 0) + activity['completions']
    
    analytics['completion_rate'] = (completed_enrollments / enrollments.count()) * 100 if enrollments.count() > 0 else 0
    analytics['average_progress'] = total_progress / enrollments.count() if enrollments.count() > 0 else 0
    
    return analytics
```

**Performance Metrics**:
- Popular courses listing: 4.1s average response time
- Student dashboard: 6.3s average response time
- Course analytics: 15.7s average response time
- Database connection pool exhaustion during peak hours

**Optimization Requirements**:
- Implement Django ORM select_related and prefetch_related optimization
- Create efficient aggregation queries using database-level calculations
- Design caching strategy for frequently accessed course data
- Optimize complex analytics through database views or background processing
- Target sub-2s response times for interactive features

**Expected Deliverables**:
- Optimized Django querysets with minimal database hits
- Strategic database indexing for MySQL performance
- Caching implementation with Django cache framework
- Background task processing for expensive analytics calculations
- Database connection pooling and optimization configuration

Generate the optimized implementation focusing on:
1. Django ORM optimization with select_related and prefetch_related
2. Database-level aggregation for complex calculations
3. Strategic caching with Django's cache framework
4. Background processing for analytics using Celery
5. MySQL-specific optimizations and indexing strategies
```

### Java Spring Boot with Oracle Enterprise Optimization

```
**Context**: Enterprise application database optimization with Spring Boot and Oracle

**Database Optimization Request**: Optimize this enterprise system's database performance:

**Current Performance Issues**:
```java
@Entity
@Table(name = "employees")
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "employee_id")
    private String employeeId;
    
    @ManyToOne(fetch = FetchType.EAGER)  // Performance issue: Always eagerly loaded
    @JoinColumn(name = "department_id")
    private Department department;
    
    @OneToMany(mappedBy = "employee", fetch = FetchType.EAGER)  // Another eager loading issue
    private List<PerformanceReview> performanceReviews;
    
    // Standard getters and setters
}

@Service
@Transactional
public class EmployeeService {
    
    @Autowired
    private EmployeeRepository employeeRepository;
    
    @Autowired
    private PerformanceReviewRepository performanceReviewRepository;
    
    // Problem 1: Inefficient employee search with department info
    public List<EmployeeDto> searchEmployees(String searchTerm, String departmentName) {
        // Causes N+1 queries due to eager loading in entity
        List<Employee> employees = employeeRepository.findByNameContainingIgnoreCase(searchTerm);
        
        List<EmployeeDto> employeeDtos = new ArrayList<>();
        for (Employee employee : employees) {
            if (departmentName == null || employee.getDepartment().getName().equals(departmentName)) {
                // Each access triggers additional queries
                EmployeeDto dto = new EmployeeDto();
                dto.setId(employee.getId());
                dto.setName(employee.getName());
                dto.setDepartmentName(employee.getDepartment().getName());
                dto.setManagerName(employee.getDepartment().getManager().getName());  // Additional query
                
                // Performance review access (eager loaded but inefficient)
                dto.setLastReviewScore(getLastReviewScore(employee.getPerformanceReviews()));
                dto.setReviewCount(employee.getPerformanceReviews().size());
                
                employeeDtos.add(dto);
            }
        }
        
        return employeeDtos;
    }
    
    // Problem 2: Expensive report generation
    public DepartmentReportDto generateDepartmentReport(Long departmentId, Date startDate, Date endDate) {
        // Multiple separate queries instead of optimized joins
        Department department = departmentRepository.findById(departmentId).orElse(null);
        List<Employee> employees = employeeRepository.findByDepartmentId(departmentId);
        
        DepartmentReportDto report = new DepartmentReportDto();
        report.setDepartmentName(department.getName());
        report.setEmployeeCount(employees.size());
        
        // Expensive calculations in application layer
        double totalSalary = 0;
        int totalReviews = 0;
        double avgPerformanceScore = 0;
        
        for (Employee employee : employees) {
            totalSalary += employee.getSalary();
            
            // Separate query for each employee's reviews in date range
            List<PerformanceReview> reviews = performanceReviewRepository
                .findByEmployeeIdAndReviewDateBetween(employee.getId(), startDate, endDate);
            
            totalReviews += reviews.size();
            
            for (PerformanceReview review : reviews) {
                avgPerformanceScore += review.getScore();
            }
        }
        
        report.setAverageSalary(totalSalary / employees.size());
        report.setTotalPerformanceReviews(totalReviews);
        report.setAveragePerformanceScore(totalReviews > 0 ? avgPerformanceScore / totalReviews : 0);
        
        // Additional expensive queries for trend analysis
        report.setMonthlyTrends(calculateMonthlyTrends(departmentId, startDate, endDate));
        
        return report;
    }
    
    // Problem 3: Inefficient bulk operations
    @Transactional
    public void updateEmployeeSalaries(List<SalaryUpdateDto> salaryUpdates) {
        // Individual updates instead of batch operations
        for (SalaryUpdateDto update : salaryUpdates) {
            Employee employee = employeeRepository.findById(update.getEmployeeId()).orElse(null);
            if (employee != null) {
                employee.setSalary(update.getNewSalary());
                employee.setLastSalaryUpdate(new Date());
                employeeRepository.save(employee);  // Individual save operations
                
                // Additional audit record for each update
                SalaryAudit audit = new SalaryAudit();
                audit.setEmployeeId(employee.getId());
                audit.setOldSalary(employee.getSalary());
                audit.setNewSalary(update.getNewSalary());
                audit.setUpdateDate(new Date());
                audit.setUpdatedBy(getCurrentUser());
                
                salaryAuditRepository.save(audit);  // Another individual operation
            }
        }
    }
    
    private List<MonthlyTrendDto> calculateMonthlyTrends(Long departmentId, Date startDate, Date endDate) {
        // Very expensive month-by-month calculation
        List<MonthlyTrendDto> trends = new ArrayList<>();
        
        Calendar cal = Calendar.getInstance();
        cal.setTime(startDate);
        
        while (cal.getTime().before(endDate)) {
            Date monthStart = cal.getTime();
            cal.add(Calendar.MONTH, 1);
            Date monthEnd = cal.getTime();
            
            // Separate queries for each month
            int newHires = employeeRepository.countByDepartmentIdAndHireDateBetween(departmentId, monthStart, monthEnd);
            int terminations = employeeRepository.countByDepartmentIdAndTerminationDateBetween(departmentId, monthStart, monthEnd);
            double avgPerformance = performanceReviewRepository.getAverageScoreByDepartmentAndDateRange(departmentId, monthStart, monthEnd);
            
            MonthlyTrendDto trend = new MonthlyTrendDto();
            trend.setMonth(monthStart);
            trend.setNewHires(newHires);
            trend.setTerminations(terminations);
            trend.setAveragePerformance(avgPerformance);
            
            trends.add(trend);
        }
        
        return trends;
    }
}
```

**Performance Metrics**:
- Employee search: 8.2s average response time
- Department report generation: 24.6s average response time
- Bulk salary updates: 45.3s for 1000 records
- Oracle connection pool maxed out during business hours

**Optimization Requirements**:
- Eliminate eager loading performance issues with strategic lazy loading
- Implement efficient bulk operations using Oracle-specific optimizations
- Create optimized reporting queries using Oracle analytical functions
- Design caching strategy for frequently accessed organizational data
- Target enterprise-grade performance standards (sub-3s for most operations)

**Expected Deliverables**:
- Optimized JPA entity configurations with lazy loading strategies
- Bulk operation implementations using Spring Data JPA batch processing
- Oracle-optimized queries with analytical functions for reporting
- Comprehensive caching strategy with Spring Cache and Redis
- Database connection pool tuning and monitoring configuration

Generate the optimized implementation with:
1. Strategic JPA entity optimization with lazy loading and fetch strategies
2. Oracle-specific bulk operations and analytical query optimization
3. Efficient reporting queries using database-level aggregations
4. Enterprise caching implementation with multiple cache levels
5. Comprehensive performance monitoring and database connection tuning
```

## Advanced Optimization Strategies

### Query Plan Analysis and Optimization

```
**Execution Plan Analysis Framework**:

Understanding and optimizing database execution plans for maximum performance:

**PostgreSQL Execution Plan Analysis**:
```sql
-- Enable detailed query analysis
EXPLAIN (ANALYZE, BUFFERS, VERBOSE) 
SELECT p.name, p.price, c.name as category_name, AVG(r.rating)
FROM products p
JOIN categories c ON p.category_id = c.id
LEFT JOIN reviews r ON p.id = r.product_id
WHERE p.price BETWEEN 100 AND 500
GROUP BY p.id, p.name, p.price, c.name
ORDER BY AVG(r.rating) DESC;

-- Analysis indicators:
-- 1. Seq Scan: Indicates missing indexes
-- 2. Nested Loop: May indicate inefficient join strategy
-- 3. Hash Join: Usually efficient for large datasets
-- 4. Sort: May indicate need for covering index
-- 5. Buffers: Shows actual I/O impact
```

**MySQL Execution Plan Insights**:
```sql
-- Detailed execution analysis
EXPLAIN FORMAT=JSON
SELECT p.product_name, 
       c.category_name,
       COUNT(o.id) as order_count,
       SUM(oi.quantity * oi.price) as total_revenue
FROM products p
JOIN categories c ON p.category_id = c.id
JOIN order_items oi ON p.id = oi.product_id  
JOIN orders o ON oi.order_id = o.id
WHERE o.order_date >= '2024-01-01'
GROUP BY p.id, p.product_name, c.category_name
ORDER BY total_revenue DESC;

-- Key metrics:
-- 1. rows_examined: Should be minimized
-- 2. filtered: Higher percentages indicate better selectivity
-- 3. Extra: "Using filesort" indicates need for index optimization
-- 4. key: Shows which indexes are being used
```

**Oracle Execution Plan Analysis**:
```sql
-- Enable detailed plan analysis
EXPLAIN PLAN FOR
SELECT /*+ GATHER_PLAN_STATISTICS */ 
       e.employee_name,
       d.department_name,
       COUNT(p.performance_id) as review_count,
       AVG(p.performance_score) as avg_score
FROM employees e
JOIN departments d ON e.department_id = d.department_id
LEFT JOIN performance_reviews p ON e.employee_id = p.employee_id
WHERE e.hire_date >= DATE '2020-01-01'
GROUP BY e.employee_id, e.employee_name, d.department_name
ORDER BY avg_score DESC;

-- Display execution statistics
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY_CURSOR(NULL, NULL, 'ALLSTATS LAST'));

-- Critical analysis points:
-- 1. Cardinality: Actual vs. estimated rows
-- 2. A-Rows: Actual rows processed
-- 3. Buffers: Logical reads (should be minimized)
-- 4. Cost: Relative cost indicator
```
```

### Strategic Indexing Design

```
**Comprehensive Indexing Strategy**:

Design optimal indexing strategies for different query patterns:

**Composite Index Design**:
```sql
-- PostgreSQL composite indexing for multi-column queries
CREATE INDEX CONCURRENTLY idx_products_category_price_rating 
ON products (category_id, price, created_at) 
INCLUDE (name, description);

-- MySQL covering index for query optimization
CREATE INDEX idx_orders_date_status_customer 
ON orders (order_date, status, customer_id) 
USING BTREE;

-- Oracle function-based index for computed columns
CREATE INDEX idx_employees_full_name 
ON employees (UPPER(first_name || ' ' || last_name));
```

**Partial Index Optimization**:
```sql
-- PostgreSQL partial indexes for filtered queries
CREATE INDEX CONCURRENTLY idx_orders_pending 
ON orders (customer_id, created_at) 
WHERE status = 'pending';

-- Partial index for active products only
CREATE INDEX CONCURRENTLY idx_products_active_category 
ON products (category_id, price) 
WHERE active = true AND deleted_at IS NULL;
```

**Specialized Index Types**:
```sql
-- PostgreSQL GIN index for full-text search
CREATE INDEX CONCURRENTLY idx_products_search 
ON products USING GIN (to_tsvector('english', name || ' ' || description));

-- PostgreSQL GiST index for geometric or hierarchical data
CREATE INDEX idx_locations_geography 
ON locations USING GIST (coordinates);

-- MySQL full-text index for search functionality
CREATE FULLTEXT INDEX idx_products_fulltext 
ON products (name, description);
```

**Index Maintenance Strategy**:
```sql
-- PostgreSQL index usage analysis
SELECT schemaname, tablename, indexname, idx_scan, idx_tup_read, idx_tup_fetch
FROM pg_stat_user_indexes 
WHERE idx_scan < 100  -- Identify unused indexes
ORDER BY idx_scan;

-- MySQL index cardinality analysis
SELECT TABLE_NAME, INDEX_NAME, CARDINALITY, SEQ_IN_INDEX
FROM INFORMATION_SCHEMA.STATISTICS 
WHERE TABLE_SCHEMA = 'your_database'
ORDER BY TABLE_NAME, INDEX_NAME, SEQ_IN_INDEX;

-- Oracle index monitoring
SELECT INDEX_NAME, MONITORING, USED
FROM USER_OBJECT_USAGE 
WHERE USED = 'NO'  -- Find unused indexes
ORDER BY INDEX_NAME;
```
```

### Query Optimization Patterns

```
**Efficient Query Rewriting Patterns**:

Transform inefficient queries into high-performance alternatives:

**Subquery to JOIN Conversion**:
```sql
-- Before: Inefficient correlated subquery
SELECT p.product_name, p.price
FROM products p
WHERE p.category_id IN (
    SELECT c.category_id 
    FROM categories c 
    WHERE c.active = true
);

-- After: Efficient JOIN with EXISTS
SELECT DISTINCT p.product_name, p.price
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE c.active = true;
```

**Window Function Optimization**:
```sql
-- Before: Multiple self-joins for ranking
SELECT p1.product_name, p1.price,
       (SELECT COUNT(*) FROM products p2 
        WHERE p2.category_id = p1.category_id 
        AND p2.price > p1.price) + 1 as price_rank
FROM products p1;

-- After: Efficient window function
SELECT product_name, price,
       RANK() OVER (PARTITION BY category_id ORDER BY price DESC) as price_rank
FROM products;
```

**Common Table Expression (CTE) Optimization**:
```sql
-- Optimized recursive CTE for hierarchical data
WITH RECURSIVE department_hierarchy AS (
    -- Base case: top-level departments
    SELECT department_id, department_name, parent_id, 0 as level
    FROM departments 
    WHERE parent_id IS NULL
    
    UNION ALL
    
    -- Recursive case: child departments
    SELECT d.department_id, d.department_name, d.parent_id, dh.level + 1
    FROM departments d
    JOIN department_hierarchy dh ON d.parent_id = dh.department_id
    WHERE dh.level < 10  -- Prevent infinite recursion
)
SELECT * FROM department_hierarchy
ORDER BY level, department_name;
```

**Batch Processing Optimization**:
```sql
-- PostgreSQL efficient bulk upsert
INSERT INTO product_inventory (product_id, quantity, last_updated)
VALUES (1, 100, NOW()), (2, 150, NOW()), (3, 200, NOW())
ON CONFLICT (product_id) 
DO UPDATE SET 
    quantity = EXCLUDED.quantity,
    last_updated = EXCLUDED.last_updated;

-- MySQL bulk update with CASE statement
UPDATE products 
SET price = CASE 
    WHEN id = 1 THEN 29.99
    WHEN id = 2 THEN 39.99
    WHEN id = 3 THEN 49.99
    ELSE price
END
WHERE id IN (1, 2, 3);

-- Oracle MERGE statement for efficient bulk operations
MERGE INTO employee_salaries es
USING (SELECT employee_id, new_salary FROM salary_updates) su
ON (es.employee_id = su.employee_id)
WHEN MATCHED THEN
    UPDATE SET salary = su.new_salary, last_updated = SYSDATE
WHEN NOT MATCHED THEN
    INSERT (employee_id, salary, last_updated)
    VALUES (su.employee_id, su.new_salary, SYSDATE);
```
```

## Performance Monitoring and Validation

### Database Performance Metrics

```
**Comprehensive Performance Monitoring Framework**:

Establish systematic monitoring for database optimization validation:

**PostgreSQL Performance Monitoring**:
```sql
-- Query performance analysis
SELECT query, calls, total_time, mean_time, rows
FROM pg_stat_statements 
WHERE calls > 1000
ORDER BY total_time DESC
LIMIT 10;

-- Index usage effectiveness
SELECT schemaname, tablename, indexname, 
       idx_scan as index_scans,
       pg_size_pretty(pg_relation_size(indexname::regclass)) as index_size
FROM pg_stat_user_indexes 
ORDER BY idx_scan DESC;

-- Database-wide performance metrics
SELECT 
    sum(heap_blks_read) as heap_read,
    sum(heap_blks_hit) as heap_hit,
    sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) as ratio
FROM pg_statio_user_tables;
```

**MySQL Performance Monitoring**:
```sql
-- Slow query analysis
SELECT schema_name, digest_text, count_star, avg_timer_wait
FROM performance_schema.events_statements_summary_by_digest 
WHERE schema_name = 'your_database'
ORDER BY avg_timer_wait DESC
LIMIT 10;

-- Buffer pool hit ratio
SELECT (1 - (Innodb_buffer_pool_reads / Innodb_buffer_pool_read_requests)) * 100 
as buffer_hit_ratio
FROM INFORMATION_SCHEMA.GLOBAL_STATUS 
WHERE VARIABLE_NAME IN ('Innodb_buffer_pool_reads', 'Innodb_buffer_pool_read_requests');

-- Connection and thread monitoring
SHOW PROCESSLIST;
SELECT * FROM INFORMATION_SCHEMA.PROCESSLIST 
WHERE COMMAND != 'Sleep' 
ORDER BY TIME DESC;
```

**Oracle Performance Monitoring**:
```sql
-- Top SQL by execution time
SELECT sql_id, child_number, executions, 
       elapsed_time/1000000 as elapsed_seconds,
       cpu_time/1000000 as cpu_seconds,
       sql_text
FROM v$sql 
WHERE executions > 100
ORDER BY elapsed_time DESC;

-- Wait event analysis
SELECT event, total_waits, total_timeouts, time_waited_micro
FROM v$system_event 
WHERE wait_class != 'Idle'
ORDER BY time_waited_micro DESC;

-- SGA and PGA memory utilization
SELECT component, current_size/1024/1024 as current_mb,
       max_size/1024/1024 as max_mb
FROM v$memory_dynamic_components 
WHERE current_size > 0;
```

**Application-Level Performance Tracking**:
```javascript
// Node.js performance monitoring
const performanceMetrics = {
    queryExecutionTimes: new Map(),
    connectionPoolStatus: {},
    
    startQueryTimer(queryId) {
        this.queryExecutionTimes.set(queryId, process.hrtime());
    },
    
    endQueryTimer(queryId) {
        const startTime = this.queryExecutionTimes.get(queryId);
        if (startTime) {
            const [seconds, nanoseconds] = process.hrtime(startTime);
            const executionTime = seconds * 1000 + nanoseconds / 1000000;
            
            // Log slow queries
            if (executionTime > 1000) {  // 1 second threshold
                console.warn(`Slow query detected: ${queryId}, execution time: ${executionTime}ms`);
            }
            
            this.queryExecutionTimes.delete(queryId);
            return executionTime;
        }
    },
    
    getConnectionPoolStatus() {
        return {
            totalConnections: this.pool.totalCount,
            idleConnections: this.pool.idleCount,
            waitingClients: this.pool.waitingCount
        };
    }
};
```
```

### Performance Validation Framework

```
**Before/After Performance Comparison**:

Systematic validation of optimization effectiveness:

**Benchmark Testing Scripts**:
```bash
#!/bin/bash
# Database performance benchmarking script

echo "=== Database Performance Benchmark ==="
echo "Date: $(date)"
echo "Database: $DB_NAME"

# Before optimization benchmarks
echo "=== BEFORE OPTIMIZATION ==="
echo "Running baseline performance tests..."

# Query execution time measurement
psql -d $DB_NAME -c "\timing on" -c "
SELECT COUNT(*) as total_products,
       AVG(price) as avg_price,
       COUNT(DISTINCT category_id) as categories
FROM products p
JOIN reviews r ON p.id = r.product_id
WHERE p.created_at >= '2024-01-01'
" > baseline_results.txt

# System resource utilization
echo "CPU Usage: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1)"
echo "Memory Usage: $(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}')"
echo "Disk I/O: $(iostat -x 1 1 | tail -n +4 | awk '{print $10}' | tail -1)"

# After optimization benchmarks
echo "=== AFTER OPTIMIZATION ==="
echo "Running optimized performance tests..."

# Same queries with optimizations applied
psql -d $DB_NAME -c "\timing on" -c "
SELECT COUNT(*) as total_products,
       AVG(price) as avg_price,
       COUNT(DISTINCT category_id) as categories
FROM products p
JOIN reviews r ON p.id = r.product_id
WHERE p.created_at >= '2024-01-01'
" > optimized_results.txt

# Calculate improvement percentages
python3 calculate_improvements.py baseline_results.txt optimized_results.txt
```

**Load Testing Validation**:
```python
# Python load testing script for database optimization validation
import asyncio
import asyncpg
import time
import statistics
from concurrent.futures import ThreadPoolExecutor

class DatabaseLoadTest:
    def __init__(self, connection_string, concurrent_users=100):
        self.connection_string = connection_string
        self.concurrent_users = concurrent_users
        self.results = []
    
    async def execute_query_scenario(self, query_set, iterations=1000):
        """Execute a set of queries simulating real user behavior"""
        response_times = []
        
        async with asyncpg.create_pool(self.connection_string, min_size=10, max_size=20) as pool:
            tasks = []
            
            for i in range(iterations):
                for query in query_set:
                    task = self.execute_single_query(pool, query)
                    tasks.append(task)
            
            # Execute all tasks concurrently
            results = await asyncio.gather(*tasks, return_exceptions=True)
            
            # Process results
            for result in results:
                if isinstance(result, Exception):
                    print(f"Query failed: {result}")
                else:
                    response_times.append(result)
        
        return {
            'total_queries': len(response_times),
            'avg_response_time': statistics.mean(response_times),
            'median_response_time': statistics.median(response_times),
            'p95_response_time': statistics.quantiles(response_times, n=20)[18],  # 95th percentile
            'p99_response_time': statistics.quantiles(response_times, n=100)[98],  # 99th percentile
            'failed_queries': iterations * len(query_set) - len(response_times)
        }
    
    async def execute_single_query(self, pool, query):
        """Execute a single query and measure response time"""
        start_time = time.time()
        
        try:
            async with pool.acquire() as connection:
                await connection.fetch(query)
            
            return (time.time() - start_time) * 1000  # Return milliseconds
        except Exception as e:
            raise e

# Example usage
async def run_performance_validation():
    # Test queries representing typical application usage
    test_queries = [
        "SELECT * FROM products WHERE category_id = 1 ORDER BY price LIMIT 20",
        "SELECT p.*, c.name FROM products p JOIN categories c ON p.category_id = c.id WHERE p.price BETWEEN 100 AND 500",
        "SELECT COUNT(*), AVG(rating) FROM reviews WHERE product_id IN (SELECT id FROM products WHERE category_id = 2)"
    ]
    
    load_tester = DatabaseLoadTest("postgresql://user:pass@localhost/dbname")
    
    print("Running database load test...")
    results = await load_tester.execute_query_scenario(test_queries, iterations=500)
    
    print(f"Performance Results:")
    print(f"Average Response Time: {results['avg_response_time']:.2f}ms")
    print(f"95th Percentile: {results['p95_response_time']:.2f}ms")
    print(f"99th Percentile: {results['p99_response_time']:.2f}ms")
    print(f"Failed Queries: {results['failed_queries']}")

# Run the validation
if __name__ == "__main__":
    asyncio.run(run_performance_validation())
```

**Continuous Performance Monitoring**:
```yaml
# Prometheus configuration for database monitoring
apiVersion: v1
kind: ConfigMap
metadata:
  name: database-monitoring-config
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
    
    scrape_configs:
      - job_name: 'postgresql'
        static_configs:
          - targets: ['postgres-exporter:9187']
        scrape_interval: 5s
        metrics_path: /metrics
      
      - job_name: 'mysql'
        static_configs:
          - targets: ['mysql-exporter:9104']
        scrape_interval: 5s
        
      - job_name: 'application'
        static_configs:
          - targets: ['app:3000']
        scrape_interval: 10s
        metrics_path: /metrics

---
# Grafana dashboard configuration for database performance
apiVersion: v1
kind: ConfigMap
metadata:
  name: grafana-dashboard-db-performance
data:
  dashboard.json: |
    {
      "dashboard": {
        "title": "Database Performance Optimization",
        "panels": [
          {
            "title": "Query Response Times",
            "targets": [
              {"expr": "histogram_quantile(0.95, rate(database_query_duration_seconds_bucket[5m]))"},
              {"expr": "histogram_quantile(0.99, rate(database_query_duration_seconds_bucket[5m]))"}
            ]
          },
          {
            "title": "Database Connections",
            "targets": [
              {"expr": "database_connections_active"},
              {"expr": "database_connections_idle"}
            ]
          },
          {
            "title": "Query Throughput",
            "targets": [
              {"expr": "rate(database_queries_total[5m])"}
            ]
          }
        ]
      }
    }
```
```

This comprehensive database query optimization template provides systematic approaches to identifying, analyzing, and resolving database performance bottlenecks across different technology stacks while ensuring measurable improvements and ongoing performance monitoring.