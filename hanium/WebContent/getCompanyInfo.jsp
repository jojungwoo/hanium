<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    
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
    //request���� inputstream���� ���� �а�	
    String str = br.readLine();//String�� �ְ�
    
    JSONObject received = (JSONObject)JSONValue.parse(str);//�Ľ���.
    String bn = (String)received.get("b_number");
    Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/mydb","root","1q2w3e4r");
	PreparedStatement stmt = conn.prepareStatement("SELECT * FROM member WHERE u_phonenum=?");
	stmt.setString(1,bn);
	ResultSet rs = stmt.executeQuery();
	toSend.put("b_number",rs.getString("b_number"));
	toSend.put("c_name",rs.getString("c_name"));
	toSend.put("c_site",rs.getString("c_site"));
	toSend.put("c_phonenumber",rs.getString("c_phonenumber"));
	toSend.put("c_hireinfo",rs.getString("c_hireinfo"));
	toSend.put("c_hireperson",rs.getString("c_hireperson"));
	toSend.put("c_info",rs.getString("c_info"));
	stmt.close();
	conn.close();
	rs.close();
	toSend.put("error",false);
	}
	catch(Exception e){

	toSend.put("error",true);
	toSend.put("errorcode",e.toString());

	}

OutputStream os = response.getOutputStream();//response���ٰ� outputStream�����
os.write(toSend.toString().getBytes("utf-8"));//�ְ�
os.flush();//����
os.close();//�ʿ������ ����.
%>