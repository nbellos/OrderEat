package omadikh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TableDAO {

    private static final String TABLE_NAME = "restaurant_table";

    public TableDAO() {}

    // THESE FUNCTIONS WILL FOR SURE GONNA BE USED BUT FOR NOW THEY WILL
    // REMAIN COMMENTED AND WE WILL KEEP ONLY THE CALLWAITER

    // /**
    //  * Fetches a table by its ID.
    //  *
    //  * @param tableId The ID of the table.
    //  * @return The Table object or null if not found.
    //  * @throws Exception if there's an issue during the operation.
    //  */
    // public Table getTableById(int tableId) throws Exception {
    //     DB db = new DB();
    //     Connection connection = null;
    //     PreparedStatement statement = null;
    //     ResultSet resultSet = null;

    //     try {
    //         connection = db.getConnection();

    //         String query = "SELECT * FROM " + TABLE_NAME + " WHERE tableId = ?";
    //         statement = connection.prepareStatement(query);
    //         statement.setInt(1, tableId);

    //         resultSet = statement.executeQuery();

    //         if (resultSet.next()) {
    //             return new Table(
    //                     resultSet.getInt("tableId"),
    //                     resultSet.getString("status"),
    //                     resultSet.getString("balance")
    //             );
    //         } else {
    //             return null;
    //         }

    //     } catch (Exception e) {
    //         throw new Exception("Error fetching table: " + e.getMessage(), e);
    //     } finally {
    //         closeResources(resultSet, statement, connection);
    //     }
    // }

    /**
     * Updates the status of a table.
     *
     * @param tableId The ID of the table.
     * @param newStatus The new status to set.
     * @throws Exception if there's an issue during the operation.
     */
    public void updateTableStatus(int tableId, String newStatus) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = db.getConnection();

            String updateQuery = "UPDATE " + TABLE_NAME + " SET status = ? WHERE tableId = ?";
            statement = connection.prepareStatement(updateQuery);
            statement.setString(1, newStatus);
            statement.setInt(2, tableId);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Table status updated successfully for Table ID: " + tableId);
            } else {
                System.out.println("No table found with Table ID: " + tableId);
            }

        } catch (Exception e) {
            throw new Exception("Error updating table status: " + e.getMessage(), e);
        } finally {
            closeResources(statement, connection);
        }
    }

    // /**
    //  * Retrieves all tables from the database.
    //  *
    //  * @return A list of Table objects.
    //  * @throws Exception if there's an issue during the operation.
    //  */
    // public List<Table> getAllTables() throws Exception {
    //     DB db = new DB();
    //     Connection connection = null;
    //     PreparedStatement statement = null;
    //     ResultSet resultSet = null;
    //     List<Table> tables = new ArrayList<>();

    //     try {
    //         connection = db.getConnection();

    //         String query = "SELECT * FROM " + TABLE_NAME;
    //         statement = connection.prepareStatement(query);

    //         resultSet = statement.executeQuery();

    //         while (resultSet.next()) {
    //             Table table = new Table(
    //                     resultSet.getInt("tableId"),
    //                     resultSet.getString("status"),
    //                     resultSet.getString("balance")
    //             );
    //             tables.add(table);
    //         }

    //     } catch (Exception e) {
    //         throw new Exception("Error retrieving tables: " + e.getMessage(), e);
    //     } finally {
    //         closeResources(resultSet, statement, connection);
    //     }

    //     return tables;
    // }

    /**
     * Simulates the "call waiter" operation.
     *
     * @param tableId The ID of the table calling the waiter.
     */
    public void callWaiter(int tableId) {
        // HERE WE WILL ADD MORE LOGIC REGARDING HOW THE CALL WILL BE
        // LIKE A NOTIFICATION SOME WHERE OR SIMPLY NO OP?
        System.out.println("Waiter called for Table ID: " + tableId);
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