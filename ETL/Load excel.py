# --- LOAD ---

# Menyimpan ke satu file Excel
with pd.ExcelWriter("etl_bank_data.xlsx") as writer:
    dim_time.to_excel(writer, sheet_name="DimTime", index=False)
    dim_department.to_excel(writer, sheet_name="DimDepartment", index=False)
    dim_employee.to_excel(writer, sheet_name="DimEmployee", index=False)
    dim_branch.to_excel(writer, sheet_name="DimBranch", index=False)
    dim_asset.to_excel(writer, sheet_name="DimAsset", index=False)
    dim_product.to_excel(writer, sheet_name="DimProduct", index=False)
    dim_customer_segment.to_excel(writer, sheet_name="DimCustomerSegment", index=False)
    fact_financial_performance.to_excel(writer, sheet_name="FactFinancialPerformance", index=False)
