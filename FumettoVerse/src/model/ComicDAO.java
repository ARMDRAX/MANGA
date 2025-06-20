package model;



import model.DatabaseConnection;
import java.sql.*;

public class ComicDAO {
    public void addComic(String title, double price, String tipo, String image) throws Exception {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO comics (title, price, tipo, image) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, title);
                stmt.setDouble(2, price);
                stmt.setString(3, tipo);
                stmt.setString(4, image);
                stmt.executeUpdate();
            }
        }
    }

    public void deleteComic(int id) throws Exception {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "DELETE FROM comics WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }
        }
    }

    public void updateComic(int id, String title, double price, String tipo) throws Exception {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE comics SET title = ?, price = ?, tipo = ? WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, title);
                stmt.setDouble(2, price);
                stmt.setString(3, tipo);
                stmt.setInt(4, id);
                stmt.executeUpdate();
            }
        }
    }
}