package omadikh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {
    private static final String TABLE_NAME = "menu";

    public MenuDAO() {
    }

    /**
     * Retrieves all menu items from the database.
     * 
     * @return List of MenuItem objects
     * @throws Exception if there's an issue during retrieval
     */
    public List<MenuItem> browseMenu() throws Exception {
        List<MenuItem> menuList = new ArrayList<>();
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = db.getConnection();
            String query = "SELECT * FROM " + TABLE_NAME;
            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int id = resultSet.getInt("itemId");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");
                float price = resultSet.getFloat("price");
                String category = resultSet.getString("category");
                
                MenuItem menuItem = new MenuItem(id, name, description, price, category);
                menuList.add(menuItem);
            }
        } catch (Exception e) {
            throw new Exception("Error fetching menu items: " + e.getMessage(), e);
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    // Log exception
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    // Log exception
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    // Log exception
                }
            }
        }

        return menuList;
    }

    public List<MenuItem> getMenuByCategory(String category) throws Exception {
        List<MenuItem> categoryList = new ArrayList<>();
        List<MenuItem> menuItems = browseMenu();
        
        for (MenuItem item : menuItems) {
            if (item.getCategory().equalsIgnoreCase(category)) {
                categoryList.add(item);
            }
        }
        return categoryList;
    }

    /**
     * Adds or updates a menu item in the database.
     * 
     * @param menuItem the MenuItem object to manage
     * @throws Exception if there's an issue during the operation
     */
    public void manageMenu(MenuItem menuItem) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;

        try {
            connection = db.getConnection();

            // Check if the menu item already exists
            String checkQuery = "SELECT * FROM " + TABLE_NAME + " WHERE itemId = ?";
            statement = connection.prepareStatement(checkQuery);
            statement.setInt(1, menuItem.getItemId());
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                // If the item exists, update it
                String updateQuery = "UPDATE " + TABLE_NAME + " SET name = ?, description = ?, price = ?, category = ? WHERE itemId = ?";
                statement = connection.prepareStatement(updateQuery);
                statement.setString(1, menuItem.getName());
                statement.setString(2, menuItem.getDescription());
                statement.setFloat(3, menuItem.getPrice());
                statement.setString(4, menuItem.getCategory());
                statement.setInt(5, menuItem.getItemId());
                statement.executeUpdate();
            } else {
                // If the item doesn't exist, insert it
                String insertQuery = "INSERT INTO " + TABLE_NAME + " (itemId, name, description, price, category) VALUES (?, ?, ?, ?, ?)";
                statement = connection.prepareStatement(insertQuery);
                statement.setInt(1, menuItem.getItemId());
                statement.setString(2, menuItem.getName());
                statement.setString(3, menuItem.getDescription());
                statement.setFloat(4, menuItem.getPrice());
                statement.setString(5, menuItem.getCategory());
                statement.executeUpdate();
            }
        } catch (Exception e) {
            throw new Exception("Error managing menu item: " + e.getMessage(), e);
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    // Log exception
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    // Log exception
                }
            }
        }
    }
    public void manageMenu(List<MenuItem> menuItems) throws Exception {
        DB db = new DB();
        Connection connection = null;
        PreparedStatement statement = null;
    
        try {
            connection = db.getConnection();
    
            // Delete all existing items in the menu
            String deleteQuery = "DELETE FROM " + TABLE_NAME;
            statement = connection.prepareStatement(deleteQuery);
            statement.executeUpdate();
    
            // Insert new items from the provided list
            String insertQuery = "INSERT INTO " + TABLE_NAME + " (itemId, name, description, price, category) VALUES (?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(insertQuery);
    
            for (MenuItem menuItem : menuItems) {
                statement.setInt(1, menuItem.getItemId());
                statement.setString(2, menuItem.getName());
                statement.setString(3, menuItem.getDescription());
                statement.setFloat(4, menuItem.getPrice());
                statement.setString(5, menuItem.getCategory());
                statement.executeUpdate();
            }
        } catch (Exception e) {
            throw new Exception("Error managing menu items: " + e.getMessage(), e);
        } finally {
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    // Log exception
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    // Log exception
                }
            }
        }
    }

    /**
 * Retrieves a specific menu item from the database by its ID.
 * 
 * @param itemId The ID of the menu item to retrieve.
 * @return A MenuItem object representing the menu item with the given ID.
 * @throws Exception if the item is not found or there's an issue during the retrieval.
 */
public MenuItem getMenuItemById(int itemId) throws Exception {
    DB db = new DB();
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    MenuItem menuItem = null;

    try {
        connection = db.getConnection();
        String query = "SELECT * FROM " + TABLE_NAME + " WHERE itemId = ?";
        statement = connection.prepareStatement(query);
        statement.setInt(1, itemId);
        resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String name = resultSet.getString("name");
            String description = resultSet.getString("description");
            float price = resultSet.getFloat("price");
            String category = resultSet.getString("category");

            // Constructing the MenuItem object
            menuItem = new MenuItem(itemId, name, description, price, category);
        } else {
            throw new Exception("Item with ID " + itemId + " not found in the menu.");
        }
    } catch (Exception e) {
        throw new Exception("Error retrieving menu item: " + e.getMessage(), e);
    } finally {
        if (resultSet != null) {
            try {
                resultSet.close();
            } catch (SQLException e) {
                // Log exception
            }
        }
        if (statement != null) {
            try {
                statement.close();
            } catch (SQLException e) {
                // Log exception
            }
        }
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                // Log exception
            }
        }
    }

    return menuItem;
}
}
