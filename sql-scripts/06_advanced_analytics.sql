-- filepath: m:\ITERA\Semester 6\Pergudangan Data\Tugas\Misi4\sql-scripts\06_advanced_analytics.sql
-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- PART 6: ADVANCED ANALYTICS & PROCEDURES
-- ====================================

USE germantrust_dw;

-- ====================================
-- ADDITIONAL ANALYTICAL VIEWS
-- ====================================

-- Create view for monthly branch performance
CREATE OR REPLACE VIEW vw_monthly_branch_performance AS
SELECT 
    LEFT(CAST(f.date_id AS CHAR), 6) as year_month,
    b.branch_id,
    b.branch_name,
    b.city,
    b.country,
    COUNT(f.fact_id) as transaction_count,
    ROUND(SUM(f.revenue), 2) as total_revenue,
    ROUND(SUM(f.net_income), 2) as total_net_income,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(AVG(f.roa), 4) as avg_roa,
    ROUND(AVG(f.debt_to_equity), 2) as avg_debt_to_equity,
    ROUND(SUM(f.assets), 2) as total_assets,
    ROUND(SUM(f.liabilities), 2) as total_liabilities
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
GROUP BY LEFT(CAST(f.date_id AS CHAR), 6), b.branch_id, b.branch_name, b.city, b.country;

-- Create view for customer segment analysis
CREATE OR REPLACE VIEW vw_customer_segment_analysis AS
SELECT 
    cs.segment_id,
    cs.segment_name,
    cs.segment_description,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue), 2) as total_revenue,
    ROUND(SUM(f.net_income), 2) as total_net_income,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(SUM(f.revenue) / COUNT(f.fact_id), 2) as revenue_per_transaction,
    ROUND(AVG(f.transaction_count), 0) as avg_transaction_volume,
    ROUND(AVG(f.roa), 4) as avg_roa
FROM FactFinancialPerformance f
JOIN DimCustomerSegment cs ON f.customer_segment_id = cs.segment_id
GROUP BY cs.segment_id, cs.segment_name, cs.segment_description;

-- Create view for employee performance ranking
CREATE OR REPLACE VIEW vw_employee_performance_ranking AS
SELECT 
    e.employee_id,
    e.employee_name,
    e.position,
    d.department_name,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue), 2) as total_revenue,
    ROUND(SUM(f.net_income), 2) as total_net_income,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    RANK() OVER (ORDER BY SUM(f.revenue) DESC) as revenue_rank,
    RANK() OVER (ORDER BY SUM(f.net_income) DESC) as profit_rank,
    RANK() OVER (ORDER BY AVG(f.profit_margin) DESC) as efficiency_rank
FROM FactFinancialPerformance f
JOIN DimEmployee e ON f.employee_id = e.employee_id
JOIN DimDepartment d ON e.department_id = d.department_id
GROUP BY e.employee_id, e.employee_name, e.position, d.department_name;

-- Create view for product performance trends
CREATE OR REPLACE VIEW vw_product_performance_trends AS
SELECT 
    LEFT(CAST(f.date_id AS CHAR), 6) as year_month,
    p.product_id,
    p.product_name,
    p.product_category,
    COUNT(f.fact_id) as transaction_count,
    ROUND(SUM(f.revenue), 2) as total_revenue,
    ROUND(SUM(f.net_income), 2) as total_net_income,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin
FROM FactFinancialPerformance f
JOIN DimProduct p ON f.product_id = p.product_id
GROUP BY LEFT(CAST(f.date_id AS CHAR), 6), p.product_id, p.product_name, p.product_category;

-- Create view for risk assessment
CREATE OR REPLACE VIEW vw_risk_assessment AS
SELECT 
    b.branch_id,
    b.branch_name,
    b.country,
    ROUND(AVG(f.debt_to_equity), 2) as avg_debt_to_equity,
    ROUND(STDDEV(f.net_income), 2) as income_volatility,
    ROUND(AVG(f.cost_to_income_ratio), 4) as avg_cost_ratio,
    ROUND(MIN(f.net_income), 2) as min_net_income,
    ROUND(MAX(f.net_income), 2) as max_net_income,
    CASE 
        WHEN AVG(f.debt_to_equity) > 4.0 THEN 'High Risk'
        WHEN AVG(f.debt_to_equity) > 3.0 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END as risk_level,
    CASE 
        WHEN STDDEV(f.net_income) / AVG(f.net_income) > 0.5 THEN 'High Volatility'
        WHEN STDDEV(f.net_income) / AVG(f.net_income) > 0.3 THEN 'Medium Volatility'
        ELSE 'Low Volatility'
    END as volatility_level
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.country;

-- ====================================
-- STORED PROCEDURES FOR REPORTS
-- ====================================

