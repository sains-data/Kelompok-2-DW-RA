-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- COMPLETE DUMMY DATASET GENERATION
-- Target: 1000+ Realistic Banking Records
-- ====================================

USE germantrust_dw;

-- Disable foreign key checks temporarily for bulk insert
SET FOREIGN_KEY_CHECKS = 0;

-- ====================================
-- 1. CLEAR EXISTING DATA
-- ====================================

TRUNCATE TABLE FactFinancialPerformance;
TRUNCATE TABLE DimAsset;
TRUNCATE TABLE DimEmployee;
TRUNCATE TABLE DimProduct;
TRUNCATE TABLE DimCustomerSegment;
TRUNCATE TABLE DimBranch;
TRUNCATE TABLE DimTime;
TRUNCATE TABLE DimDepartment;

-- ====================================
-- 2. POPULATE DimTime (2022-2025) - 1461 records
-- ====================================

INSERT INTO DimTime (date_id, full_date, day, day_of_week, week_of_year, month, month_name, quarter, year, fiscal_period, is_holiday, is_weekend)
SELECT 
    DATE_FORMAT(date_val, '%Y%m%d') as date_id,
    date_val as full_date,
    DAY(date_val) as day,
    DAYNAME(date_val) as day_of_week,
    WEEK(date_val) as week_of_year,
    MONTH(date_val) as month,
    MONTHNAME(date_val) as month_name,
    QUARTER(date_val) as quarter,
    YEAR(date_val) as year,
    CONCAT('Q', QUARTER(date_val)) as fiscal_period,
    CASE 
        WHEN (MONTH(date_val) = 1 AND DAY(date_val) = 1) OR  -- New Year
             (MONTH(date_val) = 12 AND DAY(date_val) = 25) OR -- Christmas
             (MONTH(date_val) = 12 AND DAY(date_val) = 26) OR -- Boxing Day
             (MONTH(date_val) = 5 AND DAY(date_val) = 1) OR   -- Labor Day
             (MONTH(date_val) = 10 AND DAY(date_val) = 3)     -- German Unity Day
        THEN TRUE ELSE FALSE 
    END as is_holiday,
    CASE WHEN DAYOFWEEK(date_val) IN (1,7) THEN TRUE ELSE FALSE END as is_weekend
FROM (
    SELECT DATE('2022-01-01') + INTERVAL seq.seq DAY as date_val
    FROM (
        SELECT a.n + b.n * 10 + c.n * 100 + d.n * 1000 as seq
        FROM (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) a
        CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) b
        CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) c
        CROSS JOIN (SELECT 0 as n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3) d
    ) seq
    WHERE DATE('2022-01-01') + INTERVAL seq.seq DAY <= '2025-12-31'
) dates;

-- ====================================
-- 3. POPULATE DimDepartment - 12 departments
-- ====================================

INSERT INTO DimDepartment (department_name, department_code, division, budget_allocation, head_count, manager_id, establishment_date, functional_area) VALUES
('Finance & Accounting', 'FIN', 'Corporate Services', 18500000.00, 52, NULL, '2015-01-01', 'Financial Management & Reporting'),
('Risk Management', 'RISK', 'Corporate Services', 15200000.00, 42, NULL, '2015-01-01', 'Credit & Operational Risk Assessment'),
('Treasury & Capital Markets', 'TRCM', 'Corporate Services', 22800000.00, 38, NULL, '2015-01-01', 'Liquidity & Investment Management'),
('Retail Banking Operations', 'RBO', 'Operations', 14500000.00, 145, NULL, '2015-01-01', 'Customer Service & Branch Operations'),
('Corporate Banking', 'CORP', 'Business Development', 19200000.00, 65, NULL, '2015-01-01', 'Corporate Client Relationship'),
('Private Banking & Wealth', 'PBW', 'Business Development', 25600000.00, 48, NULL, '2015-01-01', 'High Net Worth Client Services'),
('Marketing & Digital', 'MKT', 'Business Development', 16800000.00, 58, NULL, '2015-01-01', 'Marketing & Digital Transformation'),
('Information Technology', 'IT', 'Technology', 28500000.00, 95, NULL, '2015-01-01', 'IT Infrastructure & Development'),
('Compliance & Legal', 'COMP', 'Corporate Services', 8900000.00, 35, NULL, '2015-01-01', 'Regulatory Compliance & Legal Affairs'),
('Human Resources', 'HR', 'Corporate Services', 7200000.00, 28, NULL, '2015-01-01', 'Talent Management & Development'),
('Product Development', 'PD', 'Business Development', 12400000.00, 44, NULL, '2015-01-01', 'Financial Product Innovation'),
('Data Analytics & BI', 'ANALYTICS', 'Technology', 11300000.00, 35, NULL, '2015-01-01', 'Business Intelligence & Data Science');

