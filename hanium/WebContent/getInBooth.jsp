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
String u_phonenum = (String)received.get("u_phonenum");
Class.forName("com.mysql.jdbc.Driver");
String DB_URL = "jdbc:mysql://localhost:3306/mydb?useUnicode=true&characterEncoding=utf8"; // 아까 예제에서와 마찬가지로 url을 설정하죠
Connection con = DriverManager.getConnection(DB_URL, "root", "1q2w3e4r");
PreparedStatement pstmt1 = con.prepareStatement("SELECT w_number FROM waiting where b_number = ?");
pstmt1.setInt(1,b_number);
ResultSet rs = pstmt1.executeQuery();
int i = 0;
int hp = 0;//highest priority
int tmp = 0;


	while(rs.next()){
		i++;
		tmp = rs.getInt(1);
		if(i==1){
		hp = rs.getInt(1);
		}
		
		if(tmp<=hp) hp = tmp;
	}
pstmt1.close();
	PreparedStatement pstm2 = con.prepareStatement("SELECT u_phonenum FROM waiting where w_number = ?");
	if(rs.getString(1).equals(hp)){
		pstm2.close();
	PreparedStatement pstm3 = con.prepareStatement("DELETE FROM waiting WHERE w_number = ? and u_phonenum");
	    pstm3.setInt(1,hp);
	    pstm3.setString(2,u_phonenum);
	    pstm3.executeUpdate();
	    pstm3.close();
	    toSend.put("error",false);
	}
	else{
		toSend.put("error",true);
		toSend.put("errorcode","차례가아닙니다.");
	}
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