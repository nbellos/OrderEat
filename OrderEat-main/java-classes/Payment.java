package omadikh;

import java.util.Date;

public class Payment {
    private int paymentId;
    private int orderId;
    private Date paymentDate;
    private String amount;

    // Constructor
    public Payment(int paymentId, int orderId, Date paymentDate, String amount) {
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.paymentDate = paymentDate;
        this.amount = amount;
    }

    // Default Constructor
    public Payment() {}

    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getAmount() {
        return amount;
    }

    public void setAmount(String amount) {
        this.amount = amount;
    }

    @Override
    public String toString() {
        return "Payment{" +
                "paymentId=" + paymentId +
                ", orderId=" + orderId +
                ", paymentDate=" + paymentDate +
                ", amount='" + amount + '\'' +
                '}';
    }
}