package model;

import java.sql.*;
import java.util.List;
import java.util.Map;

public class OrderDAO {

    public void saveOrder(String email, List<Integer> cart, Map<Integer, Integer> quantities,
                          String paymentMethod, double totalPrice, int orderNumber) throws Exception {

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO orders (user, comic_id, quantity, payment_method, order_number, total_price, order_date) " +
                         "VALUES (?, ?, ?, ?, ?, ?, NOW())";

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (Integer comicId : cart) {
                    int quantity = quantities.getOrDefault(comicId, 1);
                    stmt.setString(1, email);
                    stmt.setInt(2, comicId);
                    stmt.setInt(3, quantity);
                    stmt.setString(4, paymentMethod);
                    stmt.setInt(5, orderNumber);
                    stmt.setDouble(6, totalPrice);
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }
        }
    }
}

