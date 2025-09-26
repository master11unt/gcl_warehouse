# Stuffing Dialog Documentation

## Overview
Dialog untuk membuat stuffing ticket baru dengan design yang clean dan minimal sesuai dengan UI/UX yang diminta.

## Design Features

### 1. Dialog Layout
- **Rounded corners** dengan radius 20px
- **Responsive width** 40% dari screen width
- **Centered title** "Create Ticket" dengan close button
- **Tab indicator** "Stuffing Ticket" dengan background abu-abu

### 2. Form Fields
- **Stuffing Owner**: Dropdown dengan pilihan (GAP LOGISTICS, DANLIRIS, SMAS LOGISTICS, ULTRA PRIMA) - Default: DANLIRIS
- **Stuffing Date**: DateTime picker dengan format mm/dd/yyyy --:-- --
- **Container Number**: Text input field
- **Estimated Time Departure**: DateTime picker dengan format mm/dd/yyyy --:-- --
- **Destination**: Text input field
- **Container Size**: Text input field
- **Closing Date**: DateTime picker dengan format mm/dd/yyyy --:-- --
- **Vessel**: Text input field

### 3. Field Styling
- **Label**: Italic, abu-abu (#6B7280), 14px
- **Input container**: Border abu-abu (#E5E7EB), radius 8px, height 48px
- **Placeholder text**: Abu-abu muda untuk datetime fields
- **Calendar icon**: Untuk datetime fields dengan warna #6B7280

### 4. Action Buttons
- **Cancel**: TextButton dengan warna abu-abu
- **Create**: ElevatedButton dengan background hitam (#1F2937)
- **Bottom padding**: 24px untuk spacing

## File Structure
```
lib/
  widgets/
    stuffing/
      stuffing_dialog.dart    # Dialog utama untuk stuffing ticket
  pages/
    ticket_page.dart          # Modified untuk support stuffing dialog
```

## Integrasi
Dialog terintegrasi dengan halaman ticket pada tab "Ticket Stuffing". Ketika user mengklik tombol "+" di bagian Options, akan menampilkan dialog stuffing yang sesuai (bukan dialog cargo in).

## Validasi
- Semua field yang bertanda (*) adalah required
- DateTime fields harus diisi
- Form validation standard Flutter

## Usage
Dialog akan muncul ketika user mengklik tombol add (+) di tab "Ticket Stuffing" pada halaman ticket.