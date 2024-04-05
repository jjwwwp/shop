<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	//인증분기: 세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String category = request.getParameter("category");
	System.out.println(category);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>카테고리 삭제</h1>
	<form method="post" action="/shop/emp/category/deleteCategoryAction.jsp">
		<div>
			삭제할 카테고리:
			<input type="text" name="category" readonly="readonly">
		</div>
		<div>
			삭제할 카테고리가 맞습니까?(모든 데이터가 삭제됩니다)
			맞을경우 아이디와 비밀번호를 입력해 주세요.
		</div>
		<div>
			아이디:
			<input type="text" name="id">
			비밀번호:
			<input type="text" name="pw">
		</div>
			<button type="submit">추가</button>
	</form>
</body>
</html>