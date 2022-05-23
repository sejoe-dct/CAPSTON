<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import ="java.sql.DriverManager" %>
<%@ page import ="java.sql.Connection" %>
<%@ page import ="java.sql.Statement" %>
<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.sql.SQLException" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Cloud - 지역문화살리기</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="../static/img/cloud.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;500&family=Roboto:wght@500;700;900&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="../static/lib/animate/animate.min.css" rel="stylesheet">
    <link href="../static/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="../static/lib/lightbox/css/lightbox.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="../static/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="../static/css/style.css" rel="stylesheet">
    <link href="../static/css/test.css" rel="stylesheet">

    <!-- 게시판 -->
    <!--
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    -->


</head>


<body>
<!-- Spinner Start -->
<div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
        <span class="sr-only">Loading...</span>
    </div>
</div>
<!-- Spinner End -->


<!-- Topbar Start -->
<div class="container-fluid bg-dark p-0">
    <div class="row gx-0 d-none d-lg-flex">
        <div class="col-lg-7 px-5 text-start">
            <div class="h-100 d-inline-flex align-items-center me-4">
                <small class="fa fa-map-marker-alt text-primary me-2"></small>
                <small>123 Street, New York, USA</small>
            </div>
            <div class="h-100 d-inline-flex align-items-center">
                <small class="far fa-clock text-primary me-2"></small>
                <small>Mon - Fri : 09.00 AM - 09.00 PM</small>
            </div>
        </div>
        <div class="col-lg-5 px-5 text-end">
            <div class="h-100 d-inline-flex align-items-center me-4">
                <small class="fa fa-phone-alt text-primary me-2"></small>
                <small>+012 345 6789</small>
            </div>
            <div class="h-100 d-inline-flex align-items-center mx-n2">
                <a class="btn btn-square btn-link rounded-0 border-0 border-end border-secondary" href=""><i class="fab fa-facebook-f"></i></a>
                <a class="btn btn-square btn-link rounded-0 border-0 border-end border-secondary" href=""><i class="fab fa-twitter"></i></a>
                <a class="btn btn-square btn-link rounded-0 border-0 border-end border-secondary" href=""><i class="fab fa-linkedin-in"></i></a>
                <a class="btn btn-square btn-link rounded-0" href=""><i class="fab fa-instagram"></i></a>
            </div>
        </div>
    </div>
</div>
<!-- Topbar End -->



<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg bg-white navbar-light sticky-top p-0">
    <a href="index.html" class="navbar-brand d-flex align-items-center border-end px-4 px-lg-5">
        <h2 class="m-0 text-primary">CLOUD</h2>
    </a>
    <button type="button" class="navbar-toggler me-4" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCollapse">
        <div class="navbar-nav ms-auto p-4 p-lg-0">

            <a href="event_register.html" class="nav-item nav-link">등록</a>
            <a href="map.html" class="nav-item nav-link">지도</a>
            <a href="test.jsp" class="nav-item nav-link">행사/축제</a>
            <a href="food.html" class="nav-item nav-link">맛집</a>
            <a href="covid.html" class="nav-item nav-link">코로나현황/날씨</a>

        </div>

    </div>
    <a href="login.html" class="btn btn-primary rounded-0 py-4 px-lg-5 d-none d-lg-block">Login<i class="fa fa-arrow-right ms-3"></i></a>
    </div>
</nav>
<!-- Navbar End -->


<!-- Page Header Start
<div class="container-fluid page-header py-5 mb-5">
    <div class="container py-5">
        <h1 class="display-3 text-white mb-3 animated slideInDown">Projects</h1>
        <nav aria-label="breadcrumb animated slideInDown">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a class="text-white" href="#">Home</a></li>
                <li class="breadcrumb-item"><a class="text-white" href="#">Pages</a></li>
                <li class="breadcrumb-item text-white active" aria-current="page">Projects</li>
            </ol>
        </nav>
    </div>
</div>
Page Header End -->


