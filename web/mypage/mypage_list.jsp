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
    <jsp:directive.include file="mypage_head.jsp"/>
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
<jsp:directive.include file="mypage_nav.jsp"/>

<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">지역 커뮤니티</h6>
            <h2 class="mb-4">지역 명소 및 맛집을 소개해주세요!</h2>
        </div>

        <div class="cp33list1"
            <%
                CommDAO commDAO=new CommDAO();
                CommentDAO commentDAO=new CommentDAO();

                String session_id=String.valueOf(session.getAttribute("userID"));
            %>

        <ul class="lst1">
            <!--1번째 -->
            <div class="country-item portfolio-item seoul">
                <%
                    ArrayList<Comm> list = commDAO.getUserlist(session_id);
                    for (int i = list.size() - 1; i >= 0; i--) {
                %>
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
                                <a href="../comm/comm_detail.jsp?commID=<%= list.get(i).getcomm_id() %>" class="tg1">
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
                                <span class="t3">(총 <em class="em"><%=commentDAO.commentCount(list.get(i).getcomm_id())%>개
                                    </em> 댓글)</span>
                            </div>
                            <!-- 버튼 두개 -->
                            <div class="cp33btns1">
<%--                                <div class="col-12" >--%>
<%--                                    <button class="btn btn-primary rounded-pill py-3 px-5" type="submit">Submit</button>--%>
<%--                                </div>--%>
                                    <a type="button" class="btn btn-outline-secondary" href="mypage_modify.jsp?commID=<%= list.get(i).getcomm_id() %>">수정</a>
                                    <a type="button" class="btn btn-outline-danger" href="mypage_del.jsp?commID=<%= list.get(i).getcomm_id() %>">삭제</a>

                            </div>
                        </div>
                    </div>
                </li>
                <%
                    }
                %>

            </div>
        </ul>

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