-- ====================================
-- 4. POPULATE DimBranch - 15 branches across Europe
-- ====================================

INSERT INTO DimBranch (branch_name, branch_code, branch_type, address, city, region, country, postal_code, establishment_date, size_category, has_atm, has_safety_deposit, manager_id, operational_cost) VALUES
-- Germany (5 branches)
('Frankfurt am Main HQ', 'DE001', 'Headquarters', 'Taunusanlage 12', 'Frankfurt am Main', 'Hesse', 'Germany', '60325', '2015-01-01', 'Large', TRUE, TRUE, NULL, 3200000.00),
('Berlin Corporate Center', 'DE002', 'Corporate Branch', 'Unter den Linden 21', 'Berlin', 'Berlin', 'Germany', '10117', '2016-03-15', 'Large', TRUE, TRUE, NULL, 2800000.00),
('Munich Business Hub', 'DE003', 'Business Branch', 'Maximilianstraße 35', 'Munich', 'Bavaria', 'Germany', '80539', '2016-06-01', 'Medium', TRUE, TRUE, NULL, 2200000.00),
('Hamburg Commercial', 'DE004', 'Commercial Branch', 'Neuer Wall 46', 'Hamburg', 'Hamburg', 'Germany', '20354', '2017-01-10', 'Medium', TRUE, FALSE, NULL, 1950000.00),
('Düsseldorf Private Banking', 'DE005', 'Private Branch', 'Königsallee 92', 'Düsseldorf', 'North Rhine-Westphalia', 'Germany', '40212', '2018-05-01', 'Medium', TRUE, TRUE, NULL, 2100000.00),

-- United Kingdom (2 branches)
('London City Financial', 'GB001', 'International Branch', '25 Old Broad Street', 'London', 'England', 'United Kingdom', 'EC2N 1HQ', '2018-04-01', 'Large', TRUE, TRUE, NULL, 3500000.00),
('Edinburgh Corporate', 'GB002', 'Corporate Branch', '43 Charlotte Square', 'Edinburgh', 'Scotland', 'United Kingdom', 'EH2 4HQ', '2019-08-15', 'Medium', TRUE, FALSE, NULL, 1800000.00),

-- France (2 branches)
('Paris La Défense', 'FR001', 'Corporate Branch', '20 Place Vendôme', 'Paris', 'Île-de-France', 'France', '75001', '2018-09-15', 'Large', TRUE, TRUE, NULL, 3100000.00),
('Lyon Business Center', 'FR002', 'Business Branch', '47 Rue de la République', 'Lyon', 'Auvergne-Rhône-Alpes', 'France', '69002', '2020-03-01', 'Medium', TRUE, FALSE, NULL, 1700000.00),

-- Netherlands (1 branch)
('Amsterdam Financial District', 'NL001', 'Business Branch', 'Damrak 70', 'Amsterdam', 'North Holland', 'Netherlands', '1012 LM', '2019-02-01', 'Medium', TRUE, TRUE, NULL, 2250000.00),

-- Switzerland (2 branches)
('Zurich Private Banking', 'CH001', 'Private Branch', 'Bahnhofstrasse 45', 'Zurich', 'Zurich', 'Switzerland', '8001', '2019-08-01', 'Large', TRUE, TRUE, NULL, 4200000.00),
('Geneva Wealth Management', 'CH002', 'Private Branch', 'Rue du Rhône 78', 'Geneva', 'Geneva', 'Switzerland', '1204', '2020-11-01', 'Medium', TRUE, TRUE, NULL, 3800000.00),

