<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="omadikh.Feedback" %>
<%@ page import="omadikh.FeedbackDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="omadikh.Customer" %>

<%
    // Check if the user is logged in
    Customer customerinio = (Customer) session.getAttribute("customer");
    if (customerinio == null) {
        // Redirect to login page if not logged in
        response.sendRedirect("login.jsp");
        return;
    }
    // Get the request parameters (feedback and rating)
    String comment = request.getParameter("feedback");
    String rating = request.getParameter("rating");

    Date date = new Date();

    FeedbackDAO feedbackDAO = new FeedbackDAO();

    // String feedbackId, String customerId, String rating, String comment, Date date
    // Must implement dynamic userId
    Feedback feedback = new Feedback("1", customerinio.getCustomerId(), rating, comment, date);
    
    feedbackDAO.makeFeedback(feedback);
    
    response.sendRedirect("viewOrder.jsp");
%>