<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Qualifying Test</title>
</head>
<body background="Student/student.jpg" style="background-size:1366px 720px;">
<%@page import="java.sql.*,connector.*" %>


<%
try
{
	HttpSession studentRollNo = request.getSession(false);
	String rollno = (String)studentRollNo.getAttribute("studentRollNo");
	
	String sql = "select count(dob) from STUDENT_"+rollno+" where hobby=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, "Apply");
	ResultSet rs = ps.executeQuery();
	int count=0;
	while(rs.next())
	{
		count = Integer.parseInt(rs.getString(1));
	}
	
	if(count == 0)
	{ %>
		<h1 style='color:black;text-align:center;font-size:50px;'><i>No Qualifying test.<br>You will have to apply for company to give their Qualifying test.</i></h1>
<%		return;
	} %>
	
	<h1 style="text-align:center;color:red;"><u><i>Qualifying Test</i></u></h1>
	<table width="100%">
	
<%
		sql = "select branch,name from STUDENT_"+rollno+" where hobby=?";
		ps = cn.prepareStatement(sql);
		ps.setString(1, "Apply");
		rs = ps.executeQuery();
		int n=0;
		String compName="",compID="";
		while(rs.next())
		{
			n++;
			compID = rs.getString(1);
			compName = rs.getString(2); %>
			
			<tr height="40px">
				<td width="33%" align="center" style="font-size:20px;"><b><%=n %>.)</b></td>
				<td width="33%" align="center" style="font-size:20px;"><b><%=compName %></b></td>
				<td width="33%" align="center"><input type="submit" value="Take Test" onclick="takeTest(this)" id="<%=compName+","+compID %>"></td>
			</tr>
<%		}
	
}
catch(Exception e)
{
	out.println(e);
}
%>
</table>
<script type="text/javascript">
function takeTest(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='studentTestQues.jsp?companyDetails='+rid;
	return false;
}
</script>
</body>
</html>