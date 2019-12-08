<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>About Movie</title>
</head>
<body bgcolor="silver">
<form action="EditMovie" method="post" enctype="multipart/form-data">
<%@page import="java.sql.*,connector.*" %>
<%
try{
	String id = request.getParameter("token");
	int num = Integer.parseInt(id);
	String sql = "select name from movies";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	for(int i=1 ; i<=num ; i++)
	{
		rs.next();
	}
	String name = rs.getString(1);
	HttpSession movie = request.getSession();
	movie.setAttribute("movie",name);%>
	<h2 style="color:red;text-align:center;"><i><%=name %></i></h2>
<% }
catch(Exception e)
{
	out.print(e);
}
%>
<center>
<h2 style="color:red">Synopsis :</h2>
<textarea rows="10" cols="70" name="synopsis" placeholder="Write synopsis"></textarea><br>
<h2 style="color:red">Lead Cast :</h2>
<textarea rows="10" cols="70" name="lead" placeholder="Write names of lead actors giving comma(,) after each name"></textarea><br>
<h2 style="color:red">Picture :</h2>
<input type="file" name="pic" placeholder="Upload Wallpaper"><br><br>
<input type="submit" value="SAVE">
</center>
</form>
</body>
</html>