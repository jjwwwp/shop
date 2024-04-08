<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*"%>
<%
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	System.out.println(empId+"<--empId");
	System.out.println(active+"<--active");
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "UPDATE emp set active=? where emp_id=?";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,active);
	stmt.setString(2,empId);
	rs = stmt.executeQuery();
	System.out.println(stmt);
	
	
	if(active.equals("ON")){
		active="OFF";
		stmt.setString(1,active);
		stmt.setString(2,empId);
		int row = stmt.executeUpdate();
	} else{
		active="ON";
		stmt.setString(1,active);
		stmt.setString(2,empId);
		int row = stmt.executeUpdate();
	}
	
	response.sendRedirect("/shop/emp/empList.jsp?currentPage");
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