package model;

import java.math.BigDecimal;
import java.sql.*;
import java.util.List;
import java.util.Map;

public class OrderDAO {

    public void saveOrder(String email, List<Integer> cart, Map<Integer, Integer> quantities,
                          String paymentMethod, double totalPrice, int orderNumber) throws Exception {

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO orders (user, comic_id, comic_title, quantity, payment_method, order_number, total_price, order_date, price_at_purchase) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), ?)";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (Integer comicId : cart) {
                    int quantity = quantities.getOrDefault(comicId, 1);

                    // Ottieni il titolo e il prezzo attuale del fumetto
                    String title = "";
                    BigDecimal priceAtPurchase = BigDecimal.ZERO;

                    try (PreparedStatement infoStmt = conn.prepareStatement("SELECT title, price FROM comics WHERE id = ?")) {
                        infoStmt.setInt(1, comicId);
                        try (ResultSet rs = infoStmt.executeQuery()) {
                            if (rs.next()) {
                                title = rs.getString("title");
                                priceAtPurchase = rs.getBigDecimal("price");
                            }
                        }
                    }

                    // Inserisci tutti i dati, inclusi titolo e prezzo
                    stmt.setString(1, email);
                    stmt.setInt(2, comicId);
                    stmt.setString(3, title);
                    stmt.setInt(4, quantity);
                    stmt.setString(5, paymentMethod);
                    stmt.setInt(6, orderNumber);
                    stmt.setDouble(7, totalPrice);
                    stmt.setBigDecimal(8, priceAtPurchase);

                    stmt.addBatch();
                }
                stmt.executeBatch();
            }
        }
    }
}

