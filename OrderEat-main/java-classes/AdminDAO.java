package omadikh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    private static final String TABLE_NAME = "admin";
    /**
     * This method is used to authenticate a Admin.
     * 
     * @param Adminname, String
     * @param password, String
     * @return Admin, the Admin object
     * @throws Exception, if the credentials are not valid
     */
    public Admin authenticate(String Adminname, String password) throws Exception {
        DB db = new DB();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            String sql = "SELECT * FROM " + TABLE_NAME + " WHERE name = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, Adminname);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
				String name = rs.getString("name");
				String email = rs.getString("email");
				
				return new Admin(1233, name, email, password);
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
}
