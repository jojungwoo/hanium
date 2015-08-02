<%@ page language="java" contentType="text/html; charset=EUC-KR"
 pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">;
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>
<%
HttpURLConnection conn = null;
OutputStream os = null;
URL url = new URL("http://192.168.0.3:8080/hanium/dap.jsp");
conn = (HttpURLConnection)url.openConnection(); //connection을 여는 부분.
conn.setConnectTimeout(10000);
conn.setReadTimeout(10000);//위 두줄은 timeout에 대한 설정부분.(ms단위임)
conn.setRequestMethod("POST");//post방식으로 받을꺼라는 설정
conn.setRequestProperty("Cache-Control", "no-cache");//캐시설정X
conn.setRequestProperty("Content-Type", "application/json");
conn.setRequestProperty("Accept", "application/json");//json으로 주고받겠다는 설정
conn.setDoOutput(true);//값을 보내기도 할거고
conn.setDoInput(true);//당연히 받기도 할거라는 설정


JSONObject job = new JSONObject();//jsonObject를 만들고
job.put("phoneNum", "01000000000");//값을 넣음
job.put("name","cho");
job.put("trash",true);

os = conn.getOutputStream();//데이터를 보낼 길(stream)을 만들고
os.write(job.toString().getBytes("utf-8"));//거기다가 써 넣고
os.flush();//보냄

os.close();//데이터 전송이 끝났으니 길을 닫음


int responseCode = conn.getResponseCode();//
if(responseCode == HttpURLConnection.HTTP_OK) {
BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream())); //서버에서 온 내용(여기서는 jsp)를 bufferedReader에 집어넣음

StringBuffer buffer = new StringBuffer(); 

 int read = 0; 

 char[] cbuff = new char[1024]; 

 while ((read = reader.read(cbuff)) > 0) {//읽을값이 있을동안에 
buffer.append(cbuff, 0, read); //읽어들임(buffer에다가 채워넣음)
 }
reader.close();//reader를 닫고
Object temp = JSONValue.parse(buffer.toString());
JSONObject reJson = (JSONObject)temp;
String ended = (String)reJson.get("dhfb");
out.println(ended);


conn.disconnect();//connection을 닫음
}
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html> 
</body>
</html>