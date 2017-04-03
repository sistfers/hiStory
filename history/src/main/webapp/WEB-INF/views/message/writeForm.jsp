<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@page import="com.hifive.history.model.UserDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Logger loger = LoggerFactory.getLogger(this.getClass());

	String SENDID = "";
	String TAKEID = request.getParameter("TAKEID");
	String NAME   = "";

	HttpSession sesson =request.getSession(false);
	UserDto dto = (UserDto) sesson.getAttribute("user");
	
	if(dto != null) {
		SENDID = dto.getId();
		NAME   = (String) request.getAttribute("NAME");
		
		loger.debug("TAKEID  -> " + TAKEID);
		loger.debug("NAME    -> " + NAME);
		
	} else {
		
	}	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>쪽지함</title>
	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet"	type="text/css" />
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript">
	/* 글자 수 체크 */
	$(document).ready(function() {
		$(function() {
		    $('#realNote').keyup(function (e){
		        var content = $(this).val();
		        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
		        $('#counter').html(content.length + '/300');
		    });
		    $('#realNote').keyup();
		});

	    $("#TAKE_ID_CK").on("click", function () {
	        modalSet(1);
	    });
	});

	function modalSet(pagenum) {
        <c:if test="${!empty sessionScope.user.id }">
            var id = "${sessionScope.user.id}";
        </c:if>
		var PAGE_NUM = pagenum;
        $("#followDiv").empty();
        $.ajax({
            type:"POST",
            url:"/user/followSearch.hi",
            dataType: "html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
            data: {
                "id": id,
	            "PAGE_NUM": PAGE_NUM
            },
            success: function (data) {
                // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
                var followList = $.parseJSON(data);
                if (followList.length == 0) {
                    $("#followDiv").append("<li><a href=\"#\">\"이웃이 없습니다.\"</a></li>");
                } else {
                    for (var i = 0; i < followList.length; i++) {
                        var followUrl = "javascript:in_follow(\'" + followList[i].ID + "\')";
                        var followName = followList[i].NAME + "(" + followList[i].ID + ")";
                        $("#followDiv").append("<p><a href=\"" + followUrl + "\">" + followName + "</a></p>");
                    }
                    // 페이징
                    var pagingString = paging(followList[0].TOT_CNT, pagenum, 10, 10, "modalSet");
                    $("#followDiv").append("<center><table><tr><td style='text-align: center;'>" + pagingString + "</td></tr></table></center>");
                }
            },
            complete: function (data) {
                // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
            },
            error: function (xhr, status, error) {
                alert("에러발생");
            }
        });
    }

    function paging(maxnum, currpageno, rowperpage, bottomcount, scriptname) {
        var maxNum = 0; // 총 갯수
        var currPageNo = 1; // 현재 페이지 번호 : page_num
        var rowPerPage = 10; // 한페이지에 보여질 행수 : page_size
        var bottomCount = 10; // 바닥에 보여질 페이지 수: 10

        maxNum = maxnum;
        currPageNo = currpageno;
        rowPerPage = rowperpage;
        bottomCount = bottomcount;

        var scriptName = scriptname; // 호출 자바스크립트

        var maxPageNo = ((maxNum - 1) / rowPerPage) + 1;
        var startPageNo = ((currPageNo - 1) / bottomCount) * bottomCount + 1;//
        var endPageNo = ((currPageNo - 1) / bottomCount + 1) * bottomCount;
        var nowBlockNo = ((currPageNo - 1) / bottomCount) + 1;
        var maxBlockNo = ((maxNum - 1) / bottomCount) + 1;

        var inx = 0;
        var html = "";
        if (currPageNo > maxPageNo) {
            return "";
        }
        html = html + "<table border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n";
        html = html + "<tr>\n";
        html = html + "<td class=\"list_num\">\n";
        html = html + "<ul class=\"pagination pagination-sm\">\n";

//        // <<
//        if (nowBlockNo > 1 && nowBlockNo <= maxBlockNo) {
//            html = html + "<li><a href=\"javascript:" + scriptName + "( 1 );\">\n";
//            html = html + "&laquo;\n";
//            html = html + "</a></li>\n";
//        }
//
//        // <
//        if (startPageNo > bottomCount) {
//            html = html + "<li><a href=\"javascript:" + scriptName + "( " + (startPageNo - 1)+ ");\"> \n";
//            html = html + "<        \n";
//            html = html + "</a></li>     \n";
//        }

        // 1 2 3 ... 10	(숫자보여주기)
        for (inx = 1; inx <= maxPageNo && inx <= endPageNo; inx++) {

            if (inx == currPageNo) {
                html = html + "<li class='active'><a href='#'>" + inx	+ "</a></li>";
            } else {
                html = html + "<li><a href=\"javascript:" + scriptName + "(" + inx+ ");\" class=\"num_text\">" + inx + "</a></li> \n";
            }
        }

//        // >
//        if (maxPageNo >= inx) {
//            html = html + "<li><a href=\"javascript:" + scriptName + "("+ ((nowBlockNo * bottomCount) + 1) + ");\"> \n";
//            html = html + ">                       \n";
//            html = html + "</a></li>              \n";
//        }
//
//        // >>
//        if (maxPageNo >= inx) {
//            html = html + "<li><a href=\"javascript:" + scriptName + "(" + maxPageNo+ ");\">      \n";
//            html = html + "&raquo;     \n";
//            html = html + "</a></li>    \n";
//        }

        html = html + "</ul>		\n";
        html = html + "</td>  	\n";
        html = html + "</tr>  	\n";
        html = html + "</table>   \n";

        return html;
    }

	function in_follow(followId) {
		$("#TAKE_ID").val(followId);
        $("#myModal").modal('toggle');
    }
