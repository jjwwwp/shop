package shop.dao;

import java.sql.*;
import java.util.*;

public class CategoryDAO {
	public static int insertCategory(String category, String createDate) throws Exception {
		int row = 0;
		
		//DB접근
		 Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		String sql = "insert ... ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, category);
		stmt.setString(2, createDate);
		
		row = stmt.executeUpdate();
		
		conn.close();
		return row;
	}
	public static ArrayList<HashMap<String,Object>> categoryList(String category, String createDate)
												throws Exception {
		
		Connection conn = DBHelper.getConnection();
		String sql = "select category, create_date createDate from category order by category asc";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			HashMap<String,Object> m = new HashMap<String,Object>();
			m.put("category",rs.getString("category"));
			m.put("createDate",rs.getString("createDate"));
		}
		conn.close();
		return categoryList(category, createDate);
	}
}
