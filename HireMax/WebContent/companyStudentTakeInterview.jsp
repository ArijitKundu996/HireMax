<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Interview</title>
</head>
<body background="CompanyLogo/companydetails.jpg" style="background-size:1366px 720px;">
<form action="CompanyStudentTakeInterview">
<%@page import="java.sql.*,connector.*" %>
<table width="100%">
<h1 style="text-align:center;color:red;"><u><i>Personal Interview</i></u></h1>
<tr height="60px">
		<th align="center" style="font-size:30px;color:red;"></th>
		<th align="center" style="font-size:30px;color:red;"><i>Criteria</i></th>
		<th align="center" style="font-size:30px;color:red;"><i>Rating</i></th>
		<th align="center" style="font-size:30px;color:red;"><i>Interviewee</i></th>
</tr>
<%
try
{
	HttpSession companyID = request.getSession(false);
	String compID = (String)companyID.getAttribute("companyID");
	
	String student_rollno = request.getParameter("student_rollno");
	
	HttpSession studentRollNo = request.getSession();
	studentRollNo.setAttribute("studentRollNo",student_rollno);
	
	String sql = "select name from student where rollno=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, student_rollno);
	ResultSet rs = ps.executeQuery();
	String student_name="";
	while(rs.next())
	{
		student_name = rs.getString(1);
	}
	
	sql = "select image from STUDENT_"+student_rollno+" where rollno=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, student_rollno);
	rs = ps.executeQuery();
	String student_image="";
	while(rs.next())
	{
		student_image = rs.getString(1);
	}
	
	sql = "select name from company where id=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, compID);
	rs = ps.executeQuery();
	String compName="";
	while(rs.next())
	{
		compName = rs.getString(1);
	}
	
	sql = "select count(*) from "+compName+" where name=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Criteria");
	rs = ps.executeQuery();
	int count=0;
	while(rs.next())
	{
		count = Integer.parseInt(rs.getString(1));
	}
	
	sql = "select about,revenue from "+compName+" where name=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Criteria");
	rs = ps.executeQuery();
	int n=0;
	while(rs.next())
	{ 
		n++;  %>
	<tr height="40px">
		<td width="10%" align="center" style="font-size:20px;"><b><%=n%></b></td>
		<td width="30%" align="center" style="font-size:20px;"><b><%=rs.getString(1)%></b></td>
		<td width="30%" align="center" style="font-size:20px;"><b><input type="text" placeholder="Enter rating" name="rating<%=n%>"> / <%=rs.getString(2) %></b></td>	
<%		if(n==1)
		{  %>
			<td align="center" style="font-size:20px;"><b><%=student_name %></b></td>	
<%		}
		if(n==2)
		{  %>
			<td align="center"><input type="button" value="View Details" onclick="viewDetails(this)" id="<%=student_rollno%>"></td>	
<%		}
		if(n==3)
		{  %>
			<td rowspan="<%=count-2 %>" align="center"><img src="<%=student_image%>" width="170" height="200" border="1" alt="Student profile picture not available"></td>
<%		} %>
	</tr>
<%	} %>
	
	<tr height="60px">
	<td align="center" colspan="3"><textarea name="remarks" rows="7" cols="100" placeholder="Write to describe the interviewee or interview"></textarea></td>
	</tr>
	<tr height="60px">
	<td align="center" colspan="4"><input type="submit" value="End Interview"></td>
	</tr>

<%}
catch(Exception e)
{
	out.println(e);
}
%>

</table>
<script type="text/javascript">
function viewDetails(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='companyStudentDetails.jsp?student_rollno='+rid;
	return false;
}
</script>
</form>
</body>
</html>