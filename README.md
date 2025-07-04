# CRUD Mahasiswa dengan JSP dan MySQL

Sistem CRUD (Create, Read, Update, Delete) untuk data mahasiswa menggunakan JSP dan MySQL.

## Struktur File

```
src/
├── crud/
│   ├── DatabaseConnection.java    # Class untuk koneksi database
│   └── Mahasiswa.java            # Class model untuk data mahasiswa
├── index.jsp                     # Halaman utama (daftar mahasiswa)
├── tambah.jsp                    # Halaman tambah mahasiswa
├── edit.jsp                      # Halaman edit mahasiswa
├── hapus.jsp                     # Halaman hapus mahasiswa
└── test.sql                      # Script database
```

## Setup Database

1. Buat database MySQL dengan nama `test`
2. Jalankan script SQL yang ada di `test.sql`

## Setup Project

1. **Download MySQL Connector/J**
   - Download dari [MySQL Connector/J](https://dev.mysql.com/downloads/connector/j/)
   - Pilih Platform Independent
   - Extract file `mysql-connector-j-x.x.x.jar`

2. **Tambahkan ke NetBeans**
   - Klik kanan pada Libraries di project
   - Pilih "Add JAR/Folder"
   - Pilih file jar MySQL Connector

3. **Konfigurasi Database**
   - Buka `DatabaseConnection.java`
   - Sesuaikan konfigurasi database:
     ```java
     private static final String DBCONNECTION = "jdbc:mysql://localhost:3306/test";
     private static final String DBUSER = "root";
     private static final String DBPASS = "";
     ```

## Fitur Aplikasi

### 1. Halaman Utama (index.jsp)
- Menampilkan daftar semua mahasiswa
- Tombol untuk tambah mahasiswa baru
- Tombol edit dan hapus untuk setiap data
- Pesan sukses/error setelah operasi

### 2. Tambah Mahasiswa (tambah.jsp)
- Form untuk menambah data mahasiswa baru
- Validasi input (NIM, nama, nilai)
- Cek duplikasi NIM
- Validasi rentang nilai (0-100)

### 3. Edit Mahasiswa (edit.jsp)
- Form untuk mengubah data mahasiswa
- Pre-fill data yang sudah ada
- Validasi input yang sama dengan tambah
- Cek duplikasi NIM (kecuali untuk data yang sedang diedit)

### 4. Hapus Mahasiswa (hapus.jsp)
- Halaman konfirmasi sebelum menghapus
- Menampilkan detail data yang akan dihapus
- Konfirmasi dengan tombol Ya/Tidak

## Cara Menjalankan

1. Setup database sesuai instruksi
2. Deploy project ke server (Tomcat/GlassFish)
3. Akses melalui browser: `http://localhost:8080/project-name/index.jsp`