<!-- 게시판 Start -->
<div class="container-xxl py-5">
    <div class="container">
        <!-- 제목 / 소제목 -->
        <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
            <h6 class="text-primary">축제 및 행사 게시판</h6>
            <h1 class="mb-4">전국 지역방방곡곡의 축제들을 알려드립니다!</h1>
        </div>
        <!-- 카테고리 -->
        <div class="row mt-n2 wow fadeInUp" data-wow-delay="0.3s">
            <div class="col-12 text-center">
                <ul class="list-inline mb-5" id="portfolio-flters">
                    <li class="mx-2 active" data-filter="*">전국</li>
                    <li class="mx-2" data-filter=".seoul">서울</li>
                    <li class="mx-2" data-filter=".first">부산</li>
                    <li class="mx-2" data-filter=".second">대전</li>
                    <li class="mx-2" data-filter=".third">인천</li>
                    <li class="mx-2" data-filter=".first">광주</li>
                    <li class="mx-2" data-filter=".first">울산</li>
                    <li class="mx-2" data-filter=".second">세종</li>
                    <li class="mx-2" data-filter=".third">경기</li>
                    <li class="mx-2" data-filter=".first">강원</li>
                    <li class="mx-2" data-filter=".first">충북</li>
                    <li class="mx-2" data-filter=".second">충남</li>
                    <li class="mx-2" data-filter=".third">전북</li>
                    <li class="mx-2" data-filter=".first">전남</li>
                    <li class="mx-2" data-filter=".first">경북</li>
                    <li class="mx-2" data-filter=".second">경남</li>
                    <li class="mx-2" data-filter=".second">제주</li>
                </ul>
            </div>
        </div>
        <div class="cp33list1">


            <ul class="lst1">


                <!--1번째 -->
                <div class="country-item portfolio-item seoul"> <!-- 카테고리 구분 -->
                    <li class="li1"><div class="w1">
                        <!-- 이미지 -->
                        <div class="w1c1">
                            <a href="?amode=view&amp;idx=191&amp;category=F0100" class="figs">
              <span class="f1">
                <span class="f1p1">
                <img src="../static/img/test/맥주1.JPG.400x400.jpg" alt="독일마을 맥주축제1">
                </span>
              </span>
                            </a>
                        </div>
                        <!-- 설명 -->
                        <div class="w1c2">
                            <div class="texts">
                                <a href="?amode=view&amp;idx=191&amp;category=F0100" class="tg1">
                                    <em class="ic1 bsContain " style="background-size: contain;">1</em>
                                    <strong class="t1">독일마을 맥주축제</strong>

                                    <div class="t2">코로나 19 장기화로 멈춘 독일마을 맥주축제가 온라인...</div>
                                </a>
                                <div class="cp33dlist1">
                                    <ul class="dl1">
                                        <li class="di place">
                                            <b class="dt">
                                                <i class="ic1"></i>
                                                <span class="t1">위치</span>
                                                <span class="sep">:</span></b>
                                            <span class="dd">
                      <span class="t2">  삼동면 독일로 89-7</span>
                    </span>
                                        </li>
                                        <li class="di calendar">
                                            <b class="dt"><i class="ic1"></i> <span class="t1">기간</span> <span class="sep">:</span></b>
                                            <span class="dd"><span class="t2">2022-05-11 ~ 2022-06-15</span></span>
                                        </li>
                                        <li class="di agency">
                                            <b class="dt">
                                                <i class="ic1"></i>
                                                <span class="t1">문의</span>
                                                <span class="sep">:</span>
                                            </b>
                                            <span class="dd">
                      <span class="t2">남해관광문화재단</span>
                    </span>
                                        </li>
                                        <li class="di phone">
                                            <b class="dt">
                                                <i class="ic1"></i>
                                                <span class="t1">전화번호</span>
                                                <span class="sep">:</span>
                                            </b>
                                            <span class="dd">
                      <span class="t2">남해관광문화재단 055-864-4515</span>
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
                                    <i class="st-on" style="width:100.0%;"><i class="ic1 bsCover" style="background-size: cover;"></i><i class="ic2 bsCover" style="background-size: cover;"></i></i><!-- ☆★(3.5/5) -->
                                    <i class="st-off"><i class="ic2"></i></i>
                                </i>
                                <span class="t2">
                <span class="blind">점수</span>
                <span class="t2t1">5</span>
                <span class="sep">/</span>
                <span class="t2t2">5.0</span>
              </span>
                                <span class="t3">(총 <em class="em">1개</em> 후기)</span>
                            </div>
                            <!-- 버튼 두개 -->
                            <div class="cp33btns1">
                                <!--<a href="?amode=rn%5Ename%5Eins&amp;rn_url=category%3DF0100%26amp%3Bamode%3Dview%26amp%3Bidx%3D191" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>-->
                                <a href="http://map.daum.net/link/to/%EB%8F%85%EC%9D%BC%EB%A7%88%EC%9D%84+%EB%A7%A5%EC%A3%BC%EC%B6%95%EC%A0%9C,34.798675,128.04251009999996" target="_blank" rel="noopener" title="새 창" class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span class="t1">길찾기</span></a>
                            </div>
                        </div>
                    </div>
                    </li>
                </div>

                <!--        &lt;!&ndash; 2번째 &ndash;&gt;-->
                <!--        <li class="li1"><div class="w1">-->
                <!--          <div class="w1c1">-->
                <!--            <a href="?amode=view&amp;idx=190&amp;category=F0100" class="figs">-->
                <!--              <span class="f1">-->
                <!--                <span class="f1p1">-->
                <!--                  <img src="../static/img/test/마늘한우.jpg" alt="마늘한우1">-->
                <!--                </span>-->
                <!--              </span>-->
                <!--            </a>-->
                <!--          </div>-->
                <!--          <div class="w1c2">-->
                <!--            <div class="texts">-->
                <!--              <a href="?amode=view&amp;idx=190&amp;category=F0100" class="tg1">-->
                <!--                <em class="ic1 bsContain " style="background-size: contain;">2</em>-->
                <!--                <strong class="t1">보물섬 마늘&amp;한우 축제</strong>-->
                <!--                <div class="t2">만남, 그 이상의 맛남!마늘 가득! 한우 듬뿍! 재미...</div>-->
                <!--              </a>-->
                <!--              <div class="cp33dlist1">-->
                <!--                <ul class="dl1">-->
                <!--                  <li class="di place">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">위치</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">남해 유배문학관 광장, 남해읍 남해대로 2745</span></span>-->
                <!--                  </li>-->
                <!--                  <li class="di calendar">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">기간</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">2022-05-11 ~ 2022-06-15</span></span>-->
                <!--                  </li>-->
                <!--                  <li class="di agency">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">문의</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">남해군관광문화재단</span></span>-->
                <!--                  </li>-->
                <!--                  <li class="di phone">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">전화번호</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">055-864-4514, 4515</span></span>-->
                <!--                  </li>-->
                <!--                </ul>-->
                <!--              </div>-->

                <!--            </div>-->
                <!--          </div>-->
                <!--          <div class="w1c3">-->
                <!--            <div class="ratings">-->
                <!--              <strong class="t1 blind">별점</strong>-->
                <!--              <i class="cp33rating1star5">-->
                <!--                <i class="st-on" style="width:0.0%;"><i class="ic1 bsCover" style="background-size: cover;"></i><i class="ic2 bsCover" style="background-size: cover;"></i></i>&lt;!&ndash; ☆★(3.5/5) &ndash;&gt;-->
                <!--                <i class="st-off"><i class="ic2"></i></i>-->
                <!--              </i>-->
                <!--              <span class="t2">-->
                <!--                <span class="blind">점수</span>-->
                <!--                <span class="t2t1">0</span>-->
                <!--                <span class="sep">/</span>-->
                <!--                <span class="t2t2">5.0</span>-->
                <!--              </span>-->
                <!--              <span class="t3">(총 <em class="em">0개</em> 후기)</span>-->
                <!--            </div>-->
                <!--            <div class="cp33btns1">-->
                <!--              &lt;!&ndash;<a href="?amode=rn%5Ename%5Eins&amp;rn_url=category%3DF0100%26amp%3Bamode%3Dview%26amp%3Bidx%3D190" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>&ndash;&gt;-->
                <!--              <a href="http://map.daum.net/link/to/%EB%B3%B4%EB%AC%BC%EC%84%AC+%EB%A7%88%EB%8A%98%26%ED%95%9C%EC%9A%B0+%EC%B6%95%EC%A0%9C,34.8319601067584,127.899185508281" target="_blank" rel="noopener" title="새 창" class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span class="t1">길찾기</span></a>-->
                <!--            </div>-->
                <!--          </div>-->
                <!--        </div></li>-->

                <!--        &lt;!&ndash;3번째&ndash;&gt;-->
                <!--        <li class="li1"><div class="w1">-->
                <!--          <div class="w1c1">-->
                <!--            <a href="?amode=view&amp;idx=194&amp;category=F0100" class="figs">-->
                <!--                                         <span class="f1"><span class="f1p1">-->
                <!--		                            	 <img src="/tour/CmsMultiFile/view.do?multifileId=TOUR00194&amp;idx=7976&amp;s=400x400" alt="미조항멸치축제1">-->
                <!--		                                 </span></span>-->
                <!--            </a>-->
                <!--          </div>-->
                <!--          <div class="w1c2">-->
                <!--            <div class="texts">-->
                <!--              <a href="?amode=view&amp;idx=194&amp;category=F0100" class="tg1">-->
                <!--                <em class="ic1 bsContain " style="background-size: contain;">3</em>-->
                <!--                <strong class="t1">보물섬 미조항 멸치축제</strong>-->

                <!--                <div class="t2">“에헤라~ 멸치 천재(天財)로구나” 매일 파도와 ...</div>-->

                <!--              </a>-->

                <!--              <div class="cp33dlist1">-->
                <!--                <ul class="dl1">-->

                <!--                  <li class="di place">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">위치</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">  미조면 미조리 북항 일원</span></span>-->
                <!--                  </li>-->

                <!--                  <li class="di calendar">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">기간</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">2022-05-11 ~ 2022-06-15</span></span>-->
                <!--                  </li>-->

                <!--                  <li class="di agency">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">문의</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">해양수산과 수산기획팀</span></span>-->
                <!--                  </li>-->


                <!--                  <li class="di phone">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">전화번호</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">055-860-3343</span></span>-->
                <!--                  </li>-->

                <!--                </ul>-->
                <!--              </div>-->

                <!--            </div>-->
                <!--          </div>-->
                <!--          <div class="w1c3">-->
                <!--            <div class="ratings">-->
                <!--              <strong class="t1 blind">별점</strong>-->
                <!--              <i class="cp33rating1star5">-->
                <!--                <i class="st-on" style="width:0.0%;"><i class="ic1 bsCover" style="background-size: cover;"></i><i class="ic2 bsCover" style="background-size: cover;"></i></i>&lt;!&ndash; ☆★(3.5/5) &ndash;&gt;-->
                <!--                <i class="st-off"><i class="ic2"></i></i>-->
                <!--              </i>-->
                <!--              <span class="t2">-->
                <!--                                  <span class="blind">점수</span>-->
                <!--                                  <span class="t2t1">0</span> <span class="sep">/</span> <span class="t2t2">5.0</span>-->
                <!--                           </span>-->
                <!--              <span class="t3">(총 <em class="em">0개</em> 후기)</span>-->
                <!--            </div>-->
                <!--            <div class="cp33btns1">-->
                <!--              &lt;!&ndash;<a href="?amode=rn%5Ename%5Eins&amp;rn_url=category%3DF0100%26amp%3Bamode%3Dview%26amp%3Bidx%3D194" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>&ndash;&gt;-->
                <!--              <a href="http://map.daum.net/link/to/%EB%B3%B4%EB%AC%BC%EC%84%AC+%EB%AF%B8%EC%A1%B0%ED%95%AD+%EB%A9%B8%EC%B9%98%EC%B6%95%EC%A0%9C,34.7131444890888,128.04532159798342" target="_blank" rel="noopener" title="새 창" class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span class="t1">길찾기</span></a>-->
                <!--            </div>-->
                <!--          </div>-->
                <!--        </div></li>-->

                <!--        &lt;!&ndash; 4번째 &ndash;&gt;-->
                <!--        <li class="li1"><div class="w1">-->
                <!--          <div class="w1c1">-->
                <!--            <a href="?amode=view&amp;idx=189&amp;category=F0100" class="figs">-->
                <!--                                         <span class="f1"><span class="f1p1">-->
                <!--		                            	 <img src="/tour/CmsMultiFile/view.do?multifileId=TOUR00189&amp;idx=8154&amp;s=400x400" alt="은모래비치1">-->

                <!--                                         </span></span>-->
                <!--            </a>-->
                <!--          </div>-->
                <!--          <div class="w1c2">-->
                <!--            <div class="texts">-->
                <!--              <a href="?amode=view&amp;idx=189&amp;category=F0100" class="tg1">-->
                <!--                <em class="ic1 bsContain " style="background-size: contain;">4</em>-->
                <!--                <strong class="t1">상주은모래비치 섬머페스티벌</strong>-->

                <!--                <div class="t2">다른 해수욕장들에서 느낄 수 없는 숲내음, 소나무 그...</div>-->

                <!--              </a>-->

                <!--              <div class="cp33dlist1">-->
                <!--                <ul class="dl1">-->

                <!--                  <li class="di place">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">위치</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">  상주면 상주로 10-3</span></span>-->
                <!--                  </li>-->

                <!--                  <li class="di calendar">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">기간</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">2022-05-11 ~ 2022-06-15</span></span>-->
                <!--                  </li>-->

                <!--                  <li class="di agency">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">문의</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">문화관광과 관광정책팀</span></span>-->
                <!--                  </li>-->


                <!--                  <li class="di phone">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">전화번호</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">055-860-8601</span></span>-->
                <!--                  </li>-->

                <!--                </ul>-->
                <!--              </div>-->

                <!--            </div>-->
                <!--          </div>-->
                <!--          <div class="w1c3">-->
                <!--            <div class="ratings">-->
                <!--              <strong class="t1 blind">별점</strong>-->
                <!--              <i class="cp33rating1star5">-->
                <!--                <i class="st-on" style="width:0.0%;"><i class="ic1 bsCover" style="background-size: cover;"></i><i class="ic2 bsCover" style="background-size: cover;"></i></i>&lt;!&ndash; ☆★(3.5/5) &ndash;&gt;-->
                <!--                <i class="st-off"><i class="ic2"></i></i>-->
                <!--              </i>-->
                <!--              <span class="t2">-->
                <!--                                  <span class="blind">점수</span>-->
                <!--                                  <span class="t2t1">0</span> <span class="sep">/</span> <span class="t2t2">5.0</span>-->
                <!--                           </span>-->
                <!--              <span class="t3">(총 <em class="em">0개</em> 후기)</span>-->
                <!--            </div>-->
                <!--            <div class="cp33btns1">-->
                <!--              &lt;!&ndash;<a href="?amode=rn%5Ename%5Eins&amp;rn_url=category%3DF0100%26amp%3Bamode%3Dview%26amp%3Bidx%3D189" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>&ndash;&gt;-->
                <!--              <a href="http://map.daum.net/link/to/%EC%83%81%EC%A3%BC%EC%9D%80%EB%AA%A8%EB%9E%98%EB%B9%84%EC%B9%98+%EC%84%AC%EB%A8%B8%ED%8E%98%EC%8A%A4%ED%8B%B0%EB%B2%8C,34.7207835,127.98808869999993" target="_blank" rel="noopener" title="새 창" class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span class="t1">길찾기</span></a>-->
                <!--            </div>-->
                <!--          </div>-->
                <!--        </div></li>-->

                <!--        &lt;!&ndash; 5번째 &ndash;&gt;-->
                <!--        <li class="li1"><div class="w1">-->
                <!--          <div class="w1c1">-->
                <!--            <a href="?amode=view&amp;idx=192&amp;category=F0100" class="figs">-->
                <!--                                         <span class="f1"><span class="f1p1">-->
                <!--		                            	 <img src="/tour/CmsMultiFile/view.do?multifileId=TOUR00192&amp;idx=8162&amp;s=400x400" alt="이순신순국제전1">-->

                <!--                                         </span></span>-->
                <!--            </a>-->
                <!--          </div>-->
                <!--          <div class="w1c2">-->
                <!--            <div class="texts">-->
                <!--              <a href="?amode=view&amp;idx=192&amp;category=F0100" class="tg1">-->
                <!--                <em class="ic1 bsContain " style="background-size: contain;">5</em>-->
                <!--                <strong class="t1">이순신순국제전</strong>-->

                <!--                <div class="t2">임금마저 백성을 버리고 도망친 전쟁, 왜군은 파죽지...</div>-->

                <!--              </a>-->

                <!--              <div class="cp33dlist1">-->
                <!--                <ul class="dl1">-->

                <!--                  <li class="di place">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">위치</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">  고현면 남해대로 3829  </span></span>-->
                <!--                  </li>-->

                <!--                  <li class="di calendar">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">기간</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">2022-05-11 ~ 2022-06-15</span></span>-->
                <!--                  </li>-->


                <!--                  <li class="di agency">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">문의</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">문화관광과 관광정책팀</span></span>-->
                <!--                  </li>-->


                <!--                  <li class="di phone">-->
                <!--                    <b class="dt"><i class="ic1"></i> <span class="t1">전화번호</span> <span class="sep">:</span></b>-->
                <!--                    <span class="dd"><span class="t2">055-860-8601</span></span>-->
                <!--                  </li>-->

                <!--                </ul>-->
                <!--              </div>-->

                <!--            </div>-->
                <!--          </div>-->
                <!--          <div class="w1c3">-->
                <!--            <div class="ratings">-->
                <!--              <strong class="t1 blind">별점</strong>-->
                <!--              <i class="cp33rating1star5">-->
                <!--                <i class="st-on" style="width:0.0%;"><i class="ic1 bsCover" style="background-size: cover;"></i><i class="ic2 bsCover" style="background-size: cover;"></i></i>&lt;!&ndash; ☆★(3.5/5) &ndash;&gt;-->
                <!--                <i class="st-off"><i class="ic2"></i></i>-->
                <!--              </i>-->
                <!--              <span class="t2">-->
                <!--                                  <span class="blind">점수</span>-->
                <!--                                  <span class="t2t1">0</span> <span class="sep">/</span> <span class="t2t2">5.0</span>-->
                <!--                           </span>-->
                <!--              <span class="t3">(총 <em class="em">0개</em> 후기)</span>-->
                <!--            </div>-->
                <!--            <div class="cp33btns1">-->
                <!--              &lt;!&ndash;<a href="?amode=rn%5Ename%5Eins&amp;rn_url=category%3DF0100%26amp%3Bamode%3Dview%26amp%3Bidx%3D192" onclick="doConfirmRealName(this.href);return false;" class="button" data-send-focus="that"><i class="ic1"></i> <span class="t1">스케줄 담기</span></a>&ndash;&gt;-->
                <!--              <a href="http://map.daum.net/link/to/%EC%9D%B4%EC%88%9C%EC%8B%A0%EC%88%9C%EA%B5%AD%EC%A0%9C%EC%A0%84,34.9125223331,127.8578081285" target="_blank" rel="noopener" title="새 창" class="btn btn-primary py-3 px-5 default getdirections"><i class="ic1"></i> <span class="t1">길찾기</span></a>-->
                <!--            </div>-->
                <!--          </div>-->
                <!--        </div></li>-->

            </ul>


        </div>

    </div>
