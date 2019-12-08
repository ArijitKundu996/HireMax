<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Details</title>
</head>
<body background="CompanyLogo/companydetails.jpg" style="background-size:1366px 720px;">
<%@page import="java.sql.*,connector.*" %>
<table width="100%">
<%
try
{
	String student_rollno = request.getParameter("student_rollno");
	
	String sql = "select email_id from student where rollno=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, student_rollno);
	ResultSet rs = ps.executeQuery();
	String email="";
	while(rs.next())
	{
		email = rs.getString(1);
	}
	
	sql = "select * from STUDENT_"+student_rollno+" where rollno=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, student_rollno);
	rs = ps.executeQuery();
	while(rs.next())
	{ %>
		
	<tr height="60px"><th colspan="2" align="center" style="font-size:40px;color:red;"><%=rs.getString(2) %></th></tr>
	
	<tr height=""><td colspan="2" align="center"><img src="<%=rs.getString(10)%>" width="310" height="370" border="1" alt="Student profile picture not available"> </td></tr>
	<tr height=""><td colspan="2" align="center">Profile Picture</td></tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>Personal Info:</i></b></td></tr>
			
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Roll No.</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(1) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Gender</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(4) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Email ID</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=email %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>DOB</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(6) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Hobby</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(7) %></td>
	</tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About Academics:</i></b></td></tr>
	
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Branch</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(5) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>CGPA</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(8) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Programming Languages <br> known</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(9) %></td>
	</tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About Parents:</i></b></td></tr>

	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Father's Name</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(11) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Father's Occupation</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(12) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Mother's Name</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(13) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Mother's Occupation</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(14) %></td>
	</tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About Class 12 Education:</i></b></td></tr>

	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>School Name</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(15) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Percentage</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(16) %> %</td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Board</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(18) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>City</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(17) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Achievements</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(19) %></td>
	</tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About Class 10 Education:</i></b></td></tr>

	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>School Name</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(20) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Percentage</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(21) %> %</td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Board</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(23) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>City</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(22) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Achievements</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(24) %></td>
	</tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About Extra - Curricular info:</i></b></td></tr>

	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Training</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(25) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Internship</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(26) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Social Service</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(27) %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Project</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=rs.getString(28) %></td>
	</tr>
	<tr height="30px"></tr>
<%	}
}
catch(Exception e)
{
	out.println(e);
}
%>
</table>
</body>
</html>