<%@page import="com.sist.util.PagingUtil"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sist.model.CodeDDto"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
	List<CodeDDto> pageCode = new ArrayList<CodeDDto>();
	List<CodeDDto> searchCode = new ArrayList<CodeDDto>();
	List<HashMap<String,Object>> data
			= new ArrayList<HashMap<String,Object>>();

	String SEARCH_DIV  = "";
	String SEARCH_WORD = "";
	String PAGE_SIZE   = "10";
	String PAGE_NUM    = "1";

	int page_num      = 1; //선택된 페이지
	int page_size     = 10;//페이지 사이즈
	int intTotalCount = 0; //총 글수

	pageCode = (List<CodeDDto>)request.getAttribute("pageCode");
	searchCode = (List<CodeDDto>)request.getAttribute("searchCode");

	data = (List<HashMap<String,Object>>)request.getAttribute("lists");

	HashMap<String, Object> datCnt = null;

	if(data != null && data.size()>0){
		datCnt = data.get(0);
		intTotalCount = Integer.parseInt(datCnt.get("TOT_CNT").toString());
	}
	int pageCount = intTotalCount/page_size;
	if(intTotalCount%page_size !=0)pageCount++;

	SEARCH_DIV  = request.getAttribute("SEARCH_DIV").toString();
	SEARCH_WORD = request.getAttribute("SEARCH_WORD").toString();
	PAGE_SIZE   = request.getAttribute("PAGE_SIZE").toString();
	PAGE_NUM    = request.getAttribute("PAGE_NUM").toString();

	if(PAGE_SIZE !=null){
		page_size = Integer.parseInt(PAGE_SIZE);
	}
	if(PAGE_NUM !=null){
		page_num = Integer.parseInt(PAGE_NUM);
	}
%>
<head>
	<link href='<c:url value="/resources/css/common.css"/>' rel="stylesheet" type="text/css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js">
	</script>
	<title>::::::::CodeM::::::::::::</title>
	<script type="text/javascript">
        // listTable
        $(document).ready(function(){

            //upsert
            $("#do_save").on("click",function() {
                var cd_id    = $("#in_cd_id").val();
                var cd_nm  = $("#in_cd_nm").val();
                var reg_id   = $("#in_reg_id").val();
                var reg_dt   = $("#in_reg_dt").val();
                var mod_id =  $("#in_mod_id").val();
                var mod_dt =  $("#in_mod_dt").val();

                $.ajax({
                    type:"POST",
                    url:"do_upsert.do",
                    dataType:"html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
                    data:{
	                    "action": "upsertCode",
	                    "cd_id": cd_id,
                        "cd_nm": cd_nm,
                        "reg_id": reg_id,
                        "reg_dt": reg_dt,
                        "mod_id": mod_id,
                        "mod_dt": mod_dt
	                },
	                success : function(data) {
	                    // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
	                    var flag = $.parseJSON(data);
	                    if(flag.msg=="true"){ do_search(); }
	                    else {alert("등록 오류 입니다.");}

	                },
	                complete : function(data) {
	                    // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	                    // TODO
	                },
	                error : function(xhr, status, error) {
	                    alert("에러발생");
	                }
                });

            });



            //상세보기
            $("#listTable").on("click","tr",function() {
                var cd_id = $(this).find("#tr_cd_id").val();

                $.ajax({
                        type:"POST",
                        url:"do_detail.do",
                        dataType:"html", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
	                    data:{
	                    "action": "selectCode",
	                    "cd_id": cd_id
                        },
	                success : function(data) {
	                    // 통신이 성공적으로 이루어졌을 때 이 함수를 타게 된다.
	                    var codeM =   $.parseJSON(data);
	                    $("#in_cd_id").val(codeM.cd_id);
	                    $("#in_cd_nm").val(codeM.cd_nm);
	                    $("#in_reg_id").val(codeM.reg_id);
	                    $("#in_reg_dt").val(codeM.reg_dt);
	                    $("#in_mod_id").val(codeM.mod_id);
	                    $("#in_mod_dt").val(codeM.mod_dt);
	                },
	                complete : function(data) {
	                    // 통신이 실패했어도 완료가 되었을 때 이 함수를 타게 된다.
	                    // TODO
	                },
	                error : function(xhr, status, error) {
	                    alert("에러발생");
	                }
                });
            });


        } );


        function do_search()
        {
            var frm = document.searchForm;
            frm.submit();
        }

        function do_search_page(url, page_num)
        {
            console.log(url+"\t"+page_num);


            var frm = document.searchForm;
            frm.PAGE_NUM.value = page_num;
            console.log("frm.page_num.value="+frm.PAGE_NUM.value);
            frm.action = url;
            frm.submit();

        }
	</script>
</head>
<body>


