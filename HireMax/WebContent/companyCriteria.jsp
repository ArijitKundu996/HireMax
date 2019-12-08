<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Criteria</title>

</head>
<body background="CompanyLogo/companydetails.jpg" style="background-size:1366px 720px;">
<form action="CompanyCriteria" method="get">
<%@page import="java.sql.*,connector.*" %>

<%
try
{
	HttpSession companyID = request.getSession(false);
	String id = (String)companyID.getAttribute("companyID");
	String sql = "select name from company where id=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, id);
	ResultSet rs = ps.executeQuery();
	String name="";
	while(rs.next())
	{
		name = rs.getString(1);
	}
	
	sql = "select count(name) from "+name+" where name=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Criteria");
	rs = ps.executeQuery();
	int num=0;
	while(rs.next())
	{
		num = Integer.parseInt(rs.getString(1));
	}
	if(num==0)
	{%>
		<h1 style="text-align:center;font-size:40px;color:black;">No Criterias to show.</h1>	
<%	}
	else
	{ %>
	<table width="100%">
	<tr height="60px">
		<th align="center" style="font-size:30px;color:red;"></th>
		<th align="center" style="font-size:30px;color:red;"><u><i>Criteria</i></u></th>
		<th align="center" style="font-size:30px;color:red;"><u><i>Rating</i></u></th>
		<th align="center" style="font-size:30px;color:red;"><u><i>Qualifying Rating</i></u></th>
	</tr>
<%		int n=1;
		sql = "select about,revenue,cgpa from "+name+" where name=?";
		ps = cn.prepareStatement(sql);
		ps.setString(1, "Criteria");
		rs = ps.executeQuery();
		while(rs.next())
		{ %>
			<tr height="40px">
			<td width="10%" align="center" style="font-size:20px;"><b><%=n%></b></td>
			<td width="30%" align="center" style="font-size:20px;"><b><%=rs.getString(1) %></b></td>
			<td width="20%" align="center" style="font-size:20px;"><b><%=rs.getString(2) %></b></td>
			<td width="30%" align="center" style="font-size:20px;"><b><%=rs.getString(3) %></b></td>
			<td width="10%" align="center"><input type="button" id="<%=n%>" onclick="deleteCriteria(this)" value="Delete Criteria"></td>
			</tr>
			<%n++; %>
<%		}
			
	} %>
	</table>
	<script type="text/javascript">
	function deleteCriteria(obj) 
	{
		var rid = obj.getAttribute("id");
		window.location.href='CompanyCriteriaDelete?token='+rid;
		return false;
	}
	</script>
<%	
}
catch(Exception e)
{
	out.println(e);
}
%>
<br><br><br><br>
<center>
<textarea rows="1" cols="70" name="criteria" placeholder="Enter Criteria"></textarea><br><br>
<input type="text" name="rating" placeholder="Enter rating"><br><br>
<input type="text" name="qualRating" placeholder="Enter qualifying rating"><br><br>
<input type="submit" value="Add Criteria"><br><br>
</center>
</form>
</body>
</html>