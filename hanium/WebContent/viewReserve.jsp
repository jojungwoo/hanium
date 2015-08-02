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
PreparedStatement stmt = conn.prepareStatement("SELECT * FROM waiting WHERE u_phonenum=?");
stmt.setString(1,pn);
ResultSet rs = stmt.executeQuery();
toSend.put("w_number",rs.getString("w_number"));
toSend.put("b_number",rs.getString("b_number"));
toSend.put("c_name",rs.getString("c_name"));
toSend.put("b_name",rs.getString("b_name"));
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