<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Home</title>
<link href="CompanyLogo/theme/theme2.css" rel="stylesheet" type="text/css"/>
</head>
<body background="CompanyLogo/background.jpg">
<%@page import="connector.*,java.sql.*" %>
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
	
	sql = "select logo from "+name+" where id=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, id);
	rs = ps.executeQuery();
	String logo="";
	while(rs.next())
	{
		logo = rs.getString(1);
	}
	%>
	
	<center><img src="<%= logo%>" height="106px" width="270px" style="position:absolute; left: 40%;top:0px; "></center>

<table width="100%" height="100%" align="center">
	 <tr>
		<td height="100px"></td>
	</tr>
	<tr id="navigation">
		<td><a href="companyHome.jsp">Home</a></td>
		<td><a href="companyDetails.jsp" target="iframe2">Company Details</a></td>
		<td><a target="iframe2" onclick="viewDetails(this)" id="<%=name+","+id%>">Company Profile</a></td>
		<td><a href="companyCriteria.jsp" target="iframe2">Criteria</a></td>
		<td><a href="companyQualTest.jsp" target="iframe2">Qualifying Test</a></td>
		<td><a href="KIITHome.html">KIIT University Portal</a></td>
		
	</tr>
	<tr id="navigation">
		<td><a href="companyRegisteredStudents.jsp" target="iframe2">Registered Students</a></td>
		<td><a href="companyQualifiedStudents.jsp" target="iframe2">Qualified Students</a></td>
		<td><a href="companyPersonalInterview.jsp" target="iframe2">Personal Interview</a></td>
		<td><a href="companySelectedStudents.jsp" target="iframe2">Selected Students</a></td>
		<td><a href="companyRecruitedStudents.jsp" target="iframe2">Recruited Students</a></td>
		<td><a href="companyLogin.html">Sign Out</a></td>
	</tr>
</table>	
<center><iframe src="<%=logo %>" style="border:none;" height="482px" width="100%" name="iframe2"> </iframe></center>

<%
}
catch(Exception e)
{
	out.println(e);
}
%>
<script type="text/javascript">
function viewDetails(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='studentCompanyDetails.jsp?companyDetails='+rid;
	return false;
}
</script>
</body>
</html>