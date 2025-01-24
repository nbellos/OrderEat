package omadikh;

import java.util.Date;
import java.util.List;

public class Order {

    // Attributes
    private String orderId;
    private String tableId;
    private List<MenuItem> menuItems; // Assuming MenuItem is another class
    private Date orderDate;
    private String bill;
    private Boolean payed;

    // Constructor
    public Order(String orderId, String tableId, List<MenuItem> menuItems , Date orderDate, String bill, Boolean payed) {
        this.orderId = orderId;
        this.tableId = tableId;
        this.menuItems = menuItems;
        this.orderDate = orderDate;
        this.bill = bill;
        this.payed = payed;
    }

    // Getters and Setters
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getTableId() {
        return tableId;
    }

    public void setTableId(String tableId) {
        this.tableId = tableId;
    }

    public List<MenuItem> getMenuItems() {
        return menuItems;
    }

    public void setMenuItems(List<MenuItem> menuItems) {
        this.menuItems = menuItems;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getBill() {
        return bill;
    }

    public void setBill(String bill) {
        this.bill = bill;
    }

    public Boolean getPayed() {
        return payed;
    }

    public void setPayed(Boolean payed) {
        this.payed = payed;
    }

    // toString method to display Order details
    @Override
    public String toString() {
        return "Order {" +
                "orderId='" + orderId + '\'' +
                ", tableId='" + tableId + '\'' +
                ", orderDate=" + orderDate +
                ", bill='" + bill + '\'' +
                '}';
    }
}