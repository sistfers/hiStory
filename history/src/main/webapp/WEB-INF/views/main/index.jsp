<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
/**
 * 모든 HTML 태그를 제거하고 반환한다.
 * 
 * @param html
 * @throws Exception  
 */
	public String removeTag(String html) throws Exception {
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

%>

<%
	List<Map<String, Object>> searchRank = (List<Map<String, Object>>)request.getAttribute("searchRank");
	List<Map<String, Object>> themeList = (List<Map<String, Object>>)request.getAttribute("themeList");	
	List<Map<String, Object>> themeCode = new ArrayList<Map<String, Object>>(); 	//Page코드 : 100
	
	themeCode = (List<Map<String, Object>>)request.getAttribute("themeCode");
	
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> ★ hiStory ★ </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<!-- Custom CSS  (이미지 동그란 모양으로 보이기)-->
    <link href="/resources/css/round-about.css" rel="stylesheet">
	  <script src="http://phuonghuynh.github.io/js/bower_components/jquery/dist/jquery.min.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/d3/d3.min.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/d3-transform/src/d3-transform.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/extarray.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/misc.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/cafej/src/micro-observer.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/microplugin/src/microplugin.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/bubble-chart.js"></script>
	  <script src="/resources/js/central-click.js"></script>
	  <script src="http://phuonghuynh.github.io/js/bower_components/bubble-chart/src/plugins/lines/lines.js"></script>
	
 <!-- 해시태그 스타일 --> 
  <style type="text/css">
    .bubbleChart {
      min-width: 100px;
      max-width: 500px;
      height: 500px;
      margin: 0 auto;
    }
    .bubbleChart svg{
      background: #ffffff;
    }
  </style>
  
  <!-- 블로그 주제별 보기 스타일 -->
  <style type="text/css">
/* generic css */

.view {
  float: left; 
  overflow: hidden;
  position: relative;
  text-align: center;
  cursor: default;
}

.view .mask,
.view .content {
  width: 100%;
  height: 100%; 
  position: absolute;
  overflow: hidden;
  top: 0; 
  left: 0;
}

.view img {
  display: block; 
  position: relative
}

.view h2 {
  text-transform: uppercase;
  color: #fff;
  text-align: center;
  position: relative;
  font-size: 17px;
  padding: 10px;
  /* font-family: 'Hanna', sans-serif; */
  /*background: rgba(0, 0, 0, 0.8);*/
  margin: 20px 0 0 0
}

.view p {
  font-style: italic;
  font-size: 14px;
  position: relative;
  color: #fff;
  padding: 0px 20px 0px;
  text-align: center
}

.view a.info {
  display: inline-block;
  text-decoration: none;
  padding: 7px 14px;
  background: #000;
  color: #fff;
  /* font-family: 'Hanna', sans-serif; */
  text-transform: uppercase;
  box-shadow: 0 0 1px #000
}

.view a.info:hover {
  box-shadow: 0 0 5px #000
}
  

.view-first img {
  /*1*/
  transition: all 0.2s linear;
  width: 100%; 
  height: 70%;
}

.view-first .mask {
  opacity: 0;
  /* background-color: rgba(58, 1, 132, 0.44); */
  background-color: rgba(243, 97, 166, 0.44);
  transition: all 0.4s ease-in-out;
}

.view-first h2 {
  transform: translateY(-100px);
  opacity: 0;
/* font-family: 'Hanna', sans-serif; */
  transition: all 0.2s ease-in-out;
}

.view-first p {
  transform: translateY(100px);
  opacity: 0;
  transition: all 0.2s linear;
}

.view-first a.info {
  opacity: 0;
  transition: all 0.2s ease-in-out;
}


/* */

.view-first:hover img {
  transform: scale(1.4);
}

.view-first:hover .mask {
  opacity: 1;
}

.view-first:hover h2,
.view-first:hover p,
.view-first:hover a.info {
  opacity: 1;
  transform: translateY(0px);
}

.view-first:hover p {
  transition-delay: 0.1s;
}

.view-first:hover a.info {
  transition-delay: 0.2s;
}

</style>

</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->
<div class="container" >
<br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->


<!-- 검색하기 -->
<form name="do_search" method="post" action="/main/do_search.hi">
<div class="col-xs-2"></div>
<div class="col-xs-8">
	<div class="form-group">
	  <div class="input-group"> 	
	    <span class="input-group-addon input-lg"><i class="glyphicon glyphicon-search"></i></span>
	     <input type="text" class="form-control input-lg" placeholder="검색어를 입력하세요" max="20" name="search_word" size=20>
	    <span class="input-group-btn">
	     <input type="button" class="btn btn-primary btn-lg" value="조 회" onclick="javascript:submit()">
	    </span>
	    
	  </div>
	</div>  
</div> 
<div class="col-xs-2"></div>
</form>
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
            <%
            for(int i=0; i<searchRank.size(); ++i){
            %>
                {text: '<%=searchRank.get(i).get("SEARCH_WORD") %>', count: '<%=searchRank.get(i).get("CNT") %>'},
            <%
            }
            %>
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
//                "font-family": "Source Sans Pro, sans-serif",
               //"font-weight": "700",
               "text-anchor": "middle",
               "fill": "white"
             },
             attr: {dy: "65px"},
             centralClick: function() {
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
//                    "font-family": "Source Sans Pro, sans-serif",
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
//                    "font-family": "Source Sans Pro, sans-serif",
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
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 Start -->
<form name="do_searchTag" method="post" action="">
<input type="hidden" id="search_word" name="search_word" value="">
</form>
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 End -->
<div class="bubbleChart"></div>
<!-- 해시태그 END -->


<br><br><br><br>
<!-- 테마별보기 START -->
<div class="row" style="background-color: #F6F6F6; border-radius: 15px">
<div class="col-xs-12">
<center>

<div class="container">
  <h3> <span class="glyphicon-circle-arrow-down"></span> 테마별보기</h3>
  
  <%if(themeCode != null) {%>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#menu1"><%=themeCode.get(0).get("CD_D_NM") %></a></li>
    <%for(int i=1; i<themeCode.size(); ++i){ %>
    <li><a data-toggle="tab" href="#menu<%=i+1%>"><%=themeCode.get(i).get("CD_D_NM") %></a></li>
    <%} %>
  </ul>
	
  <div class="tab-content">
    <br>
    
	
    <%for(int i=0; i<themeCode.size(); ++i){
    	if(i==0) {%>
    		<div id="menu<%=i+1 %>" class="tab-pane fade in active">
    	<%}else{ %>
    		<div id="menu<%=i+1 %>" class="tab-pane fade" style="cursor:pointer;">
    	<%}
    		
    		for(int j=0; j<themeList.size(); ++j){
    			if(themeList.get(j).get("FIELD").equals(themeCode.get(i).get("CD_D_NM"))){%>
    				<%if(j<=3){ %>
	    				<div class="view view-first col-xs-4" style="padding-bottom: 15px">
	    				<img src="<%=themeList.get(j).get("SAVE_NAME") %>" onerror='this.src="/resources/image/main.jpg"'/>
	    				<div class="mask" style="padding-bottom: 15px">
	      				<h2><%=themeList.get(j).get("TITLE") %></h2>
	      				<p>
	      					<%
	      					String tempContent = removeTag(themeList.get(j).get("CONTENT")+"");
	      					String content = tempContent;
	      					if(tempContent.length() >50){
		      					content = tempContent.substring(0,50) + "...";
	      					} %>
	      					<%=content %> 
	      				</p>
	      				<p><%=themeList.get(j).get("NAME") %></p>
	      				<a href="/post/main.hi?id=<%=themeList.get(j).get("ID") %>&seq=<%=themeList.get(j).get("SEQ") %>" class="info">글보러가기</a>
	    				</div>
	    				</div> 
    				
  						
    				<%}else{%>
    					<div class="view view-first col-xs-4" style="padding-top: 15px">
	    				<img src="<%=themeList.get(j).get("SAVE_NAME") %>" onerror='this.src="/resources/image/main.jpg"'/>
	    				<div class="mask" style="padding-top: 15px">
	      				<h2><%=themeList.get(j).get("TITLE") %></h2>
	      				<p>
	      					<%
	      					String tempContent = removeTag(themeList.get(j).get("CONTENT")+"");
	      					String content = tempContent;
	      					if(tempContent.length() >50){
		      					content = tempContent.substring(0,50) + "...";
	      					} %>
	      					<%=content %> 
	      				</p>
	      				<p><%=themeList.get(j).get("ID") %></p>
	      				<a href="#" class="info">글보러가기</a>
	    				</div>
	    				</div> 
    				<%	
    				  }
    				%>
	  				
    	<%			
    			}
    		}
    	%>
    	
    	</div>
    <%}//THEME별로 사진넣을 프레임 구분 %>
    
      
      	
	<!-- <div id="menu10" class="tab-pane fade">
      
      	<div class="view view-first col-xs-4">
    	<img src="/resources/image/main.jpg" />
      	<div class="mask">
      		<h2>블로그타이틀</h2>
      		<p>아.. 정말... 100%맘에들순 없는것인가..뭔가 부족하다.... </p>
      		<p>mihyun</p>
      		<a href="#" class="info">글보러가기</a>
    	</div>
	  	</div>

		<div class="view view-first col-xs-4" style="cursor:pointer;">
   		<img src="/resources/image/main.jpg"  />
    	<div class="mask">
      		<h2>Empire State</h2>
      		<p>어떤게 더 이쁜지 모르겠구나...<br>
      		이쪽껀 버튼 없는 스타일...<br>
      		<br>
      		작성자 <br>
       		</p>
    	</div>
		</div>

		<div class="view view-first col-xs-4">
	    <img src="/resources/image/main.jpg" />
	    <div class="mask">
	      <h2>Empire State</h2>
	      <p>A cool description of some sort between these tags. I am so cool and awesomely awesome.</p>
	      <a href="#" class="info">Read More</a>
	    </div>
	    <br><br>
		</div>
		<div class="view view-first col-xs-4">
    	<img src="/resources/image/main.jpg" />
      	<div class="mask">
      		<h2>블로그타이틀</h2>
      		<p>아.. 정말... 100%맘에들순 없는것인가..뭔가 부족하다.... </p>
      		<p>mihyun</p>
      		<a href="#" class="info">글보러가기</a>
    	</div>
	  	</div>


		<div class="view view-first col-xs-4" style="cursor:pointer;">
   		<img src="/resources/image/main.jpg"  />
    		<div class="mask">
      		<h2>Empire State</h2>
      		<p>어떤게 더 이쁜지 모르겠구나...<br>
      		이쪽껀 버튼 없는 스타일...<br>
      		<br>
      		작성자 <br>
       		</p>
    		</div>
		</div>

		<div class="view view-first col-xs-4">
	    <img src="/resources/image/main.jpg" />
	    <div class="mask">
	      <h2>Empire State</h2>
	      <p>A cool description of some sort between these tags. I am so cool and awesomely awesome.</p>
	      <a href="#" class="info">Read More</a>
	    </div>
		</div> -->
	</div>
	
	<%} //if(themeCode != null)끝%>	
	
	</div><!-- 탭컨텐츠 -->
</div><!-- 컨테이너 -->
	</center>
	<br>



  
	<div class="clearfix"></div><br>
  
</div>
</div>
<!-- 테마별보기 END -->


<!-- 이웃새글 START -->
<!-- 로그인전 =============================================================================== -->
<%
	if (session.getAttribute("user") == null) {
%>
<br><br>
<div class="row" style="background-color: #F6F6F6; border-radius: 15px">
<div class="col-xs-12">
<!-- 로그인후 =============================================================================== -->
<%
	} else {
%>
<br><br>
<div class="row" style="background-color: #F6F6F6; border-radius: 15px">
<div class="col-xs-12">
<h3 class="page-header">:: 이웃새글 :: </h3>

<table class="table table-striped">
	<tr><td rowspan="2" align="center"> <img src="/resources/image/main.jpg" width="100" ></td>
	<td> 작성자 | 작성일</td></tr>
	<tr><td>내용 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</td></tr>
	
	<tr><td rowspan="2" align="center"> <img src="/resources/image/main.jpg" width="100" ></td>
	<td> 작성자 | 작성일</td></tr>
	<tr><td>내용 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</td></tr>
	
	<tr><td rowspan="2" align="center"> <img src="/resources/image/main.jpg" width="100" ></td>
	<td> 작성자 | 작성일</td></tr>
	<tr><td>내용 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</td></tr>

</table>

<%
	}
%> 



</div>
</div>

<!-- 이웃새글 END -->


<!-- BEST 블로거 START -->
<br><br>
<div class="row" style="background-color: #F6F6F6; border-radius: 15px">
            <div class="col-xs-12">
                <h3 class="page-header">:: BEST 블로거 :: </h3>
            </div>
            <div class="col-xs-4 text-center">
                <center><img class="img-circle img-responsive img-center" src="/resources/image/aa.jpg" width="150" ></center>
                <h4>Mihyun Kim
                    <small>블로그타이틀</small>
                </h4>
                <p>블로그 소개글 - 안녕하세요 </p>
            </div>
            
            <div class="col-xs-4 text-center">
                <center><img class="img-circle img-responsive img-center" src="/resources/image/bb.jpg" width="150"></center>
                <h4>조윤행
                    <small>하하하하하</small>
                </h4>
                <p>What does this team member to? Keep it short! This is also a great spot for social links!</p>
            </div>
            
            <div class="col-xs-4 text-center">
                <center><img class="img-circle img-responsive img-center" src="/resources/image/cc.jpg" width="150"></center>
                <h4>배한주
                    <small>한주바보</small>
                </h4>
                <p>영어폰트가 예뻐서... 한글은 예쁘지 않아.. ㅠㅠ</p>
            </div>
</div>

<!-- BEST 블로거 END -->

</div>
<!--내용 END -->

<!--푸터 START -->
<jsp:include page="footer.jsp"/>
<!--푸터 START -->
</body>
</html>












