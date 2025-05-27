-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- PART 2: EMPLOYEE, ASSET, AND FACT DATA
-- ====================================

USE germantrust_dw;

-- ====================================
-- 7. POPULATE DimEmployee - 50 employees
-- ====================================

INSERT INTO DimEmployee (employee_name, employee_code, employee_category, position, department_id, hire_date, manager_id, is_manager, employment_status, education_level, salary_band, performance_rating) VALUES
-- Department Heads & Senior Management
('Klaus Weber', 'EMP001', 'Executive', 'Chief Financial Officer', 1, '2015-01-01', NULL, TRUE, 'Active', 'MBA Finance', 'Executive', 'Excellent'),
('Anna Schmidt', 'EMP002', 'Executive', 'Chief Risk Officer', 2, '2015-02-01', NULL, TRUE, 'Active', 'PhD Economics', 'Executive', 'Excellent'),
('Hans Mueller', 'EMP003', 'Executive', 'Treasury Director', 3, '2015-03-01', NULL, TRUE, 'Active', 'CFA, Masters Finance', 'Executive', 'Good'),
('Maria Braun', 'EMP004', 'Senior Manager', 'Head of Retail Operations', 4, '2015-04-01', NULL, TRUE, 'Active', 'MBA Business', 'Senior', 'Excellent'),
('Thomas Fischer', 'EMP005', 'Senior Manager', 'Corporate Banking Director', 5, '2015-05-01', NULL, TRUE, 'Active', 'MBA Finance', 'Senior', 'Good'),

-- Mid-Level Management
('Sarah Johnson', 'EMP006', 'Manager', 'IT Systems Manager', 8, '2016-01-01', NULL, TRUE, 'Active', 'Masters Computer Science', 'Senior', 'Excellent'),
('Michael Brown', 'EMP007', 'Manager', 'Compliance Manager', 9, '2016-02-01', NULL, TRUE, 'Active', 'Masters Law', 'Senior', 'Good'),
('Lisa Anderson', 'EMP008', 'Manager', 'Product Manager', 11, '2016-03-01', 5, TRUE, 'Active', 'MBA Marketing', 'Senior', 'Good'),
('David Wilson', 'EMP009', 'Senior Analyst', 'Senior Data Scientist', 12, '2018-01-01', NULL, FALSE, 'Active', 'PhD Statistics', 'Senior', 'Excellent'),
('Emma Davis', 'EMP010', 'Manager', 'HR Manager', 10, '2017-01-01', NULL, TRUE, 'Active', 'Masters HR Management', 'Senior', 'Good'),

-- Senior Staff
('Roberto Silva', 'EMP011', 'Senior Specialist', 'Senior Investment Advisor', 6, '2017-06-01', NULL, FALSE, 'Active', 'CFA, Bachelors Finance', 'Senior', 'Excellent'),
('Catherine Martin', 'EMP012', 'Senior Analyst', 'Senior Risk Analyst', 2, '2018-03-01', 2, FALSE, 'Active', 'Masters Statistics', 'Senior', 'Good'),
('Alexander Petrov', 'EMP013', 'Senior Specialist', 'Senior Relationship Manager', 5, '2017-09-01', 5, FALSE, 'Active', 'MBA Finance', 'Senior', 'Excellent'),
('Sophie Laurent', 'EMP014', 'Senior Analyst', 'Senior Financial Analyst', 1, '2018-05-01', 1, FALSE, 'Active', 'CPA, Masters Accounting', 'Senior', 'Good'),
('Jan van der Berg', 'EMP015', 'Senior Specialist', 'Private Banking Advisor', 6, '2019-01-01', NULL, FALSE, 'Active', 'Bachelors Economics', 'Senior', 'Excellent'),

-- Mid-Level Staff
('Elena Rodriguez', 'EMP016', 'Analyst', 'Financial Analyst', 1, '2019-04-01', 1, FALSE, 'Active', 'Masters Finance', 'Middle', 'Good'),
('James Thompson', 'EMP017', 'Specialist', 'Business Analyst', 4, '2019-07-01', 4, FALSE, 'Active', 'Bachelors Business', 'Middle', 'Good'),
('Yuki Tanaka', 'EMP018', 'Analyst', 'Quantitative Analyst', 12, '2020-01-01', 9, FALSE, 'Active', 'Masters Mathematics', 'Middle', 'Excellent'),
('Isabella Romano', 'EMP019', 'Specialist', 'Marketing Specialist', 7, '2020-03-01', NULL, FALSE, 'Active', 'Bachelors Marketing', 'Middle', 'Good'),
('Erik Larsson', 'EMP020', 'Analyst', 'Credit Analyst', 2, '2020-06-01', 2, FALSE, 'Active', 'Bachelors Economics', 'Middle', 'Good'),

