# --- EXTRACT & TRANSFORM ---

# 1. DimTime
start_date = datetime(2023, 1, 1)
dim_time_list = []
for i in range(20):
    date = start_date + timedelta(days=i)
    dim_time_list.append({
        'date_id': i + 1,
        'full_date': date,
        'day': date.day,
        'day_of_week': date.strftime('%A'),
        'week_of_year': date.isocalendar()[1],
        'month': date.month,
        'month_name': date.strftime('%B'),
        'quarter': (date.month - 1) // 3 + 1,
        'year': date.year,
        'fiscal_period': f'FY{date.year}-Q{((date.month - 1) // 3 + 1)}',
        'is_holiday': date.weekday() in [5, 6],
        'is_weekend': date.weekday() in [5, 6]
    })
dim_time = pd.DataFrame(dim_time_list)

# 2. DimDepartment
dim_department = pd.DataFrame({
    'department_id': range(1, 21),
    'department_name': [f'Department {i}' for i in range(1, 21)],
    'department_code': [f'DEP{i:03}' for i in range(1, 21)],
    'division': np.random.choice(['Finance', 'IT', 'HR', 'Sales'], size=20),
    'budget_allocation': np.round(np.random.uniform(100000, 1000000, size=20), 2),
    'head_count': np.random.randint(5, 50, size=20),
    'manager_id': np.random.randint(1, 21, size=20),
    'establishment_date': pd.date_range(start='2010-01-01', periods=20, freq='Y'),
    'functional_area': np.random.choice(['Operations', 'Support', 'Strategy'], size=20)
})

# 3. DimEmployee
dim_employee = pd.DataFrame({
    'employee_id': range(1, 21),
    'employee_name': [f'Employee {i}' for i in range(1, 21)],
    'employee_code': [f'EMP{i:03}' for i in range(1, 21)],
    'position': np.random.choice(['Analyst', 'Manager', 'Executive'], size=20),
    'department_id': np.random.randint(1, 21, size=20),
    'hire_date': pd.date_range(start='2015-01-01', periods=20, freq='Y'),
    'manager_id': [None if i == 0 else random.randint(1, 20) for i in range(20)],
    'is_manager': np.random.choice([True, False], size=20),
    'employment_status': np.random.choice(['Active', 'Inactive'], size=20),
    'education_level': np.random.choice(['Bachelor', 'Master', 'PhD'], size=20),
    'salary_band': np.random.choice(['A', 'B', 'C'], size=20),
    'performance_rating': np.random.choice(['High', 'Medium', 'Low'], size=20)
})

# 4. DimBranch
dim_branch = pd.DataFrame({
    'branch_id': range(1, 21),
    'branch_name': [f'Branch {i}' for i in range(1, 21)],
    'branch_code': [f'BR{i:03}' for i in range(1, 21)],
    'location_city': np.random.choice(['Jakarta', 'Bandung', 'Surabaya', 'Medan'], size=20),
    'location_region': np.random.choice(['West', 'Central', 'East'], size=20),
    'branch_type': np.random.choice(['Urban', 'Rural'], size=20),
    'opening_date': pd.date_range(start='2005-01-01', periods=20, freq='Y'),
    'is_active': np.random.choice([True, False], size=20),
    'manager_id': np.random.randint(1, 21, size=20),
    'num_employees': np.random.randint(5, 50, size=20),
    'branch_performance_rating': np.random.choice(['A', 'B', 'C'], size=20)
})

# 5. DimAsset
dim_asset = pd.DataFrame({
    'asset_id': range(1, 21),
    'asset_name': [f'Asset {i}' for i in range(1, 21)],
    'asset_code': [f'AST{i:03}' for i in range(1, 21)],
    'asset_type': np.random.choice(['Cash', 'Loan', 'Investment'], size=20),
    'valuation': np.round(np.random.uniform(10000, 100000, size=20), 2),
    'acquisition_date': pd.date_range(start='2016-01-01', periods=20, freq='Y'),
    'depreciation_rate': np.round(np.random.uniform(0.01, 0.10, size=20), 4),
    'residual_value': np.round(np.random.uniform(1000, 5000, size=20), 2),
    'useful_life': np.random.randint(3, 10, size=20),
    'branch_id': np.random.randint(1, 21, size=20),
    'asset_status': np.random.choice(['Active', 'Disposed'], size=20)
})

