<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
	//인증분기: 세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Session 설정값: 입력시 로그인 emp의 emp_id값이 필요해서... -->
<%
	HashMap<String,Object>loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	System.out.println((String)(loginMember.get("empId")));
%>
<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsPrice = request.getParameter("goodsPrice");
	String goodsAmount = request.getParameter("goodsAmount");
	String goodsContent = request.getParameter("goodsContent");
	
	System.out.println(goodsTitle);
	System.out.println(goodsPrice);
	System.out.println(goodsAmount);
	System.out.println(goodsContent);
	
	String sql = "insert into goods(category, emp_id, goods_title, goods_price, goods_amount,goods_content)VALUES(?,?,?,?,?,?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,category);
	stmt.setString(2,(String)(loginMember.get("empId")));
	stmt.setString(3,goodsTitle);
	stmt.setString(4,goodsPrice);
	stmt.setString(5,goodsAmount);
	stmt.setString(6,goodsContent);
	rs = stmt.executeQuery();
%>
<!-- Controller Layer -->
<%
	response.sendRedirect("/shop/emp/goodsList.jsp");
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