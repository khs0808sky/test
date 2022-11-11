<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
		<script>
			function reply() {
				location.href="reply_form.do?idx=${vo.idx}&page=${param.page}";
			}
			
			function del() {
				if (!confirm("삭제하시겠습니까?")){
					return;
				}
				
				var pwd = ${vo.pwd}; //원본 비밀번호
				var c_pwd = document.getElementById("c_pwd").value;
				
				if (pwd != c_pwd) {
					alert("비밀번호 불일치");
					return;
				}
				
				var url = "del.do";
				var param = "idx=${vo.idx}";
				
				sendRequest(url, param, delCheck, "post");
			}
			
			//삭제여부를 판단하는 콜백 메서드
			function delCheck() {
				if(xhr.readyState == 4 && xhr.status == 200) {
					var data = xhr.responseText;
					//"[{'param':'yes'}]"
					var json = eval(data);
					
					if (json[0].param == 'yes'){
						alert('삭제 성공');
						location.href="list.do?page=${param.page}";
					} else {
						alert('삭제 실패');
					}
				}
			}
			
			function modify() {
				location.href="modify_form.do?idx=${param.idx}&subject=${vo.subject}&name=${vo.name}&content=${vo.content}&page=${param.page}";
				
			}
			
			
		</script>
	</head>
	<body>
		<table border="1">
			<caption>:::게시글 상세보기:::</caption>
			<tr>
				<th>제목</th>
				<td>${vo.subject}</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${vo.name}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${vo.regidate}</td>
			</tr>
			<tr>
				<th>ip</th>
				<td>${vo.ip}</td>
			</tr>
			<tr>
				<th>내용</th>
				<td width="500px" height="200"><pre>${vo.content}</pre></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input id="c_pwd" type="password"></td>
			</tr>
			<tr>
				<td colspan="2">
					<!-- 목록으로 돌아가기 -->
					<img src="resources/img/btn_list.gif" style="cursor:pointer" onclick="location.href='list.do?page=${param.page}'">
					
					<c:if test="${vo.depth lt 1}">
					<!-- 답변 -->
					<img src="resources/img/btn_reply.gif" style="cursor:pointer" onclick="reply();">
					</c:if>
					<!-- 글 삭제 -->
					<img src="resources/img/btn_delete.gif" style="cursor:pointer" onclick="del();">
					<!-- 글 수정하기 -->
					<img src="resources/img/btn_modify.gif" style="cursor:pointer" onclick="modify();">
				</td>
			</tr>
		</table>
	</body>
</html>