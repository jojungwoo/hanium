<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
JSONObject toSend = new JSONObject();
try{
BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
//request에서 inputstream으로 값을 읽고	
String str = br.readLine();//String에 넣고
JSONObject received = (JSONObject)JSONValue.parse(str);//파싱함.
String pn = (String)received.get("phonenum");
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","1q2w3e4r");
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM member WHERE u_phonenum=?");
stmt.setString(1,pn);
ResultSet rs = stmt.executeQuery();
toSend.put("u_phonenum",rs.getString("u_phonenum"));
toSend.put("u_name",rs.getString("u_name"));
toSend.put("u_pw",rs.getString("u_pw"));
toSend.put("u_birth",rs.getString("u_birth"));
toSend.put("u_age",rs.getString("u_age"));
toSend.put("u_gender",rs.getString("u_gender"));
toSend.put("u_email",rs.getString("u_email"));
toSend.put("u_major",rs.getString("u_major"));
toSend.put("u_ability",rs.getString("u_ability"));
stmt.close();
conn.close();
rs.close();
toSend.put("error",false);
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