package omadikh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import omadikh.OrderStats;
import java.util.Date;

public class AdminStats {

    /**
     * Fetches the percentage distribution of item types (food, sweet, drink)
     * from all unpaid orders associated with a given table ID.
     *
     * @param tableId The ID of the table to fetch items for.
     * @return A map with the item type as the key and its percentage as the value.
     * @throws Exception if there's an issue during the operation.
     */
    public Map<String, Double> getItemTypePercentagesByTable(String tableId) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement orderStatement = null;
        PreparedStatement itemStatement = null;
        PreparedStatement menuItemStatement = null;
        ResultSet orderResultSet = null;
        ResultSet itemResultSet = null;
        ResultSet menuItemResultSet = null;

        // Initialize counters
        int totalItems = 0;
        int foodCount = 0;
        int sweetCount = 0;
        int drinkCount = 0;

        try {
            connection = db.getConnection();

            // Step 1: Fetch unpaid orders by tableId
            String orderQuery = "SELECT orderId FROM order_table WHERE tableId = ?";
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

                    if (menuItemResultSet.next()) {
                        String category = menuItemResultSet.getString("category");

                        // Increment the appropriate counter based on category
                        switch (category.toLowerCase()) {
                            case "food":
                                foodCount += quantity;
                                break;
                            case "sweet":
                                sweetCount += quantity;
                                break;
                            case "drink":
                                drinkCount += quantity;
                                break;
                        }

                        // Update total item count
                        totalItems += quantity;
                    }
                }
            }
        } catch (Exception e) {
            throw new Exception("Error fetching item type percentages: " + e.getMessage(), e);
        } finally {
            // Ensure resources are closed
            closeResources(orderResultSet, orderStatement, null);
            closeResources(itemResultSet, itemStatement, null);
            closeResources(null, null, connection);
        }

        // Step 4: Calculate percentages
        Map<String, Double> percentages = new HashMap<>();
        if (totalItems > 0) {
            percentages.put("food", (double) foodCount / totalItems);
            percentages.put("sweet", (double) sweetCount / totalItems);
            percentages.put("drink", (double) drinkCount / totalItems);
        } else {
            percentages.put("food", 0.0);
            percentages.put("sweet", 0.0);
            percentages.put("drink", 0.0);
        }

        return percentages;
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
            String query = "SELECT * FROM order_table";
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

    public Map<String, Integer> getOrdersByDate() throws Exception {
        List<Order> orders = manageOrders();
        Map<String, Integer> ordersByDate = new HashMap<>();

        for (Order order : orders) {
            String date = new SimpleDateFormat("yyyy-MM-dd").format(order.getOrderDate());
            ordersByDate.put(date, ordersByDate.getOrDefault(date, 0) + 1);
        }

        return new TreeMap<>(ordersByDate);
    }

    /**
     * Calculates statistical facts from a list of orders.
     *
     * @param orders The list of Order objects.
     * @return An OrderStats object containing various statistical facts.
     */
    public OrderStats calculateOrderStatistics() throws Exception {
        List<Order> orders = manageOrders();
    
        int totalOrders = orders.size();
        double totalRevenue = 0;
        int totalPaidOrders = 0;
        int totalUnpaidOrders = 0;
        Map<String, Integer> ordersPerTable = new HashMap<>();
        Map<String, Integer> ordersByDate = getOrdersByDate();
    
        // Counters for overall item type percentages
        double totalFoodPercentage = 0;
        double totalSweetPercentage = 0;
        double totalDrinkPercentage = 0;
        int tableCount = 0;
    
        for (Order order : orders) {
            // Calculate total revenue from paid orders
            if (order.getPayed()) {
                totalRevenue += Double.parseDouble(order.getBill());
                totalPaidOrders++;
            } else {
                totalUnpaidOrders++;
            }
    
            // Track orders per table
            ordersPerTable.put(order.getTableId(), ordersPerTable.getOrDefault(order.getTableId(), 0) + 1);
    
            // Calculate percentages for each table's items
            Map<String, Double> percentages = getItemTypePercentagesByTable(order.getTableId());
            totalFoodPercentage += percentages.get("food");
            totalSweetPercentage += percentages.get("sweet");
            totalDrinkPercentage += percentages.get("drink");
            tableCount++;
        }
    
        // Calculate average percentages across all tables
        double foodPercentage = (tableCount > 0) ? totalFoodPercentage / tableCount : 0;
        double sweetPercentage = (tableCount > 0) ? totalSweetPercentage / tableCount : 0;
        double drinkPercentage = (tableCount > 0) ? totalDrinkPercentage / tableCount : 0;
    
        // Calculate average order value for paid orders
        double averageOrderValue = (totalPaidOrders > 0) ? totalRevenue / totalPaidOrders : 0;
    
        // Return the OrderStats object with percentages included
        return new OrderStats(totalOrders, totalRevenue, totalPaidOrders, totalUnpaidOrders, averageOrderValue,
                              ordersPerTable, foodPercentage, drinkPercentage, sweetPercentage, ordersByDate);
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
