<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Book Tickets</title>
</head>
<body background="pictures/login.png" topmargin="50">
<%@page import="java.sql.*,connector.*" %>
<table width="100%" height="100%">
<%try{
		String sql = "select name from movies";
		Connection cn = Db2Connector.getCn();
		PreparedStatement ps = cn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		int i=1;
		String movie1,movie2="";
		while(rs.next())
		{
			movie1 = movie2 = "";
			movie1 = rs.getString(1);
			String sql2 = "select image from " +movie1.replace(" ","_")+ " where seatid=?";
			ps = cn.prepareStatement(sql2);
			ps.setString(1, "1A");
			ResultSet rs2 = ps.executeQuery();%>
			<tr>
		<%	if(rs2.next())
			{ %>
				<td align="center"><a href="seats.jsp?name=<%=movie1 %>"><img src="<%=rs2.getString(1)%>" height="200" width="400"></a></td>
		<%	}
			if(rs.next())
			  {
					movie2 = rs.getString(1);
					sql2 = "select image from " +movie2.replace(" ","_")+ " where seatid=?";
					ps = cn.prepareStatement(sql2);
					ps.setString(1, "1A");
					rs2 = ps.executeQuery();%>
			  		<%	if(rs2.next())
						{ %>
			  				<td align="center"><a href="seats.jsp?name=<%=movie2%>"><img src="<%=rs2.getString(1)%>" height="200" width="400"></a></td>
			<%			}
			  }%>
			</tr>
			<tr>
			<td style="color:white;text-align: center;font-size:30px"><i><%=movie1 %></i></td>
			<td style="color:white;text-align:center;font-size:30px"><i><%=movie2 %></i></td>
			</tr>
			<tr>
			<td><p>" "</p></td>
			</tr>
	<%	}
	}
  catch(Exception e)
	{
  		
  	} %>
</table>	
</body>
</html>