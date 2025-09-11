# Warehouse Report Page

Halaman laporan warehouse yang telah dibuat berdasarkan desain yang Anda berikan. Halaman ini menampilkan berbagai komponen pelaporan warehouse yang komprehensif.

## Fitur-Fitur Utama

### 1. Header dan Filter
- Judul "Report Warehouse" dengan deskripsi
- Tombol filter untuk memfilter data

### 2. Summary Cards
- **Total Cargo**: Menampilkan total kargo (6381)
- **Damaged Cargo**: Menampilkan kargo yang rusak (1)

### 3. Detail Quantity Cargo (Pie Chart)
- Chart lingkaran yang menampilkan distribusi status kargo:
  - Received: 5421 (biru)
  - Pending: 635 (orange)
  - Delivered: 191 (hijau)
  - Expired: 127 (merah)

### 4. Detail Status Cargo (Bar Chart)
- Chart batang yang menampilkan status kargo per bulan
- Menampilkan trend dari Januari hingga Juni

### 5. Value Cargo
- **Counted Document**: 6381
- **Uncounted Document**: 6381
- **Counted Cargo**: Status "Unscanned" dengan progress bar

### 6. Cargo Flow Chart
- Line chart yang menampilkan alur kargo dalam setahun
- Menampilkan data incoming dan outgoing cargo

### 7. Top Shipper Table
- Tabel yang menampilkan pengirim terbesar:
  1. GIMADAN (815)
  2. INDONESIA, PT (625)
  3. ADITAMA CITRA (591)
  4. LN SANTOS (181)
  5. INDONESIA, PT
  6. WITIKCO LOGISTICS
  7. WRAPPALSTUFFING (194)
- Total Shipper: 694

### 8. Stuffing Statistics
- **Stuffing Plan**: 357 (ongoing stuffing plan)
- **Closed Stuffing Plan**: 941

### 9. Next Destination
- Daftar tujuan berikutnya dengan indikator warna:
  - CNIL
  - CAKELLAGENV/OA
  - WESTPORT/PORT ALANG
  - WIESBADEN
  - MAKASSAR
  - MONTEVIDEO
  - CHITTAGONE
- Total Destination: 215

### 10. Detail Distribution Chart
- Bar chart yang menampilkan distribusi ke berbagai tujuan:
  - DAPKONG
  - SINGAPORE
  - CHITTAGONG
  - WEST AFRICA

### 11. Performance Summary
- **Performance**: 100% (Accomplished) dengan circular progress indicator
- **Capacity**: Status "Available" untuk GCLMerauke
  - Kapasitas tersedia: 1874.4926
  - Total kapasitas: 2500

### 12. Download Options
- **Cargo In Warehouse**: Book Status
- **Stuffing Plan**: GCL Merauke

## Cara Mengakses

1. Buka aplikasi GCL Warehouse
2. Tap menu hamburger (☰) di kiri atas
3. Pilih "Report" dari menu drawer
4. Halaman warehouse report akan terbuka

## Teknologi yang Digunakan

- **Flutter**: Framework utama
- **fl_chart**: Untuk membuat charts (pie chart, bar chart, line chart)
- **Material Design**: Untuk komponen UI

## File yang Dibuat

- `lib/pages/warehouse_report_page.dart`: Halaman utama warehouse report
- Update pada `lib/widgets/home/custom_drawer.dart`: Menambahkan navigasi ke report page

## Dependencies yang Diperlukan

Pastikan `pubspec.yaml` sudah memiliki dependency berikut:
```yaml
dependencies:
  flutter:
    sdk: flutter
  fl_chart: ^1.0.0
  pie_chart: ^5.4.0
```

## Cara Menjalankan

1. Jalankan `flutter pub get` untuk menginstall dependencies
2. Jalankan `flutter run` untuk menjalankan aplikasi
3. Akses halaman report melalui drawer menu

Halaman ini sepenuhnya responsive dan mengikuti desain yang Anda berikan dalam gambar.
