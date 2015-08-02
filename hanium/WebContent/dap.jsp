<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">; 
<%@ page import = "org.json.simple.*" %>
<%@ page import = "java.net.HttpURLConnection" %>
<%@ page import = "java.net.URL" %>
<%@ page import = "java.io.*" %>
<%JSONObject toSend = new JSONObject();
try{
	

BufferedReader br = new BufferedReader(new InputStreamReader(request.getInputStream()));
//request에서 inputstream으로 값을 읽고	
String str = br.readLine();//String에 넣고
JSONObject received = (JSONObject)JSONValue.parse(str);//파싱함.
Boolean tra = (Boolean)received.get("trash");


if(tra==true)
	toSend.put("dhfb","없음");
//이부분은 내가 그냥 테스트용으로 쓴거


}catch(Exception e){
	toSend.put("dhfb","dlTdma");
	toSend.put("code",e.toString());
}

OutputStream os = response.getOutputStream();//response에다가 outputStream만들고
os.write(toSend.toString().getBytes("utf-8"));//넣고
os.flush();//보냄
os.close();//필요없으니 닫음.
%>