<%@ page contentType="text/html" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Courgette|Pacifico:400,700">

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <style>
        body {
            color: #999;
            background: #e2e2e2;
            font-family: 'Roboto', sans-serif;
        }
        .form-control {
            min-height: 41px;
            box-shadow: none;
            border-color: #e1e1e1;
        }
        .form-control:focus {
            border-color: #00cb82;
        }
        .form-control, .btn {
            border-radius: 3px;
        }
        .form-header {
            margin: -30px -30px 20px;
            padding: 30px 30px 10px;
            text-align: center;
            background: #00cb82;
            border-bottom: 1px solid #eee;
            color: #fff;
        }
        .form-header h2 {
            font-size: 34px;
            font-weight: bold;
            margin: 0 0 10px;
            font-family: 'Pacifico', sans-serif;
        }
        .form-header p {
            margin: 20px 0 15px;
            font-size: 17px;
            line-height: normal;
            font-family: 'Courgette', sans-serif;
        }
        .signup-form {
            width: 390px;
            margin: 0 auto;
            padding: 30px 0;
        }
        .signup-form form {
            color: #999;
            border-radius: 3px;
            margin-bottom: 15px;
            background: #f0f0f0;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }
        .signup-form .form-group {
            margin-bottom: 20px;
        }
        .signup-form label {
            font-weight: normal;
            font-size: 14px;
        }
        .signup-form input[type="checkbox"] {
            position: relative;
            top: 1px;
        }
        .signup-form .btn {
            font-size: 16px;
            font-weight: bold;
            background: #00cb82;
            border: none;
            min-width: 200px;
        }
        .signup-form .btn:hover, .signup-form .btn:focus {
            background: #00b073 !important;
            outline: none;
        }
        .signup-form a {
            color: #00cb82;
        }
        .signup-form a:hover {
            text-decoration: underline;
        }
    </style>

    <!-- cloud Start -->
    <title>Cloud - 지역문화살리기</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">
    <!-- clooud End -->

    <!-- Favicon -->
    <link href="../static/img/cloud.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700;900&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../static/lib/animate/animate.min.css" rel="stylesheet">
    <link href="../static/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="../static/lib/lightbox/css/lightbox.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../static/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../static/css/style.css" rel="stylesheet">
</head>

<body>
<jsp:directive.include file="./templates/head.jsp"/>

<form action="signup.jsp" method="post">
    <section class="gradient-custom">
        <div class="container py-5 mh-100">
            <div class="row justify-content-center align-items-center mh-100">
                <div class="card-body p-4 p-md-5">
                    <h3 class="mb-4 pb-2 pb-md-0 mb-md-5" style="text-align: center">회원가입</h3>
                    <form>
                        <div class="row">

                            <div class="col-md-6 mb-4">
                                <!--                                    <h6 class="mb-2 pb-1">Gender: </h6>-->
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="TypeRadioOptions" id="ceotype"
                                           value="ceo" checked />
                                    <label class="form-check-label" for="ceotype">사장님</label>
                                </div>

                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="TypeRadioOptions" id="membertype"
                                           value="member" />
                                    <label class="form-check-label" for="membertype">회원</label>
                                </div>

                            </div>
                            <div class="col-md-6 mb-4">
                                <!--                                    <h6 class="mb-2 pb-1">Gender: </h6>-->
                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="GenderRadioOptions" id="maleGender"
                                           value="M" checked />
                                    <label class="form-check-label" for="femaleGender">남자</label>
                                </div>

                                <div class="form-check form-check-inline">
                                    <input class="form-check-input" type="radio" name="GenderRadioOptions" id="femaleGender"
                                           value="F" />
                                    <label class="form-check-label" for="maleGender">여자</label>
                                </div>

                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">

                                <div class="form-outline">
                                    <input type="text" name="name" class="form-control form-control-lg" required="required"/>
                                    <label class="form-label" for="Name">Name</label>
                                </div>

                            </div>
                            <div class="col-md-6 mb-4">

                                <div class="form-outline">
                                    <input type="text" name="nickname" class="form-control form-control-lg" required="required"/>
                                    <label class="form-label" for="nickname">Nickname</label>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4 pb-2">

                                <div class="form-outline">
                                    <input type="email" name="email" class="form-control form-control-lg" required="required"/>
                                    <label class="form-label" for="email">Email</label>
                                </div>

                            </div>
                            <div class="col-md-6 mb-4 pb-2">
                                <div class="form-outline">
                                    <input type="text" name="age" class="form-control form-control-lg" required="required"/>
                                    <label class="form-label" for="age">Age</label>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4 pb-2">

                                <div class="form-outline">
                                    <input type="text" name="id" class="form-control form-control-lg" required="required"/>
                                    <label class="form-label" for="id">ID</label>
                                </div>

                            </div>
                            <div class="col-md-6 mb-4 pb-2">
                                <div class="form-outline">
                                    <input type="password" name="ps" class="form-control form-control-lg" required="required"/>
                                    <label class="form-label" for="ps">Password</label>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-3 mb-4 form-outline ">
                                <select class="btn-sm select form-control-lg" name="fv1">
                                    <option value="Subject 1">Subject 1</option>
                                    <option value="Subject 2">Subject 2</option>
                                    <option value="Subject 3">Subject 3</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-4 form-outline">
                                <select class="btn-sm select form-control-lg" name="fv2">
                                    <option value="Subject 1">Subject 1</option>
                                    <option value="Subject 2">Subject 2</option>
                                    <option value="Subject 3">Subject 3</option>
                                </select>
                            </div>
                            <div class="col-md-3 mb-4 form-outline">
                                <select class="btn-sm select form-control-lg" name="fv3">
                                    <option value="Subject 1">Subject 1</option>
                                    <option value="Subject 2">Subject 2</option>
                                    <option value="Subject 3">Subject 3</option>
                                </select>
                            </div>

                        </div>

                        <div class="mt-4 pt-2 text-end">
                            <!--                                <input class="btn btn-primary btn-lg" type="submit" value="Submit" />-->
                            <button type="submit" class="btn btn-primary btn-block btn-lg">Sign Up</button>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </section>
</form>
<!-- Signup End-->

<!-- Footer Start -->
<div class="container-fluid bg-dark text-body footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
    <div class="container py-5">
        <div class="row g-5">
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Address</h5>
                <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                <div class="d-flex pt-2">
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                    <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Quick Links</h5>
                <a class="btn btn-link" href="">About Us</a>
                <a class="btn btn-link" href="">Contact Us</a>
                <a class="btn btn-link" href="">Our Services</a>
                <a class="btn btn-link" href="">Terms & Condition</a>
                <a class="btn btn-link" href="">Support</a>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Project Gallery</h5>
                <div class="row g-2">
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-1.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-2.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-3.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-4.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-5.jpg" alt="">
                    </div>
                    <div class="col-4">
                        <img class="img-fluid rounded" src="../static/img/gallery-6.jpg" alt="">
                    </div>
                </div>
            </div>
            <div class="col-lg-3 col-md-6">
                <h5 class="text-white mb-4">Newsletter</h5>
                <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                <div class="position-relative mx-auto" style="max-width: 400px;">
                    <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                    <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="copyright">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                </div>
                <div class="col-md-6 text-center text-md-end">
                    <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                    Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                    <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i class="bi bi-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="../static/lib/wow/wow.min.js"></script>
<script src="../static/lib/easing/easing.min.js"></script>
<script src="../static/lib/waypoints/waypoints.min.js"></script>
<script src="../static/lib/counterup/counterup.min.js"></script>
<script src="../static/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="../static/lib/isotope/isotope.pkgd.min.js"></script>
<script src="../static/lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="../static/js/main.js"></script>
</body>

</html>