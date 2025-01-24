<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="omadikh.MenuDAO" %>
<%@ page import="omadikh.MenuItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>


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

    // Optional: Retrieve the stored table number from the session for confirmation
    String sessionTable = (String) session.getAttribute("table");


    // Create an instance of MenuDAO and retrieve the items by category
    MenuDAO menuDAO = new MenuDAO();
    List<MenuItem> foodItems = menuDAO.getMenuByCategory("food");
    List<MenuItem> sweetItems = menuDAO.getMenuByCategory("sweet");
    List<MenuItem> drinkItems = menuDAO.getMenuByCategory("drink");
        
    List<MenuItem> orderItems = (List<MenuItem>) session.getAttribute("orderItems");
        if (orderItems == null) {
            orderItems = new ArrayList();
            session.setAttribute("orderItems", orderItems);
        }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>OrderEat</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <!-- <link href="img/favicon.ico" rel="icon"> -->

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

    <%-- Font Awesome --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">

    <!-- JQuery for Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>

<body>
    <div class="container-xxl bg-white p-0">
        <nav class="navbar navbar-expand-lg sticky-top navbar-dark bg-dark px-4 px-lg-5 py-3 py-lg-8">
            <a href="" class="navbar-brand p-0">
                <h1 class="text-primary m-0"><i class="fa fa-utensils me-4"></i>OrderEat</h1>
            </a>
            <h1 class="text-primary m-0" style="font-size: 1rem; margin-top: -2px; margin-left: -9px;">
                At Table <%= sessionTable %>
            </h1>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0 pe-4">
                    <!-- <a href="index.jsp" class="nav-item nav-link">Home</a> -->
                    <!-- <a href="about.jsp" class="nav-item nav-link">Order</a> -->
                    <a href="#" class="nav-item nav-link">Call Waiter</a>
                    <a href="menu.jsp" class="nav-item nav-link active">Menu</a>
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

            <div class="container-xxl py-5 bg-dark hero-header mb-5">
                <div class="container text-center my-5 pt-5 pb-4">
                    <h1 class="display-3 text-white mb-3 animated slideInDown">Food Menu</h1>
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb justify-content-center text-uppercase">
                            <li class="breadcrumb-item text-white active" aria-current="page">Savor the flavors of culinary excellence, where every dish tells a story and every bite is a celebration!</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar & Hero End -->


        <!-- Menu Start -->
        <div class="container-xxl py-5">
            <div class="container">
                <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="section-title ff-secondary text-center text-primary fw-normal">Food Menu</h5>
                    <h1 class="mb-5">Food</h1>
                </div>
                <div class="tab-class text-center wow fadeInUp" data-wow-delay="0.1s">
                    <ul class="nav nav-pills d-inline-flex justify-content-center border-bottom mb-5">
                        <li class="nav-item">
                            <a class="d-flex align-items-center text-start mx-3 ms-0 pb-3 active" data-bs-toggle="pill" href="#tab-1">
                                <i class="fa fa-utensils fa-2x text-primary"></i>
                                <div class="ps-3">
                                    <small class="text-body">Best</small>
                                    <h6 class="mt-n1 mb-0">Lunch</h6>
                                </div>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="d-flex align-items-center text-start mx-3 pb-3" data-bs-toggle="pill" href="#tab-2">
                                <i class="fa fa-ice-cream fa-2x text-primary"></i>
                                <div class="ps-3">
                                    <small class="text-body">Special</small>
                                    <h6 class="mt-n1 mb-0">Sweet</h6>
                                </div>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="d-flex align-items-center text-start mx-3 me-0 pb-3" data-bs-toggle="pill" href="#tab-3">
                                <i class="fa fa-cocktail fa-2x text-primary"></i>
                                <div class="ps-3">
                                    <small class="text-body">Lovely</small>
                                    <h6 class="mt-n1 mb-0">Drinks</h6>
                                </div>
                            </a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <!-- Lunch Tab -->
                        <div id="tab-1" class="tab-pane fade show active">
                            <div class="row g-4">
                                <% for (MenuItem item : foodItems) { 
                                    int quantity = 0;
                                
                                    // Check if this item is already in the orderItems list and get its quantity
                                    if (orderItems != null) {
                                        for (MenuItem orderItem : orderItems) {
                                            if (orderItem.getItemId() == item.getItemId()) {
                                                quantity = orderItem.getQuantity();
                                                break;
                                            }
                                        }
                                    }
                                %>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/food/<%= item.getName().toLowerCase().replace(" ", "_") %>.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span>
                                                    <%= item.getName() %>
                                                </span>
                                                <span class="text-primary">$<%= item.getPrice() %></span>
                                            </h5>
                                            <div class="d-flex mt-1 cart-actions align-items-center">
                                                <small class="fst-italic align-self-center me-auto">
                                                    <%= item.getDescription() %>
                                                </small>
                                                <button type="button" class="btn btn-sm btn-outline-primary mt-1 remove-from-cart" data-code="<%= item.getItemId() %>">
                                                    -
                                                </button>
                                                <% if (quantity > 0) { %>
                                                <span class="quantity-box btn btn-sm btn-outline-primary mt-1 ms-1" style="">
                                                    <%= quantity %>
                                                </span>
                                                <% } else { %>
                                                <span class="quantity-box btn btn-sm btn-outline-primary mt-1 ms-1" style="display:none">
                                                    <%= quantity %>
                                                </span>
                                                <% } %>
                                                <button type="button" class="btn btn-sm btn-outline-primary mt-1 ms-1 add-to-cart" data-code="<%= item.getItemId() %>">
                                                    +
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% 
                                    }
                                %>
                            </div>
                        </div>
        
                        <!-- Sweet Tab -->
                        <div id="tab-2" class="tab-pane fade">
                            <div class="row g-4">
                                <% for (MenuItem item : sweetItems) { 
                                    int quantity = 0;

                                    // Check if this item is already in the orderItems list and get its quantity
                                    if (orderItems != null) {
                                        for (MenuItem orderItem : orderItems) {
                                            if (orderItem.getItemId() == item.getItemId()) {
                                                quantity = orderItem.getQuantity();
                                                break;
                                            }
                                        }
                                    }
                                %>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/food/<%= item.getName().toLowerCase().replace(" ", "_") %>.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span><%= item.getName() %></span>
                                                <span class="text-primary">$<%= item.getPrice() %></span>
                                            </h5>
                                            <div class="d-flex mt-1 cart-actions align-items-center">
                                                <small class="fst-italic align-self-center me-auto">
                                                    <%= item.getDescription() %>
                                                </small>
                                                <button type="button" class="btn btn-sm btn-outline-primary mt-1 remove-from-cart" data-code="<%= item.getItemId() %>">-</button>
                                                <% if (quantity > 0) { %>
                                                <span class="quantity-box btn btn-sm btn-outline-primary mt-1 ms-1">
                                                    <%= quantity %>
                                                </span>
                                                <% } else { %>
                                                <span class="quantity-box btn btn-sm btn-outline-primary mt-1 ms-1" style="display: none;">
                                                    <%= quantity %>
                                                </span>
                                                <% } %>
                                                <button type="button" class="btn btn-sm btn-outline-primary mt-1 ms-1 add-to-cart" data-code="<%= item.getItemId() %>">+</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        </div>
        
                        <!-- Drinks Tab -->
                        <div id="tab-3" class="tab-pane fade">
                            <div class="row g-4">
                                <% for (MenuItem item : drinkItems) { 
                                    int quantity = 0;

                                    // Check if this item is already in the orderItems list and get its quantity
                                    if (orderItems != null) {
                                        for (MenuItem orderItem : orderItems) {
                                            if (orderItem.getItemId() == item.getItemId()) {
                                                quantity = orderItem.getQuantity();
                                                break;
                                            }
                                        }
                                    }
                                %>
                                <div class="col-lg-6">
                                    <div class="d-flex align-items-center">
                                        <img class="flex-shrink-0 img-fluid rounded" src="img/food/<%= item.getName().toLowerCase().replace(" ", "_") %>.jpg" alt="" style="width: 80px;">
                                        <div class="w-100 d-flex flex-column text-start ps-4">
                                            <h5 class="d-flex justify-content-between border-bottom pb-2">
                                                <span><%= item.getName() %></span>
                                                <span class="text-primary">$<%= item.getPrice() %></span>
                                            </h5>
                                            <div class="d-flex mt-1 cart-actions align-items-center">
                                                <small class="fst-italic align-self-center me-auto">
                                                    <%= item.getDescription() %>
                                                </small>
                                                <button type="button" class="btn btn-sm btn-outline-primary mt-1 remove-from-cart" data-code="<%= item.getItemId() %>">-</button>
                                                <% if (quantity > 0) { %>
                                                <span class="quantity-box btn btn-sm btn-outline-primary mt-1 ms-1">
                                                    <%= quantity %>
                                                </span>
                                                <% } else { %>
                                                <span class="quantity-box btn btn-sm btn-outline-primary mt-1 ms-1" style="display: none;">
                                                    <%= quantity %>
                                                </span>
                                                <% } %>
                                                <button type="button" class="btn btn-sm btn-outline-primary mt-1 ms-1 add-to-cart" data-code="<%= item.getItemId() %>">+</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                        </div>
            <!-- Menu End -->
        </div>

        <script>
            $(document).ready(function () {
    // Event listener for Add and Remove buttons
    $(".add-to-cart, .remove-from-cart").on("click", function () {
        const button = $(this);
        const cartActions = button.closest(".cart-actions");
        const quantityBox = cartActions.find(".quantity-box");

        // Get action and itemId from button
        const action = button.hasClass("add-to-cart") ? "add" : "remove";
        const itemId = button.data("code"); // Assuming "code" holds the itemId
        let quantity = parseInt(quantityBox.text()) || 0;

        // Update quantity locally
        if (action === "add") {
            quantity += 1;
        } else if (action === "remove") {
            quantity = Math.max(0, quantity - 1); // Prevent quantity from going below 0
        }

        // Update the displayed quantity
        quantityBox.text(quantity);

        // Adjust visibility of the quantity box and buttons
        if (quantity > 0) {
            quantityBox.show();
        } else {
            quantityBox.hide();
        }

        // Send the AJAX request to update quantity on the server
        $.ajax({
            url: "viewOrder.jsp",
            type: "POST",
            data: {
                action: action,
                itemId: itemId,
                quantity: quantity,
            },
            success: function (response) {
                console.log("Quantity updated successfully");

                
            },
            error: function (xhr, status, error) {
                console.error("Failed to update quantity:", status, error);

                // Display error in the quantity box
                quantityBox.text("Error").fadeIn();

                // Hide the box and show buttons again after 2 seconds
                setTimeout(function () {
                    quantityBox.fadeOut(300, function () {
                        cartActions.find("button").fadeIn(100);
                    });
                }, 500);
            }
        });
    });
});

</script>
        
        

    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/wow/wow.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/counterup/counterup.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</body>

</html>