comm_detail.jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="comm.Comm" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="comment.Comment" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <!--카카오지도 카테고리별-->
    <style>
        .map_wrap, .map_wrap * {
            margin: 0;
            padding: 0;
            font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
            font-size: 12px;
        }

        .map_wrap {
            position: relative;
            width: 100%;
            height: 350px;
        }

        #category {
            position: absolute;
            top: 10px;
            left: 1000px;
            border-radius: 5px;
            border: 1px solid #909090;
            box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);
            background: #fff;
            overflow: hidden;
            z-index: 2;
        }

        #category li {
            float: right;
            list-style: none;
            width: 50px;
            border-right: 1px solid #acacac;
            padding: 6px 0;
            text-align: center;
            cursor: pointer;
        }

        #category li.on {
            background: #eee;
        }

        #category li:hover {
            background: #ffe6e6;
            border-left: 1px solid #acacac;
            margin-left: -1px;
        }

        #category li:last-child {
            margin-right: 0;
            border-right: 0;
        }

        #category li span {
            display: block;
            margin: 0 auto 3px;
            width: 27px;
            height: 28px;
        }

        #category li .category_bg {
            background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;
        }

        #category li .bank {
            background-position: -10px 0;
        }

        #category li .mart {
            background-position: -10px -36px;
        }

        #category li .pharmacy {
            background-position: -10px -72px;
        }

        #category li .oil {
            background-position: -10px -108px;
        }

        #category li .cafe {
            background-position: -10px -144px;
        }

        #category li .store {
            background-position: -10px -180px;
        }

        #category li.on .category_bg {
            background-position-x: -46px;
        }

        .placeinfo_wrap {
            position: absolute;
            bottom: 28px;
            left: -150px;
            width: 300px;
        }

        .placeinfo {
            position: relative;
            width: 100%;
            border-radius: 6px;
            border: 1px solid #ccc;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            background: #fff;
        }

        .placeinfo:nth-of-type(n) {
            border: 0;
            box-shadow: 0px 1px 2px #888;
        }

        .placeinfo_wrap .after {
            content: '';
            position: relative;
            margin-left: -12px;
            left: 50%;
            width: 22px;
            height: 12px;
            background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
        }

        .placeinfo a, .placeinfo a:hover, .placeinfo a:active {
            color: #fff;
            text-decoration: none;
        }

        .placeinfo a, .placeinfo span {
            display: block;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        }

        .placeinfo span {
            margin: 5px 5px 0 5px;
            cursor: default;
            font-size: 13px;
        }

        .placeinfo .title {
            font-weight: bold;
            font-size: 14px;
            border-radius: 6px 6px 0 0;
            margin: -1px -1px 0 -1px;
            padding: 10px;
            color: #fff;
            background: #d95050;
            background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;
        }

        .placeinfo .tel {
            color: #0f7833;
        }

        .placeinfo .jibun {
            color: #999;
            font-size: 11px;
            margin-top: 0;
        }
    </style>

    <jsp:directive.include file="comm_head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="comm_nav.jsp"/>

<%
    // 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크
    //String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }

    // commID를 초기화 시키고
    // 'commID'라는 데이터가 넘어온 것이 존재한다면 캐스팅을 하여 변수에 담는다
    String commID = null;
    if (request.getParameter("commID") != null) {

        commID = request.getParameter("commID");
        System.out.println("디테일 커뮤니티 아이디 : " + commID);
        //커뮤니티 세션 commID 지정
        //session.setAttribute("commID", commID);
    }
    // 만약 넘어온 데이터가 없다면
    if (commID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('유효하지 않은 글입니다')");
        script.println("location.href='comm_main.jsp'");
        script.println("</script");
    }

    // 유효한 글이라면 구체적인 정보를 'comm'라는 인스턴스에 담는다
    Comm comm = new CommDAO().getCommDetail(Integer.parseInt(commID));
    //댓글

    CommentDAO commentDAO = new CommentDAO();

%>

