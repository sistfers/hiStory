<%@page import="java.util.HashMap"%>
<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
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
	List<Map<String, Object>> searchList = (List<Map<String, Object>>)request.getAttribute("searchList");
	String PAGE_NUM = "1"; //페이지NUM	
	PAGE_NUM = request.getAttribute("PAGE_NUM").toString();
	int page_num = 1; //선택된 페이지
	int page_size = 10; //페이지 사이즈
	int intTotalCount = 0; //총 글수
	Map<String, Object> dataCnt = null;
	if (searchList != null && searchList.size() > 0) {
		dataCnt = searchList.get(0);
		intTotalCount = Integer.parseInt(dataCnt.get("TOT_CNT").toString());
	}
	
	int pageCount = intTotalCount / page_size; // 페이지수
	if (intTotalCount % page_size != 0)
		pageCount++;
	if (PAGE_NUM != null && PAGE_NUM != "")
		page_num = Integer.parseInt(PAGE_NUM);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> ★ hiStory ★ </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"></script>
	<style type="text/css">
	.table-filter {
	background-color: #fff;
	border-bottom: 1px solid #eee;
}
.table-filter tbody tr td {
	padding: 10px;
	vertical-align: middle;
	border-top-color: #eee;
}
.table-filter tbody tr.selected td {
	background-color: #eee;
}
.table-filter tr td:first-child {
	width: 38px;
}
.table-filter tr td:nth-child(2) {
	width: 35px;
}
.table-filter .media-photo {
	width: 35px;
}
.table-filter .media-body {
    display: block;
    /* Had to use this style to force the div to expand (wasn't necessary with my bootstrap version 3.3.6) */
}
.table-filter .media-meta {
	font-size: 11px;
	color: #999;
}
.table-filter .media .title {
	color: #2BBCDE;
	font-size: 14px;
	font-weight: bold;
	line-height: normal;
	margin: 0;
}
.table-filter .media .title span {
	font-size: .8em;
	margin-right: 20px;
}
.table-filter .media .title span.pagado {
	color: #5cb85c;
}
.table-filter .media .title span.pendiente {
	color: #f0ad4e;
}
.table-filter .media .title span.cancelado {
	color: #d9534f;
}
.table-filter .media .summary {
	font-size: 14px;
}
	</style>
</head>
<body>

<!--헤더 START-->
<jsp:include page="header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!--내용 START -->
	
<!-- 검색하기 -->
<form name="do_search" method="post" action="/main/do_search.hi">
<input type="hidden" name="PAGE_NUM" value="">
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

<!-- HISTORY START -->
<br><br>
<div class="row" >
<div class="col-lg-12" >
<h3 class="page-header" style="color: #F361A6"> :: HISTORY 검색결과 :: </h3>

<div class="col-lg-1"></div>
<div class="col-lg-10">
<table width="100%" class="table table-hover" >

<%for(int i=0; i<searchList.size(); ++i){ %>
<tr name="search_detail" style="cursor:pointer;">
	<td id="<%=searchList.get(i).get("ID")%>">
	<div class="media">
		<a href="#" class="pull-left">
		<img src='<%=searchList.get(i).get("SAVE_NAME") %>' width="150px" height="100px">
		</a>
	</div>
	</td>
	<td valign="top" id="<%=searchList.get(i).get("SEQ")%>">
		<div class="media-body">
		
		
		<h4 class="title">
		<%String tempTitle = searchList.get(i).get("TITLE")+"";
			String title = tempTitle;
			if(tempTitle.length() >30){
				title = tempTitle.substring(0,30) + "...";
			}
		%>
		<%= title%>
		</h4>
		<%String tempContent = removeTag(searchList.get(i).get("CONTENT")+"");
			String content = tempContent;
			if(tempContent.length() >100){
				content = tempContent.substring(0,100) + "...";
			}
		%>
		<p class="summary"><%= content%></p>
		</div>
		<br>
	</td>
	<td align="right" valign="top" >
	<div class="media-body">
	<%=searchList.get(i).get("WDATE") %>
	</div>
	</td>
</tr>

<%} %>
</table>	

<center> 
<!-- 총글수, 현제page_no,페이지 사이즈, 10 --> 
<table><tr><td style="text-align: center;">
<%=PagingUtil.renderPaging(intTotalCount, page_num, page_size, 5, "do_search.hi", "do_search_page")%>
</td></tr>
</table>
</center>


</div>
</div>

<!-- 디테일 클릭시 해당 ID, SEQ 들고 폼전송 구간 Start -->
<form name="do_detail" method="get" action="">
<input type="hidden" id="id" name="id" value="">
<input type="hidden" id="seq" name="seq" value="">
</form>
<!-- 검색순위 클릭시 해당 검색어 들고 폼전송 구간 End -->

<script type="text/javascript">
$(document).ready(function () {
	$("tr[name=search_detail]").click(function(){
		
		var frm = document.do_detail;
		frm.id.value = $(this).eq(0).find("td").eq(0).attr('id');	//id
		frm.seq.value = $(this).eq(0).find("td").eq(1).attr('id');	//seq
		console.log("frm.id.value=" + frm.id.value);
		console.log("frm.seq.value=" + frm.seq.value);
		frm.action = "/post/main.hi";
		frm.submit();
	});

 });
 
 
function do_search() {
	var frm = document.searchForm;
	frm.submit();
}

function do_search_page(url, page_num) {
	console.log(url + "\t" + page_num);

	var frm = document.do_search;
	frm.PAGE_NUM.value = page_num;
	console.log("frm.page_num.value=" + frm.PAGE_NUM.value);
	frm.action = url;
	frm.submit();

}

</script>
<!--페이징  -->

<!-- HISTORY END -->


<!-- 네이버 검색결과 START -->
<br><br>
<div class="row">
<div class="col-lg-12">
<h3 class="page-header" style="color: #2F9D27"> :: 네이버 검색결과 :: </h3>

<p>내용</p>
</div>
</div>

<!-- 네이버 검색결과 END -->
</div>
<div class="col-lg-1"></div>
</div>
<!--푸터 START -->
<jsp:include page="footer.jsp"/>
<!--푸터 START -->
</body>
</html>