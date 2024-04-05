<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	String category = request.getParameter("category");
	System.out.println(category);	
%>
<%
	HashMap<String,Object>loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
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
			<input type="text" name="category" value="<%=category%>" readonly="readonly">
		</div>
		<div>
			삭제할 카테고리가 맞습니까?(모든 데이터가 삭제됩니다)
			맞을경우 아이디와 비밀번호를 입력해 주세요.
		</div>
		<div>
			아이디:
			<input type="text" name="empId" value="<%=(String)loginMember.get("empId")%>" readonly="readonly">
			비밀번호:
			<input type="text" name="empPw">
		</div>
			<button type="submit">삭제</button>
	</form>
</body>
</html>