<!-- Form Start -->
<form name="searchForm" action="do_search.do" method="get">
	<input type="hidden" name="PAGE_NUM" value="">
	<!-- Button Start -->
	<table cellpadding="5" cellspacing="0" border="0" width="640">
		<tr>
			<td>
				<div id="buttonArea" align="right" width="640">
					<input type="button"  value="조회"
					       onclick="javascript:do_search()"/>
				</div>
			</td>
		</tr>
	</table>
	<!-- Button Start //-->

	<!-- Search Area Start -->
	<table cellpadding="5" cellspacing="0" border="0" width="640">
		<tr>
			<td align="right">
				<select name="SEARCH_DIV" id="search_div" class="textfield">
					<option value="" >전체</option>
					<%
						for(int i=0;i<searchCode.size();i++)
						{
							CodeDDto codeD=(CodeDDto)searchCode.get(i);
					%>
					<option value="<%=codeD.getCd_d_id() %>"
							<%if(SEARCH_DIV.equals(codeD.getCd_d_id()) )out.print("selected"); %>>
						<%=codeD.getCd_d_nm() %>
					</option>
					<%
						}
					%>
				</select>
				<input type="text"  name="SEARCH_WORD"  size="20"
				       max="20" value="<%=SEARCH_WORD %>"  class="textfield" />

				<select name="PAGE_SIZE">
					<%
						for(int i=0;i<pageCode.size();i++)
						{
							CodeDDto codeD=(CodeDDto)pageCode.get(i);
							if(codeD.getCd_id()==100){
					%>
					<option value="<%=codeD.getCd_d_id() %>"
							<%if(PAGE_SIZE.equals(codeD.getCd_d_id()) )out.print("selected"); %>>
						<%=codeD.getCd_d_nm() %>
					</option>
					<%    }
					}
					%>
				</select>
			</td>
		</tr>
	</table>
	<!-- Table Area Start -->
	<table width="640"   class="table02"  id="listTable" >
		<tr>
			<td class="t02"  width="40">NO</td>
			<td class="t02"  width="40" >코드ID</td>
			<td class="t02"  width="400" >코드명</td>
			<td class="t02"  width="80">등록자</td>
			<td class="t02"  width="80">등록일</td>
		</tr>
		<!-- 반복영역 -->
		<%
			if(data.size()>0){
				Iterator   iter = data.iterator();
				while(iter.hasNext())
				{
					HashMap<String,Object>  dataOne
							= (HashMap<String,Object>)iter.next();
					//REG_DT=2017-02-22 00:00:00, RNUM=1, MOD_DT=2017-02-22 00:00:00, TOT_CNT=2, MOD_ID=Admin, CD_ID=110, CD_NM=검색조건, REG_ID=Admin
		%>
		<tr>
			<td class="t02_w" width="40"><%=dataOne.get("RNUM") %></td>
			<td class="t02_w_l"  ><%=dataOne.get("CD_ID") %>
				<input type="hidden" id="tr_cd_id" value="<%=dataOne.get("CD_ID")%>" />
			</td>
			<td class="t02_w_l" width="40"><%=dataOne.get("CD_NM")%></td>
			<td class="t02_w"  width="80"><%=dataOne.get("MOD_ID") %></td>
			<td class="t02_w"  width="80"><%=dataOne.get("MOD_DT") %></td>
		</tr>
		<%
			}//while
		}else{
		%>
		<!-- 반복영역 //-->
		<tr><td colspan="99" align="center">:::::: 조회 데어터가 업습니다.::::::</td></tr>
		<%
			}
		%>
	</table>
	<!-- Table Area Start //-->
	<!-- Paging Area Start -->
	<table cellpadding="5" cellspacing="0" border="0" width="640">
		<tr>
			<td  align="center" >
				<!-- 총글수, 현제page_no,페이지 사이즈, 10 -->
				<%=PagingUtil.renderPaging(intTotalCount, page_num, page_size, 10, "do_search.do", "do_search_page")%>
			</td>
		</tr>
	</table>
	<!-- Paging Area Start //-->
	<!-- WriteForm -->
	<form name="frmWrite" method="post" action="do_upsert.do">
		<input type="hidden" name="action" value=""> <input
			type="hidden" name="cd_id" id="cd_id" value="">
		<!-- Button Start -->
		<table cellpadding="5" cellspacing="0" border="0" width="640">
			<tr>
				<td>
					<div id="buttonArea1" align="right" width="640">
						<input type="button" value="등록" id="do_save" /> <input
							type="button" value="상세" id="do_detail" /> <input type="reset"
						                                                      value="초기화" />
					</div>
				</td>
			</tr>
		</table>
		<!-- Button Start //-->
		<table cellpadding="5" cellspacing="0" border="0" width="640"
		       class="table02">
			<tr>
				<td class="t02">코드ID</td>
				<td class="t02_w_l"><input type="text" name="in_cd_id"
				                           id="in_cd_id" size="20"></td>
			</tr>
			<tr>
				<td class="t02">코드명</td>
				<td class="t02_w_l"><input type="text" name="in_cd_nm"
				                           id="in_cd_nm" size="20"></td>
			</tr>
			<tr>
				<td class="t02">등록자</td>
				<td class="t02_w_l"><input type="text" name="in_reg_id"
				                           id="in_reg_id" size="20"></td>
			</tr>
			<tr>
				<td class="t02">등록일</td>
				<td class="t02_w_l"><input type="text" name="in_reg_dt"
				                           id="in_reg_dt" size="20"></td>
			</tr>
			<tr>
				<td class="t02">수정자</td>
				<td class="t02_w_l"><input type="text" name="in_mod_id"
				                           id="in_mod_id" size="20"></td>
			</tr>
			<tr>
				<td class="t02">수정일</td>
				<td class="t02_w_l"><input type="text" name="in_mod_dt"
				                           id="in_mod_dt" size="20"></td>
			</tr>
		</table>

	</form>
	<!-- WriteForm //-->

</form>
</body>
</html>