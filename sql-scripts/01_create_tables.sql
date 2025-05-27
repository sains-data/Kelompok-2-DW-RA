-- ====================================
-- GERMANTRUST BANK DATA WAREHOUSE
-- Misi 4: Implementasi Database Schema
-- ====================================

USE germantrust_dw;

-- Drop tables if exist (in correct order)
DROP TABLE IF EXISTS FactFinancialPerformance;
DROP TABLE IF EXISTS DimAsset;
DROP TABLE IF EXISTS DimEmployee;
DROP TABLE IF EXISTS DimProduct;
DROP TABLE IF EXISTS DimCustomerSegment;
DROP TABLE IF EXISTS DimBranch;
DROP TABLE IF EXISTS DimTime;
DROP TABLE IF EXISTS DimDepartment;

-- ====================================
-- DIMENSION TABLES
-- ====================================

-- 1. DimTime - Dimensi Waktu
CREATE TABLE DimTime (
    date_id INT NOT NULL PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT NOT NULL,
    day_of_week VARCHAR(10) NOT NULL,
    week_of_year INT NOT NULL,
    month INT NOT NULL,
    month_name VARCHAR(10) NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL,
    fiscal_period VARCHAR(10) NOT NULL,
    is_holiday BOOLEAN NOT NULL DEFAULT FALSE,
    is_weekend BOOLEAN NOT NULL DEFAULT FALSE,
    INDEX idx_time_year_month (year, month),
    INDEX idx_time_quarter (quarter),
    INDEX idx_time_fiscal_period (fiscal_period)
);

-- 2. DimDepartment - Dimensi Departemen
CREATE TABLE DimDepartment (
    department_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    department_code VARCHAR(20) NOT NULL UNIQUE,
    division VARCHAR(100) NOT NULL,
    budget_allocation DECIMAL(18,2) NOT NULL,
    head_count INT NOT NULL,
    manager_id INT NULL,
    establishment_date DATE NOT NULL,
    functional_area VARCHAR(100) NOT NULL
);

-- 3. DimBranch - Dimensi Cabang
CREATE TABLE DimBranch (
    branch_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    branch_code VARCHAR(20) NOT NULL UNIQUE,
    branch_type VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL,
    postal_code VARCHAR(20) NOT NULL,
    establishment_date DATE NOT NULL,
    size_category VARCHAR(20) NOT NULL,
    has_atm BOOLEAN NOT NULL DEFAULT FALSE,
    has_safety_deposit BOOLEAN NOT NULL DEFAULT FALSE,
    manager_id INT NULL,
    operational_cost DECIMAL(18,2) NOT NULL,
    INDEX idx_branch_country_region (country, region),
    INDEX idx_branch_type (branch_type),
    INDEX idx_branch_manager_id (manager_id)
);

-- 4. DimProduct - Dimensi Produk
CREATE TABLE DimProduct (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_code VARCHAR(20) NOT NULL UNIQUE,
    product_category VARCHAR(50) NOT NULL,
    product_subcategory VARCHAR(50) NOT NULL,
    product_type VARCHAR(50) NOT NULL,
    interest_rate DECIMAL(5,2) NULL,
    fee_structure TEXT NULL,
    min_balance DECIMAL(18,2) NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    launch_date DATE NOT NULL,
    department_owner INT NOT NULL,
    risk_level VARCHAR(20) NOT NULL,
    currency VARCHAR(10) NOT NULL DEFAULT 'EUR',
    INDEX idx_product_category (product_category, product_subcategory),
    INDEX idx_product_dept_owner (department_owner),
    INDEX idx_product_risk_level (risk_level),
    FOREIGN KEY (department_owner) REFERENCES DimDepartment(department_id)
);

-- 5. DimEmployee - Dimensi Karyawan
CREATE TABLE DimEmployee (
    employee_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_code VARCHAR(20) NOT NULL UNIQUE,
    employee_category VARCHAR(50) NOT NULL,
    position VARCHAR(100) NOT NULL,
    department_id INT NOT NULL,
    hire_date DATE NOT NULL,
    manager_id INT NULL,
    is_manager BOOLEAN NOT NULL DEFAULT FALSE,
    employment_status VARCHAR(50) NOT NULL,
    education_level VARCHAR(50) NOT NULL,
    salary_band VARCHAR(20) NOT NULL,
    performance_rating VARCHAR(20) NOT NULL,
    FOREIGN KEY (department_id) REFERENCES DimDepartment(department_id),
    FOREIGN KEY (manager_id) REFERENCES DimEmployee(employee_id)
);

-- 6. DimAsset - Dimensi Aset
CREATE TABLE DimAsset (
    asset_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    asset_name VARCHAR(100) NOT NULL,
    asset_type VARCHAR(50) NOT NULL,
    asset_category VARCHAR(50) NOT NULL,
    acquisition_date DATE NOT NULL,
    acquisition_cost DECIMAL(18,2) NOT NULL,
    current_value DECIMAL(18,2) NOT NULL,
    depreciation_method VARCHAR(50) NOT NULL,
    useful_life INT NOT NULL,
    residual_value DECIMAL(18,2) NOT NULL,
    location_id INT NOT NULL,
    is_liquid BOOLEAN NOT NULL DEFAULT TRUE,
    risk_rating VARCHAR(20) NOT NULL,
    FOREIGN KEY (location_id) REFERENCES DimBranch(branch_id)
);

