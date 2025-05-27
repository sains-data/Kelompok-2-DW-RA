-- filepath: m:\ITERA\Semester 6\Pergudangan Data\Tugas\Misi4\sql-scripts\05_analytical_queries.sql
-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- PART 5: BUSINESS INTELLIGENCE QUERIES
-- ====================================

USE germantrust_dw;

-- ====================================
-- EXECUTIVE DASHBOARD QUERIES
-- ====================================

-- 1. OVERALL BANK PERFORMANCE SUMMARY
SELECT 
    'Bank Performance Overview' as report_title,
    COUNT(DISTINCT f.fact_id) as total_transactions,
    COUNT(DISTINCT f.branch_id) as active_branches,
    COUNT(DISTINCT f.product_id) as active_products,
    COUNT(DISTINCT f.customer_segment_id) as customer_segments,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(AVG(f.roa), 4) as avg_roa,
    ROUND(AVG(f.debt_to_equity), 2) as avg_debt_to_equity
FROM FactFinancialPerformance f;

-- 2. MONTHLY TREND ANALYSIS
SELECT 
    LEFT(CAST(f.date_id AS CHAR), 6) as year_month,
    COUNT(f.fact_id) as transaction_count,
    ROUND(SUM(f.revenue) / 1000000, 2) as revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(AVG(f.roa), 4) as avg_roa,
    ROUND(
        (SUM(f.revenue) - LAG(SUM(f.revenue)) OVER (ORDER BY LEFT(CAST(f.date_id AS CHAR), 6))) 
        / LAG(SUM(f.revenue)) OVER (ORDER BY LEFT(CAST(f.date_id AS CHAR), 6)) * 100, 2
    ) as revenue_growth_percent
FROM FactFinancialPerformance f
GROUP BY LEFT(CAST(f.date_id AS CHAR), 6)
ORDER BY year_month;

-- ====================================
-- BRANCH PERFORMANCE ANALYSIS
-- ====================================

-- 3. TOP PERFORMING BRANCHES BY REVENUE
SELECT 
    'Top Branches by Revenue' as report_title,
    b.branch_name,
    b.city,
    b.country,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(AVG(f.roa), 4) as avg_roa,
    ROUND(SUM(f.assets) / 1000000, 2) as total_assets_millions
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.city, b.country
ORDER BY total_revenue_millions DESC
LIMIT 10;

-- 4. BRANCH EFFICIENCY ANALYSIS
SELECT 
    'Branch Efficiency Analysis' as report_title,
    b.branch_name,
    b.city,
    b.country,
    ROUND(AVG(f.cost_to_income_ratio), 4) as avg_cost_to_income_ratio,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(AVG(f.roa), 4) as avg_roa,
    ROUND(SUM(f.revenue) / SUM(f.expenses), 2) as revenue_to_expense_ratio,
    CASE 
        WHEN AVG(f.cost_to_income_ratio) < 0.6 THEN 'High Efficiency'
        WHEN AVG(f.cost_to_income_ratio) < 0.7 THEN 'Good Efficiency'
        WHEN AVG(f.cost_to_income_ratio) < 0.8 THEN 'Average Efficiency'
        ELSE 'Needs Improvement'
    END as efficiency_rating
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.city, b.country
ORDER BY avg_cost_to_income_ratio ASC;

-- ====================================
-- PRODUCT PERFORMANCE ANALYSIS
-- ====================================

-- 5. PRODUCT PROFITABILITY ANALYSIS
SELECT 
    'Product Profitability Analysis' as report_title,
    p.product_name,
    p.product_category,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(SUM(f.revenue) / COUNT(f.fact_id), 2) as revenue_per_transaction,
    ROUND(SUM(f.net_income) / COUNT(f.fact_id), 2) as profit_per_transaction
FROM FactFinancialPerformance f
JOIN DimProduct p ON f.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.product_category
ORDER BY total_revenue_millions DESC;

-- 6. PRODUCT CATEGORY COMPARISON
SELECT 
    'Product Category Performance' as report_title,
    p.product_category,
    COUNT(DISTINCT p.product_id) as number_of_products,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(AVG(f.transaction_count), 0) as avg_transaction_volume
