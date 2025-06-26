package model;

<<<<<<< HEAD
import java.sql.*;

public class ComicDAO {

=======


import model.DatabaseConnection;
import java.sql.*;

public class ComicDAO {
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
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

<<<<<<< HEAD
    public void updateComic(int id, String title, double price, String tipo, String image) throws Exception {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE comics SET title = ?, price = ?, tipo = ?, image = ? WHERE id = ?";
=======
    public void updateComic(int id, String title, double price, String tipo) throws Exception {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "UPDATE comics SET title = ?, price = ?, tipo = ? WHERE id = ?";
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, title);
                stmt.setDouble(2, price);
                stmt.setString(3, tipo);
<<<<<<< HEAD
                stmt.setString(4, image);
                stmt.setInt(5, id);
=======
                stmt.setInt(4, id);
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
                stmt.executeUpdate();
            }
        }
    }
<<<<<<< HEAD
}
=======
}
>>>>>>> a365fcfeb0018ec9b95aa9c4e6a8aa230cf35c24
