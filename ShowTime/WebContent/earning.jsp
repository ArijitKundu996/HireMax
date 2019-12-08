<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Earnings</title>
</head>
<body bgcolor="silver">
<%@page import="java.sql.*,connector.*" %>
<table border="2" width="100%">
<tr>
<th>MOVIE</th>
<th>EARNING</th>
</tr>
<%try{
		String movie,sql1;
		String sql = "select name from movies";
		Connection cn = Db2Connector.getCn();
		PreparedStatement ps = cn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			movie = rs.getString(1);
			sql1 = "select count(seatid) from " +movie.replace(" ","_")+ " where status=?";
			PreparedStatement ps1 = cn.prepareStatement(sql1);
			ps1.setString(1,"1");
			ResultSet rs1 = ps1.executeQuery();%>
			<tr>
			<td align="center"><%=movie %></td>
		<%	if(rs1.next())
			{%>
				<td align="center">Rs. <%=Integer.parseInt(rs1.getString(1))*150 %></td>
				</tr>
		<% 	}
		}
	}
	catch(Exception e)
	{
		out.print(e);
	}
%>
</table>
</body>
</html>