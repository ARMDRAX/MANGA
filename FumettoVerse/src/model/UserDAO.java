package model;

import java.sql.*;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class UserDAO {

    // Metodo per hashare la password con SHA-256
	public String hashPassword(String password) throws NoSuchAlgorithmException {
	    MessageDigest md = MessageDigest.getInstance("SHA-256");
	    byte[] hashBytes = md.digest(password.getBytes(StandardCharsets.UTF_8));  // Usa UTF-8 esplicitamente
	    StringBuilder sb = new StringBuilder();
	    for (byte b : hashBytes) {
	        sb.append(String.format("%02x", b));
	    }
	    return sb.toString();
	}


    public void registerUser(String name, String email, String password) throws Exception {
        String hashedPassword = hashPassword(password);

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO users (name, email, password, is_admin) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, hashedPassword);
                stmt.setBoolean(4, false); // per default non admin
                stmt.executeUpdate();
            }
        }
    }

    public User doLogin(String email, String password) throws Exception {
        String hashedPassword = hashPassword(password);
        System.out.println("Tentativo login con email: '" + email + "', password hashata: '" + hashedPassword + "'");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, hashedPassword);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    boolean isAdmin = rs.getBoolean("is_admin");
                    System.out.println("Login riuscito per utente: " + name);
                    return new User(id, name, email, isAdmin);
                } else {
                    System.out.println("Nessun utente trovato con email e password date.");
                    return null;
                }
            }
        }
    }
}