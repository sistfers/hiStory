<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> ★ hiStory ★ </title>
    <!-- Bootstrap CSS -->
	<link href="../css/bootstrap.css" rel="stylesheet" type="text/css"/>
	
	<!-- Custom CSS  (이미지 동그란 모양으로 보이기)-->
    <link href="css/round-about.css" rel="stylesheet">
    
	  <script src="http://phuonghuynh.github.io/js/bower_components/jquery/dist/jquery.min.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/d3/d3.min.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/d3-transform/src/d3-transform.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/extarray.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/misc.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/micro-observer.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/microplugin/src/microplugin.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/bubble-chart.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/plugins/central-click/central-click.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/plugins/lines/lines.js"></script>

<!-- 해시태그 스타일 -->
  <style>
    .bubbleChart {
      min-width: 100px;
      max-width: 700px;
      height: 700px;
      margin: 0 auto;
    }
    .bubbleChart svg{
      background: #ffffff;
    }
  </style>
</head>
<body>
<!--헤더 START-->
<jsp:include page="../main/header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->


<!-- 검색하기 -->
<div class="form-group">
<div class="col-xs-2"></div>

	 <!-- 검색박스 -->
	 <div class="col-xs-6">
	 <input type="text" class="form-control" placeholder="검색어를 입력하세요" max="20" name="search_word" ></div>
		
	 <!-- 조회 버튼 -->
	 <div class="col-xs-1">
 	 <input type="button" class="btn btn-primary" value="조 회" onclick="javascript:do_search()">
	 </div>
</div>
<br>

<!-- 사이즈 조절해서 사용하세요  -->
<!-- 해시태그 START -->
<script type="text/javascript">
$(document).ready(function () {
     var bubbleChart = new d3.svg.BubbleChart({
       supportResponsive: true,
       //container: => use @default
       size: 600,
       //viewBoxSize: => use @default
       innerRadius: 600 / 3.5,
       //outerRadius: => use @default
       radiusMin: 50,
       //radiusMax: use @default
       //intersectDelta: use @default
       //intersectInc: use @default
       //circleColor: use @default
       data: {
         items: [
            //데이터 받아오기
           {text: "#신촌", count: "236"},
           {text: "#홍대", count: "382"},
           {text: "#합정", count: "170"},
           {text: "#탄핵", count: "123"},
           {text: "#파워블로거", count: "12"},
           {text: "#벚꽃", count: "170"},
           {text: "#쌍용", count: "382"},
           {text: "#한주", count: "10"},
           {text: "#윤행", count: "170"},
         ],
         eval: function (item) {return item.count;},
         classed: function (item) {return item.text.split(" ").join("");}
       },
       plugins: [
         {
           name: "central-click",
           options: {
             text: "(See more detail)",
             style: {
               "font-size": "12px",
               "font-style": "italic",
               "font-family": "Source Sans Pro, sans-serif",
               //"font-weight": "700",
               "text-anchor": "middle",
               "fill": "white"
             },
             attr: {dy: "65px"},
             centralClick: function() {
               alert("Here is more details!!");
             }
           }
         },
         {
           name: "lines",
           options: {
             format: [
               {// Line #0
                 textField: "count",
                 classed: {count: true},
                 style: {
                   "font-size": "28px",
                   "font-family": "Source Sans Pro, sans-serif",
                   "text-anchor": "middle",
                   fill: "white"
                 },
                 attr: {
                   dy: "0px",
                   x: function (d) {return d.cx;},
                   y: function (d) {return d.cy;}
                 }
               },
               {// Line #1
                 textField: "text",
                 classed: {text: true},
                 style: {
                   "font-size": "14px",
                   "font-family": "Source Sans Pro, sans-serif",
                   "text-anchor": "middle",
                   fill: "white"
                 },
                 attr: {
                   dy: "20px",
                   x: function (d) {return d.cx;},
                   y: function (d) {return d.cy;}
                 }
               }
             ],
             centralFormat: [
               {// Line #0
                 style: {"font-size": "50px"},
                 attr: {}
               },
               {// Line #1
                 style: {"font-size": "30px"},
                 attr: {dy: "40px"}
               }
             ]
           }
         }]
     });
   });
</script>
<div class="bubbleChart"></div>
<!-- 해시태그 END -->
<hr>
<!-- 테마별보기 START -->
<div class="row">
<div class="col-lg-12">
<center>
<h3> :: 테마별보기 :: </h3>
<a href="#">일상</a> | 기타 | 게임 | 영화 | 여행 | 스포츠 | 자동차 | 맛집 | 뷰티 | IT
</center>
<br><br>
<p>내용</p>
</div>
</div>
<!-- 테마별보기 END -->


<!-- 이웃새글 START -->
<br><br>
<div class="row">
<div class="col-lg-12">
<h3 class="page-header">:: 이웃새글 :: </h3>

<p>내용</p>
</div>
</div>

<!-- 이웃새글 END -->


<!-- BEST 블로거 START -->
<br><br>
<div class="row">
            <div class="col-lg-12">
                <h3 class="page-header">:: BEST 블로거 :: </h3>
            </div>
            <div class="col-lg-4 col-sm-6 text-center">
                <center><img class="img-circle img-responsive img-center" src="../image/aa.jpg" width="200" ></center>
                <h3>Mihyun Kim
                    <small>블로그타이틀</small>
                </h3>
                <p>블로그 소개글 - 안녕하세요 </p>
            </div>
            
            <div class="col-lg-4 col-sm-6 text-center">
                <center><img class="img-circle img-responsive img-center" src="../image/bb.jpg" width="200"></center>
                <h3>조윤행
                    <small>하하하하하</small>
                </h3>
                <p>What does this team member to? Keep it short! This is also a great spot for social links!</p>
            </div>
            
            <div class="col-lg-4 col-sm-6 text-center">
                <center><img class="img-circle img-responsive img-center" src="../image/cc.jpg" width="200"></center>
                <h3>배한주
                    <small>한주바보</small>
                </h3>
                <p>영어폰트가 예뻐서... 한글은 예쁘지 않아.. ㅠㅠ</p>
            </div>
        </div>

<!-- BEST 블로거 END -->

</div>
<!--내용 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>












