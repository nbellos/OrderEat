<%@ page import="java.util.List" %>
<%@ page import="omadikh.Feedback" %>
<%@ page import="omadikh.FeedbackDAO" %>
<%@ page import="omadikh.CustomerDAO" %>
<%@ page import="omadikh.Customer" %>

<%
    Customer customer2 = (Customer) session.getAttribute("customer");
    String customerName = customer2 != null ? customer2.getName() : "Guest";
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>OrderEat - Feedback</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <%-- Font Awesome --%>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        /* Blur effect for the background */
        .blur-background {
            filter: blur(5px);
            transition: filter 1.5s ease;
        }

        .feedback-container {
            position: relative;
            z-index: 10;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }

        .hidden {
            display: none;
        }

        .rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: center;
        }

        .rating>input {
            display: none;
        }

        .rating>label {
            position: relative;
            width: 1em;
            font-size: 30px;
            font-weight: 300;
            color: #FFD600;
            cursor: pointer;
        }

        .rating>label::before {
            content: "\2605";
            position: absolute;
            opacity: 0;
        }

        .rating>label:hover:before,
        .rating>label:hover~label:before {
            opacity: 1 !important;
        }

        .rating>input:checked~label:before {
            opacity: 1;
        }

        .rating:hover>input:checked~label:before {
            opacity: 0.4;
        }

        .fixed-center {
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
            background-color: rgba(255, 255, 255, 0.95);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            width: 40%;
            max-width: 500px;
        }
    </style>
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

        <!-- Feedback Form Start -->
        <div class="container" id="feedback-section">
            <h4 class="text-primary fw-bold mb-4 text-center" style="background-color: #f8f9fa; padding: 10px 15px; border-radius: 10px; box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);">
                <i class="fa fa-comments me-2 blur-background blur-target"></i> Feedback from Others
            </h4>
            <button id="reopen-feedback" class="btn btn-primary btn-lg position-fixed bottom-0 m-4 rounded-pill shadow blur-background blur-target" style="right: 100px;">
                <i class="fa fa-comment-dots me-2"></i> Feedback
            </button>
            <!-- Reviews from other users -->
            <%
                // Initialize the feedback DAO and fetch the list of feedbacks
                FeedbackDAO feedbackDAO = new FeedbackDAO();
                List<Feedback> feedbacks = feedbackDAO.viewFeedback(); // Assuming viewFeedback returns a List<Feedback>
                CustomerDAO customerDAO = new CustomerDAO();


                // Loop through each feedback and display dynamically
                for (int i = feedbacks.size() - 1; i >= 0; i--) {
                    Feedback feedback = feedbacks.get(i);
            %>
                    <div class="row justify-content-center my-4 blur-background blur-target">
                        <div class="col-md-8">
                            <!-- Outer Feedback Container -->
                            <div class="card shadow-sm bg-light p-3 mb-1" style="border-radius: 20px;">
                                <!-- Inner Feedback Row -->
                                <div class="d-flex align-items-start">
                                    <!-- User Image -->
                                    <img src="img/user.jpg" alt="User" class="rounded-circle me-3" style="width: 40px; height: 40px;">

                                    <!-- Feedback Content -->
                                    <div>
                                        <!-- Name and Date Row -->
                                        <div class="d-flex justify-content-between align-items-center">
                                            <p class="mb-1 fw-bold" style="font-size: 1rem;"><%= customerDAO.getCustomerById(feedback.getCustomerId()).getName() %></p>
                                            <p class="text-muted mb-0" style="font-size: 0.85rem; margin-left: 10px;"><%= feedback.getDate() %></p>
                                        </div>

                                        <!-- Feedback Comment -->
                                        <p style="font-size: 0.95rem; color: #333;"><%= feedback.getComment() %></p>

                                        <!-- Star Rating -->
                                        <p class="mb-0">
                                            <% 
                                                int rating = Integer.parseInt(feedback.getRating()); 
                                                for (int starIndex = 1; starIndex <= 5; starIndex++) { 
                                            %>
                                                <i class="fa fa-star <%= starIndex <= rating ? "text-warning" : "text-muted" %>"></i>
                                            <% } %>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


            <%
                }
            %>

            <div class="feedback-container fixed-center" id="feedback-form">
                <button id="close-feedback" style="position: absolute; top: 10px; right: 10px; border: none; background: transparent; font-size: 1.5rem; cursor: pointer;">
                    &times;
                </button>
                <h3 class="text-center mb-4 text-primary"><i class="fa fa-comment-dots me-2"></i>Feedback</h3>
                <form>
                    <label for="name" class="form-label text-center d-block"><%= customerName %></label>
                    <div class="mb-3">
                        <label for="message" class="form-label">Your opinion is valuable to us!</label>
                        <textarea class="form-control" id="message" rows="4" placeholder="Share your thoughts with us" required></textarea>
                    </div>
                    <div class="rating">
                        <input type="radio" name="rating" value="5" id="5"><label for="5">☆</label>
                        <input type="radio" name="rating" value="4" id="4"><label for="4">☆</label>
                        <input type="radio" name="rating" value="3" id="3"><label for="3">☆</label>
                        <input type="radio" name="rating" value="2" id="2"><label for="2">☆</label>
                        <input type="radio" name="rating" value="1" id="1"><label for="1">☆</label>
                    </div>
                    <button type="button" class="btn btn-primary w-100 mt-4" id="submit-feedback">Submit Feedback</button>
                </form>
            </div>

            
        </div>
        <!-- Feedback Form End -->
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
        const submitFeedbackBtn = document.getElementById("submit-feedback");

        submitFeedbackBtn.addEventListener("click", function (e) {
            e.preventDefault(); // Prevent default button behavior

            // Get the feedback text and rating
            const feedbackText = document.getElementById("message").value;
            const starRating = document.querySelector('input[name="rating"]:checked');

            // Validate input
            if (!feedbackText) {
                alert("Please enter your feedback.");
                return;
            }

            if (!starRating) {
                alert("Please select a star rating.");
                return;
            }

            // Send data to feedbackController.jsp using AJAX
            $.ajax({
                url: "feedbackController.jsp",  // The URL for the request
                method: "POST",                 // The HTTP method
                data: {
                    feedback: feedbackText,     // Send the feedback text
                    rating: starRating.value    // Send the star rating value
                },
                success: function (response) {
                    // Store the state that the feedback has been submitted
                    localStorage.setItem("feedbackSubmitted", "true");

                    // Reload the page to update feedback list
                    location.reload();

                    // Optionally remove the blur effect from other reviews
                    const otherReviews = document.querySelectorAll(".blur-target");
                    otherReviews.forEach(function (review) {
                        review.classList.remove("blur-background");
                    });

                    // Optionally show a success message
                },
                error: function (xhr, status, error) {
                    console.error("Error submitting feedback:", error);
                    alert("An error occurred while submitting your feedback. Please try again.");
                }
            });
        });

        window.onload = function () {
            // Check if the feedback has been submitted previously
            if (localStorage.getItem("feedbackSubmitted") === "true") {
                // Hide the feedback form
                const feedbackForm = document.getElementById("feedback-form");
                if (feedbackForm) {
                    feedbackForm.style.display = "none";
                }

                // Remove the blur effect from other reviews
                const otherReviews = document.querySelectorAll(".blur-target");
                otherReviews.forEach(function (review) {
                    review.classList.remove("blur-background");
                });

                // Clear the state to ensure it's only hidden once
                localStorage.removeItem("feedbackSubmitted");
            }
        };
    });


    document.addEventListener("DOMContentLoaded", function () {
        const closeFeedbackBtn = document.getElementById("close-feedback");

        // Close feedback form on X button click
        closeFeedbackBtn.addEventListener("click", function () {
            const feedbackForm = document.getElementById("feedback-form");

            // Hide the feedback form
            feedbackForm.style.display = "none";

            // Remove blur effect from background elements
            const blurredElements = document.querySelectorAll(".blur-target");
            blurredElements.forEach(function (element) {
                element.classList.remove("blur-background");
            });
        });
    });

    document.addEventListener("DOMContentLoaded", function () {
        const reopenFeedbackBtn = document.getElementById("reopen-feedback");

        // Reopen feedback form on button click
        reopenFeedbackBtn.addEventListener("click", function () {
            const feedbackForm = document.getElementById("feedback-form");

            // Show the feedback form
            feedbackForm.style.display = "block";

            // Apply blur effect to background elements
            const blurredElements = document.querySelectorAll(".blur-target");
            blurredElements.forEach(function (element) {
                element.classList.add("blur-background");
            });
        });
    });

    </script>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
