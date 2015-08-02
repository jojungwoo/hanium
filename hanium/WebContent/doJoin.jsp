<%@ page contentType="text/html;charset=utf-8"
	import="java.sql.*" %>
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>
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
		
		String sql = "INSERT INTO user(u_phonenum,u_name,u_pw,u_birth,u_age,u_gender,u_email,u_major,u_ablility,u_resume) VALUES(?,?,?,?,?)"; // sql문 작성(id와 name, pwd값들을 보내기위한 작업)
		
		PreparedStatement pstmt = con.prepareStatement(sql);
		pstmt.setString(1,phonenum); // values에 들어갈 각각의 id, name, pwd 설정
		pstmt.setString(2,name);
		pstmt.setString(3,pw);
		pstmt.setString(4,birth);
		pstmt.setString(5,age);
		pstmt.setString(6,gender);
		pstmt.setString(7,email);
		pstmt.setString(8,major);
		pstmt.setString(9,ability);
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
