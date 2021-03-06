<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@page import="comm.Comm" %>
<%@page import="comm.CommDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="comment.CommentDAO" %>

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
<% request.setCharacterEncoding("UTF-8");
    String localDivide = "전국";
    String searchType = "최신순";
    String search = "";
    int pageNumber = 0;
    if (request.getParameter("localDivide") != null) {
        localDivide = request.getParameter("localDivide");
    }
    if (request.getParameter("searchType") != null) {
        searchType = request.getParameter("searchType");
    }
    if (request.getParameter("search") != null) {
        search = request.getParameter("search");
    }
%>
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
        <%--        <form method="post" action="test.jsp">
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
                </form>--%>
        <form method="get" action="./comm_main.jsp">
            <div class="row mt-n2 wow fadeInUp" data-wow-delay="0.3s">
                <div class="col-12 text-center">
                    <%--   <select name="lectureDivide" class="form-control mx-1 mt-2">         
                           <option value="전체">전체</option>
                                    
                           <option value="전공" <%if (lectureDivide.equals("전공")) out.println("selected");%>>전공</option>
                                    
                           <option value="교양" <%if (lectureDivide.equals("교양")) out.println("selected");%>>교양</option>
                                    
                           <option value="기타" <%if (lectureDivide.equals("기타")) out.println("selected");%>>기타</option>
                                   </select>--%>

                    <select name="localDivide" class="mx-1 mt-2 mb-1" id="portfolio-flters">
                        <option class="mx-2" value="전국">전국
                        </option>
                        <option class="mx-2" value="부산" <%if (localDivide.equals("부산")) out.println("selected");%>>부산
                        </option>
                        <option class="mx-2" value="경기" <%if (localDivide.equals("경기")) out.println("selected");%>>경기
                        </option>
                        <option class="mx-2" value="강원" <%if (localDivide.equals("강원")) out.println("selected");%>>강원
                        </option>
                        <option class="mx-2" value="충북" <%if (localDivide.equals("충북")) out.println("selected");%>>충북
                        </option>
                        <option class="mx-2" value="충남" <%if (localDivide.equals("충남")) out.println("selected");%>>충남
                        </option>
                        <option class="mx-2" value="전북" <%if (localDivide.equals("전북")) out.println("selected");%>>전북
                        </option>
                        <option class="mx-2" value="전남"  <%if (localDivide.equals("전남")) out.println("selected");%>>전남
                        </option>
                        <option class="mx-2" value="경북"  <%if (localDivide.equals("경북")) out.println("selected");%>>경북
                        </option>
                        <option class="mx-2" value="경남"  <%if (localDivide.equals("경남")) out.println("selected");%>>경남
                        </option>
                        <option class="mx-2" value="제주"  <%if (localDivide.equals("제주")) out.println("selected");%>>제주
                        </option>
                        <option class="mx-2" value="세종"  <%if (localDivide.equals("세종")) out.println("selected");%>>세종
                        </option>
                        <%--    <li class="mx-2" data-filter=".gyeonggi" name="localNum" value="8">경기</li>
                            <li class="mx-2" data-filter=".gangwon" name="localNum" value="9">강원</li>
                            <li class="mx-2" data-filter=".choongbuk" name="localNum" value="10">충북</li>
                            <li class="mx-2" data-filter=".choongnam" name="localNum" value="11">충남</li>
                            <li class="mx-2" data-filter=".jeonbuk" name="localNum" value="12">전북</li>
                            <li class="mx-2" data-filter=".jeonnam" name="localNum" value="13">전남</li>
                            <li class="mx-2" data-filter=".gyeongbuk" name="localNum" value="14">경북</li>
                            <li class="mx-2" data-filter=".gyeongnam" name="localNum" value="15">경남</li>
                            <li class="mx-2" data-filter=".jeju" name="localNum" value="16">제주</li>--%>
                    </select>
                    <div>
                        <input type="text" name="search" class="form-control mr-sm-2" value="<%= search %>"
                               placeholder="내용을 입력하세요.">
                        <button type="submit" class="btn btn-primary mx-1 mt-2">조회</button>
                    </div>
                </div>
            </div>
        </form>
        <div class="cp33list1">
            <%

                System.out.println("예전 event_detail.jsp에 있던 소스로 넘어옴");
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                CommDAO commDAO = new CommDAO();
                CommentDAO commentDAO=new CommentDAO();
            %>

            <ul class="lst1">
                <!--1번째 --> <!-- 서울 리스트 for문 -->
                <div class="country-item portfolio-item seoul"> <!-- 카테고리 구분 -->
                    <%
                        ArrayList<Comm> list = commDAO.getList(localDivide, search);

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
                                        <strong class="t1"><%=list.get(i).getcomm_title()%>
                                        </strong>
                                        <div class="t2"><%=list.get(i).getcomm_preview()%>
                                        </div>
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
                                                for (int star = 0; star < list.get(i).getcomm_score(); star++) {
                                            %>
                                            <span class="fa fa-star checked"></span>
                                            <%
                                                }
                                                for (int star_em = 0; star_em < 5 - list.get(i).getcomm_score(); star_em++) {
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
                                    <span class="t3">(총 <em class="em"><%=commentDAO.commentCount(list.get(i).getcomm_id())%>개
                                    </em> 댓글)</span>

                                </div>
                                <!-- 버튼 두개 -->
                                <div class="cp33btns1">
                                    <a href="comm_like.jsp?commID=<%= list.get(i).getcomm_id() %>"
                                       onclick="doConfirmRealName(this.href);return false;" class="button"
                                       data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>
                                    <a href="https://map.kakao.com/link/search/<%=list.get(i).getcomm_address()%>"
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