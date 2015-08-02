<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<%
JSONObject toSend = new JSONObject();
try{
BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
//request에서 inputstream으로 값을 읽고	
String str = br.readLine();//String에 넣고

JSONObject received = (JSONObject)JSONValue.parse(str);//파싱함.
int b_number = (int)received.get("b_number");
String u_phonenum = (String)received.get("u_phonenum");

Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/mydb?useUnicode=true&characterEncoding=utf8"; // 아까 예제에서와 마찬가지로 url을 설정하죠

Connection con = DriverManager.getConnection(DB_URL, "root", "1q2w3e4r");

String sql = "DELETE FROM waiting WHERE b_number=?, u_phonenum = ?"; // sql문 작성(id와 name, pwd값들을 보내기위한 작업)

PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,b_number);
pstmt.setString(2,u_phonenum);
pstmt.executeUpdate();
pstmt.close();
con.close();
}
catch(Exception e){
	
	toSend.put("error",true);
	toSend.put("errorcode",e.toString());
	
}

OutputStream os = response.getOutputStream();//response에다가 outputStream만들고
os.write(toSend.toString().getBytes("utf-8"));//넣고
os.flush();//보냄
os.close();//필요없으니 닫음.
%>
