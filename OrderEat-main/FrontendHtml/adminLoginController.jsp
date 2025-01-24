<%@ page import="omadikh.Admin, omadikh.AdminDAO" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    if (username != null && password != null) {
        AdminDAO adminDAO = new AdminDAO();

        try {
            Admin admin = adminDAO.authenticate(username, password);
            if (admin != null) {
                request.getSession().setAttribute("admin", admin);
                response.sendRedirect("adminview.jsp"); // Redirect to menu page after successful login
            } else {
                // Redirect back with an error message for invalid credentials
                response.sendRedirect("adminLogin.jsp?error=login_error");
            }
        } catch (Exception e) {
            response.sendRedirect("adminLogin.jsp?error=login_error");
        }
    } else {
        response.sendRedirect("adminLogin.jsp?error=login_error");
    }
%>