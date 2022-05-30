<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@page import="bbs.Bbs"%>
<%@page import="bbs.BbsDAO"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bbs.BbsDAO" %>
<html lang="en">

<head>
    <jsp:directive.include file="../fragment/head.jsp"/>
</head>

<body>
<jsp:directive.include file="../fragment/spinnertopbar.jsp"/>
<jsp:directive.include file="event_nav.jsp"/>

<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">축제 및 행사 게시판</h6>
            <h1 class="mb-4">전국 지역방방곡곡의 축제들을 알려드립니다!</h1>
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
 //   request.getParameter("localNum");
    System.out.println("예전 event_detail.jsp에 있던 소스로 넘어옴");
    Connection conn =null;
    Statement stmt =null;
    ResultSet rs =null;
 //   int localNum=0;
 //   String imsi = request.getParameter("imsi")==null ? "" : request.getParameter("imsi");


    //   int localNum = Integer.parseInt(request.getParameter("localNum")==null ? "0": request.getParameter("localNum"));
   //     System.out.println("넘어온 localNum ===="+localNum);
    //    String localName = "";
/*
        switch (localNum) {
            case 0:
                localName="전국";
            case 1:
                localName="seoul";
                break;
            case 2:
              System.out.println("busan 클릭 넘어옴");
                localName="busan";
                break;
            case 3:
              System.out.println("dajeon 클릭 넘어옴");
                localName="dajeon";
                break;
            case 4:
              System.out.println("incheon 클릭 넘어옴");
                localName = "incheon";
                break;
            case 5:
                localName = "gwangju";
                break;
            case 6:
                localName = "ulsan";
                break;
            case 7:
                localName = "sejong";
                break;
            case 8:
                localName = "gyeonggi";
                break;
            case 9:
                localName = "gangwon";
                break;
            case 10:
                localName = "choongbuk";
                break;
            case 11:
                localName = "choongnam";
                break;
            case 12:
                localName = "jeonbuk";
                break;
            case 13:
                localName = "jeonnam";
                break;
            case 14:
                localName = "gyeongbuk";
                break;
            case 15:
                localName = "gyeongnam";
                break;
            case 16:
                localName = "jeju";
                break;
            default:
                localName = "전국";
                break;
        }*/

  BbsDAO bbsDAO=new BbsDAO();
 // ArrayList<Bbs> list= bbsDAO.getList(localName);
  //for(int i=list.size()-1;i>=0;i--){