<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">

        <div class="container-xxl py-5">
            <div class="container">
                <div class="container bootstrap snippets bootdey">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="pro-img-details">
                                <%--                                <img src="<%=list.get(0).getEvent_Picture()%>" alt="<%=list.get(0).getEvent_Title()%>>">--%>
                            </div>

                        </div>
                        <div class="col-sm-6 push-bit" style="padding: 10px;">
                            <div class="clearfix" enctype="multipart/form-data">
                                <span class="h4">

                    <h3 class="text-success"><%=comm.getcomm_title()%></h3><br/>
                        </span>
                                <div class="text-end">
                                    <p><%=comm.getcomm_address()%>
                                    </p>
                                </div>
                                <hr/>
                                <h6><%=comm.getcomm_info()%>
                                </h6>
                            </div>
                        </div>
                    </div>
                    <!-- detail End -->

                    <hr/>

                    <!-- 댓글 Start -->
                    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
                          rel="stylesheet">

                    <div class="container bootdey">
                        <div class="col-md-12 bootstrap snippets">
                            <div class="form-group">
                                <div class="panel">
                                    <div class="panel-body">
                                        <%--<div th:object="${foodCmtDto}">--%>

                                        <form action="comment_write.jsp" >
                                                <textarea type="text" class="form-control" rows="2"
                                                          name="comment_content" placeholder="댓글을 남겨주세요"></textarea>
                                            <div class="mar-top clearfix">
                                                <input type="hidden" name="commID" value="<%=commID%>">
                                                <%--<a href="comment_write.jsp?commID=<%= commentList.get(i).getCommunity_id() %>" class="tg1">
                                                <a href="comment_write.jsp?commentID=<%=commID%>"></a> --%>
                                                <button style="margin-top: 5px"
                                                <%--onclick="location.href='comment_write.jsp?commentID=<%=commID%>'"--%>
                                                        class="btn btn-sm btn-primary pull-right" type="submit"><i
                                                        class="fa fa-pencil fa-fw"></i> Share
                                                </button>
                                            </div>
                                        </form>
                                        <%--</div>--%>
                                    </div>
                                </div>

                                <hr/>
                                <div class="panel">
                                    <div class="panel-body">
                                        <!-- Newsfeed Content -->
                                        <!--===================================================-->
                                        <% ArrayList<Comment> commentList = commentDAO.getList(commID);
                                            String commentID = null;


                                            for (int i = commentList.size() - 1; i >= 0; i--) {
                                                commentID = commentList.get(i).getComment_id(); %>

                                        <div class="media-block">
                                            <div class="media-body">
                                                <div class="mar-btm">
                                                    <h2 class="btn-link text-semibold media-heading box-inline">
                                                        <%=commentList.get(i).getUser_id() %>
                                                        <p><%=commentList.get(i).getComment_content()%></p>

                                                    </h2>
                                                </div>
                                                <form action="comment_delete.jsp" method="post">
                                                    <input type="hidden" name="commID" value="<%=commID%>">
                                                    <input type="hidden" name="commentID" value="<%=commentID%>">
                                                    <button style="margin-top: 5px"
                                                            class="btn btn-sm btn-primary pull-right" type="submit">
                                                        <i class="fa fa-pencil fa-fw"></i> 삭제
                                                    </button>
                                                </form>
                                                <hr>
                                                <!-- Comments -->
                                            </div>
                                        </div>
                                        <%
                                            }
                                        %>

                                        <!--===================================================-->
                                        <!-- End Newsfeed Content -->
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 댓글 End -->


                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- 게시판 End -->


<!-- Footer Start -->
<jsp:directive.include file="../fragment/footer.jsp"/>
<!-- Footer End -->


<!-- Back to Top -->
<a href="#" class="btn btn-lg btn-primary btn-lg-square rounded-circle back-to-top"><i
        class="bi bi-arrow-up"></i></a>


<!-- JavaScript Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="lib/wow/wow.min.js"></script>
<script src="..static/lib/easing/easing.min.js"></script>
<script src="../static/lib/waypoints/waypoints.min.js"></script>
<script src="../static/lib/counterup/counterup.min.js"></script>
<script src="../static/lib/owlcarousel/owl.carousel.min.js"></script>
<script src="../static/lib/isotope/isotope.pkgd.min.js"></script>
<script src="../static/lib/lightbox/js/lightbox.min.js"></script>

<!-- Template Javascript -->
<script src="../static/js/main.js"></script>
</body>


</html>
</html>


<%
    // 로그인 하지 않았을 때 보여지는 화면
    if (userID == null) {
    }
%>

<!-- 해당 글의 작성자가 본인이라면 수정과 삭제가 가능하도록 코드 추가 -->
<%--
   <%
       if(userID != null && userID.equals(bbs.getUserID())){
   %>
<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
<a href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
 --%>