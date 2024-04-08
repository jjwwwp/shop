<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
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
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 20;
	
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
	int startRow = (currentPage-1)*rowPerPage;
	
	/*
		null이면
		select * from goods
		null이 아니면
		select * from goods where category=?
	*/
	String sql3 = null;
	PreparedStatement stmt3 = null;
	if(category==null){
		sql3= "select category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount,filename from goods order by goods_title asc limit ?,?";
		stmt3 = conn.prepareStatement(sql3);
		 stmt3.setInt(1,startRow);
		 stmt3.setInt(2,rowPerPage);
	} else{
		 sql3 = "select category, goods_title goodsTitle, goods_content goodsContent, goods_price goodsPrice, goods_amount goodsAmount, filename from goods where category=? order by goods_title asc limit ?,?";
		 stmt3 = conn.prepareStatement(sql3);
		 stmt3.setString(1,category);
		 stmt3.setInt(2,startRow);
		 stmt3.setInt(3,rowPerPage);
		
		 
	}
	
	ResultSet rs3 = null;
	System.out.println(stmt3);
	rs3 = stmt3.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	while(rs3.next()){
		HashMap<String,Object> sm = new HashMap<String,Object>();
		sm.put("category",rs3.getString("category"));
		sm.put("goodsTitle",rs3.getString("goodsTitle"));
		sm.put("goodsPrice",rs3.getInt("goodsPrice"));
		sm.put("goodsAmount",rs3.getInt("goodsAmount"));
		sm.put("filename",rs3.getString("filename"));
		
		list.add(sm);
	}
	//System.out.println(list);
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
    <link rel="stylesheet" href="/shop/emp/css/emp.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>	
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<!-- 서브메뉴 카테고리별 상품리스트 -->
		<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
		</div>
		
		<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		</div>
		<%
			for(HashMap<String,Object> m : categoryList){
		%>
			<a href="/shop/emp/goodsList.jsp?category=<%=(String)(m.get("category"))%>">
				<%=(String)(m.get("category"))%>
				(<%=(Integer)(m.get("cnt"))%>)
			</a>
		<%
			}
		%>
	
	
	<!-- goods 목록출력 -->
	<div class="container" style="width: 100%; height: 50%; background-color: green;">
		<h3>상품목록</h3>
		
				<div class="d-flex align-content-center flex-wrap">
			<%
				for(HashMap<String,Object> sm: list){
			%>
			
					<div class="goods">
						<img src="/shop/upload/<%=sm.get("filename")%>" width="110px;" height="130px;">
					
				<div><%=(String)(sm.get("goodsTitle"))%></div>
				<div><%=(Integer)(sm.get("goodsPrice"))%>원</div>
				<div><%=(Integer)(sm.get("goodsAmount"))%>개</div>
			
					</div>
				
			<%
				}
			%>	
				</div>
			
		</div>
		
		<nav aria-label="Page navigation example">
  		<ul class="pagination justify-content-center">
  		
  		<%
				if(currentPage > 1){
			%>
				<div class="page-item">
					<a class ="page-link" href="./goodsList.jsp?currentPage=1"> << </a>
				</div>
				<div class="page-item">
					<a class ="page-link" href="./goodsList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				</div>
			<%		
				} else{
			%>
				<div class="page-item disabled">
					<a class ="page-link" href="./goodsList.jsp?currentPage=1"> << </a>
				</div>	
				<div class="page-item disabled">
					<a class ="page-link" href="./goodsList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				</div>
			<%
				}
			%>
				
				<div>
					<span class="btn btn-outline-secondary">
							<%=currentPage%> 
					</span>
				</div>
				
			<%		
				
				if(currentPage < lastPage) {
			%>
				<div class="page-item">
					<a class ="page-link" href="./goodsList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				</div>
				<div class="page-item">
					<a class ="page-link" href="./goodsList.jsp?currentPage=<%=lastPage%>">>></a>
				</div>
				
			<%		
				}
			%>
		</ul>
		</nav>
</body>
</html>