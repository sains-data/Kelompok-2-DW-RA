-- filepath: m:\ITERA\Semester 6\Pergudangan Data\Tugas\Misi4\sql-scripts\04_additional_fact_data.sql
-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- PART 4: ADDITIONAL FACT TABLE DATA
-- ====================================

USE germantrust_dw;

-- ====================================
-- ADDITIONAL FACT DATA FOR COMPREHENSIVE ANALYSIS
-- ====================================

-- Insert batch 9: 2024 Q3 Enhanced Data (July)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20240715 as date_id, -- July 15, 2024
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Enhanced financial metrics (growth trend continued)
    1050000 + (seq * 18000) + FLOOR(RAND() * 600000) as operating_income,
    580000 + (seq * 9500) + FLOOR(RAND() * 350000) as expenses,
    380000 + (seq * 8500) + FLOOR(RAND() * 250000) as net_income,
    52000000 + (seq * 600000) + FLOOR(RAND() * 12000000) as assets,
    38000000 + (seq * 450000) + FLOOR(RAND() * 9000000) as liabilities,
    14000000 + (seq * 150000) + FLOOR(RAND() * 3000000) as equity,
    1100000 + (seq * 19000) + FLOOR(RAND() * 650000) as revenue,
    155000 + (seq * 2500) + FLOOR(RAND() * 95000) as cash_flow,
    28000 + (seq * 600) + FLOOR(RAND() * 18000) as interest_expense,
    42000 + (seq * 950) + FLOOR(RAND() * 25000) as tax_expense,
    12000 + (seq * 300) + FLOOR(RAND() * 8000) as dividend_payout,
    320 + (seq * 6) + FLOOR(RAND() * 250) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) c
    WHERE a.n + b.n * 10 + c.n * 100 < 75
) numbers;

-- Insert batch 10: 2024 Q3 Enhanced Data (August)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20240815 as date_id, -- August 15, 2024
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Peak summer performance metrics
    1080000 + (seq * 19000) + FLOOR(RAND() * 620000) as operating_income,
    590000 + (seq * 10000) + FLOOR(RAND() * 360000) as expenses,
    395000 + (seq * 9000) + FLOOR(RAND() * 260000) as net_income,
    53500000 + (seq * 620000) + FLOOR(RAND() * 13000000) as assets,
    39000000 + (seq * 470000) + FLOOR(RAND() * 9500000) as liabilities,
    14500000 + (seq * 150000) + FLOOR(RAND() * 3500000) as equity,
    1130000 + (seq * 20000) + FLOOR(RAND() * 670000) as revenue,
    160000 + (seq * 2600) + FLOOR(RAND() * 100000) as cash_flow,
    29000 + (seq * 650) + FLOOR(RAND() * 19000) as interest_expense,
    44000 + (seq * 1000) + FLOOR(RAND() * 26000) as tax_expense,
    13000 + (seq * 320) + FLOOR(RAND() * 8500) as dividend_payout,
    335 + (seq * 7) + FLOOR(RAND() * 260) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) c
    WHERE a.n + b.n * 10 + c.n * 100 < 80
) numbers;

-- Insert batch 11: 2024 Q4 Data (September)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20240915 as date_id, -- September 15, 2024
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Strong Q4 beginning metrics
    1100000 + (seq * 20000) + FLOOR(RAND() * 640000) as operating_income,
    600000 + (seq * 10500) + FLOOR(RAND() * 370000) as expenses,
    410000 + (seq * 9500) + FLOOR(RAND() * 270000) as net_income,
    55000000 + (seq * 650000) + FLOOR(RAND() * 14000000) as assets,
    40000000 + (seq * 490000) + FLOOR(RAND() * 10000000) as liabilities,
    15000000 + (seq * 160000) + FLOOR(RAND() * 4000000) as equity,
    1150000 + (seq * 21000) + FLOOR(RAND() * 690000) as revenue,
    165000 + (seq * 2700) + FLOOR(RAND() * 105000) as cash_flow,
    30000 + (seq * 700) + FLOOR(RAND() * 20000) as interest_expense,
    46000 + (seq * 1050) + FLOOR(RAND() * 27000) as tax_expense,
    14000 + (seq * 340) + FLOOR(RAND() * 9000) as dividend_payout,
    350 + (seq * 8) + FLOOR(RAND() * 270) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) c
    WHERE a.n + b.n * 10 + c.n * 100 < 85
) numbers;

