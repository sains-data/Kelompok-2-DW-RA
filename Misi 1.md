# PROPOSAL DATA WAREHOUSE

**Disusun Oleh, Kelompok 2:**
- Ahmad Zidan Wirawan (120450044)  
- Raditia Riandi (121450105)  
- Dwi Ratna Anggraeni (122450008)  
- Ahmad Sahidin Akbar (122450044)  
- Gymnastiar Al Khoarizmy (122450096)  
- Nabila Zakiyah Zahra (122450139)  

**INSTITUT TEKNOLOGI SUMATERA**  
Lampung Selatan, 2025  

---

## 1. Profil Industri dan Masalah Bisnis

GermanTrust Bank merupakan institusi keuangan global yang beroperasi di lebih dari 50 negara dan fokus pada layanan perbankan investasi, korporasi, serta manajemen aset.

Sejak 2015, bank menghadapi tantangan dalam:
- Integrasi data keuangan dari berbagai wilayah
- Analisis data yang lambat dan kurang akurat
- Pengambilan keputusan yang terhambat

**Target:**
Meningkatkan profitabilitas sebesar 15% dalam 3 tahun melalui sistem **Data Warehouse terintegrasi** yang:
- Mempercepat pelaporan keuangan
- Meningkatkan akurasi analisis aset & risiko
- Mendorong efisiensi biaya
- Mengoptimalkan strategi pertumbuhan

---

## 2. Stakeholder dan Tujuan

| Stakeholder | Peran/Kepentingan | Tujuan |
|-------------|-------------------|--------|
| **Departemen Keuangan** | Laporan & anggaran | Akurasi + waktu tutup buku ↓20% |
| **Departemen Risiko** | Mitigasi risiko | Risiko kredit ↓15%, patuh Basel III |
| **Departemen Treasury** | Likuiditas & investasi | Return investasi naik 8% |
| **Layanan Nasabah** | Hubungan nasabah | Retensi naik 12%, skor kepuasan 7.5 → 8.5 |
| **Pemasaran** | Strategi produk | Konversi naik 20%, biaya akuisisi ↓15% |
| **IT** | Infrastruktur TI | Ketersediaan sistem 99.9%, keamanan ↑ |
| **Operasional** | Proses harian | Waktu transaksi ↓40%, otomatisasi ↑60% |
| **Pengembangan Produk** | Inovasi produk | 5 produk baru/tahun, adopsi naik 25% |
| **Analitik** | Insight data | 10 model prediktif strategis |
| **Kepatuhan** | Regulasi | Denda 0%, respon audit lebih cepat 30% |

---

## 3. Fakta dan Dimensi
<img src="https://github.com/user-attachments/assets/0400a3a0-fe0b-4797-8046-ee8effa33adb" alt="description of image">


**Skema:** Bintang  
**Tabel Fakta:** `FactFinancialPerformance`  
**Metrik:**
- Operating income, revenue, expenses, net income
- Assets, liabilities, equity
- Rasio: debt_to_equity, ROA, profit_margin, cost_to_income_ratio
- Cash flow, interest_expense, tax_expense, dividend_payout
- Transaction_count

**Foreign Keys:**
- `date_id` → DimTime  
- `branch_id` → DimBranch  
- `product_id` → DimProduct  
- `employee_id` → DimEmployee  
- `asset_id` → DimAsset  
- `customer_segment_id` → DimCustomerSegment  

**Tabel Dimensi:**
- **DimTime**: Hierarki waktu (hari → minggu → bulan → kuartal → tahun)
- **DimBranch**: Lokasi fisik cabang
- **DimProduct**: Kategori produk; terhubung DimDepartment
- **DimEmployee**: Info SDM; terhubung DimDepartment
- **DimAsset**: Kategori aset untuk analisis ROA
- **DimCustomerSegment**: Segmentasi nasabah
- **DimDepartment**: Struktur organisasi

---

## 4. Sumber Data & Metadata

| Sumber | Deskripsi | Frekuensi | Contoh |
|--------|-----------|-----------|--------|
| Core Banking | Transaksi, saldo, mutasi | Real-time | Transfer ID: 202504241001, Nominal: Rp100.000.000 |
| Sistem Keuangan | Jurnal, neraca, arus kas | Harian | Jurnal: 20250424-02, Pendapatan Bunga: Rp2.500.000 |
| Manajemen Risiko | Kredit, scoring, limit | Harian | Kredit ID: 876543, Skor: 80, Limit: Rp1M |
| Treasury | Investasi, surat berharga | Harian | SBN: Rp5M, Jatuh Tempo: 2025-12-31 |
| CRM | Profil & feedback nasabah | Mingguan | ID: 123456, Segmen: Corporate, Skor: 8.2 |
| SDM & Organisasi | Data pegawai, absensi | Bulanan | ID: 110022, Jabatan: RM, Kehadiran: 98% |
| Manajemen Aset | Aset tetap, penyusutan | Bulanan | ID: 445566, ATM, Nilai Buku: Rp250Jt |
| Layanan Digital | Digital banking | Harian | Transaksi mobile: 150rb/hari, Volume: Rp10M/hari |
| Kepatuhan & Audit | Hasil audit, pelaporan | Triwulanan | Audit ID: 2025Q1-05, Status: Sesuai |

---

## 5. Referensi

1. Mirhajisadati, H. *DeutscheBank Financial Performance*, Kaggle, 2023.  
   [https://www.kaggle.com/datasets/heidarmirhajisadati/deutschebank-financial-performance](https://www.kaggle.com/datasets/heidarmirhajisadati/deutschebank-financial-performance)

2. Dibouliya, A., & Jotwani, V. *The Transformational Impact of Modern Data Warehousing on the Banking System*, IJRASET, 2023.  
   [https://www.ijraset.com/research-paper/the-transformational-impact-of-modern-data-warehousing-on-the-banking-system](https://www.ijraset.com/research-paper/the-transformational-impact-of-modern-data-warehousing-on-the-banking-system)

3. Sharma, R., & Gupta, A. *The Role of Data Warehousing in Revolutionizing Banking and User Experience*, IJFMR, 2023.  
   [https://www.ijfmr.com/research-paper.php?id=8890](https://www.ijfmr.com/research-paper.php?id=8890)
