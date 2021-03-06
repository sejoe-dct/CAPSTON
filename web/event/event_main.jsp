<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@page import="bbs.Bbs" %>
<%@page import="bbs.BbsDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Event_dataDAO" %>
<%@ page import="java.net.URLEncoder" %>
<html lang="en">

<head>
    <jsp:directive.include file="event_head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="event_nav.jsp"/>
<% request.setCharacterEncoding("UTF-8");
    String localDivide = "전국";
//    String searchType = "최신순";
    String search = "";
    if (request.getParameter("localDivide") != null) {
        localDivide = request.getParameter("localDivide");
    }

    if (request.getParameter("search") != null) {
        search = request.getParameter("search");
    }

    ArrayList<Bbs> list = new ArrayList<Bbs>();

    int pageNumber = 0; // 기본페이지 기본적으로 페이지 1부터 시작하므로
    if (request.getParameter("pageNumber") != null) {
        try {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        } catch (Exception e) {
            System.out.println("검색 페이지 번호 오류");
        }
    }

%>
<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">축제 및 체험활동 게시판</h6>
            <h1 class="mb-4">전국 지역방방곡곡의 축제 및 체험활동을 알려드립니다!</h1>
        </div>
        <!-- 카테고리 -->
        <!-- <form method="post" action="event_detail.jsp">-->
        <form method="get" action="./event_main.jsp">
            <div class="row">
                <div class="col-lg-12">
                    <div class="row">
                        <div class="form-group col-lg-2 col-md-2 col-sm-12 p-0" >
                            <select name="localDivide" class="form-select search-slt"  id="portfolio-flters">
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
                            </select>
                        </div>

                        <div class="form-group col-lg-5 col-md-2 col-sm-12 p-0">
                            <input type="text" name="search" class="form-control search-slt" value="<%= search %>"
                                   placeholder="내용을 입력하세요.">
                        </div>

                        <div class="form-group col-lg-2 col-md-2 col-sm-12 p-0">
                            <button type="submit" class="btn btn-primary wrn-btn">검색</button>
                        </div>

                    </div>
                </div>
            </div>

        </form>
        <div class="cp33list1">
            <%
                //BbsDAO bbsDAO = new BbsDAO();
                list = new BbsDAO().getList(localDivide, search, pageNumber);

                for (int i =0; i<list.size();  i++) {
                    if (i == 5) break;

            %>
            <ul class="lst1">
                <!--1번째 -->
                <div class="country-item portfolio-item">
                    <li class="li1">
                        <div class="w1">
                            <!-- 이미지 -->
                            <div class="w1c1">
                                <a href="?amode=view&amp;idx=191&amp;category=F0100" class="figs">
                                    <span class="f1">
                                        <span class="f1p1">
                                            <img src="<%="http://localhost:8888//uploadedFiles/"+list.get(i).getEvent_picName()%>"
                                                 alt="<%=list.get(i).getEvent_Title()%>">
                                        </span>
                                    </span>
                                </a>
                            </div>
                            <!-- 설명 -->
                            <div class="w1c2">
                                <div class="texts">
                                    <a href="event_detail.jsp?eventID=<%= list.get(i).getEventID() %>" class="tg1">
                                        <em class="ic1 bsContain "
                                            style="background-size: contain;"><%=i+1%>
                                        </em>
                                        <strong class="t1"><%=list.get(i).getEvent_Title()%>
                                        </strong>
                                        <div class="t2"><%=list.get(i).getEvent_Preview()%>
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
                                                    <span class="t2"> <%=list.get(i).getEvent_Address()%></span>
                                                </span>
                                            </li>
                                            <li class="di calendar">
                                                <b class="dt">
                                                    <i class="ic1"></i>
                                                    <span class="t1">기간</span>
                                                    <span class="sep">:</span>
                                                </b>
                                                <span class="dd">
                                                    <span class="t2"><%=list.get(i).getEvent_StartDate()%> ~ <%=list.get(i).getEvent_EndDate()%></span>
                                                </span>
                                            </li>
                                            <li class="di agency">
                                                <b class="dt">
                                                    <i class="ic1"></i>
                                                    <span class="t1">문의</span>
                                                    <span class="sep">:</span>
                                                </b>
                                                <span class="dd">
                                                    <span class="t2"><%=list.get(i).getEvent_manager()%></span>
                                                </span>
                                            </li>
                                            <li class="di phone">
                                                <b class="dt">
                                                    <i class="ic1"></i>
                                                    <span class="t1">전화번호</span>
                                                    <span class="sep">:</span>
                                                </b>
                                                <span class="dd">
                                                    <span class="t2"><%=list.get(i).getEvent_Phone()%></span>
                                                </span>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <!--  좋아요 -->
                            <div class="w1c3">
                                <div class="ratings">
                                    <strong class="t1 blind">좋아요</strong>
                                    <div style="padding: 5px;">
                                        <button type="button" class="btn btn-default">
                                            <span class="bi bi-hand-thumbs-up"
                                                  style="font-size: 3rem; color: cornflowerblue;"></span>
                                        </button>

                                    </div>
                                    <span class="t2">
                                        <span class="t2t1"><%=list.get(i).getEvent_Like()%></span>
                                    </span>
                                </div>

                                <!-- 버튼 두개 -->
                                <div class="cp33btns1">
                                    <%
                                        Event_dataDAO event_data = new Event_dataDAO();
                                        String userid = (String) session.getAttribute("userID");
                                        int result = event_data.check(userid, list.get(i).getEventID());

                                        if (result == -1) {
                                    %>
                                    <a href="event_like.jsp?eventID=<%= list.get(i).getEventID() %>" class="button"
                                       data-send-focus="that"><i class="ic1"></i> <span class="t1">담기</span></a>

                                    <%
                                    } else if (result == 2) {
                                    %>
                                    <a href="event_likecancel.jsp?eventID=<%= list.get(i).getEventID() %>"
                                       class="button" data-send-focus="that"><i class="ic1"></i> <span
                                            class="t1">담기취소</span></a>
                                    <%
                                        }
                                    %>
                                    <a href="https://map.kakao.com/link/search/<%=list.get(i).getEvent_Address()%>"
                                       target="_blank" rel="noopener" title="새 창"
                                       class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span
                                            class="t1">길찾기</span></a>
                                </div>
                            </div>
                            <%-- </div>--%>
                    </li>
                    <%
                        }
                    %>
                    <div class="text-end" style="padding: 10px">
                        <a type="button" class="btn btn-primary" href="event_login_check.jsp">등록</a>
                    </div>
                </div>
            </ul>
        </div>

        <!-- Pagination Start -->
        <ul class="pagination justify-content-center mt-3">
            <li class="page-item">
                <%
                    if (pageNumber <= 0) {
                %>
                <a class="page-link disabled">이전</a>
                <%
                    } else {
                %>
                <a class="page-link" href="./event_main.jsp?localDivide=<%=URLEncoder.encode(localDivide, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber - 1%>">이전</a><% }%>
            </li>
            <li class="page-item">
                <%
                    if (list.size() < 6){
                %>
                <a class="page-link disabled">다음</a>
                <%
                    } else {
                %>
                <a class="page-link" href="./event_main.jsp?localDivide=<%=URLEncoder.encode(localDivide, "UTF-8")%>&search=<%=URLEncoder.encode(search, "UTF-8")%>&pageNumber=<%=pageNumber + 1%>">다음</a>
                <%
                    }
                %>
            </li>
        </ul>

        <!--<nav aria-label="...">
            <ul class="pagination">
                <li class="page-item disabled">
                    <a class="page-link" href="#" tabindex="-1">Previous</a>
                </li>
                <li class="page-item"><a class="page-link" href="#">1</a></li>
                <li class="page-item active">
                    <a class="page-link" href="#">2 <span class="sr-only">(current)</span></a>
                </li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                </li>
            </ul>
        </nav>-->
        <!-- Pagination End -->
    </div>
</div>



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