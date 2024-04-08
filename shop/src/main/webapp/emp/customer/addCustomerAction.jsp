<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%
	String userMail = request.getParameter("email");
	String userPw = request.getParameter("userPw");
	String userName = request.getParameter("userName");
	String userBirth = request.getParameter("userBirth");
	String gender = request.getParameter("gender");
	
	System.out.println(userMail+"<--userMail");
	System.out.println(userName+"<--userName");
	System.out.println(userBirth+"<--userBirth");
	System.out.println(gender+"<--gender");
	
	String sql = "insert into customer(user_mail, user_name, user_birth, user_gender)VALUES(?,?,?,?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,userMail);
	stmt.setString(2,userName);
	stmt.setString(3,userBirth);
	stmt.setString(4,gender);
	
	int row = stmt.executeUpdate();
	
	if(row == 1){
	    response.sendRedirect("/shop/emp//customer/customerList.jsp");
	} else {
		String errMsg = URLEncoder.encode("작성에 실패했습니다. 확인 후 다시 입력하세요.", "utf-8");
		response.sendRedirect("/shop/emp/customer/addCustomerForm.jsp?errMsg=" + errMsg);
	    return;
	}

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

</body>
</html>