package omadikh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.Statement;

public class OrderDAO {

    private static final String TABLE_NAME = "order_table";
    private static final String ORDER_ITEMS_TABLE = "order_items";

    public OrderDAO() {
    }

    /**
     * Places an order into the database, including its associated menu items.
     *
     * @param order The Order object to be added to the database.
     * @throws Exception if there's an issue during the operation.
     */
    public void placeOrder(Order order) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement orderStatement = null;
        PreparedStatement itemsStatement = null;

        try {
            connection = db.getConnection();
            connection.setAutoCommit(false); // Start transaction

            // Insert the order into the "orders" table
            String insertOrderQuery = "INSERT INTO " + TABLE_NAME + " (tableId, orderDate, bill, payed) VALUES (?, ?, ?, ?)";
            orderStatement = connection.prepareStatement(insertOrderQuery, Statement.RETURN_GENERATED_KEYS);
            orderStatement.setString(1, order.getTableId());
            orderStatement.setDate(2, new java.sql.Date(order.getOrderDate().getTime()));
            orderStatement.setString(3, order.getBill());
            orderStatement.setBoolean(4, order.getPayed());
            orderStatement.executeUpdate();

            ResultSet generatedKeys = orderStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                int generatedOrderId = generatedKeys.getInt(1);
                order.setOrderId(String.valueOf(generatedOrderId)); // Set the ID to the order object
            } else {
                throw new Exception("Failed to retrieve generated order ID.");
            }

            // Insert associated menu items into "order_order_items" table
            String insertItemsQuery = "INSERT INTO " + ORDER_ITEMS_TABLE + " (orderId, itemId, quantity) VALUES (?, ?, ?)";
            itemsStatement = connection.prepareStatement(insertItemsQuery);

            for (MenuItem item : order.getMenuItems()) {
                itemsStatement.setString(1, order.getOrderId());
                itemsStatement.setInt(2, item.getItemId());
                itemsStatement.setInt(3, item.getQuantity());
                itemsStatement.addBatch();
            }
            itemsStatement.executeBatch();

