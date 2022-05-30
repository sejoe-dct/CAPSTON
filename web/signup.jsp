<%@ page contentType="text/html" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:directive.include file="fragment/head.jsp"/>
</head>

<body>
<jsp:directive.include file="fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="fragment/nav.jsp"/>

<form action="signup_back.jsp" method="post">
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
<jsp:directive.include file="./fragment/footer.jsp"/>
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