FROM FactFinancialPerformance f
JOIN DimProduct p ON f.product_id = p.product_id
GROUP BY p.product_category
ORDER BY total_revenue_millions DESC;

-- ====================================
-- CUSTOMER SEGMENT ANALYSIS
-- ====================================

-- 7. CUSTOMER SEGMENT PROFITABILITY
SELECT 
    'Customer Segment Analysis' as report_title,
    cs.segment_name,
    cs.segment_description,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(SUM(f.revenue) / COUNT(f.fact_id), 2) as revenue_per_transaction,
    ROUND(AVG(f.transaction_count), 0) as avg_transaction_volume
FROM FactFinancialPerformance f
JOIN DimCustomerSegment cs ON f.customer_segment_id = cs.segment_id
GROUP BY cs.segment_id, cs.segment_name, cs.segment_description
ORDER BY total_revenue_millions DESC;

-- ====================================
-- ASSET PERFORMANCE ANALYSIS
-- ====================================

-- 8. ASSET CLASS PERFORMANCE
SELECT 
    'Asset Performance Analysis' as report_title,
    a.asset_category,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(AVG(f.roa), 4) as avg_roa,
    ROUND(SUM(f.assets) / 1000000, 2) as total_assets_millions,
    ROUND(SUM(f.net_income) / SUM(f.assets), 4) as asset_efficiency_ratio
FROM FactFinancialPerformance f
JOIN DimAsset a ON f.asset_id = a.asset_id
GROUP BY a.asset_category
ORDER BY avg_roa DESC;

-- ====================================
-- EMPLOYEE PERFORMANCE ANALYSIS
-- ====================================

-- 9. TOP PERFORMING EMPLOYEES
SELECT 
    'Top Performing Employees' as report_title,
    e.employee_name,
    e.position,
    d.department_name,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(SUM(f.revenue) / COUNT(f.fact_id), 2) as revenue_per_transaction
FROM FactFinancialPerformance f
JOIN DimEmployee e ON f.employee_id = e.employee_id
JOIN DimDepartment d ON e.department_id = d.department_id
GROUP BY e.employee_id, e.employee_name, e.position, d.department_name
ORDER BY total_revenue_millions DESC
LIMIT 15;

-- 10. DEPARTMENT PERFORMANCE
SELECT 
    'Department Performance Analysis' as report_title,
    d.department_name,
    COUNT(DISTINCT f.employee_id) as unique_employees,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(SUM(f.revenue) / COUNT(DISTINCT f.employee_id) / 1000, 2) as revenue_per_employee_thousands
FROM FactFinancialPerformance f
JOIN DimEmployee e ON f.employee_id = e.employee_id
JOIN DimDepartment d ON e.department_id = d.department_id
GROUP BY d.department_id, d.department_name
ORDER BY total_revenue_millions DESC;

-- ====================================
-- GEOGRAPHICAL ANALYSIS
-- ====================================

