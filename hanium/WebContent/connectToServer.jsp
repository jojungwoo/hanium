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
conn = (HttpURLConnection)url.openConnection(); //connection�� ���� �κ�.
conn.setConnectTimeout(10000);
conn.setReadTimeout(10000);//�� ������ timeout�� ���� �����κ�.(ms������)
conn.setRequestMethod("POST");//post������� ��������� ����
conn.setRequestProperty("Cache-Control", "no-cache");//ĳ�ü���X
conn.setRequestProperty("Content-Type", "application/json");
conn.setRequestProperty("Accept", "application/json");//json���� �ְ�ްڴٴ� ����
conn.setDoOutput(true);//���� �����⵵ �ҰŰ�
conn.setDoInput(true);//�翬�� �ޱ⵵ �ҰŶ�� ����


JSONObject job = new JSONObject();//jsonObject�� �����
job.put("phoneNum", "01000000000");//���� ����
job.put("name","cho");
job.put("trash",true);

os = conn.getOutputStream();//�����͸� ���� ��(stream)�� �����
os.write(job.toString().getBytes("utf-8"));//�ű�ٰ� �� �ְ�
os.flush();//����

os.close();//������ ������ �������� ���� ����


int responseCode = conn.getResponseCode();//
if(responseCode == HttpURLConnection.HTTP_OK) {
BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream())); //�������� �� ����(���⼭�� jsp)�� bufferedReader�� �������

StringBuffer buffer = new StringBuffer(); 

 int read = 0; 

 char[] cbuff = new char[1024]; 

 while ((read = reader.read(cbuff)) > 0) {//�������� �������ȿ� 
buffer.append(cbuff, 0, read); //�о����(buffer���ٰ� ä������)
 }
reader.close();//reader�� �ݰ�
Object temp = JSONValue.parse(buffer.toString());
JSONObject reJson = (JSONObject)temp;
String ended = (String)reJson.get("dhfb");
out.println(ended);


conn.disconnect();//connection�� ����
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