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
    <jsp:directive.include file="comm_head.jsp"/>
    <style>
        .checked {
            color: orange;
        }
        .left-box {
            float: left;
        }
        .right-box {
            float: right;
        }
    </style>
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
                                <img src="<%="http://localhost:8888//uploadedFiles/"+comm.getComm_picName()%>" alt="<%=comm.getcomm_title()%>"
                                     width=80%, height=80%>
                            </div>

                        </div>
                        <div class="col-sm-6 push-bit" style="padding: 10px;">
                            <div class="clearfix" enctype="multipart/form-data">
                                <span class="h4">
                                    <h3 class="left-box text-success"><%=comm.getcomm_title()%></h3>
                                    <div class="right-box ratings">
                                        <div class="row">
                                            <div>
                                                <%
                                                    for (int star = 0; star < comm.getcomm_score(); star++) {
                                                %>
                                                <span class="fa fa-star checked"></span>
                                                <%
                                                    }
                                                    for (int star_em = 0; star_em < 5 - comm.getcomm_score(); star_em++) {
                                                %>
                                                <span class="fa fa-star"></span>
                                                <%
                                                    }
                                                %>
                                            </div>
                                        </div>
                                        <h6>
                                            <span class="t2">
                                                <span class="blind">점수</span>
                                                <span class="t2t1"><%=comm.getcomm_score()%></span>
                                                <span class="sep">/</span>
                                                <span class="t2t2">5.0</span>
                                            </span>
                                        </h6>
                                    </div>
                                </br>
                                </span>
                            </div>

                        </br><h6><%=comm.getcomm_preview()%></h6></br>
                                <div>
                                    <label><i class="bi bi-geo-alt"></i></i>    주소</label></br>
                                    <p><%=comm.getcomm_address()%></p>
                                </div>
                                <div>
                                    <label><i class="bi bi-calendar-range"></i>    작성날짜</label></br>
                                    <p><%=comm.getcomm_date()%></p>
                                </div>
                                <hr />
                                <h6 style="line-height: 2em">
                                    <%=comm.getcomm_info()%>
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
                                                    </h2>
                                                    <h6>
                                                        <p><%=commentList.get(i).getComment_content()%></p>
                                                    </h6>


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