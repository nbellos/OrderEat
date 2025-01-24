<%@ page import="omadikh.Customer, omadikh.CustomerDAO" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>

<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");

    if (username != null && email != null && phone != null && password != null && confirmPassword != null) {
        if (password.equals(confirmPassword)) {
            

            // TEMPORARY CHECK FOR ADMING
            if (username.startsWith("admin")) {
                if (!password.equals("AdminOnlyOrderEatPassword")) {
                    out.println("<p>Error: Admin password must be the correct</p>");
                    return;
                }
            }
            //////

            String customerId = UUID.randomUUID().toString(); // random here, but doesnt matter since it will be autoincremented in the DAO
            String loyaltyPoints = "0"; // Initial loyalty points

            Customer customer = new Customer(customerId, password, username, email, phone, loyaltyPoints);
            
            CustomerDAO customerDAO = new CustomerDAO();

            try {
                customerDAO.register(customer);
                response.sendRedirect("login.jsp"); // Redirect to login page after successful registration
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        } else {
            out.println("<p>Passwords do not match!</p>");
        }
    } else {
        out.println("<p>All fields are required!</p>");
    }
%>