-- 7. DimCustomerSegment - Dimensi Segmentasi Nasabah
CREATE TABLE DimCustomerSegment (
    customer_segment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    segment_name VARCHAR(50) NOT NULL,
    segment_description VARCHAR(255) NOT NULL,
    avg_income_range VARCHAR(50) NOT NULL,
    avg_age_range VARCHAR(20) NOT NULL,
    preferred_channel VARCHAR(50) NOT NULL,
    risk_profile VARCHAR(20) NOT NULL,
    loyalty_level VARCHAR(20) NOT NULL,
    profitability_score DECIMAL(5,2) NOT NULL,
    acquisition_channel VARCHAR(50) NOT NULL,
    retention_rate DECIMAL(5,2) NOT NULL,
    INDEX idx_customersegment_risk (risk_profile),
    INDEX idx_customersegment_profitability (profitability_score)
);

-- ====================================
-- FACT TABLE
-- ====================================

-- FactFinancialPerformance - Tabel Fakta Kinerja Keuangan
CREATE TABLE FactFinancialPerformance (
    performance_id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    date_id INT NOT NULL,
    branch_id INT NOT NULL,
    product_id INT NOT NULL,
    employee_id INT NOT NULL,
    asset_id INT NOT NULL,
    customer_segment_id INT NOT NULL,
    
    -- Metrik Keuangan
    operating_income DECIMAL(18,2) NOT NULL,
    expenses DECIMAL(18,2) NOT NULL,
    net_income DECIMAL(18,2) NOT NULL,
    assets DECIMAL(18,2) NOT NULL,
    liabilities DECIMAL(18,2) NOT NULL,
    equity DECIMAL(18,2) NOT NULL,
    revenue DECIMAL(18,2) NOT NULL,
    cash_flow DECIMAL(18,2) NOT NULL,
    interest_expense DECIMAL(18,2) NOT NULL,
    tax_expense DECIMAL(18,2) NOT NULL,
    dividend_payout DECIMAL(18,2) NOT NULL,
    transaction_count INT NOT NULL,
    
    -- Rasio Keuangan (calculated fields)
    debt_to_equity DECIMAL(10,4) GENERATED ALWAYS AS (
        CASE WHEN equity != 0 THEN liabilities / equity ELSE 0 END
    ) STORED,
    roa DECIMAL(10,4) GENERATED ALWAYS AS (
        CASE WHEN assets != 0 THEN net_income / assets ELSE 0 END
    ) STORED,
    profit_margin DECIMAL(10,4) GENERATED ALWAYS AS (
        CASE WHEN revenue != 0 THEN net_income / revenue ELSE 0 END
    ) STORED,
    cost_to_income_ratio DECIMAL(10,4) GENERATED ALWAYS AS (
        CASE WHEN operating_income != 0 THEN expenses / operating_income ELSE 0 END
    ) STORED,
    
    -- Foreign Keys
    FOREIGN KEY (date_id) REFERENCES DimTime(date_id),
    FOREIGN KEY (branch_id) REFERENCES DimBranch(branch_id),
    FOREIGN KEY (product_id) REFERENCES DimProduct(product_id),
    FOREIGN KEY (employee_id) REFERENCES DimEmployee(employee_id),
    FOREIGN KEY (asset_id) REFERENCES DimAsset(asset_id),
    FOREIGN KEY (customer_segment_id) REFERENCES DimCustomerSegment(customer_segment_id),
    
    -- Indexes for performance
    INDEX idx_fact_date_id (date_id),
    INDEX idx_fact_branch_id (branch_id),
    INDEX idx_fact_product_id (product_id),
    INDEX idx_fact_segment_id (customer_segment_id),
    INDEX idx_fact_date_branch (date_id, branch_id),
    INDEX idx_fact_date_product (date_id, product_id),
    INDEX idx_fact_date_segment (date_id, customer_segment_id)
);

-- ====================================
-- VIEWS FOR ANALYSIS
-- ====================================

-- View untuk Profitabilitas per Cabang
CREATE VIEW vw_branch_profitability AS
SELECT 
    b.branch_id,
    b.branch_name,
    b.city,
    b.region,
    b.country,
    t.year,
    t.quarter,
    SUM(f.revenue) AS total_revenue,
    SUM(f.expenses) AS total_expenses,
    SUM(f.net_income) AS total_profit,
    AVG(f.profit_margin) AS avg_profit_margin,
    SUM(f.transaction_count) AS transaction_volume
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
JOIN DimTime t ON f.date_id = t.date_id
GROUP BY b.branch_id, b.branch_name, b.city, b.region, b.country, t.year, t.quarter;

-- View untuk Analisis Produk
CREATE VIEW vw_product_performance AS
SELECT 
    p.product_category,
    p.product_subcategory,
    p.product_name,
    t.year,
    t.quarter,
    SUM(f.revenue) AS total_revenue,
    SUM(f.net_income) AS total_profit,
    AVG(f.profit_margin) AS avg_profit_margin,
    SUM(f.transaction_count) AS total_transactions
FROM FactFinancialPerformance f
JOIN DimProduct p ON f.product_id = p.product_id
JOIN DimTime t ON f.date_id = t.date_id
GROUP BY p.product_category, p.product_subcategory, p.product_name, t.year, t.quarter;

COMMIT;