-- Procedure to get branch performance for a specific period
DELIMITER //
CREATE PROCEDURE GetBranchPerformance(
    IN start_date_id INT,
    IN end_date_id INT
)
BEGIN
    SELECT 
        b.branch_name,
        b.city,
        b.country,
        COUNT(f.fact_id) as transaction_count,
        ROUND(SUM(f.revenue) / 1000000, 2) as revenue_millions,
        ROUND(SUM(f.net_income) / 1000000, 2) as net_income_millions,
        ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
        ROUND(AVG(f.roa), 4) as avg_roa
    FROM FactFinancialPerformance f
    JOIN DimBranch b ON f.branch_id = b.branch_id
    WHERE f.date_id BETWEEN start_date_id AND end_date_id
    GROUP BY b.branch_id, b.branch_name, b.city, b.country
    ORDER BY revenue_millions DESC;
END //
DELIMITER ;

-- Procedure to get top products by revenue
DELIMITER //
CREATE PROCEDURE GetTopProducts(
    IN limit_count INT
)
BEGIN
    SELECT 
        p.product_name,
        p.product_category,
        COUNT(f.fact_id) as transaction_count,
        ROUND(SUM(f.revenue) / 1000000, 2) as revenue_millions,
        ROUND(SUM(f.net_income) / 1000000, 2) as net_income_millions,
        ROUND(AVG(f.profit_margin), 4) as avg_profit_margin
    FROM FactFinancialPerformance f
    JOIN DimProduct p ON f.product_id = p.product_id
    GROUP BY p.product_id, p.product_name, p.product_category
    ORDER BY revenue_millions DESC
    LIMIT limit_count;
END //
DELIMITER ;

-- Procedure to get financial health report
DELIMITER //
CREATE PROCEDURE GetFinancialHealthReport(
    IN report_year_month VARCHAR(6)
)
BEGIN
    SELECT 
        'Financial Health Report' as report_title,
        report_year_month as period,
        COUNT(f.fact_id) as total_transactions,
        ROUND(SUM(f.revenue) / 1000000, 2) as revenue_millions,
        ROUND(SUM(f.net_income) / 1000000, 2) as net_income_millions,
        ROUND(AVG(f.debt_to_equity), 2) as avg_debt_to_equity,
        ROUND(AVG(f.roa), 4) as avg_roa,
        ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
        ROUND(AVG(f.cost_to_income_ratio), 4) as avg_cost_to_income_ratio,
        CASE 
            WHEN AVG(f.debt_to_equity) < 2.0 AND AVG(f.roa) > 0.01 AND AVG(f.profit_margin) > 0.15 THEN 'Excellent'
            WHEN AVG(f.debt_to_equity) < 3.0 AND AVG(f.roa) > 0.008 AND AVG(f.profit_margin) > 0.12 THEN 'Good'
            WHEN AVG(f.debt_to_equity) < 4.0 AND AVG(f.roa) > 0.005 AND AVG(f.profit_margin) > 0.08 THEN 'Fair'
            ELSE 'Needs Attention'
        END as financial_health_rating
    FROM FactFinancialPerformance f
    WHERE LEFT(CAST(f.date_id AS CHAR), 6) = report_year_month;
END //
DELIMITER ;

-- Procedure to calculate year-over-year growth
DELIMITER //
CREATE PROCEDURE GetYearOverYearGrowth()
BEGIN
    WITH MonthlyMetrics AS (
        SELECT 
            LEFT(CAST(date_id AS CHAR), 6) as year_month,
            SUM(revenue) as monthly_revenue,
            SUM(net_income) as monthly_net_income
        FROM FactFinancialPerformance
        GROUP BY LEFT(CAST(date_id AS CHAR), 6)
    )
    SELECT 
        year_month,
        ROUND(monthly_revenue / 1000000, 2) as revenue_millions,
        ROUND(monthly_net_income / 1000000, 2) as net_income_millions,
        ROUND(
            (monthly_revenue - LAG(monthly_revenue, 12) OVER (ORDER BY year_month)) 
            / LAG(monthly_revenue, 12) OVER (ORDER BY year_month) * 100, 2
        ) as yoy_revenue_growth_percent,
        ROUND(
            (monthly_net_income - LAG(monthly_net_income, 12) OVER (ORDER BY year_month)) 
            / LAG(monthly_net_income, 12) OVER (ORDER BY year_month) * 100, 2
        ) as yoy_income_growth_percent
    FROM MonthlyMetrics
    ORDER BY year_month;
END //
DELIMITER ;

-- ====================================
-- DATA QUALITY CHECKS
-- ====================================

