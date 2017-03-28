<%@page import="com.hifive.history.util.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
List<Map<String, Object>> datas = new ArrayList<Map<String, Object>>();
datas = (ArrayList<Map<String, Object>>) request.getAttribute("getList");

int intTotalCount = 0;
int page_num = 1;


if((String) request.getAttribute("PAGE_NUM") != null) {
	page_num = Integer.parseInt((String) request.getAttribute("PAGE_NUM"));
} 
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 쪽지함 </title>
    <!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>


<script type="text/javascript">
// 페이징
function do_search_page(url, page_num) 
{
	  console.log(url+"\t"+page_num);
	 
	  var frm = document.searchForm;
	  frm.PAGE_NUM.value = page_num;
	  frm.action = url;
	  frm.submit();
}
</script>	
</head>
<body>

<!--헤더 START-->
<jsp:include page="../main/header.jsp"/>
<!--헤더 END-->
<div class="container" >
<br><br><br><br> <!-- 헤더때문에 윗에 공백 넣어주는거임 -->

<!-- 좌측메뉴 -->
<div class="col-xs-2">
	<jsp:include page="menu.jsp"/>
</div>

<!--내용 START -->
<div class="col-xs-10">
<center><h2> :: 받은쪽지함 ::</h2></center><br>
	<div class="col-xs-1"></div>
	<form name="searchForm" action="do_search.do" method="POST">
		<input type="hidden" name="PAGE_NUM" value="">
	<div class="col-xs-10">
		<!-- 버튼 -->	
		<div class="form-group">			
		<button class="btn btn-warning">삭제</button>
	    <button class="btn btn-warning">답장</button>
    
    	</div>
		<table class="table">
			<tr class="warning" >
				<th width="10%" style="text-align: center;">삭제</th>
				<th width="20%" style="text-align: center;">보낸사람</th>
				<th width="40%" style="text-align: center;">내용</th>
				<th width="20%" style="text-align: center;">날짜</th>
				<th width="10%" style="text-align: center;">읽음</th>
			</tr>
			
			<%
			if(datas != null && datas.size() > 0) {	
				Map<String, Object> cnt = datas.get(0);
				intTotalCount = (Integer) cnt.get("TOTAL");
				
				for(int i = 0; i < datas.size(); i++) {
					Map<String, Object> item = datas.get(i);
			%>
				<tr>
				<td align="center"><input type="checkbox"></td>
				<td><%=item.get("SEND_ID") %>(<%=item.get("NAME") %>)</td>
				<td><a href='read.hi?note=<%=item.get("SEQ") %>'><%=item.get("CONTENTS") %></a></td>
				<td><%=item.get("WDATE") %></td>
				
				<% 
				if(item.get("STATE").equals("0")) {
				%>
				<td>읽지 않음</td>
				<%	
				} else {
				%>
				<td><%=item.get("RDATE") %></td>
				<%	
				}
				%>
			</tr>
			<%
				}
			} else {
			%>
				<tr>
				<td align="center" colspan="5">쪽지가 없습니다.</td>
				</tr>
			<%	
			}
			%>
	
		</table>
		<center>
			<!-- Paging Area Start -->
			<%
//			System.out.println("intTotalCount " + intTotalCount);
			%>
			<%=PagingUtil.renderPaging(
					intTotalCount, page_num, 10, 10, "send_message_list.hi", "do_search_page")%>
			<!-- Paging Area end //--> 	<!--밑에 페이지 갯수 몇개씩 보여줄건지   -->	
		</center>
	
	</div>
	</form>
	<div class="col-xs-1"></div>
</div>


<br><br><br><br><br>
</div>
<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->
</body>
</html>