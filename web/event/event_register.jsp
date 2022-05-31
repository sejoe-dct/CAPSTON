<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
" pageEncoding="utf-8" %>

<!DOCTYPE html>
<html lang="en" xmlns:jsp="http://java.sun.com/JSP/Page">

<head>
    <jsp:directive.include file="event_head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="event_nav.jsp"/>


<div class="container-xxl py-5">
    <div class="container">
        <!-- ���� / ������ -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">���� �� ��� ����ϱ�</h6>
            <h1 class="mb-4">��� �� ����, ������Ŭ���� ���</h1>
        </div>

        <form action="event_register_back.jsp" method="post" enctype="multipart/form-data" accept-charset="utf-8">
            <div class="row">

                <div class="col-md-6 mb-4">
                    <!--                                    <h6 class="mb-2 pb-1">Gender: </h6>-->
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="E_TypeRadioOptions" id="fetivaltype"
                               value="ceo" checked />
                        <label class="form-check-label" for="fetivaltype">��� �� ����</label>
                    </div>

                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="E_TypeRadioOptions" id="classtype"
                               value="member" />
                        <label class="form-check-label" for="classtype">������Ŭ���� �� ü��Ȱ��</label>
                    </div>

                </div>
            <div class="row g-3">
                <div class="col-12 col-sm-6">
                    <input type="text" class="form-control border-0" name="event_Title" placeholder="��� ����"
                           style="height: 55px;" required="">
                </div>
                <div class="col-12">
                    <input type="text" class="form-control border-0" name="event_Preview" placeholder="��� ���� �Ұ�"
                           style="height: 55px;">
                </div>
                <div class="col-12 col-sm-6">
                    <input type="text" class="form-control border-0" id="address" name="event_Address" placeholder="��� ���"
                           style="height: 55px;" readonly>
                </div>
                <div class="col-12 col-sm-6">
                    <button class="btn btn-outline-success btn-sm py-3 px-5" id="adBtn" onclick="Postcode()" type="button"
                            placeholder="�ּ� �˻�">�ּҰ˻�
                    </button>
                </div>
                <div class="col-12 col-sm-6">
                    <input type="text" class="form-control border-0" id="detailAddress" name= "event_detailAddress" placeholder="�� �ּ�"
                           style="height: 55px;">
                </div>

                <div class="col-12 ">
                    <input type="text" class="form-control border-0" name="event_Phone" placeholder="��ȭ��ȣ"
                           style="height: 55px;">
                </div>

                <div class="col-12">
                    <input type="file" class="form-control border-0" name="event_Picture" placeholder="���Ұ� �̹���"
                           style="height: 55px;">
                </div>
                <div class="col-12 col-sm-6">
                    <input type="date" class="form-control border-0" name="event_StartDate" placeholder="��� ���� ��¥"
                           style="height: 55px;">
                </div>
                <div class="col-12 col-sm-6">
                    <input type="date" class="form-control border-0" name="event_EndDate" placeholder="��� ���� ��¥"
                           style="height: 55px;">
                </div>
                <div class="col-12">
                    <textarea class="form-control border-0" name="event_Intro" placeholder="��� �Ұ�"></textarea>
                </div>
                <div class="col-12">
                    <textarea class="form-control border-0" name="event_Content" placeholder="��� ����"></textarea>
                </div>
                <div class="col-12">
                    <button class="btn btn-primary rounded-pill py-3 px-5" type="submit">Submit</button>
                </div>
            </div>
        </form>
    </div>
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //�� ���������� ���θ� �ּ� ǥ�� ��Ŀ� ���� ���ɿ� ����, �������� �����͸� �����Ͽ� �ùٸ� �ּҸ� �����ϴ� ����� �����մϴ�.
    function Postcode() {
        daum.postcode.load(function () {
            new daum.Postcode({
                oncomplete: function (data) {
                    var addr = "";
                    if(data.userSelectedType === 'R'){
                        addr = data.roadAddress;
                    }else{
                        addr = data.jibunAddress;
                    }
                    document.getElementById("address").value = addr;
                    document.getElementById("detailAddress").focus();
                }


            }).open();
        });


    }
</script>

<!-- Footer Start -->
<jsp:directive.include file="../fragment/footer.jsp"/>
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