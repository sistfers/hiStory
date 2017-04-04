<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@page import="com.hifive.history.model.CategoryDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	String id = request.getParameter("id");
	// 해당블로그 유저id 받아오기
	
	String ct_seq = request.getParameter("ct_seq");	
	System.out.println("ct_seq==========================="+ct_seq);
	if(ct_seq == null) ct_seq = "All";
	
	List<CategoryDto> categoryList = (List<CategoryDto>)request.getAttribute("categoryList");

	// 로그인 유저
	UserDto loginuser = (UserDto)session.getAttribute("user");

	// 블로그 주인
	UserDto userDto = (UserDto)request.getAttribute("userDto");

	Map<String, Integer> visit = new HashMap<>();
	visit = (Map<String, Integer>)request.getAttribute("visit");

	boolean follow = (Boolean)request.getAttribute("follow");
//	boolean follow = false;
	List<HashMap<String, Object>> cateCount = (List<HashMap<String, Object>>)request.getAttribute("cateCount");
%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 이웃추가버튼 스타일 -->
	<style type="text/css">
	.btn-glyphicon {
		padding: 8px;
		background: #ffffff;
		margin-right: 4px;
	}

	.icon-btn {
		padding: 1px 15px 3px 2px;
		border-radius: 50px;
	}
	</style>

	<script type="text/javascript">
		function delete_follow(loginId, blogId) {
            var my_id = loginId;
            var you_id = blogId;
            var command = "delete";
            $.ajax({
                type: "POST",
                url: "/followInsert.hi",
                datatype: "html",
                data: {
                    my_id: my_id,
                    you_id: you_id,
                    command: command
                },
                success: function () {
                    alert("이웃 삭제 되었습니다.");
                    location.reload();
                },
                error: function () {
                }
            });
        }

		function insert_follow(loginId, blogId) {
		    var my_id = loginId;
		    var you_id = blogId;
		    var command = "insert";
			$.ajax({
				type: "POST",
				url: "/followInsert.hi",
				datatype: "html",
				data: {
				    my_id: my_id,
					you_id: you_id,
					command: command
				},
				success: function (data) {
                    alert("이웃 추가 되었습니다.");
                    location.reload();
				},
				error: function (data) {

				}
			});
        }
	</script>
</head>
<body>
<center>
<br>

<!-- 블로그 주인의 프로필사진을 넣습니다 -->
<img src="<%=userDto.getPf_image() %>" width="150" height="150"><br>

<!-- 블로그 주인의 닉네임을 넣습니다 -->
<h3><%=userDto.getName() %></h3>

<!-- 블로그 주인의 블로그소개를 넣습니다 -->
<h5><%=userDto.getPf_content() %></h5>

<%
	if(loginuser != null){
		if(id.equals(loginuser.getId())){ %>
			<a href="write.hi?id=<%=id %>" class="btn btn-default btn-md">
			    <span class="glyphicon glyphicon-pencil"></span> 포스트쓰기
			</a>
		<% } else if(follow){ %>
			<a class="btn icon-btn btn-warning btn-sm" href="javascript:delete_follow('<%=loginuser.getId()%>', '<%=id%>')">
				<span class="glyphicon btn-glyphicon glyphicon-minus img-circle text-warning"></span>
				이웃삭제
			</a>
		<% } else { %>
			<a class="btn icon-btn btn-warning btn-sm" href="javascript:insert_follow('<%=loginuser.getId()%>', '<%=id%>')">
				<span class="glyphicon btn-glyphicon glyphicon-plus img-circle text-warning"></span>
				이웃추가
			</a>
		<% } %>
<%}%>
<br>
<hr>

<!-- 카테고리 -->
<div class="list-group">
<a href="main.hi?id=<%=id%>" class="list-group-item btn-link" style="color: #F15F5F; background-color: #F6F6F6;" >
<h6>카테고리 전체글보기 &nbsp;<span class="glyphicon glyphicon-circle-arrow-right"></span></h6> 
</a>

  <%
  	for(int i = 0 ; i < categoryList.size(); ++i){
  %>
    <a class="list-group-item <%if(ct_seq.equals(categoryList.get(i).getSeq()+"")) out.println("active");%>" href="main.hi?ct_seq=<%=categoryList.get(i).getSeq() %>&id=<%=id%>" >
    <span class="badge"><%=cateCount.get(i).get("TOTAL") %></span>		<!-- 카테고리별 글 갯수  -->
    <%=categoryList.get(i).getName() %>
    </a>
  <%
  	}
  %>
</div>

<%-- 선택된 메뉴 색깔 바뀌게 하는것... 나중에 해야함.. 

 <a class="list-group-item" href="main.hi?ct_seq=<%=categoryList.get(i).getSeq() %>&id=<%=id%>" <%if(ct_seq.equals(categoryList.get(i).getSeq())) out.println("style='color:red'");%>> --%> 


<!-- 방문자수 -->
<div class="panel panel-info">
      <div class="panel-heading">방문자수</div>
      <div class="panel-body">
      	Today <%=visit.get("today") %><br>
      	Total <%=visit.get("total") %>
      </div>
</div>
		


</center>
</body>
</html>