# 6. DimProduct
dim_product = pd.DataFrame({
    'product_id': range(1, 21),
    'product_name': [f'Product {i}' for i in range(1, 21)],
    'product_code': [f'PRD{i:03}' for i in range(1, 21)],
    'product_category': np.random.choice(['Savings', 'Loan', 'Credit Card'], size=20),
    'product_subcategory': np.random.choice(['Standard', 'Premium'], size=20),
    'product_type': np.random.choice(['Individual', 'Corporate'], size=20),
    'interest_rate': np.round(np.random.uniform(1.0, 10.0, size=20), 2),
    'fee_structure': ['None'] * 20,
    'min_balance': np.round(np.random.uniform(0, 1000, size=20), 2),
    'is_active': np.random.choice([True, False], size=20),
    'launch_date': pd.date_range(start='2018-01-01', periods=20, freq='Y'),
    'department_id': np.random.randint(1, 21, size=20),
    'risk_level': np.random.choice(['Low', 'Medium', 'High'], size=20),
    'currency': np.random.choice(['USD', 'IDR', 'EUR'], size=20)
})

# 7. DimCustomerSegment
dim_customer_segment = pd.DataFrame({
    'customer_segment_id': range(1, 21),
    'segment_name': [f'Segment {i}' for i in range(1, 21)],
    'segment_description': [f'Description {i}' for i in range(1, 21)],
    'avg_income_range': np.random.choice(['<5M', '5-10M', '>10M'], size=20),
    'avg_age_range': np.random.choice(['18-25', '26-35', '36-50'], size=20),
    'preferred_channel': np.random.choice(['Mobile', 'Branch', 'Online'], size=20),
    'risk_profile': np.random.choice(['Low', 'Medium', 'High'], size=20),
    'loyalty_level': np.random.choice(['Silver', 'Gold', 'Platinum'], size=20),
    'profitability_score': np.round(np.random.uniform(1.0, 10.0, size=20), 2),
    'acquisition_channel': np.random.choice(['Referral', 'Online', 'Branch'], size=20),
    'retention_rate': np.round(np.random.uniform(0.5, 1.0, size=20), 2)
})

# 8. FactFinancialPerformance
fact_financial_performance = pd.DataFrame({
    'performance_id': range(1, 21),
    'date_id': np.random.randint(1, 21, size=20),
    'branch_id': np.random.randint(1, 21, size=20),
    'product_id': np.random.randint(1, 21, size=20),
    'employee_id': np.random.randint(1, 21, size=20),
    'asset_id': np.random.randint(1, 21, size=20),
    'customer_segment_id': np.random.randint(1, 21, size=20),
    'operating_income': np.round(np.random.uniform(10000, 100000, size=20), 2),
    'expenses': np.round(np.random.uniform(5000, 50000, size=20), 2),
    'net_income': np.round(np.random.uniform(1000, 50000, size=20), 2),
    'assets': np.round(np.random.uniform(100000, 500000, size=20), 2),
    'liabilities': np.round(np.random.uniform(50000, 300000, size=20), 2),
    'equity': np.round(np.random.uniform(50000, 200000, size=20), 2),
    'debt_to_equity': np.round(np.random.uniform(0.5, 2.5, size=20), 4),
    'roa': np.round(np.random.uniform(0.01, 0.15, size=20), 4),
    'revenue': np.round(np.random.uniform(20000, 150000, size=20), 2),
    'cash_flow': np.round(np.random.uniform(10000, 90000, size=20), 2),
    'profit_margin': np.round(np.random.uniform(0.05, 0.5, size=20), 4),
    'interest_expense': np.round(np.random.uniform(1000, 10000, size=20), 2),
    'tax_expense': np.round(np.random.uniform(1000, 8000, size=20), 2),
    'dividend_payout': np.round(np.random.uniform(500, 5000, size=20), 2),
    'transaction_count': np.random.randint(10, 200, size=20),
    'cost_to_income_ratio': np.round(np.random.uniform(0.4, 0.9, size=20), 4)
})
