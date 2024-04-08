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
<!-- Model Layer -->
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "select user_gender gender from customer";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	ArrayList<String> genderList = new ArrayList<String>();
	
	while(rs.next()){
		genderList.add(rs.getString("gender"));
	}
	//디버깅
	System.out.println(genderList);
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
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<h1>회원가입</h1>
	<form method="post" action="/shop/emp/customer/addCustomerAction.jsp"
				enctype="multipart/form-data">
		
		<!-- emp_id값은 action쪽에서 세션변수에서 바인딩 -->
		<div>
			email:
			<input type="text" name="userMail">
		</div>
		<div>
			Pw:
			<input type="text" name="userPw">
		</div>
		<div>
			name:
			<input type="text" name="userName">
		</div>
		<div>
			birth:
			<input type="text" name="userBirth">
		</div>
		
		<div>
			gender: 
			<select name="gender">
				<option value="">선택</option>
				<%
					for(String c: genderList){
				%>
					<option value="<%=c%>"><%=c%></option>
				<%
					}
				%>
			</select>
		</div>
	
		<div>
			<button type="submit">등록</button>
		</div>
	</form>	
</body>
</html>