</div>
<!-- 게시판 End -->


<!-- Quote Start
<div class="container-fluid bg-light overflow-hidden my-5 px-lg-0">
  <div class="container quote px-lg-0">
    <div class="row g-0 mx-lg-0">
      <div class="col-lg-6 ps-lg-0 wow fadeIn" data-wow-delay="0.1s" style="min-height: 400px;">
        <div class="position-relative h-100">
          <img class="position-absolute img-fluid w-100 h-100" src="../static/img/quote.jpg" style="object-fit: cover;" alt="">
        </div>
      </div>
      <div class="col-lg-6 quote-text py-5 wow fadeIn" data-wow-delay="0.5s">
        <div class="p-lg-5 pe-lg-0">
          <h6 class="text-primary">Free Quote</h6>
          <h1 class="mb-4">Get A Free Quote</h1>
          <p class="mb-4 pb-2">Tempor erat elitr rebum at clita. Diam dolor diam ipsum sit. Aliqu diam amet diam et eos. Clita erat ipsum et lorem et sit, sed stet lorem sit clita duo justo erat amet</p>
          <form>
            <div class="row g-3">
              <div class="col-12 col-sm-6">
                <input type="text" class="form-control border-0" placeholder="Your Name" style="height: 55px;">
              </div>
              <div class="col-12 col-sm-6">
                <input type="email" class="form-control border-0" placeholder="Your Email" style="height: 55px;">
              </div>
              <div class="col-12 col-sm-6">
                <input type="text" class="form-control border-0" placeholder="Your Mobile" style="height: 55px;">
              </div>
              <div class="col-12 col-sm-6">
                <select class="form-select border-0" style="height: 55px;">
                  <option selected>Select A Service</option>
                  <option value="1">Service 1</option>
                  <option value="2">Service 2</option>
                  <option value="3">Service 3</option>
                </select>
              </div>
              <div class="col-12">
                <textarea class="form-control border-0" placeholder="Special Note"></textarea>
              </div>
              <div class="col-12">
                <button class="btn btn-primary rounded-pill py-3 px-5" type="submit">Submit</button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
 Quote End -->


