<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<%
  String userID = null;
%>

<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0">
  <a href="../index.jsp" class="navbar-brand d-flex align-items-center border-end px-4 px-lg-5">
    <h2 class="m-0 text-primary">CLOUD</h2>
  </a>
  <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarCollapse">
    <div class="navbar-nav ms-auto p-4 p-lg-0">

      <a href="../map.jsp" class="nav-item nav-link">지도</a>
      <a href="../event/event_main.jsp" class="nav-item nav-link">행사/축제</a>
      <a href="../comm/comm_main.jsp" class="nav-item nav-link">맛집</a>
      <a href="./recommend_session_check.jsp" class="nav-item nav-link">여행지 추천</a>
      <%
        if(session.getAttribute("userID") != null){
      %>
      <%--      <a href="mypage.jsp" class="nav-item nav-link">마이페이지</a>--%>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          마이페이지
        </a>
        <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <li><a class="dropdown-item" href="../mypage/mypage_main.jsp">내 정보</a></li>
          <li><a class="dropdown-item" href="../mypage/mypage_list.jsp">작성한 게시글</a></li>
          <li><a class="dropdown-item" href="../mypage/my_map.jsp">나만의 지도</a></li>
        </ul>
      </li>
    </div>

    <a href="../logout.jsp" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">Logout<i class="fa fa-arrow-right ms-3"></i></a>
    <%
    }else {
      //center에 값이 존재하는 경우에만 로그인버튼을 띄움.
      //처리를 안해주고 로그인 버튼을 누를시 LoginForm.jsp로 넘어가면 Top.jsp에 있는 로그인 버튼이 그대로 나옴.
    %>
    <a href="../login.jsp" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">Login<i class="fa fa-arrow-right ms-3"></i></a>
    <%
      }
    %>
  </div>
  </div>
</nav>
<!-- Navbar End -->

</html>