-- Junior Staff & Recent Hires
('Priya Sharma', 'EMP021', 'Junior Analyst', 'Junior Data Analyst', 12, '2021-09-01', 9, FALSE, 'Active', 'Bachelors Statistics', 'Junior', 'Good'),
('Lucas Dubois', 'EMP022', 'Associate', 'Treasury Associate', 3, '2021-11-01', 3, FALSE, 'Active', 'Bachelors Finance', 'Junior', 'Good'),
('Amara Okafor', 'EMP023', 'Associate', 'Operations Associate', 4, '2022-01-01', 4, FALSE, 'Active', 'Bachelors Business', 'Junior', 'Excellent'),
('Chen Wei', 'EMP024', 'Developer', 'Software Developer', 8, '2022-03-01', 6, FALSE, 'Active', 'Bachelors Computer Science', 'Middle', 'Good'),
('Fatima Al-Zahra', 'EMP025', 'Associate', 'Client Associate', 6, '2022-05-01', 15, FALSE, 'Active', 'Bachelors Economics', 'Junior', 'Good'),

-- Additional Staff for Volume
('Oliver Kowalski', 'EMP026', 'Specialist', 'Loan Officer', 4, '2019-08-01', 4, FALSE, 'Active', 'Bachelors Finance', 'Middle', 'Good'),
('Nina Popovic', 'EMP027', 'Analyst', 'Investment Analyst', 6, '2020-02-01', 11, FALSE, 'Active', 'Masters Finance', 'Middle', 'Excellent'),
('Ahmed Hassan', 'EMP028', 'Associate', 'Trade Finance Associate', 5, '2021-04-01', 5, FALSE, 'Active', 'Bachelors International Business', 'Junior', 'Good'),
('Ingrid Nilsson', 'EMP029', 'Specialist', 'Digital Banking Specialist', 7, '2020-09-01', NULL, FALSE, 'Active', 'Bachelors Information Systems', 'Middle', 'Excellent'),
('Marco Bianchi', 'EMP030', 'Analyst', 'Performance Analyst', 12, '2021-07-01', 9, FALSE, 'Active', 'Masters Business Analytics', 'Middle', 'Good'),

-- Branch Staff
('Helen McGrath', 'EMP031', 'Manager', 'London Branch Manager', 4, '2018-04-01', 4, TRUE, 'Active', 'MBA Management', 'Senior', 'Good'),
('Pierre Dubois', 'EMP032', 'Manager', 'Paris Branch Manager', 4, '2018-09-01', 4, TRUE, 'Active', 'Masters Business', 'Senior', 'Good'),
('Gerhard Hoffman', 'EMP033', 'Senior Specialist', 'Munich Relationship Manager', 5, '2017-12-01', 5, FALSE, 'Active', 'Bachelors Economics', 'Senior', 'Excellent'),
('Claudia Rossi', 'EMP034', 'Specialist', 'Milan Client Advisor', 6, '2020-08-01', 15, FALSE, 'Active', 'Bachelors Finance', 'Middle', 'Good'),
('Hans Zimmermann', 'EMP035', 'Associate', 'Hamburg Operations Associate', 4, '2021-03-01', 31, FALSE, 'Active', 'Bachelors Business', 'Junior', 'Good'),

-- Technology & Analytics Staff
('Raj Patel', 'EMP036', 'Senior Developer', 'Senior Software Engineer', 8, '2018-06-01', 6, FALSE, 'Active', 'Masters Computer Science', 'Senior', 'Excellent'),
('Anna Kowalczyk', 'EMP037', 'Analyst', 'Business Intelligence Analyst', 12, '2019-05-01', 9, FALSE, 'Active', 'Masters Data Science', 'Middle', 'Good'),
('Carlos Mendez', 'EMP038', 'Specialist', 'Cybersecurity Specialist', 8, '2020-07-01', 6, FALSE, 'Active', 'Masters Cybersecurity', 'Senior', 'Excellent'),
('Leila Abdel', 'EMP039', 'Analyst', 'Regulatory Analyst', 9, '2021-02-01', 7, FALSE, 'Active', 'Masters Compliance', 'Middle', 'Good'),
('Viktor Petrov', 'EMP040', 'Associate', 'Junior Developer', 8, '2022-08-01', 36, FALSE, 'Active', 'Bachelors Computer Science', 'Junior', 'Good'),

