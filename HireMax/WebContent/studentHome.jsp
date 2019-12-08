<!DOCTYPE html>
<%@page import="connector.*,java.sql.*"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Student Home</title>
<link href="CompanyLogo/theme/theme2.css" rel="stylesheet" type="text/css"/>
<%
try
{
	HttpSession studentRollNo = request.getSession(false);
	String rollno = (String)studentRollNo.getAttribute("studentRollNo");
	
	Connection cn = Db2Connector.getCn();
	String sql = "select name from student where rollno=?";
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1,rollno);
	ResultSet rs = ps.executeQuery();
	String name="";
	while(rs.next())
	{
		name = rs.getString(1);
	}
	%>
<br><br><p style="font-size:18px;">Welcome &nbsp;&nbsp;<b><i><%=name %></i></b></p>	
</head>
<body background="Student/studenthome.jpg" style="background-size:1366px 720px;">
<img src="Student/kiit2.png" height="108px" width="800px" style="position:absolute; left:20%;top:0px; ">
<table width="100%" height="100%" align="center">
	 <tr>
		<td height="10px"></td>
	</tr>
	<tr id="navigation">
		<td><a href="studentHome.jsp">Home</a></td>
		<td><a href="studentDetails.jsp" target="iframe2">My Details</a></td>
		<td><a target="iframe2" onclick="viewDetails(this)" id="<%=rollno%>">My Profile</a></td>
		<td><a href="studentCompanyListing.jsp" target="iframe2">Company Listing</a></td>
		<td><a href="studentDashboard.jsp" target="iframe2">Dashboard</a></td>
		<td><a href="studentQualTest.jsp" target="iframe2">Qualifying Test</a></td>
		<td><a href="KIITHome.html">KIIT University Portal</a></td>
		<td><a href="studentLogin.html">Sign Out</a></td>
	</tr>
</table>
<%}
catch(Exception e)
{
	out.println(e);
}
%>	
<center><iframe src="" style="border:none;" height="509px" width="1350px" name="iframe2"> </iframe></center>
<script type="text/javascript">
function viewDetails(obj) {
	var rid = obj.getAttribute("id");
	//window.location.href='companyStudentDetails.jsp?student_rollno='+rid;
	window.location.href='companyStudentDetailsCheck.jsp?student_rollno='+rid;
	return false;
}
</script>
</body>
</html>