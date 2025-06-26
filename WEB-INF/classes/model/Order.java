package model;

import java.util.Date;
import java.util.List;

public class Order {
    private int orderNumber;
    private String paymentMethod;
    private double totalPrice;
    private Date orderDate;
    private List<OrderItem> items;
    private String user; 

    
    public Order(int orderNumber, String paymentMethod, double totalPrice, Date orderDate, List<OrderItem> items, String user) {
        this.orderNumber = orderNumber;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.items = items;
        this.user = user;
    }

   
    public Order(int orderNumber, String paymentMethod, double totalPrice, Date orderDate, List<OrderItem> items) {
        this(orderNumber, paymentMethod, totalPrice, orderDate, items, null);
    }

    // Getters e Setters
    public int getOrderNumber() {
        return orderNumber;
    }

    public void setOrderNumber(int orderNumber) {
        this.orderNumber = orderNumber;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

  
    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }
}

