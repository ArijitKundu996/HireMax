<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Movies</title>
</head>
<body background="pictures/movie.jpg" style="background-size: 1366px 720px;background-repeat: no-repeat;">
<%@page import="java.sql.*,connector.*" %>
<%
try{
	int i=1;
	String sql = "select name from movies where lang=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1,"Hindi");
	ResultSet rs = ps.executeQuery(); %>
	&emsp;<span style="color:red;font-size:30px">Hindi</span><br><br>
<%	while(rs.next())
	{%>
		&emsp;&emsp;<a href="moviedetails.jsp?name=<%=rs.getString(1)%>"><span style="color:#000000;font-size:20px" ><%= rs.getString(1)%></span></a><br>
<%	}
	ps = cn.prepareStatement(sql);
	ps.setString(1,"Bengali");
	rs = ps.executeQuery(); %>
<br>&emsp;<span style="color:red;font-size:30px">Bengali</span><br><br>
<%	while(rs.next())
	{%>
	&emsp;&emsp;<a href="moviedetails.jsp?name=<%=rs.getString(1)%>"><span style="color:#000000;font-size:20px"><%= rs.getString(1)%></span></a><br>
<%	}
	ps = cn.prepareStatement(sql);
	ps.setString(1,"English");
	rs = ps.executeQuery(); %>
<br>&emsp;<span style="color:red;font-size:30px">English</span><br><br>
<%	while(rs.next())
	{%>
	&emsp;&emsp;<a href="moviedetails.jsp?name=<%=rs.getString(1)%>"><span style="color:#000000;font-size:20px"><%= rs.getString(1)%></span></a><br>
<%	}
   }
   catch(Exception e)
   {
		out.println(e);
	} %>
</body>
</html>