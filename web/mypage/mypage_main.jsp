<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="user.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="user.UserDAO" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:directive.include file="mypage_head.jsp"/>
</head>


<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="mypage_nav.jsp"/>


    <div class="container-xxl py-5">
        <div class="container">
            <!-- 제목 / 소제목 -->
            <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
                <h6 class="text-primary">내 정보</h6>
                <h1 class="mb-4"> <%=session.getAttribute("userID")%>님, 환영합니다!</h1>
            </div>

            <%

                System.out.println("예전 event_detail.jsp에 있던 소스로 넘어옴");
                Connection conn =null;
                Statement stmt =null;
                ResultSet rs =null;

                UserDAO userDAO=new UserDAO();
                String session_id=String.valueOf(session.getAttribute("userID"));

                ArrayList<User> list= userDAO.getUserinfo(session_id);
                int user_type = list.get(0).getUserType();
                String user_Sex = list.get(0).getUserSex();
            %>

                    <form>
                        <div class="row">
                            <!-- 타입선택창 -->
                            <div class="col-md-6 mb-4">
                                <div class="form-check form-check-inline">
                                    <%
                                        if (user_type == 2){

                                    %>
                                    <input class="form-check-input" type="radio" name="TypeRadioOptions" id="ceotype"
                                           value="ceo" checked />
                                    <%
                                        }else{
                                    %>

                                    <input class="form-check-input" type="radio" name="TypeRadioOptions" id="ceotype"
                                           value="ceo" disabled/>
                                    <%
                                        }
                                    %>
                                    <label class="form-check-label" for="ceotype">사장님</label>
                                </div>
                                <div class="form-check form-check-inline">
                                    <%
                                        if (user_type == 3){
                                    %>
                                    <input class="form-check-input" type="radio" name="TypeRadioOptions" id="membertype"
                                           value="member" checked />
                                    <%
                                        }else{
                                    %>
                                    <input class="form-check-input" type="radio" name="TypeRadioOptions" id="membertype"
                                           value="member" disabled/>
                                    <%
                                        }
                                    %>
                                    <label class="form-check-label" for="membertype">회원</label>
                                </div>
                            </div>
                            <!-- 성별선택창 -->
                            <div class="col-md-6 mb-4">
                                <div class="form-check form-check-inline">
                                    <%
                                        if (user_Sex.equals("M")){

                                    %>
                                    <input class="form-check-input" type="radio" name="GenderRadioOptions" id="maleGender"
                                           value="M" checked />
                                    <%
                                    }else{
                                    %>
                                    <input class="form-check-input" type="radio" name="GenderRadioOptions" id="maleGender"
                                           value="M"  disabled/>
                                    <%
                                        }
                                    %>
                                    <label class="form-check-label" for="maleGender">남자</label>
                                </div>

                                <div class="form-check form-check-inline">
                                    <%
                                        if (user_Sex.equals("F")){

                                    %>
                                    <input class="form-check-input" type="radio" name="GenderRadioOptions" id="maleGender"
                                           value="F" checked />
                                    <%
                                    }else{
                                    %>
                                    <input class="form-check-input" type="radio" name="GenderRadioOptions" id="maleGender"
                                           value="F"  disabled/>
                                    <%
                                        }
                                    %>
                                    <label class="form-check-label" for="maleGender">여자</label>
                                </div>

                            </div>

                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4">

                                <div class="form-outline">
<%--                                    <input type="text" name="name" class="form-control form-control-lg" <%= list.get(0).getUserName() %>/>--%>
                                    <p  class="form-control" id="name" ><%= list.get(0).getUserName() %></p>
                                    <label class="form-label" for="Name">Name</label>
                                </div>
                            </div>
                            <div class="col-md-6 mb-4">

                                <div class="form-outline">
<%--                                    <input type="text" name="nickname" class="form-control form-control-lg" required="required"/>--%>
                                    <p  class="form-control" id="nickname" ><%= list.get(0).getUserNickname() %></p>
                                    <label class="form-label" for="nickname">Nickname</label>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4 pb-2">

                                <div class="form-outline">
<%--                                    <input type="email" name="email" class="form-control form-control-lg" required="required"/>--%>
                                    <p  class="form-control" id="email" ><%= list.get(0).getUserEmail() %></p>
                                    <label class="form-label" for="email">Email</label>
                                </div>

                            </div>
                            <div class="col-md-6 mb-4 pb-2">
                                <div class="form-outline">
<%--                                    <input type="text" name="age" class="form-control form-control-lg" required="required"/>--%>
                                    <p  class="form-control" id="age" ><%= list.get(0).getUserAge() %></p>
                                    <label class="form-label" for="age">Age</label>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-4 pb-2">

                                <div class="form-outline">
<%--                                    <input type="text" name="id" class="form-control form-control-lg" disabled/>--%>
                                    <p  class="form-control" id="id" ><%= list.get(0).getUserID() %></p>
                                    <label class="form-label" for="id">ID</label>
                                </div>

                            </div>
                            <div class="col-md-6 mb-4 pb-2">
                                <div class="form-outline">
<%--                                    <input type="password" name="ps" class="form-control form-control-lg" disabled/>--%>
                                    <p  class="form-control" id="ps" >비밀번호는 안알려줄거지롱</p>
                                    <label class="form-label" for="ps">Password</label>
                                </div>

                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-4 pb-2">

                                <div class="form-outline">
                                    <%--                                    <input type="text" name="id" class="form-control form-control-lg" disabled/>--%>
                                    <p  class="form-control" id="id" ><%= list.get(0).getUserFv1() %></p>
                                    <label class="form-label" for="id">타입1</label>
                                </div>

                            </div>
                            <div class="col-md-4 mb-4 pb-2">
                                <div class="form-outline">
                                    <%--                                    <input type="password" name="ps" class="form-control form-control-lg" disabled/>--%>
                                    <p  class="form-control" id="ps" ><%= list.get(0).getUserFv2() %></p>
                                    <label class="form-label" for="ps">타입2</label>
                                </div>

                            </div>
                            <div class="col-md-4 mb-4 pb-2">

                                <div class="form-outline">
                                    <%--                                    <input type="text" name="id" class="form-control form-control-lg" disabled/>--%>
                                    <p  class="form-control" id="id" ><%= list.get(0).getUserFv3() %></p>
                                    <label class="form-label" for="id">타입3</label>
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
                            <button type="submit" class="btn btn-primary btn-block btn-lg">수정</button>

                        </div>

                    </form>
        </div>
    </div>

<!-- Signup End-->

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