-- Insert batch 12: 2024 Q4 Data (October)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20241015 as date_id, -- October 15, 2024
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Strong Q4 performance metrics
    1120000 + (seq * 21000) + FLOOR(RAND() * 660000) as operating_income,
    610000 + (seq * 11000) + FLOOR(RAND() * 380000) as expenses,
    425000 + (seq * 10000) + FLOOR(RAND() * 280000) as net_income,
    56500000 + (seq * 680000) + FLOOR(RAND() * 15000000) as assets,
    41000000 + (seq * 510000) + FLOOR(RAND() * 10500000) as liabilities,
    15500000 + (seq * 170000) + FLOOR(RAND() * 4500000) as equity,
    1170000 + (seq * 22000) + FLOOR(RAND() * 710000) as revenue,
    170000 + (seq * 2800) + FLOOR(RAND() * 110000) as cash_flow,
    31000 + (seq * 750) + FLOOR(RAND() * 21000) as interest_expense,
    48000 + (seq * 1100) + FLOOR(RAND() * 28000) as tax_expense,
    15000 + (seq * 360) + FLOOR(RAND() * 9500) as dividend_payout,
    365 + (seq * 9) + FLOOR(RAND() * 280) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) c
    WHERE a.n + b.n * 10 + c.n * 100 < 90
) numbers;

-- Insert batch 13: 2024 Q4 Year-End Data (November)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20241115 as date_id, -- November 15, 2024
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Strong year-end performance metrics
    1150000 + (seq * 22000) + FLOOR(RAND() * 680000) as operating_income,
    620000 + (seq * 11500) + FLOOR(RAND() * 390000) as expenses,
    440000 + (seq * 10500) + FLOOR(RAND() * 290000) as net_income,
    58000000 + (seq * 700000) + FLOOR(RAND() * 16000000) as assets,
    42000000 + (seq * 530000) + FLOOR(RAND() * 11000000) as liabilities,
    16000000 + (seq * 170000) + FLOOR(RAND() * 5000000) as equity,
    1200000 + (seq * 23000) + FLOOR(RAND() * 730000) as revenue,
    175000 + (seq * 2900) + FLOOR(RAND() * 115000) as cash_flow,
    32000 + (seq * 800) + FLOOR(RAND() * 22000) as interest_expense,
    50000 + (seq * 1150) + FLOOR(RAND() * 29000) as tax_expense,
    16000 + (seq * 380) + FLOOR(RAND() * 10000) as dividend_payout,
    380 + (seq * 10) + FLOOR(RAND() * 290) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) c
    WHERE a.n + b.n * 10 + c.n * 100 < 95
) numbers;

-- Insert batch 14: 2024 Q4 Year-End Data (December)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20241215 as date_id, -- December 15, 2024
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Peak year-end performance metrics
    1180000 + (seq * 23000) + FLOOR(RAND() * 700000) as operating_income,
    630000 + (seq * 12000) + FLOOR(RAND() * 400000) as expenses,
    455000 + (seq * 11000) + FLOOR(RAND() * 300000) as net_income,
    60000000 + (seq * 720000) + FLOOR(RAND() * 17000000) as assets,
    43000000 + (seq * 550000) + FLOOR(RAND() * 11500000) as liabilities,
    17000000 + (seq * 170000) + FLOOR(RAND() * 5500000) as equity,
    1230000 + (seq * 24000) + FLOOR(RAND() * 750000) as revenue,
    180000 + (seq * 3000) + FLOOR(RAND() * 120000) as cash_flow,
    33000 + (seq * 850) + FLOOR(RAND() * 23000) as interest_expense,
    52000 + (seq * 1200) + FLOOR(RAND() * 30000) as tax_expense,
    17000 + (seq * 400) + FLOOR(RAND() * 10500) as dividend_payout,
    400 + (seq * 11) + FLOOR(RAND() * 300) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7) c
    WHERE a.n + b.n * 10 + c.n * 100 < 100
) numbers;

-- ====================================
-- DATA SUMMARY VERIFICATION
-- ====================================

-- Check total record count
SELECT 
    'Total Fact Records' as metric,
    COUNT(*) as count 
FROM FactFinancialPerformance;

-- Check data distribution by year
SELECT 
    LEFT(CAST(date_id AS CHAR), 4) as year,
    COUNT(*) as records,
    ROUND(AVG(net_income), 2) as avg_net_income,
    ROUND(AVG(operating_income), 2) as avg_operating_income
FROM FactFinancialPerformance 
GROUP BY LEFT(CAST(date_id AS CHAR), 4)
ORDER BY year;

-- Check data distribution by branch
SELECT 
    b.branch_name,
    b.city,
    b.country,
    COUNT(f.fact_id) as total_records,
    ROUND(AVG(f.net_income), 2) as avg_net_income,
    ROUND(SUM(f.revenue), 2) as total_revenue
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
GROUP BY b.branch_id, b.branch_name, b.city, b.country
ORDER BY total_revenue DESC;