-- 11. COUNTRY PERFORMANCE COMPARISON
SELECT 
    'Country Performance Analysis' as report_title,
    b.country,
    COUNT(DISTINCT b.branch_id) as number_of_branches,
    COUNT(f.fact_id) as total_transactions,
    ROUND(SUM(f.revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(f.net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(SUM(f.revenue) / COUNT(DISTINCT b.branch_id) / 1000000, 2) as revenue_per_branch_millions
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
GROUP BY b.country
ORDER BY total_revenue_millions DESC;

-- ====================================
-- FINANCIAL HEALTH INDICATORS
-- ====================================

-- 12. FINANCIAL HEALTH DASHBOARD
SELECT 
    'Financial Health Indicators' as report_title,
    LEFT(CAST(f.date_id AS CHAR), 6) as year_month,
    ROUND(AVG(f.debt_to_equity), 2) as avg_debt_to_equity,
    ROUND(AVG(f.roa), 4) as avg_roa,
    ROUND(AVG(f.profit_margin), 4) as avg_profit_margin,
    ROUND(AVG(f.cost_to_income_ratio), 4) as avg_cost_to_income_ratio,
    ROUND(SUM(f.cash_flow) / 1000000, 2) as total_cash_flow_millions,
    CASE 
        WHEN AVG(f.debt_to_equity) < 2.0 AND AVG(f.roa) > 0.01 AND AVG(f.profit_margin) > 0.15 THEN 'Excellent'
        WHEN AVG(f.debt_to_equity) < 3.0 AND AVG(f.roa) > 0.008 AND AVG(f.profit_margin) > 0.12 THEN 'Good'
        WHEN AVG(f.debt_to_equity) < 4.0 AND AVG(f.roa) > 0.005 AND AVG(f.profit_margin) > 0.08 THEN 'Fair'
        ELSE 'Needs Attention'
    END as financial_health_rating
FROM FactFinancialPerformance f
GROUP BY LEFT(CAST(f.date_id AS CHAR), 6)
ORDER BY year_month;

-- ====================================
-- RISK ANALYSIS
-- ====================================

-- 13. RISK ASSESSMENT BY SEGMENT
SELECT 
    'Risk Analysis by Segment' as report_title,
    cs.segment_name,
    ROUND(AVG(f.debt_to_equity), 2) as avg_debt_to_equity,
    ROUND(STDDEV(f.net_income) / AVG(f.net_income), 4) as income_volatility,
    ROUND(AVG(f.cost_to_income_ratio), 4) as avg_cost_ratio,
    CASE 
        WHEN AVG(f.debt_to_equity) > 4.0 OR STDDEV(f.net_income) / AVG(f.net_income) > 0.5 THEN 'High Risk'
        WHEN AVG(f.debt_to_equity) > 3.0 OR STDDEV(f.net_income) / AVG(f.net_income) > 0.3 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END as risk_level
FROM FactFinancialPerformance f
JOIN DimCustomerSegment cs ON f.customer_segment_id = cs.segment_id
GROUP BY cs.segment_id, cs.segment_name
ORDER BY avg_debt_to_equity DESC;

-- ====================================
-- GROWTH ANALYSIS
-- ====================================

-- 14. YEAR-OVER-YEAR GROWTH ANALYSIS
WITH MonthlyMetrics AS (
    SELECT 
        LEFT(CAST(date_id AS CHAR), 6) as year_month,
        SUM(revenue) as monthly_revenue,
        SUM(net_income) as monthly_net_income,
        COUNT(fact_id) as monthly_transactions
    FROM FactFinancialPerformance
    GROUP BY LEFT(CAST(date_id AS CHAR), 6)
)
SELECT 
    'Growth Analysis' as report_title,
    year_month,
    ROUND(monthly_revenue / 1000000, 2) as revenue_millions,
    ROUND(monthly_net_income / 1000000, 2) as net_income_millions,
    monthly_transactions,
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

-- ====================================
-- SUMMARY REPORT
-- ====================================

-- 15. EXECUTIVE SUMMARY REPORT
SELECT 'GERMANTRUST BANK - EXECUTIVE SUMMARY' as title;

SELECT 
    'KEY PERFORMANCE INDICATORS' as section,
    ROUND(SUM(revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(profit_margin) * 100, 2) as avg_profit_margin_percent,
    ROUND(AVG(roa) * 100, 2) as avg_roa_percent,
    COUNT(DISTINCT branch_id) as total_branches,
    COUNT(DISTINCT product_id) as total_products,
    COUNT(fact_id) as total_transactions
FROM FactFinancialPerformance;

SELECT 
    'TOP 3 COUNTRIES BY REVENUE' as section,
    b.country,
    ROUND(SUM(f.revenue) / 1000000, 2) as revenue_millions
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
GROUP BY b.country
ORDER BY revenue_millions DESC
LIMIT 3;

SELECT 
    'TOP 3 PRODUCT CATEGORIES' as section,
    p.product_category,
    ROUND(SUM(f.revenue) / 1000000, 2) as revenue_millions
FROM FactFinancialPerformance f
JOIN DimProduct p ON f.product_id = p.product_id
GROUP BY p.product_category
ORDER BY revenue_millions DESC
LIMIT 3;
