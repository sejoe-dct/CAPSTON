<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@page import="comm.Comm" %>
<%@page import="comm.CommDAO" %>
<%@ page import="java.util.ArrayList" %>

<html lang="en">
<head>
    <jsp:directive.include file="comm_head.jsp"/>

    <!-- Font Awesome Icon Library -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        .checked {
            color: orange;
        }
    </style>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="comm_nav.jsp"/>

<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">지역 커뮤니티</h6>
            <h1 class="mb-4">지역 명소 및 맛집을 소개해주세요!</h1>
        </div>
        <!-- 카테고리 -->
        <!-- <form method="post" action="event_detail.jsp">-->
        <form method="post" action="test.jsp">
            <div class="row mt-n2 wow fadeInUp" data-wow-delay="0.3s">
                <div class="col-12 text-center">
                    <ul class="list-inline mb-5" id="portfolio-flters">
                        <li class="mx-2 active" data-filter="*" name="localNum" value="0">전국</li>
                        <li class="mx-2" data-filter=".seoul" name="localNum" value="1">서울</li>
                        <li class="mx-2" data-filter=".busan" name="localNum" value="2">부산</li>
                        <li class="mx-2" data-filter=".dajeon" name="localNum" value="3">대전</li>
                        <li class="mx-2" data-filter=".incheon" name="localNum" value="4">인천</li>
                        <li class="mx-2" data-filter=".gwangju" name="localNum" value="5">광주</li>
                        <li class="mx-2" data-filter=".ulsan" name="localNum" value="6">울산</li>
                        <li class="mx-2" data-filter=".sejong" name="localNum" value="7">세종</li>
                        <li class="mx-2" data-filter=".gyeonggi" name="localNum" value="8">경기</li>
                        <li class="mx-2" data-filter=".gangwon" name="localNum" value="9">강원</li>
                        <li class="mx-2" data-filter=".choongbuk" name="localNum" value="10">충북</li>
                        <li class="mx-2" data-filter=".choongnam" name="localNum" value="11">충남</li>
                        <li class="mx-2" data-filter=".jeonbuk" name="localNum" value="12">전북</li>
                        <li class="mx-2" data-filter=".jeonnam" name="localNum" value="13">전남</li>
                        <li class="mx-2" data-filter=".gyeongbuk" name="localNum" value="14">경북</li>
                        <li class="mx-2" data-filter=".gyeongnam" name="localNum" value="15">경남</li>
                        <li class="mx-2" data-filter=".jeju" name="localNum" value="16">제주</li>
                    </ul>
                </div>
            </div>
        </form>
        <div class="cp33list1">
            <%

                System.out.println("예전 event_detail.jsp에 있던 소스로 넘어옴");
                Connection conn =null;
                Statement stmt =null;
                ResultSet rs =null;

                CommDAO commDAO=new CommDAO();
            %>

            <ul class="lst1">
                <!--1번째 --> <!-- 서울 리스트 for문 -->
                <div class="country-item portfolio-item seoul"> <!-- 카테고리 구분 -->
                    <%
                        ArrayList<Comm> list = commDAO.getList("전국");
                        for (int i = list.size() - 1; i >= 0; i--) {
                    %>
                    <%System.out.println("comm_main.jsp list.size()-i 값: " + (list.size() - i));%>
                    <%System.out.println("i값 : " + i);%>
                    <li class="li1">
                        <div class="w1">
                            <!-- 이미지 -->
                            <div class="w1c1">
                                <a href="?amode=view&amp;idx=191&amp;category=F0100" class="figs">
                                    <span class="f1">
                                        <span class="f1p1">
                                            <img src="<%="http://localhost:8888//uploadedFiles/"+list.get(i).getComm_picName()%>"
                                                alt="<%=list.get(i).getcomm_title()%>">
                                        </span>
                                    </span>
                                </a>
                            </div>
                            <!-- 설명 -->
                            <div class="w1c2">
                                <div class="texts">
                                    <a href="comm_detail.jsp?commID=<%= list.get(i).getcomm_id() %>" class="tg1">
                                        <em class="ic1 bsContain "
                                            style="background-size: contain;"><%=list.size() - i%>
                                        </em>
                                        <strong class="t1"><%=list.get(i).getcomm_title()%></strong>
                                        <div class="t2"><%=list.get(i).getcomm_preview()%></div>
                                    </a>
                                    <div class="cp33dlist1">
                                        <ul class="dl1">
                                            <li class="di place">
                                                <b class="dt">
                                                    <i class="ic1"></i>
                                                    <span class="t1">위치</span>
                                                    <span class="sep">:</span>
                                                </b>
                                                <span class="dd">
                                                    <span class="t2"> <%=list.get(i).getcomm_address()%></span>
                                                </span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!-- 별점 -->
                            <div class="w1c3">
                                <div class="ratings">
                                    <strong class="t1 blind">별점</strong>

                                    <div class="row">
                                    <div>
                                        <%
                                            for (int star = 0; star <list.get(i).getcomm_score(); star++) {
                                        %>
                                    <span class="fa fa-star checked"></span>
                                        <%
                                            }
                                            for (int star_em = 0; star_em <5-list.get(i).getcomm_score(); star_em++) {
                                        %>
                                        <span class="fa fa-star"></span>
                                        <%
                                            }
                                        %>
                                        </div>
                                    </div>



                                    <span class="t2">
                                        <span class="blind">점수</span>
                                        <span class="t2t1"><%=list.get(i).getcomm_score()%></span>
                                        <span class="sep">/</span>
                                        <span class="t2t2">5.0</span>
                                      </span>
                                    <span class="t3">(총 <em class="em">1개</em> 후기)</span>
                                </div>
                                <!-- 버튼 두개 -->
                                <div class="cp33btns1">
                                    <a href="comm_like.jsp?commID=<%= list.get(i).getcomm_id() %>" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>
                                    <a href="http://map.daum.net/link/to/%EB%8F%85%EC%9D%BC%EB%A7%88%EC%9D%84+%EB%A7%A5%EC%A3%BC%EC%B6%95%EC%A0%9C,34.798675,128.04251009999996"
                                          target="_blank" rel="noopener" title="새 창"
                                          class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span
                                               class="t1">길찾기</span></a>
                                </div>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                    <div class="text-end" style="padding: 10px">
                        <a type="button" class="btn btn-primary" href="comm_login_check.jsp">등록</a>
                    </div>
                </div>
            </ul>
        </div>
    </div>
</div>

<!-- Footer Start -->
<jsp:directive.include file="../fragment/footer.jsp"/>
<!-- Footer End -->

<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i
        class="bi bi-arrow-up"></i></a>


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
<script src="../static/js/rating.js"></script>

</body>

</html>