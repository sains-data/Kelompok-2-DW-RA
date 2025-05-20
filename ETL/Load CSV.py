# --- LOAD ---

# Simpan ke CSV per tabel
dim_time.to_csv("DimTime.csv", index=False)
dim_department.to_csv("DimDepartment.csv", index=False)
dim_employee.to_csv("DimEmployee.csv", index=False)
dim_branch.to_csv("DimBranch.csv", index=False)
dim_asset.to_csv("DimAsset.csv", index=False)
dim_product.to_csv("DimProduct.csv", index=False)
dim_customer_segment.to_csv("DimCustomerSegment.csv", index=False)
fact_financial_performance.to_csv("FactFinancialPerformance.csv", index=False)
