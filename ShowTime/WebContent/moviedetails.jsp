<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movie Sketch</title>
</head>
<body background="pictures/last.jpg" style="background-size:1366px 720px" topmargin="50" leftmargin="50" rightmargin="100">
<%@page import="java.sql.*,connector.*" %>
<%try{
	String movie = request.getParameter("name");
	String sql = "select synopsis,lead_cast from " +movie.replace(" ","_")+ " where seatid=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, "1A");
	ResultSet rs = ps.executeQuery();
	if(rs.next())
	{%>
		<span style="color:white;"><strong>SYNOPSIS</strong><br><br>
		<p style="color:white;"><strong><%=rs.getString(1) %></strong></p><br><br>
		<span style="color:white;"><strong>LEAD CAST</strong><br><br>
	<% 	int start=0;
		String cast = rs.getString(2);
		for(int i=0 ; i<cast.length() ; i++)
		{
			if(cast.charAt(i)==',')
			{
				String s = cast.substring(start,i);
				start = i+1;%>
				<span style="color:white;"><strong><%=s %></strong></span><br>
<%			}
		}%>
		<span style="color:white;"><strong><%=cast.substring(start) %></strong></span><br>
<%	}
 }
catch(Exception e)
{
	out.print(e);
}%>
</body>
</html>