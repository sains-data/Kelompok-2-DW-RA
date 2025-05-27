# 🚀 Quick Start Guide - GermanTrust Bank Data Warehouse

## 30-Second Setup

### 1. Start the Environment
```bash
docker-compose up -d
```

### 2. Access phpMyAdmin
- Open: http://localhost:8080
- Username: `root`
- Password: `germantrustpw`

### 3. Run Complete Setup
In phpMyAdmin SQL tab, execute:
```sql
SOURCE sql-scripts/00_setup_complete.sql;
```

## ✅ Verification Checklist

After setup, you should see:
- ✅ **1000+ records** in FactFinancialPerformance
- ✅ **8 tables** with data
- ✅ **7 analytical views** created
- ✅ **8 stored procedures** available

## 🔍 Quick Tests

### Test 1: Basic Data Check
```sql
SELECT COUNT(*) as total_fact_records FROM FactFinancialPerformance;
-- Expected: 1000+ records
```

### Test 2: Revenue Summary
```sql
SELECT 
    ROUND(SUM(revenue)/1000000, 2) as revenue_millions,
    COUNT(DISTINCT branch_id) as branches
FROM FactFinancialPerformance;
-- Expected: Significant revenue across 15 branches
```

### Test 3: View Access
```sql
SELECT * FROM vw_branch_profitability LIMIT 5;
-- Expected: Branch performance data
```

### Test 4: Procedure Execution
```sql
CALL GetTopProducts(5);
-- Expected: Top 5 products by revenue
```

## 🎯 Next Steps

1. **Explore Analytics**: Run queries from `05_analytical_queries.sql`
2. **Custom Reports**: Use stored procedures for specific analysis
3. **Data Exploration**: Browse views for different business perspectives
4. **Performance Testing**: Monitor query execution times

## ⚠️ Troubleshooting

### Database Connection Issues
```bash
# Check containers
docker-compose ps

# Restart if needed
docker-compose restart
```

### Import Errors
- Ensure scripts run in order (00_setup_complete.sql handles this)
- Check MySQL error log in Docker logs
- Verify file paths in SOURCE commands

### Performance Issues
- Use EXPLAIN for query optimization
- Check index usage with SHOW INDEX
- Monitor with SHOW PROCESSLIST

## 📊 Ready-to-Use Dashboards

Once setup is complete, you can immediately access:

### Executive Dashboard
```sql
SOURCE sql-scripts/05_analytical_queries.sql;
-- Query 1: Overall bank performance
-- Query 15: Executive summary
```

### Branch Analysis
```sql
SELECT * FROM vw_branch_profitability ORDER BY total_revenue_millions DESC;
```

### Product Performance
```sql
CALL GetTopProducts(10);
```

### Risk Assessment
```sql
SELECT * FROM vw_risk_assessment WHERE risk_level = 'High Risk';
```

---
**Total Setup Time**: ~5 minutes  
**Data Ready**: Immediately after setup  
**Full Analysis**: Available instantly
