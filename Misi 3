
# Misi 3

## 📌 Fokus: Desain Konseptual, Logikal, & Fisik

---

## 🎯 Desain Konseptual

### 📖 Tabel Dimensi (Skill 1.1)

| Nama Dimensi       | Deskripsi                                             |
|:------------------|:-----------------------------------------------------|
| **DimTime**        | Informasi waktu transaksi (tanggal, bulan, tahun, dst.) |
| **DimBranch**      | Informasi cabang (lokasi, kota, region, dll.)        |
| **DimProduct**     | Informasi produk keuangan                            |
| **DimEmployee**    | Data karyawan                                        |
| **DimAsset**       | Informasi aset keuangan dan non-keuangan             |
| **DimCustomerSegment** | Segmentasi nasabah berdasarkan income, channel, dll. |
| **DimDepartment**  | Data departemen internal                             |

---

### 📖 Tabel Fakta (Skill 1.2)

| Nama Fakta            | Deskripsi                               |
|:---------------------|:-----------------------------------------|
| **operating_income**   | Pendapatan operasional                  |
| **expenses**           | Beban operasional                       |
| **net_income**         | Laba bersih                              |
| **assets**             | Total aset                                |
| **liabilities**        | Kewajiban                                 |
| **equity**             | Ekuitas                                   |
| **debt_to_equity**     | Rasio utang terhadap ekuitas              |
| **roa**                | Return on Asset                           |
| **revenue**            | Pendapatan total                          |
| **profit_margin**      | Margin keuntungan                         |
| **cash_flow**          | Arus kas                                   |
| **transaction_count**  | Jumlah transaksi                          |

**Skema yang digunakan:** ⭐ Star Schema  
**Alasan:** Lebih cepat, query lebih simpel, mudah dipahami oleh business user.

---

## 📌 Desain Logikal & Fisik

### 📖 Index Design (Skill 1.3)

| Tabel                      | Kolom                                    | Index Type      |
|:--------------------------|:------------------------------------------|:----------------|
| FactFinancialPerformance   | `date_id`, `branch_id`, `product_id`, `customer_segment_id` | Single Index |
| FactFinancialPerformance   | `(date_id, branch_id)`                    | Composite Index |
| DimTime                    | `(year, month)`                          | Composite Index |
| DimBranch                  | `(country, region)`                      | Composite Index |
| DimProduct                 | `(product_category, product_subcategory)` | Composite Index |
| DimCustomerSegment         | `(risk_profile, profitability_score)`     | Composite Index |

---

### 📖 Storage Design (Skill 1.4)

- **Engine:** InnoDB (support FK, transaction-safe, compression)
- **Tablespace:**  
  - `ts_dimension_data` → untuk tabel dimensi  
  - `ts_fact_data` → untuk tabel fakta  

```sql
CREATE TABLESPACE ts_dimension_data ADD DATAFILE 'ts_dimension_data.ibd' ENGINE=InnoDB;
CREATE TABLESPACE ts_fact_data ADD DATAFILE 'ts_fact_data.ibd' ENGINE=InnoDB;
```

**Alasan:**  
Meminimalkan fragmentasi, percepat query OLAP, mudah maintenance.

---

### 📖 Partitioning & View Design (Skill 1.5)

#### 📑 Partitioning Fact Table:

```sql
ALTER TABLE FactFinancialPerformance
PARTITION BY RANGE (date_id) (
  PARTITION p_2023_q1 VALUES LESS THAN (20230401),
  PARTITION p_2023_q2 VALUES LESS THAN (20230701),
  PARTITION p_future VALUES LESS THAN MAXVALUE
);
```

**Alasan:**  
Mempercepat query per kuartal/tahun & memudahkan data archiving.

---

#### 📑 View untuk Laporan:

- **vw_branch_profitability**  
  Pendapatan & laba bersih per cabang per kuartal  
- **vw_credit_risk_analysis**  
  Analisis risiko kredit per segmen & produk  
- **vw_product_performance**  
  Laporan profitabilitas per produk per periode

📌 Contoh:
```sql
CREATE VIEW vw_branch_profitability AS
SELECT
  b.branch_id, b.branch_name, t.year, t.quarter,
  SUM(f.revenue) AS total_revenue, SUM(f.net_income) AS total_profit
FROM FactFinancialPerformance f
JOIN DimBranch b ON f.branch_id = b.branch_id
JOIN DimTime t ON f.date_id = t.date_id
GROUP BY b.branch_id, t.year, t.quarter;
```

---

## 📌 Summary

✅ **Skill 1.1 & 1.2:** Desain tabel fakta & dimensi lengkap (star schema)  
✅ **Skill 1.3:** Index optimal untuk FK, filter, agregat  
✅ **Skill 1.4:** Storage engine + tablespace sesuai workload OLAP  
✅ **Skill 1.5:** Partitioning fact table per kuartal + View reporting  

---

**Disusun oleh:**  
Kelompok 2 - GermanTrust Bank Data Warehouse Project  
Institut Teknologi Sumatera, 2025
