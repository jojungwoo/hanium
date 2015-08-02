<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">; 
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%
JSONObject toSend = new JSONObject();
try
{
    BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
    //request에서 inputstream으로 값을 읽고	
    String str = br.readLine();//String에 넣고
    
    JSONObject received = (JSONObject)JSONValue.parse(str);//파싱함.
    String phonenum = (String)received.get("phonenum"); // input.jsp에서 입력받은 값들을 받아옵니다.
	String name = (String)received.get("name");
	String pw = (String)received.get("pw");
	String birth = (String)received.get("birth");
	String age = (String)received.get("age");
	String gender = (String)received.get("gender");
	String email = (String)received.get("email");
	String major = (String)received.get("major");
	String ability = (String)received.get("ability");
	
		Class.forName("com.mysql.jdbc.Driver");
		String DB_URL = "jdbc:mysql://localhost:3306/mydb?useUnicode=true&characterEncoding=utf8"; // 아까 예제에서와 마찬가지로 url을 설정하죠
		
		Connection con = DriverManager.getConnection(DB_URL, "root", "1q2w3e4r");
		
		String sql = "UPDATE member SET u_name=? ,u_pw=? ,u_birth=? ,u_gender=? ,u_email=?,u_major=?,u_ability=?WHERE u_phonenum=?"; // sql문 작성(id와 name, pwd값들을 보내기위한 작업)
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1,name);
		pstmt.setString(2,pw);
		pstmt.setString(3,birth);
		pstmt.setString(4,age);
		pstmt.setString(5,gender);
		pstmt.setString(6,email);
		pstmt.setString(7,major);
		pstmt.setString(8,ability);
		pstmt.setString(9,phonenum);
		pstmt.executeUpdate(); // sql문 실행(회원추가 실행)
		pstmt.close();
		con.close();
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
