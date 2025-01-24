<%@ page import="java.util.*" %>
<%@ page import="omadikh.OrderStats" %>
<%@ page import="omadikh.AdminStats" %>
<%@ page import="omadikh.Admin, omadikh.AdminDAO, omadikh.Order" %>


<!DOCTYPE jsp>
<html lang="en">

<%
    Admin admin = (Admin) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>

<head>
    <meta charset="utf-8">
    <title>Admin Dashboard - OrderEat</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Chart and Bootstrap Imports -->
    <script src="https://d3js.org/d3.v4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/billboard.js/dist/billboard.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/billboard.js/dist/billboard.min.css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.2.2/Chart.min.js"></script>

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

     <%-- Font Awesome --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Additional Styling -->
    <style>
        body {
            text-align: center;
            color: green;
        }

        h2 {
            font-family: "Verdana", sans-serif;
        }

        .summary-card {
            background-color: #fdf1e6;
            padding: 30px;
            height: 300px;
        }

        .summary-card h5 {
            font-size: 1.5em;
        }

        .summary-card h3 {
            font-size: 2.5em;
        }

        .summary-card p {
            font-size: 1.3em;
        }

        .chart-container {
            width: 80%;
            height: 400px;
            margin: 0 auto;
        }

        .btn {
            font-size: 1.2em;
            padding: 15px 30px;
        }

        .btn-primary,
        .btn-success {
            width: 200px;
        }

        .summary-heading {
            font-size: 2.5em;
        }

        #donut-chart {
            max-width: 40%;
            height: 260px;
            margin: 0 auto;
        }

        .taller-chart-card {
            height: 500px;
        }

        /* Remove underline from navbar links */
        .navbar-nav .nav-link {
            text-decoration: none;
        }
    </style>
</head>

<body>
    <%
        // Create an instance of AdminStats
        AdminStats adminStats = new AdminStats();

        // Fetch the order statistics
        OrderStats orderStats = null;
        try {
            orderStats = adminStats.calculateOrderStatistics();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }

        // Display the statistics if available
        if (orderStats != null) {
    %>
    <div class="container-xxl bg-white p-0">
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top bg-dark px-4 px-lg-5 py-3 py-lg-8">
            <a href="" class="navbar-brand p-0">
                <h1 class="text-primary m-0"><i class="fa fa-utensils me-3"></i>OrderEat Admin</h1>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0 pe-4">
                    <a href="adminview.jsp" class="nav-item nav-link active">Dashboard</a>
                    <a href="orders.jsp" class="nav-item nav-link">Orders</a>
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

        <!-- Admin Dashboard -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp mb-5" data-wow-delay="0.1s">
                    <h3 class="section-title ff-secondary text-primary fw-normal">Admin Dashboard</h3>
                    <h1 class="mb-5 summary-heading">Summary Overview</h1>
                </div>

                <!-- Summary Cards -->
                <div class="row g-4">
                    <div class="col-lg-4 col-md-3">
                        <div class="p-4 rounded shadow-sm d-flex flex-column justify-content-center align-items-center summary-card">
                            <h5 class="text-secondary mb-3">Total Sales</h5>
                            <h3 class="text-primary">$<%= String.format("%.2f", orderStats.getTotalRevenue()) %></h3>
                            <p class="text-muted">Compared to last month: <span class="text-success">+15%</span></p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-3">
                        <div class="p-4 rounded shadow-sm d-flex flex-column justify-content-center align-items-center summary-card">
                            <h5 class="text-secondary mb-3">Total Orders</h5>
                            <h3 class="text-primary"><%= orderStats.getTotalOrders() %></h3>
                            <p class="text-muted">New orders this week: <span class="text-success">+32</span></p>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-3">
                        <div class="p-4 rounded shadow-sm d-flex flex-column justify-content-center align-items-center summary-card">
                            <h5 class="text-secondary mb-3">Average Order Value</h5>
                            <h3 class="text-primary"><%= String.format("%.2f", orderStats.getAverageOrderValue()) %></h3>
                            <p class="text-muted">
                                    Target Average $20 
                                    <%
                                        double target = 20.0;
                                        double averageOrderValue = orderStats.getAverageOrderValue();
                                        double difference = averageOrderValue - target;
                                        String cssClass = difference >= 0 ? "text-success" : "text-danger";
                                        String sign = difference >= 0 ? "+" : "-";
                                    %>
                                    <span class="<%= cssClass %>"><%= sign + String.format("%.2f", Math.abs(difference)) %></span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Sales & Orders Chart -->
                <div class="row mt-5">
                    <div class="col-lg-6 mb-4">
                        <div class="p-4 rounded shadow-sm summary-card">
                            <h5 class="text-secondary mb-3">Sales Overview</h5>
                            <div id="donut-chart"></div>
                        </div>
                    </div>
                    <div class="col-lg-6 mb-4">
                        <div class="p-4 rounded shadow-sm summary-card">
                            <h5 class="text-secondary mb-3">Order Trends</h5>
                            <div class="chart-container">
                                <canvas id="myChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row mt-5">
                    <div class="col text-center">
                        <button class="btn btn-primary rounded-pill me-2">Generate Report</button>
                        <button class="btn btn-success rounded-pill ms-2">Download Summary</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } %>

    <!-- Donut Chart Script -->
    <script>
        // Dynamically populate the chart with data from OrderStats
        bb.generate({
            data: {
                columns: [
                    ["Drinks", <%= String.format("%.2f", orderStats.getDrinkPercentage() * 100) %>],
                    ["Food", <%= String.format("%.2f", orderStats.getFoodPercentage() * 100) %>],
                    ["Sweets", <%= String.format("%.2f", orderStats.getSweetPercentage() * 100) %>]
                ],
                type: "donut"
            },
            donut: {
                title: "Summary Pie"
            },
            bindto: "#donut-chart"
        });
    </script>

    <!-- Line Chart Script -->
    <script>
        const ctx = document.getElementById("myChart").getContext("2d");

        // Dynamic data from JSP
        const labels = [<% for (String date : orderStats.getOrdersByDate().keySet()) { %>"<%= date %>", <% } %>];
        const data = [<% for (int count : orderStats.getOrdersByDate().values()) { %><%= count %>, <% } %>];

        const myChart = new Chart(ctx, {
            type: "line",
            data: {
                labels: labels,
                datasets: [{
                    label: "Total Orders",
                    data: data,
                    backgroundColor: "rgba(153, 205, 1, 0.6)",
                    borderColor: "rgba(153, 205, 1, 1)",
                    fill: false
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>

</html>