-- Italy (1 branch)
('Milan Corporate', 'IT001', 'Corporate Branch', 'Via Montenapoleone 8', 'Milan', 'Lombardy', 'Italy', '20121', '2020-01-15', 'Medium', TRUE, TRUE, NULL, 2400000.00),

-- Spain (1 branch)
('Madrid Business', 'ES001', 'Business Branch', 'Paseo de la Castellana 95', 'Madrid', 'Madrid', 'Spain', '28046', '2020-06-01', 'Medium', TRUE, FALSE, NULL, 1900000.00),

-- Austria (1 branch)
('Vienna Corporate', 'AT001', 'Corporate Branch', 'Graben 19', 'Vienna', 'Vienna', 'Austria', '1010', '2021-04-01', 'Medium', TRUE, TRUE, NULL, 2050000.00);

-- ====================================
-- 5. POPULATE DimCustomerSegment - 10 segments
-- ====================================

INSERT INTO DimCustomerSegment (segment_name, segment_description, avg_income_range, avg_age_range, preferred_channel, risk_profile, loyalty_level, profitability_score, acquisition_channel, retention_rate) VALUES
('Ultra High Net Worth', 'Ultra-wealthy individuals and families', '€5M+', '50-70', 'Private Banking', 'Low', 'High', 9.8, 'Referral Network', 98.2),
('High Net Worth Individual', 'Affluent private banking clients', '€1M-5M', '45-65', 'Private Banking', 'Low', 'High', 9.1, 'Relationship Manager', 95.8),
('Mass Affluent Professional', 'High-income professionals', '€150K-1M', '35-55', 'Digital & Branch', 'Low', 'Medium', 7.4, 'Digital Marketing', 87.3),
('Corporate Enterprise', 'Large multinational corporations', '€100M+', 'N/A', 'Relationship Manager', 'Medium', 'High', 8.9, 'Direct Sales', 93.6),
('Mid-Market Corporate', 'Medium-sized business clients', '€10M-100M', 'N/A', 'Business Banking', 'Medium', 'Medium', 7.8, 'Business Development', 82.4),
('Small Business Banking', 'SME companies and startups', '€500K-10M', 'N/A', 'Digital Banking', 'Medium', 'Medium', 6.5, 'Online Channel', 76.9),
('Young Professionals', 'High-potential young professionals', '€50K-150K', '25-40', 'Mobile Banking', 'Medium', 'Medium', 6.8, 'Social Media', 78.5),
('Retail Premium', 'Mass market premium customers', '€75K-150K', '30-60', 'Branch & Digital', 'Low', 'Medium', 6.2, 'Branch Network', 81.7),
('International Expats', 'Non-resident international clients', '€200K+', '35-55', 'International Banking', 'Medium', 'Medium', 7.6, 'Partner Network', 84.3),
('Institutional Clients', 'Pension funds, insurance companies', '€500M+', 'N/A', 'Institutional Sales', 'Low', 'High', 9.4, 'Direct Institutional', 96.5);

-- ====================================
-- 6. POPULATE DimProduct - 20 products
-- ====================================

INSERT INTO DimProduct (product_name, product_code, product_category, product_subcategory, product_type, interest_rate, fee_structure, min_balance, is_active, launch_date, department_owner, risk_level, currency) VALUES
-- Banking Products
('Premium Current Account', 'PCA001', 'Banking', 'Current Accounts', 'Deposit', 0.25, 'Monthly fee €25, free transactions', 25000.00, TRUE, '2015-01-01', 4, 'Low', 'EUR'),
('Business Current Account', 'BCA001', 'Banking', 'Current Accounts', 'Deposit', 0.15, 'Monthly fee €45, transaction fees apply', 10000.00, TRUE, '2015-01-01', 5, 'Low', 'EUR'),
('High Yield Savings', 'HYS001', 'Banking', 'Savings Accounts', 'Deposit', 2.15, 'No monthly fee, minimum balance required', 5000.00, TRUE, '2015-01-01', 4, 'Low', 'EUR'),
('Digital Savings Plus', 'DSP001', 'Banking', 'Savings Accounts', 'Deposit', 1.85, 'No fees, online only', 1000.00, TRUE, '2020-01-01', 4, 'Low', 'EUR'),

