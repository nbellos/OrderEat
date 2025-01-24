<%@ page import="omadikh.Order" %>
<%@ page import="omadikh.OrderDAO" %>
<%@ page import="omadikh.MenuItem" %>
<%@ page import="java.util.List" %>
<%@ page import="omadikh.Admin, omadikh.AdminDAO, omadikh.Order" %>
<%@ page import="java.util.ArrayList" %>

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Orders - OrderEat</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

     <%-- Font Awesome --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <style>
        body {
            color: green;
        }

        /* h1 {
            margin-bottom: 30px;
            font-family: "Verdana", sans-serif;
            font-size: 1em; /* Make the title smaller */


        .no-underline {
            text-decoration: none;
        }

        .table th,
        .table td {
            vertical-align: middle; /* Center-aligns the text vertically in the table cells */
        }

        .navbar {
            margin-bottom: 30px; /* Spacing for the navbar */
        }

        /* Table Color Styles */
        .table {
            background-color: #fdf1e6; /* Light background color */
        }

        .table th {
            background-color: #f9c2a5; /* Header background color */
            color: #fff; /* Header text color */
        }

        .table td {
            background-color: #fff; /* Cell background color */
        }

        /* Hover effect for table rows */
        .table tbody tr:hover {
            background-color: #ffe6cc; /* Light hover effect */
        }
    </style>
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top bg-dark px-4 px-lg-5 py-3 py-lg-8">
            <a href="adminview.jsp" class="navbar-brand">
                <h1 class="text-primary m-0"><i class="fa fa-utensils me-3"></i>OrderEat Admin</h1>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0 pe-4">
                    <a href="adminview.jsp" class="nav-item nav-link">Dashboard</a>
                    <a href="orders.jsp" class="nav-item nav-link active">Orders</a>
                    <%-- <a href="reports.jsp" class="nav-item nav-link">Reports</a>
                    <a href="editmenu.jsp" class="nav-item nav-link">Edit Menu</a> --%>
                     <% 
                        omadikh.Admin customer = (omadikh.Admin) session.getAttribute("admin");
                        if (customer != null) {
                    %>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-solid fa-user"></i> <%= customer.getName() %>
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="logout.jsp">Log out</a></li>
                            </ul>
                        </div>
                    <% } else { %>
                        <a href="adminLogin.jsp" class="nav-item nav-link"><i class="fa-solid fa-user"></i> Login</a>
                    <% } %>
                </div>
            </div>
        </nav>

        <div class="container">
            <h1 class="text-center">Order List</h1>

           <!-- Orders Table -->
           <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Table</th>
                        <th>Order Date</th>
                        <th>Status</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        OrderDAO orderDAO = new OrderDAO();
                        List<Order> orders = orderDAO.manageOrders(); // Assuming getOrders() fetches all orders.
                        for (Order order : orders) {
                    %>
                        <tr>
                            <td>#<%= order.getOrderId() %></td>
                            <td><%= order.getTableId() %></td>
                            <td><%= order.getOrderDate() %></td>
                            <td><%= order.getPayed() ? "Paid" : "Pending" %></td>
                            <td>$<%= order.getBill() %></td>
                        </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>

</html>
