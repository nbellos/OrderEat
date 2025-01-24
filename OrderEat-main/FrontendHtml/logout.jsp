<%@ page import="javax.servlet.http.HttpSession" %>
<%
    request.getSession().removeAttribute("customer");
    response.sendRedirect("login.jsp"); // Redirect to login page
%>