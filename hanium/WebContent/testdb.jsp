<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<%
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/han?useUnicode=true&characterEncoding=utf8"; // 아까 예제에서와 마찬가지로 url을 설정하죠
Connection con = DriverManager.getConnection(DB_URL, "uroot", "p6742");
PreparedStatement pstmt1 = con.prepareStatement("SELECT u_phonenumber from user where u_gender=m");
ResultSet rs= pstmt.executeQuery;
String dab = rs.getString(1);

OutputStream os = response.getOutputStream();//response에다가 outputStream만들고
os.write(dab);//넣고
os.flush();//보냄
os.close();//필요없으니 닫음.
%>