<!-- Testimonial Start
<div class="container-xxl py-5">
  <div class="container">
    <div class="text-center mx-auto mb-5 wow fadeInUp" data-wow-delay="0.1s" style="max-width: 600px;">
      <h6 class="text-primary">Testimonial</h6>
      <h1 class="mb-4">What Our Clients Say!</h1>
    </div>
    <div class="owl-carousel testimonial-carousel wow fadeInUp" data-wow-delay="0.1s">
      <div class="testimonial-item text-center">
        <div class="testimonial-img position-relative">
          <img class="img-fluid rounded-circle mx-auto mb-5" src="../static/img/testimonial-1.jpg">
          <div class="btn-square bg-primary rounded-circle">
            <i class="fa fa-quote-left text-white"></i>
          </div>
        </div>
        <div class="testimonial-text text-center rounded p-4">
          <p>Clita clita tempor justo dolor ipsum amet kasd amet duo justo duo duo labore sed sed. Magna ut diam sit et amet stet eos sed clita erat magna elitr erat sit sit erat at rebum justo sea clita.</p>
          <h5 class="mb-1">Client Name</h5>
          <span class="fst-italic">Profession</span>
        </div>
      </div>
      <div class="testimonial-item text-center">
        <div class="testimonial-img position-relative">
          <img class="img-fluid rounded-circle mx-auto mb-5" src="../static/img/testimonial-2.jpg">
          <div class="btn-square bg-primary rounded-circle">
            <i class="fa fa-quote-left text-white"></i>
          </div>
        </div>
        <div class="testimonial-text text-center rounded p-4">
          <p>Clita clita tempor justo dolor ipsum amet kasd amet duo justo duo duo labore sed sed. Magna ut diam sit et amet stet eos sed clita erat magna elitr erat sit sit erat at rebum justo sea clita.</p>
          <h5 class="mb-1">Client Name</h5>
          <span class="fst-italic">Profession</span>
        </div>
      </div>
      <div class="testimonial-item text-center">
        <div class="testimonial-img position-relative">
          <img class="img-fluid rounded-circle mx-auto mb-5" src="../static/img/testimonial-3.jpg">
          <div class="btn-square bg-primary rounded-circle">
            <i class="fa fa-quote-left text-white"></i>
          </div>
        </div>
        <div class="testimonial-text text-center rounded p-4">
          <p>Clita clita tempor justo dolor ipsum amet kasd amet duo justo duo duo labore sed sed. Magna ut diam sit et amet stet eos sed clita erat magna elitr erat sit sit erat at rebum justo sea clita.</p>
          <h5 class="mb-1">Client Name</h5>
          <span class="fst-italic">Profession</span>
        </div>
      </div>
    </div>
  </div>
</div>
 Testimonial End -->


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
<script src="../static/js/main.js"></script>
</body>

</body>
</html>
