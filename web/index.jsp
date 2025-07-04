<%-- 
    Document   : index
    Created on : Jul 4, 2025, 1:15:46 PM
    Author     : Andika
--%>
<%@page import="crud.Mahasiswa"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Mahasiswa> mahasiswaList = Mahasiswa.getAll();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Mahasiswa</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f5f5f5;
            }
            .container {
                max-width: 1000px;
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
            .btn {
                display: inline-block;
                padding: 10px 20px;
                margin: 5px;
                text-decoration: none;
                border-radius: 4px;
                font-size: 14px;
                cursor: pointer;
                border: none;
            }
            .btn-primary {
                background-color: #007bff;
                color: white;
            }
            .btn-success {
                background-color: #28a745;
                color: white;
            }
            .btn-warning {
                background-color: #ffc107;
                color: black;
            }
            .btn-danger {
                background-color: #dc3545;
                color: white;
            }
            .btn:hover {
                opacity: 0.8;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 12px;
                text-align: left;
            }
            th {
                background-color: #f8f9fa;
                font-weight: bold;
            }
            tr:nth-child(even) {
                background-color: #f8f9fa;
            }
            .action-buttons {
                white-space: nowrap;
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
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Data Mahasiswa</h1>
            
            <!-- Pesan sukses/error -->
            <%
                String message = request.getParameter("message");
                String type = request.getParameter("type");
                if (message != null && type != null) {
            %>
            <div class="alert alert-<%= type %>">
                <%= message %>
            </div>
            <% } %>
            
            <a href="tambah.jsp" class="btn btn-primary">Tambah Mahasiswa Baru</a>
            
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>NIM</th>
                        <th>Nama</th>
                        <th>Nilai</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (mahasiswaList.isEmpty()) {
                    %>
                    <tr>
                        <td colspan="5" style="text-align: center; color: #666;">
                            Tidak ada data mahasiswa
                        </td>
                    </tr>
                    <%
                        } else {
                            for (Mahasiswa m : mahasiswaList) {
                    %>
                    <tr>
                        <td><%= m.id %></td>
                        <td><%= m.nim %></td>
                        <td><%= m.nama %></td>
                        <td><%= m.nilai %></td>
                        <td class="action-buttons">
                            <a href="edit.jsp?id=<%= m.id %>" class="btn btn-warning">Edit</a>
                            <a href="hapus.jsp?id=<%= m.id %>" class="btn btn-danger" 
                               onclick="return confirm('Apakah Anda yakin ingin menghapus data <%= m.nama %>?')">
                               Hapus
                            </a>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>