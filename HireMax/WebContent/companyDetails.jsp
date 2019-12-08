<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Details</title>
<script>
function buttonDisable()
{
	document.getElementById("butt").disabled = true;
}
function check()
{
	var about = document.frm.about;
	var skills = document.frm.skills;
	if(about.val.length>1000)
	{
		alert("This field should be atmost of 1000 characters");
		about.focus();
		about.select(); <!--It selects the entered wrong value-->
		return false;	
	}
	if(skills.val.length>300)
	{
		alert("This field should be atmost of 300 characters");
		skills.focus();
		skills.select(); <!--It selects the entered wrong value-->
		return false;	
	}
}
</script>
</head>
<body background="CompanyLogo/companydetails.jpg" style="background-size:1366px 720px;">
<form action="CompanyDetails" method="post" enctype="multipart/form-data" name="frm" onsubmit="return check()">
<%@page import="java.sql.*,connector.*" %>
<h1 style="text-align:center;color:red;"><u><i>Enter Company Details</i></u></h1>
<table width="100%">
<tr height="40px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About the company:</i></b></td></tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Company ID</b></td> 
<%
try
{
	HttpSession companyID = request.getSession(false);
	String id = (String)companyID.getAttribute("companyID");
%>
	<td align="center" style="font-size:20px;"><b><%=id %></b></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Company Name</b></td>
	
<% 	String sql = "select name from company where id=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1,id);
	ResultSet rs = ps.executeQuery();
	String name="";
	while(rs.next())
	{
		name = rs.getString(1);
	%>
		<td align="center" style="font-size:20px;"><b><%=name%></b></td>
</tr>
<%	}
	
	sql = "select about from "+name+" where id=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1,id);
	rs = ps.executeQuery();
	while(rs.next())
	{
		if(! rs.getString(1).equals("0"))
		{
			
		}
	}
}
catch(Exception e)
{
	out.println(e);
}
%>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Type of organisation</b></td>
	<td align="center" style="font-size:20px;">
		<select name="companyType">
			<option>Private</option>
			<option>Public</option>
			<option>Government</option>
			<option>Community Interests</option>
			<option>Start-Up</option>
		</select>
	</td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Founded in</b></td>
	<td align="center"><textarea rows="1" cols="50" name="founded" placeholder="Enter year"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>CEO</b></td>
	<td align="center"><textarea rows="1" cols="50" name="ceo" placeholder="Enter CEO name"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Headquarter</b></td>
	<td align="center"><textarea rows="1" cols="50" name="headquarter" placeholder="Enter location of headquarter"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Area served</b></td>
	<td align="center">
		<select name="area">
			<option>Worldwide</option>
			<option>Intercontinental</option>
			<option>Nationwide</option>
		</select>
	</td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Revenue (in US$ Billion)</b></td>
	<td align="center"><textarea rows="1" cols="50" name="revenue" placeholder="Enter revenue"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Number of employees</b></td>
	<td align="center"><textarea rows="1" cols="50" name="emp_no" placeholder="Enter no. of employees working"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Website</b></td>
	<td align="center"><textarea rows="1" cols="50" name="website" placeholder="Enter company website"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>About the company</b></td>
	<td align="center"><textarea rows="7" cols="50" name="about" placeholder="Write to describe the company in 1000 words or less"></textarea></td>
</tr>
<tr height="100px">
	<td align="center" style="font-size:20px;"><b>Choose Logo for the company</b></td>
	<td align="center"><input type="file" name="logo"></td>
</tr>
<tr height="40px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About the job offered:</i></b></td></tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Estimated Recuits</b></td>
	<td align="center"><textarea rows="1" cols="50" name="est_recruit" placeholder="Enter estimated recruits"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Job Profile</b></td>
	<td align="center"><textarea rows="7" cols="50" name="job_profile" placeholder="Write to describe the job"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Job Position</b></td>
	<td align="center"><textarea rows="1" cols="50" name="job_pos" placeholder="Enter job position offered"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>CTC (in Lakhs pa)</b></td>
	<td align="center"><textarea rows="1" cols="50" name="ctc" placeholder="Enter offering CTC"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Min CGPA</b></td>
	<td align="center"><textarea rows="1" cols="50" name="cgpa" placeholder="Enter cut-off CGPA"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Enter Skills</b></td>
	<td align="center"><textarea rows="5" cols="50" name="skills" placeholder="Enter skills to apply for the job"></textarea></td>
</tr>
<tr height="100px">
	<td align="center" colspan="2"><input type="submit" id="butt" value="Save Details"></td>
</tr>
</table>
</form>
</body>
</html>