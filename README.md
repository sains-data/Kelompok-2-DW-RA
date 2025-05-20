
# 📖 Data Warehouse Project — GermanTrust Bank

## 📋 Deskripsi Proyek
Repositori ini berisi laporan tugas kelompok **Data Warehouse** untuk studi kasus di industri **perbankan (GermanTrust Bank)**. Tugas dibagi dalam dua misi yang saling berkaitan, dimulai dari analisis kebutuhan hingga perancangan skema konseptual multidimensi.

---
## Arsitektur Data
Arsitektur data untuk proyek ini mengikuti lapisan Medallion Architecture Bronze , Silver , dan Gold :
<img src="https://github.com/user-attachments/assets/e08acdfe-a162-45c3-9ed8-05cb12225c18" alt="description of image">
## 🎯 Tujuan

### Misi 1
**Menganalisis kebutuhan bisnis dan teknis** untuk merancang **Data Warehouse (DW)** di industri perbankan.

**Format:** PDF (maks. 5 halaman)  
**Struktur laporan:**
1. Profil Industri & Masalah Bisnis (1 paragraf)  
2. Daftar Stakeholder & Tujuan Bisnis (tabel)  
3. Fakta & Dimensi (diagram + penjelasan)  
4. Sumber Data & Metadata (deskripsi + contoh data)  
5. Referensi (jika ada)

**Langkah Pengerjaan:**
1. Identifikasi Stakeholder & Kebutuhan Bisnis  
2. Daftar Fakta & Dimensi  
3. Sumber Data & Metadata  

📄 Laporan: [`Misi 1.md`](Misi%201.md)

---

### Misi 2
**Membangun conceptual schema data warehouse** berdasarkan kebutuhan bisnis & teknis yang telah dianalisis pada Misi 1, menggunakan pendekatan **multidimensional** (fakta, dimensi, dan hierarki).

**Format:** PDF (maks. 5 halaman)  
**Struktur laporan:**
1. Ringkasan Kebutuhan dari Misi  
2. Skema Konseptual Multidimensi  
3. Penjelasan Tiap Komponen  
4. Justifikasi Desain Konseptual  
5. Kesesuaian dengan Sumber Data  

📄 Laporan: [`Misi 2.md`](Misi%202.md)

---

## 🔗 Keterkaitan Misi 1 & Misi 2

| Misi 1 | Misi 2 |
|:------------|:------------|
| Identifikasi kebutuhan bisnis, stakeholder, fakta, dimensi, dan sumber data | Menerjemahkan kebutuhan tersebut ke dalam skema star schema multidimensi |
| Menentukan fakta & dimensi berdasarkan masalah bisnis bank | Mendesain relasi antar tabel fakta & dimensi sesuai analisis di Misi 1 |
| Menganalisis sumber data dan metadata | Menyesuaikan skema dengan kondisi aktual data dan sistem sumber |

---

## 📦 Struktur Repository

```
📂 /
├── 📄 Misi 1.md
├── 📄 Misi 2.md
└── 📄 README.md
```

---
