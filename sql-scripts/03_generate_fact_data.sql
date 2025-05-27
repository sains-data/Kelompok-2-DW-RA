-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- PART 3: FACT TABLE DATA GENERATION
-- ====================================

USE germantrust_dw;

-- ====================================
-- GENERATE REALISTIC FACT TABLE DATA
-- ====================================

-- Insert batch 1: 2023 data (Q1-Q2)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20230115 as date_id, -- January 15, 2023
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Financial metrics with realistic ranges
    850000 + (seq * 15000) + FLOOR(RAND() * 500000) as operating_income,
    520000 + (seq * 8000) + FLOOR(RAND() * 300000) as expenses,
    280000 + (seq * 7000) + FLOOR(RAND() * 200000) as net_income,
    45000000 + (seq * 500000) + FLOOR(RAND() * 10000000) as assets,
    35000000 + (seq * 400000) + FLOOR(RAND() * 8000000) as liabilities,
    10000000 + (seq * 100000) + FLOOR(RAND() * 2000000) as equity,
    900000 + (seq * 16000) + FLOOR(RAND() * 550000) as revenue,
    120000 + (seq * 2000) + FLOOR(RAND() * 80000) as cash_flow,
    25000 + (seq * 500) + FLOOR(RAND() * 15000) as interest_expense,
    35000 + (seq * 800) + FLOOR(RAND() * 20000) as tax_expense,
    8000 + (seq * 200) + FLOOR(RAND() * 5000) as dividend_payout,
    250 + (seq * 5) + FLOOR(RAND() * 200) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- Insert batch 2: 2023 data (February)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20230215 as date_id, -- February 15, 2023
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Slightly higher February numbers
    875000 + (seq * 16000) + FLOOR(RAND() * 520000) as operating_income,
    535000 + (seq * 8500) + FLOOR(RAND() * 310000) as expenses,
    290000 + (seq * 7500) + FLOOR(RAND() * 210000) as net_income,
    46000000 + (seq * 520000) + FLOOR(RAND() * 10500000) as assets,
    36000000 + (seq * 420000) + FLOOR(RAND() * 8200000) as liabilities,
    10200000 + (seq * 102000) + FLOOR(RAND() * 2100000) as equity,
    920000 + (seq * 17000) + FLOOR(RAND() * 570000) as revenue,
    125000 + (seq * 2100) + FLOOR(RAND() * 82000) as cash_flow,
    26000 + (seq * 520) + FLOOR(RAND() * 16000) as interest_expense,
    36000 + (seq * 820) + FLOOR(RAND() * 21000) as tax_expense,
    8200 + (seq * 210) + FLOOR(RAND() * 5200) as dividend_payout,
    260 + (seq * 6) + FLOOR(RAND() * 220) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- Insert batch 3: 2023 data (March - Q1 end)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20230315 as date_id, -- March 15, 2023
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Q1 end - strong performance
    920000 + (seq * 18000) + FLOOR(RAND() * 580000) as operating_income,
    560000 + (seq * 9000) + FLOOR(RAND() * 340000) as expenses,
    315000 + (seq * 8000) + FLOOR(RAND() * 240000) as net_income,
    48000000 + (seq * 580000) + FLOOR(RAND() * 11000000) as assets,
    37500000 + (seq * 460000) + FLOOR(RAND() * 8800000) as liabilities,
    10500000 + (seq * 120000) + FLOOR(RAND() * 2200000) as equity,
    975000 + (seq * 19000) + FLOOR(RAND() * 620000) as revenue,
    135000 + (seq * 2400) + FLOOR(RAND() * 90000) as cash_flow,
    28000 + (seq * 580) + FLOOR(RAND() * 18000) as interest_expense,
    39000 + (seq * 900) + FLOOR(RAND() * 24000) as tax_expense,
    12000 + (seq * 300) + FLOOR(RAND() * 8000) as dividend_payout, -- Higher Q1 dividend
    280 + (seq * 7) + FLOOR(RAND() * 250) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- Insert batch 4: 2023 Q2 data (June)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20230615 as date_id, -- June 15, 2023
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Q2 mid-year performance
    950000 + (seq * 19000) + FLOOR(RAND() * 600000) as operating_income,
    580000 + (seq * 9500) + FLOOR(RAND() * 350000) as expenses,
    325000 + (seq * 8500) + FLOOR(RAND() * 250000) as net_income,
    49500000 + (seq * 600000) + FLOOR(RAND() * 11500000) as assets,
    38500000 + (seq * 480000) + FLOOR(RAND() * 9200000) as liabilities,
    11000000 + (seq * 125000) + FLOOR(RAND() * 2300000) as equity,
    1005000 + (seq * 20000) + FLOOR(RAND() * 640000) as revenue,
    140000 + (seq * 2500) + FLOOR(RAND() * 95000) as cash_flow,
    29000 + (seq * 600) + FLOOR(RAND() * 19000) as interest_expense,
    40000 + (seq * 950) + FLOOR(RAND() * 25000) as tax_expense,
    9000 + (seq * 225) + FLOOR(RAND() * 6000) as dividend_payout,
    290 + (seq * 8) + FLOOR(RAND() * 260) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- Insert batch 5: 2023 Q3 data (September)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20230915 as date_id, -- September 15, 2023
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Q3 seasonal growth
    980000 + (seq * 20000) + FLOOR(RAND() * 620000) as operating_income,
    595000 + (seq * 10000) + FLOOR(RAND() * 365000) as expenses,
    340000 + (seq * 9000) + FLOOR(RAND() * 255000) as net_income,
    51000000 + (seq * 620000) + FLOOR(RAND() * 12000000) as assets,
    39800000 + (seq * 500000) + FLOOR(RAND() * 9600000) as liabilities,
    11200000 + (seq * 130000) + FLOOR(RAND() * 2400000) as equity,
    1035000 + (seq * 21000) + FLOOR(RAND() * 660000) as revenue,
    145000 + (seq * 2600) + FLOOR(RAND() * 98000) as cash_flow,
    30000 + (seq * 620) + FLOOR(RAND() * 20000) as interest_expense,
    42000 + (seq * 980) + FLOOR(RAND() * 26000) as tax_expense,
    9500 + (seq * 240) + FLOOR(RAND() * 6200) as dividend_payout,
    300 + (seq * 9) + FLOOR(RAND() * 270) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- Insert batch 6: 2023 Q4 data (December - Year end)
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20231215 as date_id, -- December 15, 2023
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- Q4 year-end strong performance
    1020000 + (seq * 22000) + FLOOR(RAND() * 680000) as operating_income,
    615000 + (seq * 11000) + FLOOR(RAND() * 380000) as expenses,
    365000 + (seq * 10000) + FLOOR(RAND() * 280000) as net_income,
    53000000 + (seq * 680000) + FLOOR(RAND() * 13000000) as assets,
    41500000 + (seq * 540000) + FLOOR(RAND() * 10400000) as liabilities,
    11500000 + (seq * 140000) + FLOOR(RAND() * 2600000) as equity,
    1080000 + (seq * 23000) + FLOOR(RAND() * 720000) as revenue,
    155000 + (seq * 2800) + FLOOR(RAND() * 105000) as cash_flow,
    32000 + (seq * 680) + FLOOR(RAND() * 22000) as interest_expense,
    45000 + (seq * 1050) + FLOOR(RAND() * 28000) as tax_expense,
    18000 + (seq * 450) + FLOOR(RAND() * 12000) as dividend_payout, -- High Q4 dividend
    320 + (seq * 10) + FLOOR(RAND() * 300) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- Insert batch 7-12: 2024 data (6 batches for 2024)
