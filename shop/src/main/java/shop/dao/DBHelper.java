package shop.dao;

import java.io.FileReader;
import java.sql.*;
import java.util.Properties;

//쿼리문 속 민감한 개인정보(id,pw) 노출을 막음
public class DBHelper {
	public static java.sql.Connection getConnection() throws Exception {
		 Class.forName("org.mariadb.jdbc.Driver");
		 
		 //로컬 PC의 Properties파일 읽어 오기
		 FileReader fr = new FileReader("d:/dev/auth/mariadb.properties"); 
		 Properties prop = new Properties();
		 prop.load(fr);
		 //System.out.println(prop.getProperty("id"));
		 //System.out.println(prop.getProperty("pw"));
		 String id = prop.getProperty("id");
		 String pw = prop.getProperty("pw");
		 Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop",id,pw);
		 return conn;
	}
}
