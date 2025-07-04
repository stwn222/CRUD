<%-- 
    Document   : hapus
    Created on : Jul 4, 2025, 2:05:47 PM
    Author     : Andika
--%>
<%@page import="crud.Mahasiswa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String message = "";
    String messageType = "";
    
    // Get ID parameter
    String idStr = request.getParameter("id");
    if (idStr == null || idStr.trim().isEmpty()) {
        response.sendRedirect("index.jsp?message=ID tidak valid&type=error");
        return;
    }
    
    try {
        int id = Integer.parseInt(idStr);
        
        // Get data mahasiswa untuk konfirmasi
        Mahasiswa mahasiswa = Mahasiswa.getById(id);
        if (mahasiswa == null) {
            response.sendRedirect("index.jsp?message=Data tidak ditemukan&type=error");
            return;
        }
        
        // Proses penghapusan
        if (request.getMethod().equals("POST")) {
            String action = request.getParameter("action");
            
            if ("delete".equals(action)) {
                // Set ID untuk mahasiswa dan hapus
                mahasiswa.id = id;
                if (mahasiswa.hapus()) {
                    response.sendRedirect("index.jsp?message=Data " + mahasiswa.nama + " berhasil dihapus&type=success");
                    return;
                } else {
                    message = "Gagal menghapus data!";
                    messageType = "error";
                }
            } else if ("cancel".equals(action)) {
                response.sendRedirect("index.jsp");
                return;
            }
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hapus Mahasiswa</title>
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
            .warning-box {
                background-color: #fff3cd;
                border: 1px solid #ffecb5;
                border-radius: 4px;
                padding: 20px;
                margin-bottom: 20px;
                border-left: 4px solid #ffc107;
            }
            .warning-title {
                color: #856404;
                font-size: 18px;
                font-weight: bold;
                margin-bottom: 10px;
            }
            .warning-text {
                color: #856404;
                margin-bottom: 15px;
            }
            .data-info {
                background-color: #f8f9fa;
                padding: 15px;
                border-radius: 4px;
                margin: 15px 0;
            }
            .data-row {
                display: flex;
                margin-bottom: 8px;
            }
            .data-label {
                font-weight: bold;
                width: 80px;
                color: #555;
            }
            .data-value {
                color: #333;
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
            .btn-danger {
                background-color: #dc3545;
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
            .alert-error {
                color: #721c24;
                background-color: #f8d7da;
                border-color: #f5c6cb;
            }
            .button-group {
                text-align: center;
                margin-top: 20px;
            }
            .icon {
                font-size: 48px;
                text-align: center;
                margin-bottom: 20px;
                color: #dc3545;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="icon">⚠️</div>
            <h1>Hapus Data Mahasiswa</h1>
            
            <!-- Pesan error -->
            <% if (!message.isEmpty()) { %>
            <div class="alert alert-<%= messageType %>">
                <%= message %>
            </div>
            <% } %>
            
            <div class="warning-box">
                <div class="warning-title">Peringatan!</div>
                <div class="warning-text">
                    Anda akan menghapus data mahasiswa berikut. Tindakan ini tidak dapat dibatalkan.
                </div>
                
                <div class="data-info">
                    <div class="data-row">
                        <div class="data-label">ID:</div>
                        <div class="data-value"><%= mahasiswa.id %></div>
                    </div>
                    <div class="data-row">
                        <div class="data-label">NIM:</div>
                        <div class="data-value"><%= mahasiswa.nim %></div>
                    </div>
                    <div class="data-row">
                        <div class="data-label">Nama:</div>
                        <div class="data-value"><%= mahasiswa.nama %></div>
                    </div>
                    <div class="data-row">
                        <div class="data-label">Nilai:</div>
                        <div class="data-value"><%= mahasiswa.nilai %></div>
                    </div>
                </div>
                
                <div class="warning-text">
                    Apakah Anda yakin ingin menghapus data ini?
                </div>
            </div>
            
            <form method="POST" action="hapus.jsp?id=<%= mahasiswa.id %>">
                <div class="button-group">
                    <button type="submit" name="action" value="delete" class="btn btn-danger">
                        Ya, Hapus Data
                    </button>
                    <button type="submit" name="action" value="cancel" class="btn btn-secondary">
                        Batal
                    </button>
                </div>
            </form>
        </div>
        
        <script>
            // Auto focus pada tombol batal untuk keamanan
            document.querySelector('button[value="cancel"]').focus();
        </script>
    </body>
</html>
<%
    } catch (NumberFormatException e) {
        response.sendRedirect("index.jsp?message=ID tidak valid&type=error");
        return;
    }
%>