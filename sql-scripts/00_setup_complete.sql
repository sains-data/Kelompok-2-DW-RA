-- filepath: m:\ITERA\Semester 6\Pergudangan Data\Tugas\Misi4\sql-scripts\00_setup_complete.sql
-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- COMPLETE SETUP SCRIPT
-- ====================================

-- This script will execute all setup scripts in the correct order
-- Use this for complete database initialization

-- Step 1: Create database and tables
SOURCE sql-scripts/01_create_tables.sql;

-- Step 2: Insert dimension data (part 1)
SOURCE sql-scripts/02_insert_sample_data_part1.sql;

-- Step 3: Insert dimension data (part 2) + employees and assets
SOURCE sql-scripts/02_insert_sample_data_part2.sql;

-- Step 4: Generate initial fact table data
SOURCE sql-scripts/03_generate_fact_data.sql;

-- Step 5: Add additional fact data to reach 1000+ records
SOURCE sql-scripts/04_additional_fact_data.sql;

-- Step 6: Create advanced analytics views and procedures
SOURCE sql-scripts/06_advanced_analytics.sql;

-- ====================================
-- SETUP VERIFICATION
-- ====================================

-- Verify database setup
SELECT 'SETUP VERIFICATION' as status;

-- Check all tables exist and have data
SELECT 'Table Verification' as check_type;
SELECT 'FactFinancialPerformance' as table_name, COUNT(*) as record_count FROM FactFinancialPerformance
UNION ALL
SELECT 'DimTime', COUNT(*) FROM DimTime
UNION ALL
SELECT 'DimBranch', COUNT(*) FROM DimBranch
UNION ALL
SELECT 'DimProduct', COUNT(*) FROM DimProduct
UNION ALL
SELECT 'DimEmployee', COUNT(*) FROM DimEmployee
UNION ALL
SELECT 'DimAsset', COUNT(*) FROM DimAsset
UNION ALL
SELECT 'DimCustomerSegment', COUNT(*) FROM DimCustomerSegment
UNION ALL
SELECT 'DimDepartment', COUNT(*) FROM DimDepartment;

-- Check views exist
SELECT 'Views Created' as check_type;
SHOW TABLES LIKE 'vw_%';

-- Check procedures exist
SELECT 'Procedures Created' as check_type;
SHOW PROCEDURE STATUS WHERE Db = 'germantrust_dw';

-- Sample data verification
SELECT 'Sample Data Check' as check_type;
SELECT 
    'Fact Table Date Range' as metric,
    MIN(date_id) as min_date,
    MAX(date_id) as max_date,
    COUNT(DISTINCT date_id) as unique_dates
FROM FactFinancialPerformance;

-- Financial summary
SELECT 'Financial Summary' as check_type;
SELECT 
    ROUND(SUM(revenue) / 1000000, 2) as total_revenue_millions,
    ROUND(SUM(net_income) / 1000000, 2) as total_net_income_millions,
    ROUND(AVG(profit_margin) * 100, 2) as avg_profit_margin_percent,
    COUNT(DISTINCT branch_id) as active_branches,
    COUNT(DISTINCT product_id) as active_products
FROM FactFinancialPerformance;

SELECT 'DATABASE SETUP COMPLETED SUCCESSFULLY!' as final_status;
