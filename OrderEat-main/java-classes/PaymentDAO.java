package omadikh;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PaymentDAO {

    private static final String TABLE_NAME = "payment";

    public PaymentDAO() {}

    /**
     * Inserts a new payment record into the database.
     *
     * @param payment The Payment object containing payment details.
     * @throws Exception if there's an issue during the operation.
     */
    public void makePayment(Payment payment) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = db.getConnection();

            String insertQuery = "INSERT INTO " + TABLE_NAME + " (orderId, paymentDate, amount) VALUES (?, ?, ?)";
            statement = connection.prepareStatement(insertQuery);
            statement.setInt(1, payment.getOrderId());
            statement.setDate(2, new java.sql.Date(payment.getPaymentDate().getTime()));
            statement.setString(3, payment.getAmount());

            statement.executeUpdate();
            System.out.println("Payment successfully made with Payment ID: " + payment.getPaymentId());

            String updateQuery = "UPDATE order_table SET payed = 1 WHERE orderId = ?";
            PreparedStatement statementNew = connection.prepareStatement(updateQuery);

            // Assuming `orderId` is the parameter you want to pass
            statementNew.setInt(1, payment.getOrderId());

            statementNew.executeUpdate();

        } catch (Exception e) {
            throw new Exception("Error inserting payment: " + e.getMessage(), e);
        } finally {
            closeResources(statement, connection);
        }
    }

    // Utility method to close resources
    private void closeResources(AutoCloseable... resources) {
        for (AutoCloseable resource : resources) {
            if (resource != null) {
                try {
                    resource.close();
                } catch (Exception e) {
                    System.err.println("Error closing resource: " + e.getMessage());
                }
            }
        }
    }
}