</script>

<style type="text/css">
	#wrap span {
	    position: absolute;
	    bottom: 5px;
	    right: 20px;
	}

	#counter {
		/* background:rgba(255,0,0,0.5);
		border-radius: 0.5em;
		padding: 0 .5em 0 .5em;
		font-size: 0.75em; */
	}	
</style>


</head>
<body>

	<!--헤더 START-->
	<jsp:include page="/header.hi" />
	<!--헤더 END-->
	<div class="container">
		<br> <br> <br> <br>
		<!-- 헤더때문에 윗에 공백 넣어주는거임 -->

		<!-- 좌측메뉴 -->
		<div class="col-xs-2">
			<jsp:include page="menu.jsp" />
		</div>

		<!--내용 START -->
		<div class="col-xs-10">
			<center>
				<h2>:: 쪽지쓰기 ::</h2>
			</center>
			<br>
			<div class="col-xs-1"></div>
			<div class="col-xs-8">
				<form action="write.hi" method="post" class="form-horizontal">
					<input type="hidden" name="SEND_ID" value="<%=SENDID %>" />
					<div class="form-group">
						<label class="col-lg-2 control-label">받는사람</label>
						<div class="col-lg-7">
						<%
						if(TAKEID != null) {
						%>
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID"
									placeholder="<%=TAKEID %>(<%=NAME %>)" value="<%=TAKEID %>" maxlength="30">
						<%	
						} else {
						%>	
							<input type="text" class="form-control" id=TAKE_ID name="TAKE_ID"
									placeholder="hifive" maxlength="30">
						<% 
						}
						%>
						</div>
						<div class="col-lg-3">
							<button type="button" class="btn btn-info btn-block" data-toggle="modal" data-target="#myModal" id="TAKE_ID_CK"
							        name="TAKE_ID_CK">
								이웃목록보기
							</button>

							<!-- Modal -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog modal-sm">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
											<h4 class="modal-title" id="myModalLabel">이웃 목록</h4>
										</div>
										<div class="modal-body" id="followDiv">
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div id="wrap" class="form-group">
						<label class="col-lg-2 control-label">내용</label>
						<div class="col-lg-10">
							<textarea id="realNote" name="NOTE" 
							rows="10" maxlength="300" style="resize: none"
							class="form-control"></textarea>
							<span id="counter">###</span>
						</div>
					</div>

					<div class="form-group">
						<button class="btn btn-primary col-lg-3 col-md-offset-3"
							type="submit">보내기</button>
						<button class="btn btn-default col-lg-3 col-md-offset-1"
							type="reset">Cancel</button>
					</div>

				</form>

			</div>
			<div class="col-xs-3"></div>
		</div>
		<br> <br> <br> <br> <br>
	</div>
	<!--푸터 START -->
	<jsp:include page="../main/footer.jsp" />
	<!--푸터 START -->
</body>
</html>