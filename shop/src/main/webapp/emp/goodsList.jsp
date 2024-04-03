<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<!-- Controller Layer -->
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
	
	int currentPage=1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currnetPage"));
	}
	int rowPerPage = 10;
	
	int startRow = (currentPage-1)*rowPerPage;
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	String sql2 = "select count(*) cnt from goods";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
	
	
	int totalRow = 0;
	if(rs2.next()){
		totalRow = rs2.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage +1;
	}
	
	/*
		null이면
		select * from goods
		null이 아니면
		select * from goods where category=?
	*/
	String sql3 = null;
	PreparedStatement stmt3 = null;
	if(category==null){
		sql3= "select category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount from goods";
		stmt3 = conn.prepareStatement(sql3);
	} else{
		 sql3 = "select category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount from goods where category=?";
		 stmt3 = conn.prepareStatement(sql3);
		 stmt3.setString(1,category);
		
		 
	}
	
	ResultSet rs3 = null;
	
	rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	while(rs3.next()){
		HashMap<String,Object> sm = new HashMap<String,Object>();
		sm.put("category",rs3.getString("category"));
		sm.put("goodsTitle",rs3.getString("goodsTitle"));
		sm.put("goodsPrice",rs3.getInt("goodsPrice"));
		sm.put("goodsAmount",rs3.getInt("goodsAmount"));
		
		list.add(sm);
	}
	System.out.println(list);
%>
<!-- Model Layer -->
<%
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select category, count(*) cnt from goods group by category order by category asc";
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> categoryList = new ArrayList<HashMap<String,Object>>();
	
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("category",rs.getString("category"));
		m.put("cnt",rs.getInt("cnt"));
		categoryList.add(m);
	}
	//디버깅
	//System.out.println(categoryList);
%>
<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>goodsList</title>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
	</div>	 

	<!-- 서브메뉴 카테고리별 상품리스트 -->
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for(HashMap m : categoryList){
		%>
			<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
				<%=(String)(m.get("category"))%>
				(<%=(Integer)(m.get("cnt"))%>)
			</a>
		<%
			}
		%>
	</div>
	<div>
		<table>
			<%
				for(HashMap sm: list){
			%>
			<tr>
					<td><%=(String)(sm.get("category"))%></td>
					<td><%=(String)(sm.get("goodsTitle"))%></td>
					<td><%=(Integer)(sm.get("goodsPrice"))%></td>
					<td><%=(Integer)(sm.get("goodsAmount"))%></td>
			</tr>		
			<%
				}
			%>		
		</table>
	</div>
</body>
</html>