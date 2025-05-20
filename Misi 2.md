
# 📊 Proposal Data Warehouse  
**GermanTrust Bank**

## 📑 Disusun Oleh  
**Kelompok 2:**
- Ahmad Zidan Wirawan (120450044)
- Raditia Riandi (121450105)
- Dwi Ratna Anggraeni (122450008)
- Ahmad Sahidin Akbar (122450044)
- Gymnastiar Al Khoarizmy (122450096)
- Nabila Zakiyah Zahra (122450139)

**Institut Teknologi Sumatera**  
Lampung Selatan — 2025  

---

## 📌 1. Ringkasan Kebutuhan dari Misi

### 1.1 Identifikasi Sistem Sumber  
Sistem sumber utama terdiri dari:  
- **Core Banking System**  
- **Sistem Keuangan & Akuntansi**  
- **Manajemen Risiko**  
- **Sistem Aset & Portofolio**  
- **CRM**  
- **SDM & Organisasi**  
- **Layanan Digital**  
- **Audit & Keamanan**

### 1.2 Penerapan Proses Derivasi  
Fact table utama: `FactFinancialPerformance` dengan metrik:
- Pendapatan operasional
- Biaya, Aset, Kewajiban
- ROA, Profit Margin, dll  
Granularitas: **harian per produk, segmen nasabah, cabang, dan departemen**.

### 1.3 Dimensi & Hierarki Potensial
- **DimTime** : Day → Week → Month → Quarter → Year  
- **DimBranch** : Branch → City → Region → Country → Continent  
- **DimProduct** : Product → Product Category → Product Line  
- **DimEmployee** : Employee → Supervisor → Department / Position → Job Level  
- **DimAsset** : Asset → Asset Type → Asset Class  
- **DimCustomerSegment** : Customer → Segment → Segment Group  
- **DimDepartment** : Department → Division → Business Unit  

### 1.4 Ringkasan Hasil Derivasi  
**Fact Table:** FactFinancialPerformance  
**Measures:**  
operating_income, revenue, expenses, net_income, ROA, profit_margin, etc.

**Dimensi:**  
| Dimension | Cardinality | Hierarchy |
|:------------|:---------------|:--------------|
| DimTime | 1:N | Day → Year |
| DimBranch | 1:N | Branch → Continent |
| DimProduct | 1:N | Product → Product Line |
| DimEmployee | 1:N | Employee → Job Level |
| DimAsset | 1:N | Asset → Asset Class |
| DimCustomerSegment | 1:N | Customer → Segment Group |
| DimDepartment | 1:N | Department → Business Unit |

### 1.5 Spesifikasi Kebutuhan  
Target profitabilitas **15% dalam 3 tahun**.  
Sistem warehouse harus:
- Integrasi seluruh sistem sumber
- Dukungan laporan finansial, analisis risiko, optimalisasi portofolio

---

## 📌 2. Skema Konseptual Multidimensi  

**Model:** Star Schema + Parsial Snowflake  
**Fact Table:** `FactFinancialPerformance`  
**Dimensi:** DimTime, DimBranch, DimProduct, DimEmployee, DimAsset, DimCustomerSegment, DimDepartment  

**Granularitas:** transaksi harian per cabang, produk, segmen nasabah

**Hubungan:**  
- Fact → Dimensi = 1:N  
- Snowflake pada hierarki kompleks (contoh DimEmployee ke DimDepartment)

---

## 📌 3. Penjelasan Tiap Komponen

### a. FactFinancialPerformance  
Berisi metrik finansial harian per cabang, produk, dll  
**Foreign Key:** date_id, branch_id, product_id, employee_id, asset_id, customer_segment_id  
**Measures:** operating_income, expenses, net_income, ROA, dll  

### b. DimTime  
Analisis waktu: day, week, month, quarter, year  

### c. DimBranch  
Lokasi geografis: branch, city, region, country, continent  

### d. DimProduct  
Klasifikasi produk & layanan  

### e. DimEmployee  
Data SDM + Hierarki organisasi  

### f. DimAsset  
Kategori aset  

### g. DimCustomerSegment  
Segmentasi nasabah  

### h. DimDepartment  
Struktur organisasi

---

## 📌 4. Justifikasi Desain Konseptual  

- **Star Schema** untuk kecepatan query & kemudahan maintenance  
- **Parsial Snowflake** untuk hierarki kompleks  
- **Granularitas harian** memenuhi target 15% profit  
- **Dimensi & hierarki maksimal 5 level**  
- **ETL harian** untuk transaksi, bulanan untuk SDM/aset  
- **Tools:** Informatica / Talend untuk ETL, Amazon Redshift  

**Stakeholder Need:**  
- Keuangan: laporan keuangan dengan drill-down  
- Risiko: analisis kredit  
- Manajemen: analisis waktu & geografis  

---

## 📌 5. Kesesuaian Dengan Sumber Data  

- Integrasi data harian dari Core Banking, Keuangan, Treasury  
- Dimensi DimBranch & DimProduct standarisasi kode  
- Data CRM untuk customer segment  
- Data SDM untuk struktur organisasi  
- Mengatasi tantangan data geografis & ketidakkonsistenan dengan integrasi antar sistem  

---

> 📎 **Dokumentasi ini dibuat untuk kebutuhan akademis mata kuliah Data Warehouse Manajemen Informasi Strategis.**
