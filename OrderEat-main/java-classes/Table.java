package omadikh;

public class Table {
    private int tableId;
    private String status;
    private String balance;

    // Constructor
    public Table(int tableId, String status, String balance) {
        this.tableId = tableId;
        this.status = status;
        this.balance = balance;
    }

    // Default Constructor
    public Table() {}

    // Getters and Setters
    public int getTableId() {
        return tableId;
    }

    public void setTableId(int tableId) {
        this.tableId = tableId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBalance() {
        return balance;
    }

    public void setBalance(String balance) {
        this.balance = balance;
    }

    // Method to call the waiter
    public void callWaiter() {
        System.out.println("Waiter called for Table ID: " + tableId);
    }

    // Override toString for better representation
    @Override
    public String toString() {
        return "Table {" +
                "tableId=" + tableId +
                ", status='" + status + '\'' +
                ", balance='" + balance + '\'' +
                '}';
    }
}