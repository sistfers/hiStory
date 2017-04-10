<%@page import="com.hifive.history.model.BlogDto"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hifive.history.model.PostDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	List<HashMap<String, Object>> loveRank;
	if(request.getAttribute("loveRank")!=null){
		loveRank = (List<HashMap<String, Object>>)request.getAttribute("loveRank");
	}else{
		loveRank = new ArrayList<>();
	}
	
	List<HashMap<String, Object>> loveSelectRank;
	if(request.getAttribute("loveSelectRank")!=null){
		loveSelectRank = (List<HashMap<String, Object>>)request.getAttribute("loveSelectRank");
	}else{
		loveSelectRank = new ArrayList<>();
	}
	
	//블로그 테마색 불러오기
	if(session.getAttribute("user")!=null){
		UserDto user = (UserDto)session.getAttribute("user");
	}
	
	BlogDto blogdto = (BlogDto)request.getAttribute("blogdto");
	
	
%>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>블로그 관리/통계</title>
<!-- Bootstrap CSS -->
<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/> -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/3.2.1/css/font-awesome.min.css">
<style type="text/css">
.mydiv{
width:20%;
margin-right:0.5%;
border-radius: 15px;
}
.mydiv2{
width:78%;
margin-left:0.5%;
border-radius: 15px;
}
</style>

<script>
	function search() {
		if($("#startdate").val()<$("#enddate").val()){
			var frm = document.lovechart;
			frm.submit();
		}else{
			alert("기간을 확인하세요");
		}
	}
</script>

</head>
<body>
<!--헤더 START-->
<jsp:include page="/header.hi"/>
<!--헤더 END-->

<!-- 중간 START -->
   <br><br><br>
   <div class="container" >
      <div class="col-xs-2 mydiv" style="background-color: <%=blogdto.getTheme() %>; border-radius: 15px">
         <jsp:include page="menu.jsp"/>
      </div>
      <!--내용 START -->
        <div class="col-xs-10 mydiv2" style="background-color:<%=blogdto.getTheme() %>">
	        <div class="col-xs-1"></div>
	        <div class="col-xs-10" style="margin-top: 20px; margin-bottom : 20px; background-color: #FCFCFC;">
		       	 <div class="col-xs-12" style="background-color: white; padding-top: 20px;">
			       	<fieldset>
			       	<legend><i class="icon-bar-chart"></i> 전체</legend></fieldset>
		        
			       	<!-- <p style="font-size: 25px; margin-top: 20px">전체</p> -->
			        <table class="table" style="margin-top: 10px">
			        	<tr class="info">
							<th>순위</th>
							<th>분야</th>
							<th>글제목</th>
							<th>공감수</th>
							<th>작성일</th>
			        	</tr>
			        	<%
			        		if(loveRank!=null&&loveRank.size()!=0){
			        			for(int i = 0; i < loveRank.size(); ++i){	
			    		%>	
			    		       		<tr class="active">
			    		       		<td><%=i+1 %>위</td>
			    		       		<td><%=loveRank.get(i).get("FIELD") %></td>
			    		       		<td><%=loveRank.get(i).get("TITLE") %></td>
			    		       		<td><%=loveRank.get(i).get("TOTAL_CNT") %></td>
			    		       		<td><%=loveRank.get(i).get("WDATE") %></td>
			    		       		</tr>
			    		<%
			    				if(i==4)break;
			        			}		    		
			        		}else{
			        	%>
			        		<tr class="active">
			        			<td colspan="5" style="text-align: center;">공감받은 글이 없습니다.</td>
			        		</tr>
			        	<%
			        		}
			        	%>
			        	
			        	
			        </table>
			        </div>
			        <br>
			        <hr style="border:2px dashed">
			        <br>
			       	<div class="col-xs-12" style="background-color: white; padding-top: 20px;">
			        <form class="form-horizontal" method="post" action="love.hi" name="lovechart">
			<!--        	<p style="font-size: 25px; margin-top: 20px">기간별 조회</p> -->
			       	
			       	<fieldset>
			       	<legend><i class="icon-bar-chart"></i> 기간별 조회</legend></fieldset>
			       	<div class="form-group" id="">
						<div class="col-xs-4">
							<input type="date" class="form-control" id="startdate" name="startdate">
						</div>
						<div class="col-xs-1">
							<h4><i class="icon-ellipsis-horizontal"></i></h4>
						</div>
						<div class="col-xs-4">
							<input type="date" class="form-control" id="enddate" name="enddate">
						</div>
						<div class="col-xs-3">
							<button type="button" class="btn btn-primary" onclick="search()"> 조회 </button>
						</div>
					</div>
				
		        <table class="table" style="margin-top: 10px">
		        	<tr class="info">
						<th>순위</th>
						<th>글제목</th>
						<th>분야</th>
						<th>공감수</th>
						<th>작성일</th>
		        	</tr>
		        	<%
		        		if(loveSelectRank!=null&&loveSelectRank.size()!=0){
		        			for(int i = 0; i < loveSelectRank.size(); ++i){	
		        	%>	
			        		<tr class="active">
			        		<td><%=i+1 %>위</td>
			        		<td><%=loveRank.get(i).get("TITLE") %></td>
			        		<td><%=loveRank.get(i).get("FIELD") %></td>
			        		<td><%=loveRank.get(i).get("TOTAL_CNT") %></td>
			        		<td><%=loveRank.get(i).get("WDATE") %></td>
			        		</tr>
		        	<%
		        			if(i==4)break;
		        			}
		        		}else{
		        	%>
		        			<tr class="active">
			        		<td colspan="5" style="text-align: center;">선택하신 기간에 공감받은 글이 없습니다.</td>
			        		</tr>
			        <%
		        		}
		        	%>
		        	
		        	
		        </table>
		        </form>
				<br><br><br>
				
				
				</div>
				<div class="col-xs-1"></div>
  		</div>
</div>

<!--중간 END -->
</div>

<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>	
<!--푸터 START -->
</body>
</html>