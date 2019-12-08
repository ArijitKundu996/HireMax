<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Profile</title>
</head>
<body bgcolor="cyan">
<%@page import="java.sql.*,connector.*" %>
<%
try{
	HttpSession user = request.getSession(false);
	String id = (String)user.getAttribute("session");
	if(id.equals(null) || id.equals(""))
	{ %>
		<h2 style="text-align:center;">Please Log In first...!!!</h2>
<% 	}else{ %>
	<h1 style="text-align:center;"><i>My Profile</i></h1><br><br>
<% 	String sql = "select * from booking where id=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1,id);
	ResultSet rs = ps.executeQuery();
	if(rs.next())
	{ %>
		<center><table>
			<tr>
				<td>User ID : </td>
				<td><%=rs.getString(1) %></td>
			</tr>
			<tr>
				<td>Name : </td>
				<td><%=rs.getString(2) %></td>
			</tr>
			<tr>
				<td>Email : </td>
				<td><%=rs.getString(3) %></td>
			</tr>
			<tr>
				<td>Contact No. : </td>
				<td><%=rs.getString(4) %></td>
			</tr>
			<tr>
				<td>Recovery Question : </td>
				<td><%=rs.getString(6) %></td>
			</tr>
		</table></center>
	<%}
	}
}
catch(Exception e)
{
	out.print("<h2 style='text-align:center;'>Please Log In first...!!!</h2>");
}%>
</body>
</html>