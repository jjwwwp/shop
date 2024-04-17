<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	if(session.getAttribute("loginCustomer")!= null){
		response.sendRedirect("/shop/emp/goodsList.jsp");
		return;
	}
%>
<%
	String customerMail = request.getParameter("customerMail");
	String customerPw = request.getParameter("customerPw");
	
	System.out.println(customerMail + "<-- customerMail");
	System.out.println(customerPw + "<-- customerPw");
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql = "select mail customerMail, pw customerPw from customer where mail=? and pw=password(?)";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerMail);
	stmt.setString(2, customerPw);
	rs = stmt.executeQuery();
	
	if(rs.next()){
		System.out.println("로그인 성공");
		//세션안에 여러개의 값을 저장하기 위해서 HashMap타입을 사용
		HashMap<String,Object> loginCustomer = new HashMap<String,Object>();
		loginCustomer.put("customerMail",rs.getString("customerMail"));
		loginCustomer.put("customerPw",rs.getString("customerPw"));
		
		session.setAttribute("loginCustomer", loginCustomer);
		
		//디버깅
		HashMap<String,Object> m = (HashMap<String,Object>)(session.getAttribute("loginCustomer"));
		System.out.println((String)(m.get("customerMail")));
		System.out.println((String)(m.get("customerPw")));
		
		response.sendRedirect("/shop/emp/goodsList.jsp");
	}else{
		System.out.println("로그인 실패");
		response.sendRedirect("/shop/emp/customer/customerLoginForm.jsp");
	}  
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>

</body>
</html>