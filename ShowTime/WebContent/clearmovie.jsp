<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Clear Seats</title>
</head>
<body bgcolor="silver">
<%@page import="java.sql.*,connector.*" %>
<table border="2" width="100%">
<tr>
<th>MOVIE NAME</th>
<th>MOVIE LANGUAGE</th>
</tr>
<%
try{
	Connection cn = Db2Connector.getCn();
	String sql = "select * from movies";
	PreparedStatement ps = cn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	int i=1;
	while(rs.next())
	{%>
		<tr>
		<td align="center"><%=rs.getString(1) %></td>
		<td align="center"><%=rs.getString(2) %></td>
		<td align="center"><input type="button" value="Clear" onclick="save(this)" id="<%=i %>"></td>
		</tr>
		<%i++; %>
<%	}
}
catch(Exception e)
{
	out.println(e);
}
%>
</table>
<script type="text/javascript">
function save(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='ClearMovie?token='+rid;
	return false;
}
</script>
</body>
</html>