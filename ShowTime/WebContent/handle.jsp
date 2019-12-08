<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Managing Database</title>
</head>
<body bgcolor="silver">
<%@page import="connector.*,java.sql.*" %>
<table border="2" width="100%">
<tr>
<th>ID</th>
<th>NAME</th>
<th>EMAIL ID</th>
<th>MOBILE</th>
<th>RECOVERY QUESTION</th>
</tr>
<%
try
{
	int i=1;
	String sql = "select * from booking";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	while(rs.next())
	{%>
		<tr>
		<td align="center"><%=rs.getString(1) %></td>
		<td align="center"><%=rs.getString(2) %></td>
		<td align="center"><%=rs.getString(3) %></td>
		<td align="center"><%=rs.getString(4) %></td>
		<td align="center"><%=rs.getString(6) %></td>
		<td align="center"><input type="button" id="<%=i%>" class="ref" onclick="save(this)" value="Delete"></td>
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
	window.location.href='Delete?token='+rid;
	return false;

}
</script>
<center>
</center>
</body>
</html>