-- Additional Support Staff
('Grace O\'Connor', 'EMP041', 'Coordinator', 'Executive Assistant', 1, '2020-11-01', 1, FALSE, 'Active', 'Bachelors Administration', 'Junior', 'Good'),
('Mohammed Al-Ahmad', 'EMP042', 'Associate', 'Accounting Associate', 1, '2021-12-01', 14, FALSE, 'Active', 'Bachelors Accounting', 'Junior', 'Good'),
('Bianca Santos', 'EMP043', 'Specialist', 'Customer Service Specialist', 4, '2020-04-01', 4, FALSE, 'Active', 'Bachelors Communication', 'Middle', 'Good'),
('Dmitri Volkov', 'EMP044', 'Analyst', 'Market Research Analyst', 7, '2021-08-01', 19, FALSE, 'Active', 'Masters Marketing', 'Middle', 'Good'),
('Aisha Kone', 'EMP045', 'Associate', 'HR Associate', 10, '2022-06-01', 10, FALSE, 'Active', 'Bachelors Psychology', 'Junior', 'Good'),

-- Recent Graduate Hires
('Max Richter', 'EMP046', 'Trainee', 'Management Trainee', 1, '2023-09-01', 1, FALSE, 'Active', 'Masters Finance', 'Trainee', 'Good'),
('Sofia Andersson', 'EMP047', 'Trainee', 'Analytics Trainee', 12, '2023-09-01', 9, FALSE, 'Active', 'Bachelors Data Science', 'Trainee', 'Good'),
('Jules Moreau', 'EMP048', 'Trainee', 'Banking Trainee', 4, '2024-01-01', 4, FALSE, 'Active', 'Masters Banking', 'Trainee', 'Good'),
('Zara Khan', 'EMP049', 'Trainee', 'Technology Trainee', 8, '2024-02-01', 6, FALSE, 'Active', 'Bachelors IT', 'Trainee', 'Good'),
('Leon Fischer', 'EMP050', 'Trainee', 'Risk Trainee', 2, '2024-03-01', 2, FALSE, 'Active', 'Masters Risk Management', 'Trainee', 'Good');

-- Update manager references after all employees are inserted
UPDATE DimEmployee SET manager_id = 1 WHERE employee_id IN (14, 16, 41, 42, 46);
UPDATE DimEmployee SET manager_id = 2 WHERE employee_id IN (12, 20, 50);
UPDATE DimEmployee SET manager_id = 3 WHERE employee_id = 22;
UPDATE DimEmployee SET manager_id = 4 WHERE employee_id IN (17, 23, 26, 31, 32, 35, 43, 48);
UPDATE DimEmployee SET manager_id = 5 WHERE employee_id IN (8, 13, 28, 33);
UPDATE DimEmployee SET manager_id = 6 WHERE employee_id IN (24, 36, 38, 40, 49);
UPDATE DimEmployee SET manager_id = 9 WHERE employee_id IN (18, 21, 30, 37, 47);
UPDATE DimEmployee SET manager_id = 10 WHERE employee_id = 45;
UPDATE DimEmployee SET manager_id = 11 WHERE employee_id = 27;
UPDATE DimEmployee SET manager_id = 15 WHERE employee_id IN (25, 34);
UPDATE DimEmployee SET manager_id = 19 WHERE employee_id = 44;

-- ====================================
-- 8. POPULATE DimAsset - 25 assets
-- ====================================

INSERT INTO DimAsset (asset_name, asset_type, asset_category, acquisition_date, acquisition_cost, current_value, depreciation_method, useful_life, residual_value, location_id, is_liquid, risk_rating) VALUES
-- Real Estate Assets
('Frankfurt HQ Building', 'Real Estate', 'Commercial Property', '2015-01-01', 85000000.00, 95000000.00, 'Straight Line', 50, 15000000.00, 1, FALSE, 'Low'),
('London Office Tower', 'Real Estate', 'Commercial Property', '2018-04-01', 120000000.00, 135000000.00, 'Straight Line', 50, 20000000.00, 6, FALSE, 'Low'),
('Paris Branch Building', 'Real Estate', 'Commercial Property', '2018-09-01', 75000000.00, 82000000.00, 'Straight Line', 50, 12000000.00, 8, FALSE, 'Low'),
('Zurich Private Banking Center', 'Real Estate', 'Commercial Property', '2019-08-01', 95000000.00, 108000000.00, 'Straight Line', 50, 18000000.00, 11, FALSE, 'Low'),
('Munich Business Center', 'Real Estate', 'Commercial Property', '2016-06-01', 45000000.00, 52000000.00, 'Straight Line', 50, 8000000.00, 3, FALSE, 'Low'),

