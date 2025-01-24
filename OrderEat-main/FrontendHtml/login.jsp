<!DOCTYPE html>
<html lang="en">

<%

    // Check if the 'table' parameter is present in the URL
    String table = request.getParameter("table");

    if (table != null && !table.isEmpty()) {
        // Store the table number in the session
        session.setAttribute("table", table);
    }
    if (session.getAttribute("table") == null) {
        out.println("<div class='alert alert-danger'> error : no table selected </div>");
    }
    // Check if a login error parameter is present in the request
    String loginError = request.getParameter("error");
%>

<head>
    <meta charset="utf-8">
    <title>OrderEat - Login</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">

    <%-- Font Awesome --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <!-- Navbar Start -->
        <nav class="navbar navbar-expand-lg navbar-dark sticky-top bg-dark px-4 px-lg-5 py-3 py-lg-8">
            <a href="menu.jsp" class="navbar-brand p-0">
                <h1 class="text-primary m-0"><i class="fa fa-utensils me-3"></i>OrderEat</h1>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0 pe-4">
                    <a href="#" class="nav-item nav-link">Call Waiter</a>
                    <a href="menu.jsp" class="nav-item nav-link">Menu</a>
                    <a href="viewOrder.jsp" class="nav-item nav-link">View Order</a>
                    <% 
                        omadikh.Customer customer = (omadikh.Customer) session.getAttribute("customer");
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
                        <a href="login.jsp" class="nav-item nav-link"><i class="fa-solid fa-user"></i> Login</a>
                    <% } %>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

        <!-- Login Form Start -->
        <div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh; padding-top: 80px;">
            <div class="col-md-6 col-lg-5 col-xl-4">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-4 text-primary"><i class="fa fa-user-circle me-2"></i>Login</h3>
                        <% if (loginError != null && !loginError.isEmpty()) { %>
                            <div class="alert alert-danger text-center">Invalid username or password. Please try again.</div>
                        <% } %>
                        <form action="loginController.jsp" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="username" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 mt-4">Login</button>
                        </form>
                        <p class="text-center mt-3 mb-0">Don't have an account? <a href="signup.jsp" class="text-primary">Sign Up</a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Login Form End -->

    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
