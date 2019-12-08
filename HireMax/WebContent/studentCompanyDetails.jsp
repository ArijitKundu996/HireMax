<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Details</title>
</head>
<body background="Student/student.jpg" style="background-size:1366px 720px">
<%@page import="java.sql.*,connector.*" %>
<table width="100%">
<%
try
{
	String str = request.getParameter("companyDetails");
	String companyID = str.substring(str.indexOf(',')+1);
	String companyName = str.substring(0,str.indexOf(','));
 	
	String sql = "select * from "+companyName+" where id=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1,companyID);
	ResultSet rs = ps.executeQuery();
	String name="",type="",founded="",ceo="",headquarter="",area_served="",revenue="",no_of_emp="",website="",about="",
		   logo="",est_recruit="",recruited="",job_profile="",job_pos="",ctc="",skills="",cgpa="";
	while(rs.next())
	{
		name = rs.getString(2);
		type = rs.getString(3);
		founded = rs.getString(4);
		ceo = rs.getString(5);
		headquarter = rs.getString(6);
		area_served = rs.getString(7);
		revenue = rs.getString(8);
		no_of_emp = rs.getString(9);
		website = rs.getString(10);
		about = rs.getString(11);
		logo = rs.getString(12);
		est_recruit = rs.getString(13);
		recruited = rs.getString(14);
		job_profile = rs.getString(15);
		job_pos = rs.getString(16);
		ctc = rs.getString(17);
		skills = rs.getString(18);
		cgpa = rs.getString(19);
	}  %>
	
	<tr height="60px"><th colspan="2" align="center" style="font-size:40px;color:red;"><%=name %></th></tr>
	
	<tr height=""><td colspan="2" align="center"><img src="<%=logo%>" width="600" height="300" border="1" alt="Company Logo not available"> </td></tr>
	<tr height=""><td colspan="2" align="center">Company Logo</td></tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About the company:</i></b></td></tr>
	
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Company Type</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=type %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Founded</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=founded %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>CEO</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=ceo %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Headquarter</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=headquarter %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Area Served</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=area_served %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Revenue</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=revenue %> US $ Billion</td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Number of employees</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=no_of_emp %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Website</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=website %></td>
	</tr>
	<tr height="80px">
		<td width="40%" align="center" style="font-size:20px;color:red;"><b>About the company</b></td>
		<td height="40px" width="60%" align="justify" style="font-size:20px;"><%=about %></td>
	</tr>
	
	<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About the job offered:</i></b></td></tr>

	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>Job Position</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=job_pos %></td>
	</tr>
	<tr height="80px">
		<td width="40%" align="center" style="font-size:20px;color:red;"><b>Job Profile</b></td>
		<td width="60%" align="justify" style="font-size:20px;"><%=job_profile %></td>
	</tr>
	<tr height="40px">
		<td width="50%" align="center" style="font-size:20px;color:red;"><b>CTC</b></td>
		<td width="50%" align="center" style="font-size:20px;"><%=ctc %> Lakhs per annum</td>
	</tr>
	<tr height="80px">
		<td width="40%" align="center" style="font-size:20px;color:red;"><b>Skills required</b></td>
		<td width="60%" align="justify" style="font-size:20px;"><%=skills %></td>
	</tr>
	
<%	
}
catch(Exception e)
{
	out.println(e);
}
%>
</table>
</body>
</html>