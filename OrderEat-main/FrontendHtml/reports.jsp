<!DOCTYPE html>
<html lang="en">
<%@ page import="omadikh.Customer, omadikh.CustomerDAO" %>

<%
    Customer admin = (Customer) session.getAttribute("customer");
    if (admin == null || !admin.getName().startsWith("admin")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<head>
    <meta charset="utf-8">
    <title>Reports - OrderEat</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <style>
        body {
            color: green;
        }

        .no-underline {
            text-decoration: none;
        }

        .table th,
        .table td {
            vertical-align: middle;
        }

        .navbar {
            margin-bottom: 30px;
        }

        /* Table Color Styles */
        .table {
            background-color: #fdf1e6;
        }

        .table th {
            background-color: #f9c2a5;
            color: #fff;
        }

        .table td {
            background-color: #fff;
        }

        /* Hover effect for table rows */
        .table tbody tr:hover {
            background-color: #ffe6cc;
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
                    <a href="adminview.jsp" class="nav-item nav-link no-underline">Dashboard</a>
                    <a href="orders.jsp" class="nav-item nav-link no-underline">Orders</a>
                    <a href="reports.jsp" class="nav-item nav-link no-underline active">Reports</a>
                    <a href="editmenu.jsp" class="nav-item nav-link no-underline">Edit Menu</a>
                </div>
            </div>
        </nav>

        <div class="container">
            <h1 class="text-center">Reports</h1>

            <!-- Reports Table -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>Report ID</th>
                            <th>Report Date</th>
                            <th>Type</th>
                            <th>Description</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>#R001</td>
                            <td>2024-10-05</td>
                            <td>Sales</td>
                            <td>Monthly sales report</td>
                            <td><button class="btn btn-primary btn-sm" style="padding: 2px 6px; font-size: 0.8em;">View</button></td>
                        </tr>
                        <tr>
                            <td>#R002</td>
                            <td>2024-10-10</td>
                            <td>Inventory</td>
                            <td>Current stock levels</td>
                            <td><button class="btn btn-primary btn-sm" style="padding: 2px 6px; font-size: 0.8em;">View</button></td>
                        </tr>
                        <tr>
                            <td>#R003</td>
                            <td>2024-10-15</td>
                            <td>Customer</td>
                            <td>Customer feedback summary</td>
                            <td><button class="btn btn-primary btn-sm" style="padding: 2px 6px; font-size: 0.8em;">View</button></td>
                        </tr>
                        <!-- More reports can be added here -->
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
