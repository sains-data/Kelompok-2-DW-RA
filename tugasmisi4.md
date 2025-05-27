# Tugas Misi Keempat


- Fokus:
- Implementasi skema data warehouse di SQL Server
- Pengisian data (ETL/ELT)
- Query analitik
- Dokumentasi laporan akhir dan struktur GitHub

### Tugas Misi Keempat: Implementasi, Reporting, dan Produksi


- **Output:**
    1. Skema databasedata warehousedi SQL Server
    2. ScriptSQL untuk membuat tabel fakta dan dimensi
    3. Relasi antar tabel (starschemaatau snowflakeschema)
    4. Implementasi indexingjika diperlukan
- **Spesifikasi:**
    1. Tabel fakta (misalnya: penjualan, transaksi, kunjungan)
    2. Tabel dimensi (misalnya: waktu, produk, lokasi, pelanggan)
    3. Data dummyatau hasil transformasi dari sumber data transaksional
    4. Normalisasi (jika relevan) atau denormalisasisesuai model dimensional
    5. SQL scriptdisimpan dan di-commitke GitHub(misalnya create_tables.sql,
       insert_data.sql)

## 1. Implementasi Gudang Data di SQL Server


#### Output:

##### 1. Proses ekstraksi dan pemuatan data dari data sumber ke data

##### warehouse

##### 2. ScriptSQL (atau SSIS package, jika pakai)

#### Spesifikasi:

##### 1. Ekstraksi data dari fileExcel/CSV/sumber databasetransaksional

##### 2. Transformasi data (misalnya: konversi format tanggal, normalisasi nilai)

##### 3. Load ke tabel fakta dan dimensi

##### 4. Bisa dilakukan via SQL scriptatau SSMS wizard

## 2. ETL/ELT


- **Output:**

##### 1. Kumpulan queryanalitik berbasis SQL

##### 2. Hasil berupa ringkasan data, agregasi, perbandingan waktu, dll

##### 3. Contoh Query:Totalpenjualan per bulan

##### 4. Rata-rata transaksi per pelanggan

##### 5. Produk terlaris berdasarkan wilayah

##### 6. Tren pertumbuhan dari tahun ke tahun

- **Spesifikasi:**

##### 1. Gunakan Metode OLAP

##### 2. Gunakan fungsi agregat (SUM, AVG, COUNT)

##### 3. Gunakan GROUP BY, JOIN, dan ORDER BY dengan tabel dimensiQuery

##### disimpan dalam fileanalysis_queries.sql

## 3. Query OLAP / Analitik


- **Spesifikasi Isi Laporan Akhir:**
    1. Ringkasan proyek dan latar belakang
    2. Tujuan dan ruang lingkup sistem
    3. Metodologi (termasuk tools, waterfall, tahapan misi 1-4)
    4. Analisis Kebutuhan (dari misi 1)
    5. Desain konseptual, logikal, dan fisikal(boleh disalin dari misi 2-3)
    6. Proses implementasi (screenshots, penjelasan query, penjelasan proses ETL)
    7. Hasil implementasi (tampilan sistem, fungsionalitas, data)
    8. Evaluasi (apa yang berhasil, apa yang belum, kendala teknis)
    9. Rencana pengembangan ke depan (jika ingin dikembangkan lagi)
    10. Tim Proyek (Deskripsikan tim Anda –nama tim, anggota, ketua)
- **File Dokumentasi Proyek -> README GitHub:**
    - Isi nyaadalah summarydari laporan akhir Anda per poin.

## 4. Reporting dan Dokumentasi Proyek

• Spesifikasi Isi Laporan Akhir:
1. Ringkasan proyek dan latar belakang
2. Tujuan dan ruang lingkup sistem
3. Metodologi (termasuk tools, waterfall, tahapan misi 1-4)
4. Analisis Kebutuhan (dari misi 1)
5. Desain konseptual, logikal, dan fisikal (boleh disalin dari misi 2-3)
6. Proses implementasi (screenshots, penjelasan query, penjelasan proses ETL)
7. Hasil implementasi (tampilan sistem, fungsionalitas, data)
8. Evaluasi (apa yang berhasil, apa yang belum, kendala teknis)
9. Rencana pengembangan ke depan (jika ingin dikembangkan lagi)
10. Tim Proyek (Deskripsikan tim Anda –nama tim, anggota, ketua)
## File Dokumentasi Proyek -> README GitHub:
• Isi nya adalah summary dari laporan akhir Anda per poin.