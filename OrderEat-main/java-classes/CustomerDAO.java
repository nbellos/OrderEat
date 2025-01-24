package omadikh;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CustomerDAO provides all the necessary methods related to Customers.
 * 
 */
public class CustomerDAO {

    private static final String TABLE_NAME = "customer";

    /**
     * This method returns a List with all Customers
     * 
     * @return List<Customer>
     */
    public List<Customer> getCustomers() throws Exception {
        List<Customer> Customers = new ArrayList<>();
        DB db = new DB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            String sql = "SELECT * FROM " + TABLE_NAME;
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            while (rs.next()) {
				String customerId = rs.getString("customerId");
				String password = rs.getString("password");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String phone = rs.getString("phone");
                String loyaltyPoints = rs.getString("loyaltyPoints");
				
				Customer Customer = new Customer(customerId, password, name, email, phone, loyaltyPoints);
				Customers.add(Customer);
			}
        } catch (Exception e) {
            throw new Exception("Error fetching Customers: " + e.getMessage(), e);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }

        return Customers;
    }

    /**
     * Search Customer by Customername
     * 
     * @param Customername, String
     * @return Customer, the Customer object or null
     * @throws Exception
     */
    public Customer findCustomer(String Customername) throws Exception {
        DB db = new DB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            String sql = "SELECT * FROM " + TABLE_NAME + " WHERE name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, Customername);
            rs = pstmt.executeQuery();

            if (rs.next()) {
				String customerId = rs.getString("customerId");
				String password = rs.getString("password");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String phone = rs.getString("phone");
                String loyaltyPoints = rs.getString("loyaltyPoints");
				
				Customer Customer = new Customer(customerId, password, name, email, phone, loyaltyPoints);
                return Customer;
            }
        } catch (Exception e) {
            throw new Exception("Error finding Customer: " + e.getMessage(), e);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }

        return null;
    }

    /**
     * This method is used to authenticate a Customer.
     * 
     * @param Customername, String
     * @param password, String
     * @return Customer, the Customer object
     * @throws Exception, if the credentials are not valid
     */
    public Customer authenticate(String Customername, String password) throws Exception {
        DB db = new DB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            String sql = "SELECT * FROM " + TABLE_NAME + " WHERE name = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, Customername);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
				String customerId = rs.getString("customerId");
				String name = rs.getString("name");
				String email = rs.getString("email");
				String phone = rs.getString("phone");
                String loyaltyPoints = rs.getString("loyaltyPoints");
				
				return new Customer(customerId, password, name, email, phone, loyaltyPoints);
            } else {
                throw new Exception("Wrong name or password");
            }
        } catch (Exception e) {
            throw new Exception("Error during authentication: " + e.getMessage(), e);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }

    /**
     * Register/create new Customer.
     * 
     * @param Customer, Customer
     * @throws Exception, if encounter any error.
     */
    public void register(Customer customer) throws Exception {
        DB db = new DB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            String sqlCheck = "SELECT * FROM " + TABLE_NAME + " WHERE name = ? OR email = ?";
            pstmt = conn.prepareStatement(sqlCheck);
            pstmt.setString(1, customer.getName());
            pstmt.setString(2, customer.getEmail());
            rs = pstmt.executeQuery();

            if (rs.next()) {
                throw new Exception("Customer with the same name or email already exists.");
            }

            String sqlInsert = "INSERT INTO " + TABLE_NAME + " (password, name, email, phone, loyaltyPoints) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sqlInsert, Statement.RETURN_GENERATED_KEYS);
            pstmt.setString(1, customer.getPassword());
            pstmt.setString(2, customer.getName());
            pstmt.setString(3, customer.getEmail());
            pstmt.setString(4, customer.getPhone());
            pstmt.setString(5, customer.getLoyaltyPoints());

            pstmt.executeUpdate();

            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                int generatedId = rs.getInt(1);
                customer.setCustomerId(String.valueOf(generatedId));
            }
        } catch (Exception e) {
            throw new Exception("Error during registration: " + e.getMessage(), e);
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }

    /**
     * This method returns a Customer object based on the provided customerId.
     *
     * @param customerId, String
     * @return Customer, the Customer object or null if not found
     * @throws Exception, if any database error occurs
     */
    public Customer getCustomerById(String customerId) throws Exception {
        DB db = new DB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            String sql = "SELECT * FROM " + TABLE_NAME + " WHERE customerId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, customerId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String password = rs.getString("password");
                String name = rs.getString("name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String loyaltyPoints = rs.getString("loyaltyPoints");

                return new Customer(customerId, password, name, email, phone, loyaltyPoints);
            }
        } catch (Exception e) {
            throw new Exception("Error fetching Customer by ID: " + e.getMessage(), e);
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }

        return null;
    }


} // End of class
