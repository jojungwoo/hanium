<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>
<%@ page import="java.sql.*" %>
<%JSONObject toSend = new JSONObject();
try{
BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
//request에서 inputstream으로 값을 읽고	
String str = br.readLine();//String에 넣고

JSONObject received = (JSONObject)JSONValue.parse(str);//파싱함.
int b_number = (int)received.get("b_number");
String c_name = (String)received.get("c_name");
String u_phonenum = (String)received.get("u_phonenum");
String b_name = (String)received.get("b_name");
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/mydb?useUnicode=true&characterEncoding=utf8"; // 아까 예제에서와 마찬가지로 url을 설정하죠
Connection con = DriverManager.getConnection(DB_URL, "root", "1q2w3e4r");
PreparedStatement pstmt1 = con.prepareStatement("SELECT w_number from waiting where b_number = ?");
pstmt1.setInt(1,b_number);
ResultSet rs = pstmt1.executeQuery();
ResultSetMetaData md = rs.getMetaData();
int numUser = md.getColumnCount();
int i = 0;
int w_number = 1;


	while(rs.next()){
	i++;
		if(i==numUser){
		w_number = rs.getInt(1);
		w_number++;
		}
	}
pstmt1.close();
	
	if(w_number != 0){
	PreparedStatement pstm2 = con.prepareStatement("INSERT INTO waiting(w_number,b_number,c_name,u_phonenum,b_name) values(?,?,?,?,?)");
	
	
	pstm2.setInt(1,w_number);
	pstm2.setInt(2,b_number);
	pstm2.setString(3,c_name);
	pstm2.setString(4,u_phonenum);
	pstm2.setString(5,b_name);
	pstm2.executeUpdate();
	pstm2.close();
	con.close();
	toSend.put("error",false);
	}
	else{
	toSend.put("error",true);
	toSend.put("errorcode","Unknown");
	}

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