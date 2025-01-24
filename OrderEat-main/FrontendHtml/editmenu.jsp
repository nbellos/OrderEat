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
    <title>Edit Menu - OrderEat</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600&family=Nunito:wght@600;700;800&family=Pacifico&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/animate/animate.min.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
    <div class="container-xxl bg-white p-0">
        <nav class="navbar navbar-expand-lg sticky-top navbar-dark bg-dark px-4 px-lg-5 py-3 py-lg-8">
            <a href="adminview.jsp" class="navbar-brand p-0">
                <h1 class="text-primary m-0"><i class="fa fa-utensils me-4"></i>OrderEat</h1>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0 pe-4">
                    <a href="adminview.jsp" class="nav-item nav-link no-underline">Dashboard</a>
                    <a href="orders.jsp" class="nav-item nav-link no-underline">Orders</a>
                    <a href="reports.jsp" class="nav-item nav-link no-underline">Reports</a>
                    <a href="editmenu.jsp" class="nav-item nav-link no-underline active">Edit Menu</a>
                </div>
            </div>
        </nav>

        <!-- Menu Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="section-title ff-secondary text-center text-primary fw-normal">Edit Menu</h5>
                    <h1 class="mb-5">Food</h1>
                </div>
                <div class="tab-class text-center wow fadeInUp" data-wow-delay="0.1s">
                    <ul class="nav nav-pills d-inline-flex justify-content-center border-bottom mb-5">
                        <li class="nav-item">
                            <a class="d-flex align-items-center text-start mx-3 ms-0 pb-3 active" data-bs-toggle="pill" href="#tab-1">
                                <i class="fa fa-coffee fa-2x text-primary"></i>
                                <div class="ps-3">
                                    <small class="text-body">Popular</small>
                                    <h6 class="mt-n1 mb-0">Breakfast</h6>
                                </div>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="d-flex align-items-center text-start mx-3 pb-3" data-bs-toggle="pill" href="#tab-2">
                                <i class="fa fa-hamburger fa-2x text-primary"></i>
                                <div class="ps-3">
                                    <small class="text-body">Special</small>
                                    <h6 class="mt-n1 mb-0">Lunch</h6>
                                </div>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="d-flex align-items-center text-start mx-3 me-0 pb-3" data-bs-toggle="pill" href="#tab-3">
                                <i class="fa fa-utensils fa-2x text-primary"></i>
                                <div class="ps-3">
                                    <small class="text-body">Lovely</small>
                                    <h6 class="mt-n1 mb-0">Dinner</h6>
                                </div>
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div id="tab-1" class="tab-pane fade show p-0 active">
                            <div class="row g-4">
                                <!-- Menu Item -->
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center position-relative">
                                        <div class="position-absolute" style="top: 50px; left: 550px;">
                                            <button class="btn btn-danger btn-sm rounded-circle me-1" title="Delete" onclick="deleteItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-times"></i>
                                            </button>
                                            <button class="btn btn-secondary btn-sm rounded-circle" title="Edit" onclick="editItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-pencil-alt"></i>
                                            </button>
                                        </div>
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/menu-1.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span>Chicken Burger</span>
                                                <span class="text-primary">$115</span>
                                            </h5>
                                            <small class="fst-italic">Ipsum ipsum clita erat amet dolor justo diam</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center position-relative">
                                        <div class="position-absolute" style="top: 50px; left: 550px;">
                                            <button class="btn btn-danger btn-sm rounded-circle me-1" title="Delete" onclick="deleteItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-times"></i>
                                            </button>
                                            <button class="btn btn-secondary btn-sm rounded-circle" title="Edit" onclick="editItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-pencil-alt"></i>
                                            </button>
                                        </div>
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/menu-2.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span>Chicken Burger</span>
                                                <span class="text-primary">$115</span>
                                            </h5>
                                            <small class="fst-italic">Ipsum ipsum clita erat amet dolor justo diam</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center position-relative">
                                        <div class="position-absolute" style="top: 50px; left: 550px;">
                                            <button class="btn btn-danger btn-sm rounded-circle me-1" title="Delete" onclick="deleteItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-times"></i>
                                            </button>
                                            <button class="btn btn-secondary btn-sm rounded-circle" title="Edit" onclick="editItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-pencil-alt"></i>
                                            </button>
                                        </div>
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/menu-3.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span>Chicken Burger</span>
                                                <span class="text-primary">$115</span>
                                            </h5>
                                            <small class="fst-italic">Ipsum ipsum clita erat amet dolor justo diam</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center position-relative">
                                        <div class="position-absolute" style="top: 50px; left: 550px;">
                                            <button class="btn btn-danger btn-sm rounded-circle me-1" title="Delete" onclick="deleteItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-times"></i>
                                            </button>
                                            <button class="btn btn-secondary btn-sm rounded-circle" title="Edit" onclick="editItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-pencil-alt"></i>
                                            </button>
                                        </div>
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/menu-5.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span>Chicken Burger</span>
                                                <span class="text-primary">$115</span>
                                            </h5>
                                            <small class="fst-italic">Ipsum ipsum clita erat amet dolor justo diam</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center position-relative">
                                        <div class="position-absolute" style="top: 50px; left: 550px;">
                                            <button class="btn btn-danger btn-sm rounded-circle me-1" title="Delete" onclick="deleteItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-times"></i>
                                            </button>
                                            <button class="btn btn-secondary btn-sm rounded-circle" title="Edit" onclick="editItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-pencil-alt"></i>
                                            </button>
                                        </div>
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/menu-6.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span>Chicken Burger</span>
                                                <span class="text-primary">$115</span>
                                            </h5>
                                            <small class="fst-italic">Ipsum ipsum clita erat amet dolor justo diam</small>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center position-relative">
                                        <div class="position-absolute" style="top: 50px; left: 550px;">
                                            <button class="btn btn-danger btn-sm rounded-circle me-1" title="Delete" onclick="deleteItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-times"></i>
                                            </button>
                                            <button class="btn btn-secondary btn-sm rounded-circle" title="Edit" onclick="editItem('Chicken Burger')" style="width: 30px; height: 30px;">
                                                <i class="fa fa-pencil-alt"></i>
                                            </button>
                                        </div>
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/menu-7.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span>Chicken Burger</span>
                                                <span class="text-primary">$115</span>
                                            </h5>
                                            <small class="fst-italic">Ipsum ipsum clita erat amet dolor justo diam</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Other categories-->
                    </div>
                </div>
            </div>
        </div>
        <!-- Menu End -->

    </div>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>

</html>
