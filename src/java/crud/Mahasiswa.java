/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Andika
 */
package crud;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Mahasiswa {
    public int id;
    public String nim;
    public String nama;
    public Integer nilai;
    
    // Constructor kosong
    public Mahasiswa() {}
    
    // Constructor dengan parameter
    public Mahasiswa(String nim, String nama, Integer nilai) {
        this.nim = nim;
        this.nama = nama;
        this.nilai = nilai;
    }
    
    // Constructor lengkap dengan id
    public Mahasiswa(int id, String nim, String nama, Integer nilai) {
        this.id = id;
        this.nim = nim;
        this.nama = nama;
        this.nilai = nilai;
    }
    
    // Method untuk menambah data mahasiswa
    public boolean tambah() {
        Connection conn = null;
        PreparedStatement st = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "INSERT INTO mahasiswa (nim, nama, nilai) VALUES (?, ?, ?)";
            st = conn.prepareStatement(sql);
            st.setString(1, this.nim);
            st.setString(2, this.nama);
            st.setInt(3, this.nilai);
            
            int result = st.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.closeStatement(st);
            DatabaseConnection.closeConnection(conn);
        }
    }
    
    // Method untuk mengupdate data mahasiswa
    public boolean update() {
        Connection conn = null;
        PreparedStatement st = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "UPDATE mahasiswa SET nim = ?, nama = ?, nilai = ? WHERE id = ?";
            st = conn.prepareStatement(sql);
            st.setString(1, this.nim);
            st.setString(2, this.nama);
            st.setInt(3, this.nilai);
            st.setInt(4, this.id);
            
            int result = st.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.closeStatement(st);
            DatabaseConnection.closeConnection(conn);
        }
    }
    
    // Method untuk menghapus data mahasiswa
    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "DELETE FROM mahasiswa WHERE id = ?";
            st = conn.prepareStatement(sql);
            st.setInt(1, this.id);
            
            int result = st.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            DatabaseConnection.closeStatement(st);
            DatabaseConnection.closeConnection(conn);
        }
    }
    
    // Method untuk mendapatkan data mahasiswa berdasarkan ID
    public static Mahasiswa getById(int id) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM mahasiswa WHERE id = ?";
            st = conn.prepareStatement(sql);
            st.setInt(1, id);
            rs = st.executeQuery();
            
            if (rs.next()) {
                return new Mahasiswa(
                    rs.getInt("id"),
                    rs.getString("nim"),
                    rs.getString("nama"),
                    rs.getInt("nilai")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.closeResultSet(rs);
            DatabaseConnection.closeStatement(st);
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }
    
    // Method untuk mendapatkan semua data mahasiswa
    public static List<Mahasiswa> getAll() {
        List<Mahasiswa> mahasiswaList = new ArrayList<>();
        Connection conn = null;
        Statement st = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT * FROM mahasiswa ORDER BY id DESC");
            
            while (rs.next()) {
                mahasiswaList.add(new Mahasiswa(
                    rs.getInt("id"),
                    rs.getString("nim"),
                    rs.getString("nama"),
                    rs.getInt("nilai")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.closeResultSet(rs);
            DatabaseConnection.closeStatement(st);
            DatabaseConnection.closeConnection(conn);
        }
        return mahasiswaList;
    }
    
    // Method untuk mencari mahasiswa berdasarkan NIM
    public static Mahasiswa getByNim(String nim) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM mahasiswa WHERE nim = ?";
            st = conn.prepareStatement(sql);
            st.setString(1, nim);
            rs = st.executeQuery();
            
            if (rs.next()) {
                return new Mahasiswa(
                    rs.getInt("id"),
                    rs.getString("nim"),
                    rs.getString("nama"),
                    rs.getInt("nilai")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.closeResultSet(rs);
            DatabaseConnection.closeStatement(st);
            DatabaseConnection.closeConnection(conn);
        }
        return null;
    }
    
    // Method untuk validasi NIM unik (untuk insert)
    public static boolean isNimExists(String nim) {
        return getByNim(nim) != null;
    }
    
    // Method untuk validasi NIM unik (untuk update)
    public static boolean isNimExistsForUpdate(String nim, int id) {
        Connection conn = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        
        try {
            conn = DatabaseConnection.getConnection();
            String sql = "SELECT COUNT(*) as count FROM mahasiswa WHERE nim = ? AND id != ?";
            st = conn.prepareStatement(sql);
            st.setString(1, nim);
            st.setInt(2, id);
            rs = st.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DatabaseConnection.closeResultSet(rs);
            DatabaseConnection.closeStatement(st);
            DatabaseConnection.closeConnection(conn);
        }
        return false;
    }
}
