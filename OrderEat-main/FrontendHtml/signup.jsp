<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>OrderEat - Sign Up</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
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
                    <a href="signup.jsp" class="nav-item nav-link active">Sign Up</a>
                </div>
            </div>
        </nav>
        <!-- Navbar End -->

        <!-- Sign Up Form Start -->
        <div class="container d-flex align-items-center justify-content-center" style="min-height: 100vh; padding-top: 80px;">
            <div class="col-md-6 col-lg-5 col-xl-4">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <h3 class="text-center mb-4 text-primary"><i class="fa fa-user-plus me-2"></i>Sign Up</h3>
                        <form action="signupController.jsp" method="post">
                            <!-- Full Name -->
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                            </div>
                        
                            <!-- Email Address -->
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                            </div>
                        
                            <!-- Phone Number -->
                            <div class="mb-3">
                                <label for="phone" class="form-label">Phone Number</label>
                                <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter your phone number" required>
                            </div>
                        
                            <!-- Password -->
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                            </div>
                        
                            <!-- Confirm Password -->
                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label">Confirm Password</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm your password" required>
                            </div>
                        
                            <!-- Terms and Conditions Checkbox -->
                            <div class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" id="terms" required>
                                <label class="form-check-label" for="terms">
                                    I agree to the <a href="#" class="text-primary">Terms & Conditions</a>
                                </label>
                            </div>
                        
                            <!-- Sign Up Button -->
                            <button type="submit" class="btn btn-primary w-100 mt-4">Sign Up</button>
                        </form>
                        <p class="text-center mt-3 mb-0">Already have an account? <a href="login.jsp" class="text-primary">Login</a></p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Sign Up Form End -->

    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