-- Securities & Investment Assets
('German Government Bonds', 'Securities', 'Government Bonds', '2015-01-01', 200000000.00, 198000000.00, 'Market Value', 10, 200000000.00, 1, TRUE, 'Low'),
('European Corporate Bonds', 'Securities', 'Corporate Bonds', '2016-01-01', 150000000.00, 155000000.00, 'Market Value', 8, 145000000.00, 1, TRUE, 'Low'),
('Blue Chip Equity Portfolio', 'Securities', 'Equity Securities', '2015-01-01', 300000000.00, 385000000.00, 'Market Value', 0, 0.00, 1, TRUE, 'Medium'),
('Emerging Markets Fund', 'Securities', 'Equity Securities', '2017-01-01', 75000000.00, 82000000.00, 'Market Value', 0, 0.00, 1, TRUE, 'High'),
('Real Estate Investment Trust', 'Securities', 'REIT Securities', '2018-01-01', 50000000.00, 58000000.00, 'Market Value', 0, 0.00, 1, TRUE, 'Medium'),

-- Loan Portfolios
('Prime Mortgage Portfolio', 'Loans', 'Mortgage Loans', '2015-01-01', 800000000.00, 785000000.00, 'Provision Based', 30, 700000000.00, 1, FALSE, 'Low'),
('Corporate Loan Portfolio', 'Loans', 'Commercial Loans', '2015-01-01', 600000000.00, 580000000.00, 'Provision Based', 7, 550000000.00, 1, FALSE, 'Medium'),
('SME Lending Portfolio', 'Loans', 'SME Loans', '2016-01-01', 250000000.00, 245000000.00, 'Provision Based', 5, 220000000.00, 1, FALSE, 'Medium'),
('Personal Loan Portfolio', 'Loans', 'Consumer Loans', '2015-01-01', 150000000.00, 142000000.00, 'Provision Based', 5, 130000000.00, 1, FALSE, 'Medium'),
('Trade Finance Portfolio', 'Loans', 'Trade Finance', '2016-01-01', 180000000.00, 175000000.00, 'Provision Based', 2, 170000000.00, 1, FALSE, 'Medium'),

-- Technology & Equipment
('Core Banking System', 'Technology', 'IT Infrastructure', '2020-01-01', 45000000.00, 35000000.00, 'Accelerated', 7, 5000000.00, 1, FALSE, 'Medium'),
('Trading Platform Technology', 'Technology', 'Trading Systems', '2019-01-01', 25000000.00, 18000000.00, 'Accelerated', 5, 3000000.00, 1, FALSE, 'Medium'),
('Data Center Infrastructure', 'Technology', 'IT Infrastructure', '2018-01-01', 35000000.00, 25000000.00, 'Accelerated', 10, 5000000.00, 1, FALSE, 'Medium'),
('Branch Technology Network', 'Technology', 'IT Equipment', '2017-01-01', 18000000.00, 12000000.00, 'Accelerated', 5, 2000000.00, 1, FALSE, 'Medium'),
('Cybersecurity Infrastructure', 'Technology', 'Security Systems', '2021-01-01', 15000000.00, 13000000.00, 'Accelerated', 5, 2000000.00, 1, FALSE, 'High'),

-- Liquid Assets
('Cash and Cash Equivalents', 'Cash', 'Liquid Assets', '2015-01-01', 2000000000.00, 2000000000.00, 'None', 0, 2000000000.00, 1, TRUE, 'Low'),
('Money Market Instruments', 'Securities', 'Money Market', '2015-01-01', 500000000.00, 502000000.00, 'Market Value', 1, 500000000.00, 1, TRUE, 'Low'),
('Treasury Bills Portfolio', 'Securities', 'Government Securities', '2015-01-01', 300000000.00, 298000000.00, 'Market Value', 1, 300000000.00, 1, TRUE, 'Low'),

-- Alternative Investments
('Private Equity Fund', 'Alternative', 'Private Equity', '2018-01-01', 100000000.00, 125000000.00, 'Market Value', 10, 80000000.00, 1, FALSE, 'High'),
('Hedge Fund Portfolio', 'Alternative', 'Hedge Funds', '2019-01-01', 75000000.00, 82000000.00, 'Market Value', 5, 70000000.00, 1, FALSE, 'High'),
('Commodity Investments', 'Alternative', 'Commodities', '2020-01-01', 50000000.00, 48000000.00, 'Market Value', 3, 45000000.00, 1, FALSE, 'High');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ====================================
-- 9. VERIFY DATA GENERATION
-- ====================================

-- Check record counts
SELECT 'DimTime' as table_name, COUNT(*) as record_count FROM DimTime
UNION ALL
SELECT 'DimDepartment', COUNT(*) FROM DimDepartment
UNION ALL
SELECT 'DimBranch', COUNT(*) FROM DimBranch
UNION ALL
SELECT 'DimCustomerSegment', COUNT(*) FROM DimCustomerSegment
UNION ALL
SELECT 'DimProduct', COUNT(*) FROM DimProduct
UNION ALL
SELECT 'DimEmployee', COUNT(*) FROM DimEmployee
UNION ALL
SELECT 'DimAsset', COUNT(*) FROM DimAsset;

COMMIT;