-- Lending Products  
('Personal Loan Standard', 'PLS001', 'Lending', 'Personal Loans', 'Credit', 5.25, 'Setup fee €250, no prepayment penalty', 5000.00, TRUE, '2015-01-01', 4, 'Medium', 'EUR'),
('Mortgage Prime', 'MOP001', 'Lending', 'Mortgages', 'Credit', 2.75, 'Setup fee €2000, appraisal fee €500', 100000.00, TRUE, '2015-01-01', 4, 'Low', 'EUR'),
('Business Term Loan', 'BTL001', 'Lending', 'Business Loans', 'Credit', 4.50, 'Setup fee €5000, quarterly review', 50000.00, TRUE, '2015-01-01', 5, 'Medium', 'EUR'),
('Corporate Credit Line', 'CCL001', 'Lending', 'Credit Lines', 'Credit', 3.85, 'Commitment fee 0.5%, usage-based pricing', 500000.00, TRUE, '2016-01-01', 5, 'Medium', 'EUR'),

-- Investment Products
('Balanced Portfolio Fund', 'BPF001', 'Investment', 'Mutual Funds', 'Investment', NULL, 'Management fee 1.2% p.a.', 25000.00, TRUE, '2015-01-01', 6, 'Medium', 'EUR'),
('Growth Equity Fund', 'GEF001', 'Investment', 'Mutual Funds', 'Investment', NULL, 'Management fee 1.8% p.a.', 50000.00, TRUE, '2016-01-01', 6, 'High', 'EUR'),
('Fixed Income Portfolio', 'FIP001', 'Investment', 'Fixed Income', 'Investment', 3.25, 'Management fee 0.8% p.a.', 100000.00, TRUE, '2015-01-01', 6, 'Low', 'EUR'),
('Private Equity Access', 'PEA001', 'Investment', 'Alternative Investments', 'Investment', NULL, 'Management fee 2.0%, performance fee 20%', 1000000.00, TRUE, '2018-01-01', 6, 'High', 'EUR'),

-- Trading Products
('FX Trading Platform', 'FXT001', 'Trading', 'Foreign Exchange', 'Trading', NULL, 'Spread-based pricing, 0.1-0.3%', 10000.00, TRUE, '2015-01-01', 3, 'High', 'EUR'),
('Commodities Trading', 'CMT001', 'Trading', 'Commodities', 'Trading', NULL, 'Commission €15 per trade', 25000.00, TRUE, '2017-01-01', 3, 'High', 'EUR'),
('Securities Trading', 'SET001', 'Trading', 'Equities', 'Trading', NULL, 'Commission 0.25% min €25', 15000.00, TRUE, '2015-01-01', 3, 'High', 'EUR'),

-- Specialized Services
('Trade Finance Services', 'TFS001', 'Trade Finance', 'Import/Export', 'Service', 4.75, 'Variable fees based on transaction', 100000.00, TRUE, '2016-01-01', 5, 'Medium', 'EUR'),
('Cash Management', 'CMS001', 'Treasury Services', 'Cash Management', 'Service', NULL, 'Monthly fee €150, transaction fees', 250000.00, TRUE, '2015-01-01', 3, 'Low', 'EUR'),
('Custody Services', 'CUS001', 'Custody', 'Asset Custody', 'Service', NULL, 'Fee 0.15% p.a. on assets under custody', 500000.00, TRUE, '2015-01-01', 3, 'Low', 'EUR'),

-- Digital/Innovation Products
('Digital Investment Advisor', 'DIA001', 'Digital Services', 'Robo-Advisory', 'Investment', NULL, 'Management fee 0.5% p.a.', 5000.00, TRUE, '2021-01-01', 7, 'Medium', 'EUR'),
('Cryptocurrency Trading', 'CRT001', 'Digital Services', 'Digital Assets', 'Trading', NULL, 'Trading fee 0.75% per transaction', 1000.00, TRUE, '2022-01-01', 7, 'High', 'EUR');
