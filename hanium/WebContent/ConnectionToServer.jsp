<%@ page language="java" contentType="text/html; charset=utf-8"
 pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">;
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>

<%
HttpURLConnection conn = null;
OutputStream os = null;
InputStream  is   = null;
ByteArrayOutputStream baos = null;

URL url = new URL("http://14.63.214.67:10004/hanium/dap.jsp");//접속할 url.*에다가 url을 넣어주시면 됩니다.
conn = (HttpURLConnection)url.openConnection(); //connection을 여는 부분입니다.

conn.setConnectTimeout(10000);
conn.setReadTimeout(10000);//위 두줄은 timeout에 대한 설정부분.(ms단위, 현재는 10초로 그냥 만들어놨어요)

conn.setRequestMethod("POST");//post방식으로 받을꺼라는 설정.(get방식보다는 조오금 더 보안성이 높아요)

conn.setRequestProperty("Cache-Control", "no-cache");//캐시설정X

conn.setRequestProperty("Content-Type", "application/json");
conn.setRequestProperty("Accept", "application/json");//json으로 주고받겠다는 설정입니다.

conn.setDoOutput(true);//값을 보내기도 할거고
conn.setDoInput(true);//당연히 받기도 할거라는 설정입니다.

JSONObject job = new JSONObject();//jsonObject를 만들고
job.put("phoneNum", "01000000000");//값을 넣습니다.
job.put("name","cho");
job.put("trash",true);

os = conn.getOutputStream();//데이터를 보낼 길(stream)을 만들고
os.write(job.toString().getBytes("utf-8"));//거기다가 써 넣고
os.flush();//보내고
os.close();//데이터 전송이 끝났으니 길을 닫습니다.


int responseCode = conn.getResponseCode();
if(responseCode == HttpURLConnection.HTTP_OK) {
	String rs = null;
	is = conn.getInputStream();//inputStream을 만들어서
	
    baos = new ByteArrayOutputStream();//byte배열로 온 걸 byte[]에 넣어줄 아이.(String으로 안하고 byte[]로 하는이유는 한글깨짐방지.)
    byte[] byteBuffer = new byte[1024];//받는 단위를 1024byte(1KB)로 설정합니다.
    int nLength = 0;
    while((nLength = is.read(byteBuffer, 0, byteBuffer.length)) != -1) {//읽을게 있는동안
        baos.write(byteBuffer, 0, nLength);//읽어입니다.
    }
    rs = new String(baos.toByteArray());//읽어들인것들을 String으로 만들고
    JSONObject reJson = (JSONObject)JSONValue.parse(rs);//파싱을 함.(JSONValue.parse()를 쓰면 object가 리턴이라
    													//JSONObject로 캐스팅한겁니다.
    String ended = (String)reJson.get("dhfb");//*에다가 변수명을 넣으면 변수명에 해당하는 값을 받을수있습니다.
    									   //여기서도 리턴은 object라 캐스팅이 꼭 필요합니다.
    out.println(ended);
}
conn.disconnect();//데이터 전송들이 끝났으니 connection을 닫습니다.

%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
</body>
</html> 