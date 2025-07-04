<%-- 
    Document   : tambah
    Created on : Jul 4, 2025, 2:03:33 PM
    Author     : Andika
--%>

<%@page import="crud.Mahasiswa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String message = "";
    String messageType = "";
    boolean showForm = true;
    
    if (request.getMethod().equals("POST")) {
        String nim = request.getParameter("nim");
        String nama = request.getParameter("nama");
        String nilaiStr = request.getParameter("nilai");
        
        // Validasi input
        if (nim == null || nim.trim().isEmpty()) {
            message = "NIM tidak boleh kosong!";
            messageType = "error";
        } else if (nama == null || nama.trim().isEmpty()) {
            message = "Nama tidak boleh kosong!";
            messageType = "error";
        } else if (nilaiStr == null || nilaiStr.trim().isEmpty()) {
            message = "Nilai tidak boleh kosong!";
            messageType = "error";
        } else {
            try {
                int nilai = Integer.parseInt(nilaiStr);
                
                // Validasi rentang nilai
                if (nilai < 0 || nilai > 100) {
                    message = "Nilai harus antara 0-100!";
                    messageType = "error";
                } else {
                    // Cek apakah NIM sudah ada
                    if (Mahasiswa.isNimExists(nim.trim())) {
                        message = "NIM " + nim + " sudah terdaftar!";
                        messageType = "error";
                    } else {
                        // Simpan data
                        Mahasiswa mahasiswa = new Mahasiswa();
                        mahasiswa.nim = nim.trim();
                        mahasiswa.nama = nama.trim();
                        mahasiswa.nilai = nilai;
                        
                        if (mahasiswa.tambah()) {
                            // Redirect ke index dengan pesan sukses
                            response.sendRedirect("index.jsp?message=Data berhasil ditambahkan&type=success");
                            return;
                        } else {
                            message = "Gagal menyimpan data!";
                            messageType = "error";
                        }
                    }
                }
            } catch (NumberFormatException e) {
                message = "Nilai harus berupa angka!";
                messageType = "error";
            }
        }
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tambah Mahasiswa</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 600px;
                margin: 0 auto;
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 30px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #555;
            }
            input[type="text"], input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
                box-sizing: border-box;
            }
            input[type="text"]:focus, input[type="number"]:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 2px rgba(0,123,255,0.25);
            }
            .btn {
                display: inline-block;
                padding: 12px 24px;
                margin: 5px;
                text-decoration: none;
                border-radius: 4px;
                font-size: 14px;
                cursor: pointer;
                border: none;
                font-weight: bold;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-secondary {
                background-color: #6c757d;
                color: white;
            }
            .btn:hover {
                opacity: 0.8;
            }
            .alert {
                padding: 15px;
                margin-bottom: 20px;
                border: 1px solid transparent;
                border-radius: 4px;
            }
            .alert-success {
                color: #155724;
                background-color: #d4edda;
                border-color: #c3e6cb;
            }
            .alert-error {
                color: #721c24;
                background-color: #f8d7da;
                border-color: #f5c6cb;
            }
            .button-group {
                text-align: center;
                margin-top: 20px;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Tambah Mahasiswa</h1>
            
            <!-- Pesan error -->
            <% if (!message.isEmpty()) { %>
            <div class="alert alert-<%= messageType %>">
                <%= message %>
            </div>
            <% } %>
            
            <form method="POST" action="tambah.jsp">
                <div class="form-group">
                    <label for="nim">NIM:</label>
                    <input type="text" id="nim" name="nim" 
                           value="<%= request.getParameter("nim") != null ? request.getParameter("nim") : "" %>"
                           required maxlength="20" placeholder="Masukkan NIM">
                </div>
                
                <div class="form-group">
                    <label for="nama">Nama:</label>
                    <input type="text" id="nama" name="nama" 
                           value="<%= request.getParameter("nama") != null ? request.getParameter("nama") : "" %>"
                           required maxlength="100" placeholder="Masukkan nama lengkap">
                </div>
                
                <div class="form-group">
                    <label for="nilai">Nilai:</label>
                    <input type="number" id="nilai" name="nilai" 
                           value="<%= request.getParameter("nilai") != null ? request.getParameter("nilai") : "" %>"
                           required min="0" max="100" placeholder="Masukkan nilai (0-100)">
                </div>
                
                <div class="button-group">
                    <input type="submit" value="Simpan" class="btn btn-primary">
                    <a href="index.jsp" class="btn btn-secondary">Batal</a>
                </div>
            </form>
        </div>
    </body>
</html>