-- Procedure to check data quality
DELIMITER //
CREATE PROCEDURE CheckDataQuality()
BEGIN
    -- Check for null values in critical fields
    SELECT 'Null Value Check' as check_type, 
           COUNT(*) as total_records,
           SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) as null_revenue,
           SUM(CASE WHEN net_income IS NULL THEN 1 ELSE 0 END) as null_net_income,
           SUM(CASE WHEN assets IS NULL THEN 1 ELSE 0 END) as null_assets
    FROM FactFinancialPerformance;
    
    -- Check for negative values where they shouldn't exist
    SELECT 'Negative Value Check' as check_type,
           SUM(CASE WHEN revenue < 0 THEN 1 ELSE 0 END) as negative_revenue,
           SUM(CASE WHEN assets < 0 THEN 1 ELSE 0 END) as negative_assets,
           SUM(CASE WHEN transaction_count < 0 THEN 1 ELSE 0 END) as negative_transactions
    FROM FactFinancialPerformance;
    
    -- Check for outliers in key metrics
    SELECT 'Outlier Check' as check_type,
           COUNT(*) as total_records,
           SUM(CASE WHEN profit_margin > 1.0 OR profit_margin < -1.0 THEN 1 ELSE 0 END) as extreme_profit_margins,
           SUM(CASE WHEN debt_to_equity > 10.0 THEN 1 ELSE 0 END) as extreme_debt_ratios
    FROM FactFinancialPerformance;
    
    -- Check referential integrity
    SELECT 'Referential Integrity Check' as check_type,
           SUM(CASE WHEN b.branch_id IS NULL THEN 1 ELSE 0 END) as missing_branches,
           SUM(CASE WHEN p.product_id IS NULL THEN 1 ELSE 0 END) as missing_products,
           SUM(CASE WHEN e.employee_id IS NULL THEN 1 ELSE 0 END) as missing_employees
    FROM FactFinancialPerformance f
    LEFT JOIN DimBranch b ON f.branch_id = b.branch_id
    LEFT JOIN DimProduct p ON f.product_id = p.product_id
    LEFT JOIN DimEmployee e ON f.employee_id = e.employee_id;
END //
DELIMITER ;

-- ====================================
-- PERFORMANCE OPTIMIZATION
-- ====================================

-- Create indexes for better query performance
CREATE INDEX idx_fact_date_branch ON FactFinancialPerformance(date_id, branch_id);
CREATE INDEX idx_fact_product_segment ON FactFinancialPerformance(product_id, customer_segment_id);
CREATE INDEX idx_fact_employee_date ON FactFinancialPerformance(employee_id, date_id);
CREATE INDEX idx_fact_revenue ON FactFinancialPerformance(revenue);
CREATE INDEX idx_fact_net_income ON FactFinancialPerformance(net_income);

-- Create indexes on dimension tables
CREATE INDEX idx_branch_country ON DimBranch(country);
CREATE INDEX idx_product_category ON DimProduct(product_category);
CREATE INDEX idx_employee_department ON DimEmployee(department_id);
CREATE INDEX idx_time_year_month ON DimTime(year, month);

-- ====================================
-- UTILITY PROCEDURES
-- ====================================

-- Procedure to refresh all analytical views
DELIMITER //
CREATE PROCEDURE RefreshAnalyticalViews()
BEGIN
    -- This would typically refresh materialized views if supported
    -- For now, we'll just provide a status message
    SELECT 'Analytical views are automatically updated in MySQL' as status,
           'No manual refresh required for standard views' as note;
END //
DELIMITER ;

-- Procedure to get database statistics
DELIMITER //
CREATE PROCEDURE GetDatabaseStatistics()
BEGIN
    SELECT 'Database Statistics' as report_title;
    
    SELECT 'Table Row Counts' as section;
    SELECT 'FactFinancialPerformance' as table_name, COUNT(*) as row_count FROM FactFinancialPerformance
    UNION ALL
    SELECT 'DimBranch', COUNT(*) FROM DimBranch
    UNION ALL
    SELECT 'DimProduct', COUNT(*) FROM DimProduct
    UNION ALL
    SELECT 'DimEmployee', COUNT(*) FROM DimEmployee
    UNION ALL
    SELECT 'DimCustomerSegment', COUNT(*) FROM DimCustomerSegment
    UNION ALL
    SELECT 'DimAsset', COUNT(*) FROM DimAsset
    UNION ALL
    SELECT 'DimDepartment', COUNT(*) FROM DimDepartment
    UNION ALL
    SELECT 'DimTime', COUNT(*) FROM DimTime;
    
    SELECT 'Date Range' as section;
    SELECT 
        MIN(date_id) as earliest_date,
        MAX(date_id) as latest_date,
        COUNT(DISTINCT date_id) as unique_dates
    FROM FactFinancialPerformance;
END //
DELIMITER ;

-- ====================================
-- EXAMPLE PROCEDURE CALLS
-- ====================================

-- Example calls (commented out - uncomment to use)
-- CALL GetBranchPerformance(20240101, 20241231);
-- CALL GetTopProducts(10);
-- CALL GetFinancialHealthReport('202412');
-- CALL GetYearOverYearGrowth();
-- CALL CheckDataQuality();
-- CALL GetDatabaseStatistics();
