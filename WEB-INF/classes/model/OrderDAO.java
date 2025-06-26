package model;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    /* ------------------------------------------------------------------
       Salva un nuovo ordine
    ------------------------------------------------------------------ */
    public void saveOrder(String email, Order order) throws Exception {
        try (Connection conn = DatabaseConnection.getConnection()) {

            String sql = """
                INSERT INTO orders
                (user, comic_id, comic_title, quantity,
                 payment_method, order_number, total_price,
                 order_date, price_at_purchase)
                VALUES (?, ?, ?, ?, ?, ?, ?, NOW(), ?)
                """;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                for (OrderItem item : order.getItems()) {
                    int comicId = getComicIdByTitle(item.getTitle());
                    stmt.setString(1, email);
                    stmt.setInt   (2, comicId);
                    stmt.setString(3, item.getTitle());
                    stmt.setInt   (4, item.getQuantity());
                    stmt.setString(5, order.getPaymentMethod());
                    stmt.setInt   (6, order.getOrderNumber());
                    stmt.setDouble(7, order.getTotalPrice());
                    stmt.setBigDecimal(8, BigDecimal.valueOf(item.getPrice()));
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }
        }
    }

    /* ------------------------------------------------------------------
       Recupera tutti gli ordini di un utente
    ------------------------------------------------------------------ */
    public List<Order> getOrdersByUser(String email) throws Exception {
        List<Order> orders = new ArrayList<>();

        try (Connection conn = DatabaseConnection.getConnection()) {

            String sql = """
                SELECT order_number, payment_method,
                       MAX(total_price)  AS total_price,
                       MAX(order_date)   AS order_date
                FROM orders
                WHERE user = ?
                GROUP BY order_number, payment_method
                ORDER BY order_number DESC
                """;

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    int        orderNum  = rs.getInt("order_number");
                    String     payMethod = rs.getString("payment_method");
                    double     totPrice  = rs.getDouble("total_price");
                    Timestamp  ordDate   = rs.getTimestamp("order_date");

                    /* --- articoli dell’ordine --- */
                    List<OrderItem> items = new ArrayList<>();
                    String itemSql = """
                        SELECT o.comic_id, o.comic_title, o.quantity,
                               o.price_at_purchase, c.image
                        FROM orders o
                        JOIN comics c ON c.id = o.comic_id
                        WHERE o.user = ? AND o.order_number = ?
                        """;

                    try (PreparedStatement ps = conn.prepareStatement(itemSql)) {
                        ps.setString(1, email);
                        ps.setInt   (2, orderNum);
                        ResultSet its = ps.executeQuery();

                        while (its.next()) {
                            int    id    = its.getInt   ("comic_id");
                            String title = its.getString("comic_title");
                            int    qty   = its.getInt   ("quantity");
                            double price = its.getDouble("price_at_purchase");
                            String img   = its.getString("image"); // può essere null
                            items.add(new OrderItem(id, title, qty, price, img));
                        }
                    }

                    orders.add(new Order(orderNum, payMethod, totPrice, ordDate, items, email));
                }
            }
        }
        return orders;
    }

    public int getComicIdByTitle(String title) throws Exception {
        String q = "SELECT id FROM comics WHERE title = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(q)) {

            ps.setString(1, title);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
            throw new Exception("Fumetto non trovato: " + title);
        }
    }

}