-- Q1 2024
INSERT INTO FactFinancialPerformance 
(date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id,
 operating_income, expenses, net_income, assets, liabilities, equity, revenue,
 cash_flow, interest_expense, tax_expense, dividend_payout, transaction_count)
SELECT 
    20240315 as date_id, -- March 15, 2024
    (ROW_NUMBER() OVER () % 15) + 1 as branch_id,
    (ROW_NUMBER() OVER () % 20) + 1 as product_id,
    (ROW_NUMBER() OVER () % 50) + 1 as employee_id,
    (ROW_NUMBER() OVER () % 25) + 1 as asset_id,
    (ROW_NUMBER() OVER () % 10) + 1 as customer_segment_id,
    
    -- 2024 - growth trajectory continuing
    1080000 + (seq * 24000) + FLOOR(RAND() * 720000) as operating_income,
    650000 + (seq * 12000) + FLOOR(RAND() * 400000) as expenses,
    385000 + (seq * 11000) + FLOOR(RAND() * 300000) as net_income,
    55000000 + (seq * 720000) + FLOOR(RAND() * 14000000) as assets,
    43000000 + (seq * 570000) + FLOOR(RAND() * 11200000) as liabilities,
    12000000 + (seq * 150000) + FLOOR(RAND() * 2800000) as equity,
    1140000 + (seq * 25000) + FLOOR(RAND() * 760000) as revenue,
    165000 + (seq * 3000) + FLOOR(RAND() * 110000) as cash_flow,
    33000 + (seq * 720) + FLOOR(RAND() * 24000) as interest_expense,
    48000 + (seq * 1100) + FLOOR(RAND() * 30000) as tax_expense,
    15000 + (seq * 375) + FLOOR(RAND() * 10000) as dividend_payout,
    340 + (seq * 11) + FLOOR(RAND() * 320) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- Q4 2024 (December - Latest data)
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
    
    -- 2024 Q4 - achieving profitability targets
    1150000 + (seq * 26000) + FLOOR(RAND() * 780000) as operating_income,
    680000 + (seq * 13000) + FLOOR(RAND() * 420000) as expenses,
    420000 + (seq * 12000) + FLOOR(RAND() * 320000) as net_income,
    58000000 + (seq * 780000) + FLOOR(RAND() * 15000000) as assets,
    45000000 + (seq * 620000) + FLOOR(RAND() * 12000000) as liabilities,
    13000000 + (seq * 160000) + FLOOR(RAND() * 3000000) as equity,
    1220000 + (seq * 27000) + FLOOR(RAND() * 820000) as revenue,
    175000 + (seq * 3200) + FLOOR(RAND() * 120000) as cash_flow,
    35000 + (seq * 780) + FLOOR(RAND() * 26000) as interest_expense,
    52000 + (seq * 1200) + FLOOR(RAND() * 32000) as tax_expense,
    22000 + (seq * 550) + FLOOR(RAND() * 15000) as dividend_payout, -- Strong Q4 2024 dividend
    360 + (seq * 12) + FLOOR(RAND() * 340) as transaction_count
FROM (
    SELECT a.n + b.n * 10 + c.n * 100 as seq
    FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
    CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4) c
    WHERE a.n + b.n * 10 + c.n * 100 < 50
) numbers;

-- ====================================
-- VERIFY FACT DATA GENERATION
-- ====================================

SELECT 
    COUNT(*) as total_fact_records,
    MIN(date_id) as earliest_date,
    MAX(date_id) as latest_date,
    COUNT(DISTINCT branch_id) as unique_branches,
    COUNT(DISTINCT product_id) as unique_products,
    COUNT(DISTINCT customer_segment_id) as unique_segments
FROM FactFinancialPerformance;

-- Summary by year
SELECT 
    LEFT(CAST(date_id AS CHAR), 4) as year,
    COUNT(*) as records_count,
    ROUND(AVG(profit_margin), 4) as avg_profit_margin,
    SUM(revenue) as total_revenue,
    SUM(net_income) as total_profit
FROM FactFinancialPerformance
GROUP BY LEFT(CAST(date_id AS CHAR), 4)
ORDER BY year;

COMMIT;
