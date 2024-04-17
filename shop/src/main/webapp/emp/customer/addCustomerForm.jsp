<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	//인증분기: 세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp")!=null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Model Layer -->
<%
	String customerId = request.getParameter("customerId");
	System.out.println(customerId + "<-- customerId");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/customerMenu.jsp"></jsp:include>
	</div>
	
	<h1>회원가입</h1>
	<form method="post" action="/shop/emp/customer/addCustomerAction.jsp"
				enctype="multipart/form-data">
		
		<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
		<div>
			Mail:
			<input type="email" name="userMail">
		</div>
		<div>
			PW:
			<input type="text" name="userPw">
		</div>
		<div>
			이름:
			<input type="text" name="userName">
		</div>
		<div>
			생일:
			<input type="text" name="userBirth">
		</div>
		
		<div>
			성별: 
			<input type="radio" name="userGender" value="남">남
			<input type="radio" name="userGender" value="여">여
		</div>
	
		<div>
			<button type="submit">가입</button>
		</div>
	</form>	
</body>
</html>