            connection.commit(); // Commit transaction
            System.out.println("Order placed successfully with Order ID: " + order.getOrderId());

        } catch (Exception e) {
            if (connection != null) connection.rollback();
            throw new Exception("Error placing order: " + e.getMessage(), e);
        } finally {
            closeResources(orderStatement, itemsStatement, connection);
        }
    }

    /**
     * Calculates the total bill for a specific order and updates it in the database.
     *
     * @param orderId The ID of the order.
     * @return The total bill amount.
     * @throws Exception if there's an issue during the operation.
     */
    public float calculateBill(String orderId) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        float totalBill = 0.0f;

        try {
            connection = db.getConnection();

            // Query to fetch the prices of all menu items for the given order
            String query = "SELECT mi.price FROM order_items mi JOIN order_order_items omi ON mi.itemId = omi.itemId WHERE omi.orderId = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, orderId);
            resultSet = statement.executeQuery();

            // Sum up the prices
            while (resultSet.next()) {
                totalBill += resultSet.getFloat("price");
            }

            // Update the total bill in the "orders" table
            String updateQuery = "UPDATE " + TABLE_NAME + " SET bill = ? WHERE orderId = ?";
            try (PreparedStatement updateStatement = connection.prepareStatement(updateQuery)) {
                updateStatement.setString(1, String.format("%.2f", totalBill));
                updateStatement.setString(2, orderId);
                updateStatement.executeUpdate();
            }

            System.out.println("Total bill for Order ID " + orderId + " is $" + totalBill);

        } catch (Exception e) {
            throw new Exception("Error calculating bill: " + e.getMessage(), e);
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return totalBill;
    }

    /**
     * Retrieves and lists all orders from the database.
     *
     * @return A list of Order objects.
     * @throws Exception if there's an issue during the operation.
     */
    public List<Order> manageOrders() throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        List<Order> orders = new ArrayList<>();

        try {
            connection = db.getConnection();

            // Query to fetch all orders
            String query = "SELECT * FROM " + TABLE_NAME;
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String orderId = resultSet.getString("orderId");
                String tableId = resultSet.getString("tableId");
                Date orderDate = resultSet.getDate("orderDate");
                String bill = resultSet.getString("bill");
                Boolean payed = resultSet.getBoolean("payed");

                orders.add(new Order(orderId, tableId, null, orderDate, bill, payed)); // MenuItems not loaded here
                System.out.println("Order ID: " + orderId + ", Table ID: " + tableId + ", Bill: $" + bill);
            }

        } catch (Exception e) {
            throw new Exception("Error managing orders: " + e.getMessage(), e);
        } finally {
            closeResources(resultSet, statement, connection);
        }

        return orders;
    }
    /**
     * Fetches all items for all orders associated with a given table ID.
     *
     * @param tableId The ID of the table to fetch items for.
     * @return A list of OrderItem objects.
     * @throws Exception if there's an issue during the operation.
     */
    public List<MenuItem> getOrderItemsByTable(String tableId) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement orderStatement = null;
        PreparedStatement itemStatement = null;
        PreparedStatement menuItemStatement = null;
        ResultSet orderResultSet = null;
        ResultSet itemResultSet = null;
        ResultSet menuItemResultSet = null;

        List<MenuItem> menuItems = new ArrayList<>();

        try {
            connection = db.getConnection();

            // Step 1: Fetch unpaid orders by tableId
            String orderQuery = "SELECT orderId FROM order_table WHERE tableId = ? AND payed = FALSE";
            orderStatement = connection.prepareStatement(orderQuery);
            orderStatement.setString(1, tableId);
            orderResultSet = orderStatement.executeQuery();

            // Step 2: Fetch items for each orderId
            String itemQuery = "SELECT * FROM order_items WHERE orderId = ?";
            itemStatement = connection.prepareStatement(itemQuery);

            while (orderResultSet.next()) {
                int orderId = orderResultSet.getInt("orderId");

                // Set orderId parameter and execute query
                itemStatement.setInt(1, orderId);
                itemResultSet = itemStatement.executeQuery();


                while (itemResultSet.next()) {
                    int itemId = itemResultSet.getInt("itemId");
                    int quantity = itemResultSet.getInt("quantity");

                    // Step 3: Fetch menu item details from the menu table
                    String menuItemQuery = "SELECT * FROM menu WHERE itemId = ?";
                    menuItemStatement = connection.prepareStatement(menuItemQuery);
                    menuItemStatement.setInt(1, itemId);
                    menuItemResultSet = menuItemStatement.executeQuery();

                    while (menuItemResultSet.next()) {
                        String name = menuItemResultSet.getString("name");
                        String description = menuItemResultSet.getString("description");
                        float price = menuItemResultSet.getFloat("price");
                        String category = menuItemResultSet.getString("category");
            
                        // Check if the menu item already exists in the list
                        boolean itemExists = false;
                        for (MenuItem existingItem : menuItems) {
                            if (existingItem.getItemId() == itemId) {
                                // Increase quantity if item exists
                                existingItem.setQuantity(existingItem.getQuantity() + quantity);
                                itemExists = true;
                                break;
                            }
                        }
            
                        // If the item does not exist, add it to the list
                        if (!itemExists) {
                            MenuItem menuItem = new MenuItem(itemId, name, description, price, category);
                            menuItem.setQuantity(quantity);
                            menuItems.add(menuItem);
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw new Exception("Error fetching order items: " + e.getMessage(), e);
        } finally {
            // Ensure resources are closed
            closeResources(orderResultSet, orderStatement, null);
            closeResources(itemResultSet, itemStatement, null);
            closeResources(null, null, connection);
        }

        return menuItems;
    }


    /**
     * Fetches all orders associated with a given table ID.
     *
     * @param tableId The ID of the table to fetch items for.
     * @return A list of Order Ids.
     * @throws Exception if there's an issue during the operation.
     */
    public List<String> getOrderIDsByTable(String tableId) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement orderStatement = null;
        ResultSet orderResultSet = null;

        List<String> orderIds = new ArrayList<>();

        try {
            connection = db.getConnection();

            // Step 1: Fetch unpaid orders by tableId
            String orderQuery = "SELECT orderId FROM order_table WHERE tableId = ? AND payed = FALSE";
            orderStatement = connection.prepareStatement(orderQuery);
            orderStatement.setString(1, tableId);
            orderResultSet = orderStatement.executeQuery();

            while (orderResultSet.next()) {
                int orderId = orderResultSet.getInt("orderId");
                orderIds.add(String.valueOf(orderId));
            }
        } catch (Exception e) {
            throw new Exception("Error fetching order items: " + e.getMessage(), e);
        } finally {
            // Ensure resources are closed
            closeResources(orderResultSet, orderStatement, null);
            closeResources(null, null, connection);
        }

        return orderIds;
    }

    /**
         * Retrieves and lists all orders from the database.
         *
         * @return A list of Order objects.
         * @throws Exception if there's an issue during the operation.
         */
        public List<Order> retrieveOrdersByTable(String tableId) throws Exception {
            DB db = new DB();
            Connection connection = null;
            PreparedStatement statement = null;
            ResultSet resultSet = null;

            List<Order> orders = new ArrayList<>();

            try {
                connection = db.getConnection();

                // Query to fetch all orders
                String query = "SELECT * FROM order_table WHERE tableId = ? AND payed = FALSE";
                statement = connection.prepareStatement(query);
                statement.setString(1, tableId);
                
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    String orderId = resultSet.getString("orderId");
                    Date orderDate = resultSet.getDate("orderDate");
                    String bill = resultSet.getString("bill");
                    Boolean payed = resultSet.getBoolean("payed");

                    orders.add(new Order(orderId, tableId, null, orderDate, bill, payed)); // MenuItems not loaded here
                    System.out.println("Order ID: " + orderId + ", Table ID: " + tableId + ", Bill: $" + bill);
                }

            } catch (Exception e) {
                throw new Exception("Error managing orders: " + e.getMessage(), e);
            } finally {
                closeResources(resultSet, statement, connection);
            }

            return orders;
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