%>


            <ul class="lst1">

                <!--1번째 --> <!-- 서울 리스트 for문 -->
                <div class="country-item portfolio-item seoul"> <!-- 카테고리 구분 -->
                    <%
                        //    ArrayList<Bbs> list= bbsDAO.getList("서울");
                        ArrayList<Bbs> list= bbsDAO.getList("seoul");
                        for(int i=list.size()-1;i>=0;i--){
                    %>
                    <%System.out.println("event_list.jsp list.size()-i 값: "+(list.size()-i));%>
                    <%System.out.println("i값 : "+i);%>
                    <%--                    <%=   list.size()-i %>--%>
                    <li class="li1">
                        <div class="w1">
                            <!-- 이미지 -->
                            <div class="w1c1">
                                <a href="?amode=view&amp;idx=191&amp;category=F0100" class="figs">
              <span class="f1">
                  <%System.out.println("event_list.jsp 리스트 html문 for문 안 ");%>
                <span class="f1p1">
          <!--      <img src="../static/img/test/맥주1.JPG.400x400.jpg" alt="독일마을 맥주축제1">-->
<%--                    <img src="C:/CAPSTON/out/artifacts/cap_war_exploded/uploadedFiles/KakaoTalk_20220518_191008960.jpg" alt="<%=list.get(i).getEvent_Title()%>">--%>
                    <img src="<%="http://localhost:8888//uploadedFiles/"+list.get(i).getEvent_picName()%>" alt="<%=list.get(i).getEvent_Title()%>">
                </span>
              </span>
                                </a>
                            </div>
                            <!-- 설명 -->
                            <div class="w1c2">
                                <div class="texts">
                                    <a href="event_detail.jsp?eventID=<%= list.get(i).getEventID() %>" class="tg1">
                                        <em class="ic1 bsContain " style="background-size: contain;"><%=list.size()-i%></em>
                                        <strong class="t1"><%=list.get(i).getEvent_Title()%></strong>

                                        <div class="t2"><%=list.get(i).getEvent_Preview()%></div>
                                    </a>
                                    <div class="cp33dlist1">
                                        <ul class="dl1">
                                            <li class="di place">
                                                <b class="dt">
                                                    <i class="ic1"></i>
                                                    <span class="t1">위치</span>
                                                    <span class="sep">:</span></b>
                                                <span class="dd">
                      <span class="t2"> <%=list.get(i).getEvent_Address()%></span>
                    </span>
                                            </li>
                                            <li class="di calendar">
                                                <b class="dt"><i class="ic1"></i> <span class="t1">기간</span> <span
                                                        class="sep">:</span></b>
                                                <span class="dd"><span class="t2"><%=list.get(i).getEvent_StartDate()%> ~ <%=list.get(i).getEvent_EndDate()%></span></span>
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
                            <!-- 별점 -->
                            <div class="w1c3">
                                <div class="ratings">
                                    <strong class="t1 blind">별점</strong>
                                    <i class="cp33rating1star5">
                                        <i class="st-on" style="width:100.0%;"><i class="ic1 bsCover"
                                                                                  style="background-size: cover;"></i><i
                                                class="ic2 bsCover" style="background-size: cover;"></i></i>
                                        <!-- ☆★(3.5/5) -->
                                        <i class="st-off"><i class="ic2"></i></i>
                                    </i>
                                    <span class="t2">
                <span class="blind">점수</span>
                <span class="t2t1"><%=list.get(i).getEvent_score()%></span>
                <span class="sep">/</span>
                <span class="t2t2">5.0</span>
              </span>
                                    <span class="t3">(총 <em class="em">1개</em> 후기)</span>
                                </div>
                                <!-- 버튼 두개 -->
                                <div class="cp33btns1">
                                    <!--<a href="?amode=rn%5Ename%5Eins&amp;rn_url=category%3DF0100%26amp%3Bamode%3Dview%26amp%3Bidx%3D191" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>-->
                                    <!--   <a href="http://map.daum.net/link/to/%EB%8F%85%EC%9D%BC%EB%A7%88%EC%9D%84+%EB%A7%A5%EC%A3%BC%EC%B6%95%EC%A0%9C,34.798675,128.04251009999996"
                                          target="_blank" rel="noopener" title="새 창"
                                          class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span
                                               class="t1">길찾기</span></a> -->
                                </div>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                    <div class="text-end" style="padding: 10px">
                        <a type="button" class="btn btn-primary" href="event_login_check.jsp">등록</a>
                    </div>
                </div>


                <!-- 2번째 -->
                <!--
                <li class="li1"><div class="w1">
                  <div class="w1c1">
                    <a href="?amode=view&amp;idx=190&amp;category=F0100" class="figs">
                      <span class="f1">
                        <span class="f1p1">
                          <img src="../static/img/test/마늘한우.jpg" alt="마늘한우1">
                        </span>
                      </span>
                    </a>
                  </div>
                  <div class="w1c2">
                    <div class="texts">
                      <a href="?amode=view&amp;idx=190&amp;category=F0100" class="tg1">
                        <em class="ic1 bsContain " style="background-size: contain;">2</em>
                        <strong class="t1">보물섬 마늘&amp;한우 축제</strong>
                        <div class="t2">만남, 그 이상의 맛남!마늘 가득! 한우 듬뿍! 재미...</div>
                      </a>
                      <div class="cp33dlist1">
                        <ul class="dl1">
                          <li class="di place">
                            <b class="dt"><i class="ic1"></i> <span class="t1">위치</span> <span class="sep">:</span></b>
                            <span class="dd"><span class="t2">남해 유배문학관 광장, 남해읍 남해대로 2745</span></span>
                          </li>
                          <li class="di calendar">
                            <b class="dt"><i class="ic1"></i> <span class="t1">기간</span> <span class="sep">:</span></b>
                            <span class="dd"><span class="t2">2022-05-11 ~ 2022-06-15</span></span>
                          </li>
                          <li class="di agency">
                            <b class="dt"><i class="ic1"></i> <span class="t1">문의</span> <span class="sep">:</span></b>
                            <span class="dd"><span class="t2">남해군관광문화재단</span></span>
                          </li>
                          <li class="di phone">
                            <b class="dt"><i class="ic1"></i> <span class="t1">전화번호</span> <span class="sep">:</span></b>
                            <span class="dd"><span class="t2">055-864-4514, 4515</span></span>
                          </li>
                        </ul>
                      </div>

                    </div>
                  </div>
                  <div class="w1c3">
                    <div class="ratings">
                      <strong class="t1 blind">별점</strong>
                      <i class="cp33rating1star5">
                        <i class="st-on" style="width:0.0%;"><i class="ic1 bsCover" style="background-size: cover;"></i><i class="ic2 bsCover" style="background-size: cover;"></i></i> ☆★(3.5/5)
                        <i class="st-off"><i class="ic2"></i></i>
                      </i>
                      <span class="t2">
                        <span class="blind">점수</span>
                        <span class="t2t1">0</span>
                        <span class="sep">/</span>
                        <span class="t2t2">5.0</span>
                      </span>
                      <span class="t3">(총 <em class="em">0개</em> 후기)</span>
                    </div>
                    <div class="cp33btns1">
                      <a href="?amode=rn%5Ename%5Eins&amp;rn_url=category%3DF0100%26amp%3Bamode%3Dview%26amp%3Bidx%3D190" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>
                      <a href="http://map.daum.net/link/to/%EB%B3%B4%EB%AC%BC%EC%84%AC+%EB%A7%88%EB%8A%98%26%ED%95%9C%EC%9A%B0+%EC%B6%95%EC%A0%9C,34.8319601067584,127.899185508281" target="_blank" rel="noopener" title="새 창" class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span class="t1">길찾기</span></a>
                    </div>
                  </div>
                </div></li>-->
            </ul>
            <%--            <jsp:directive.include file="footer.jsp"/>--%>


            <!-- Footer Start -->
            <div class="container-fluid bg-dark text-body footer mt-5 pt-5 wow fadeIn" data-wow-delay="0.1s">
                <div class="container py-5">
                    <div class="row g-5">
                        <div class="col-lg-3 col-md-6">
                            <h5 class="text-white mb-4">Address</h5>
                            <p class="mb-2"><i class="fa fa-map-marker-alt me-3"></i>123 Street, New York, USA</p>
                            <p class="mb-2"><i class="fa fa-phone-alt me-3"></i>+012 345 67890</p>
                            <p class="mb-2"><i class="fa fa-envelope me-3"></i>info@example.com</p>
                            <div class="d-flex pt-2">
                                <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-youtube"></i></a>
                                <a class="btn btn-square btn-outline-light btn-social" href=""><i class="fab fa-linkedin-in"></i></a>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h5 class="text-white mb-4">Quick Links</h5>
                            <a class="btn btn-link" href="">About Us</a>
                            <a class="btn btn-link" href="">Contact Us</a>
                            <a class="btn btn-link" href="">Our Services</a>
                            <a class="btn btn-link" href="">Terms & Condition</a>
                            <a class="btn btn-link" href="">Support</a>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h5 class="text-white mb-4">Project Gallery</h5>
                            <div class="row g-2">
                                <div class="col-4">
                                    <img class="img-fluid rounded" src="../static/img/gallery-1.jpg" alt="">
                                </div>
                                <div class="col-4">
                                    <img class="img-fluid rounded" src="../static/img/gallery-2.jpg" alt="">
                                </div>
                                <div class="col-4">
                                    <img class="img-fluid rounded" src="../static/img/gallery-3.jpg" alt="">
                                </div>
                                <div class="col-4">
                                    <img class="img-fluid rounded" src="../static/img/gallery-4.jpg" alt="">
                                </div>
                                <div class="col-4">
                                    <img class="img-fluid rounded" src="../static/img/gallery-5.jpg" alt="">
                                </div>
                                <div class="col-4">
                                    <img class="img-fluid rounded" src="../static/img/gallery-6.jpg" alt="">
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <h5 class="text-white mb-4">Newsletter</h5>
                            <p>Dolor amet sit justo amet elitr clita ipsum elitr est.</p>
                            <div class="position-relative mx-auto" style="max-width: 400px;">
                                <input class="form-control border-0 w-100 py-3 ps-4 pe-5" type="text" placeholder="Your email">
                                <button type="button" class="btn btn-primary py-2 position-absolute top-0 end-0 mt-2 me-2">SignUp</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="copyright">
                        <div class="row">
                            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                                &copy; <a href="#">Your Site Name</a>, All Right Reserved.
                            </div>
                            <div class="col-md-6 text-center text-md-end">
                                <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                                Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                                <br>Distributed By: <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
            <script src="../static/js/main.js"></script>--%>
</body>

</html>