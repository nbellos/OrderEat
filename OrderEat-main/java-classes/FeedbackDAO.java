package omadikh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;

public class FeedbackDAO {
    private static final String TABLE_NAME = "feedback";

    public FeedbackDAO() {}

    /**
     * Inserts a new feedback record into the database.
     *
     * @param feedback The Feedback object containing feedback details.
     * @throws Exception if there's an issue during the operation.
     */
    public void makeFeedback(Feedback feedback) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = db.getConnection();

            String insertQuery = "INSERT INTO " + TABLE_NAME + " (customerId, rating, comment, date) VALUES (?, ?, ?, ?)";
            statement = connection.prepareStatement(insertQuery);
            statement.setString(1, feedback.getCustomerId());
            statement.setString(2, feedback.getRating());
            statement.setString(3, feedback.getComment());
            statement.setDate(4, new java.sql.Date(feedback.getDate().getTime()));

            statement.executeUpdate();
            System.out.println("Feedback successfully added for Customer ID: " + feedback.getCustomerId());
        } catch (Exception e) {
            throw new Exception("Error inserting feedback: " + e.getMessage(), e);
        } finally {
            closeResources(statement, connection);
        }
    }

    /**
     * Retrieves all feedback records from the database.
     *
     * @return A list of Feedback objects.
     * @throws Exception if there's an issue during the operation.
     */
    public List<Feedback> viewFeedback() throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        List<Feedback> feedbackList = new ArrayList<>();

        try {
            connection = db.getConnection();

            String query = "SELECT * FROM " + TABLE_NAME;
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String feedbackId = resultSet.getString("feedbackId");
                String customerId = resultSet.getString("customerId");
                String rating = resultSet.getString("rating");
                String comment = resultSet.getString("comment");
                Date date = resultSet.getDate("date");

                Feedback feedback = new Feedback(feedbackId, customerId, rating, comment, date);
                feedbackList.add(feedback);
            }

            System.out.println("Retrieved " + feedbackList.size() + " feedback records.");
        } catch (Exception e) {
            throw new Exception("Error retrieving feedback: " + e.getMessage(), e);
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return feedbackList;
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