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
<form action="StudentTestQues"> 
<h1 style="text-align:center;color:red;"><u><i>Qualifying Test</i></u></h1>
<%
try
{
	String compDetails = request.getParameter("companyDetails");
	String compName = compDetails.substring(0,compDetails.indexOf(','));
	String compID = compDetails.substring(compDetails.indexOf(',')+1);
	
	HttpSession companyDetails = request.getSession();
	companyDetails.setAttribute("companyDetails", compDetails);
	
	String sql = "select logo from "+compName+" where id=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, compID);
	ResultSet rs = ps.executeQuery();
	String logo="";
	while(rs.next())
	{
		logo = rs.getString(1);
	} %>
	
	<center><img border="1" src=<%=logo %> height="250" width="500"></center>
	<h2 style="text-align:center;color:red;"><i>All The Best</i></h2>	
	<table width="100%">
	
<%
	sql = "select about,job_profile,skills from "+compName+" where name=?";
	cn = Db2Connector.getCn();
	ps = cn.prepareStatement(sql);
	ps.setString(1, "QualTest");
	rs = ps.executeQuery();
	String ques="",op1="",op2="",op3="",op4="";
	int n=0;
	while(rs.next())
	{
		n++;
		ques = rs.getString(1).substring(0,rs.getString(1).indexOf('+'));
		op1 = rs.getString(2).substring(0,rs.getString(2).indexOf('+'));
		op2 = rs.getString(2).substring(rs.getString(2).indexOf('+')+1);
		op3 = rs.getString(3).substring(0,rs.getString(3).indexOf('+'));
		op4 = rs.getString(3).substring(rs.getString(3).indexOf('+')+1); %>
		
		<tr height="70px">
				<td colspan="2" align="left" style="font-size:20px;"><b><%=n %>.   <%=ques %></b></td>
		</tr>
		<tr>
				<td align="justify" style="font-size:20px;"><input type="checkbox" name="ans" id="<%= op1%>" value="<%= op1%>">  A. <i><%=op1 %></i></td>
				<td align="justify" style="font-size:20px;"><input type="checkbox" name="ans" id="<%= op2%>" value="<%= op2%>">  B. <i><%=op2 %></i></td>
		</tr>
		<tr>
				<td align="justify" style="font-size:20px;"><input type="checkbox" name="ans" id="<%= op3%>" value="<%= op3%>">  C. <i><%=op3 %></i></td>
				<td align="justify" style="font-size:20px;"><input type="checkbox" name="ans" id="<%= op4%>" value="<%= op4%>">  D. <i><%=op4 %></i></td>
		</tr>
				
<%	} %>
	
	<tr height="100px">
	<td align="center" colspan="2"><input type="submit" value="Submit Test"></td>
	</tr>
	
<%}
catch(Exception e)
{
	out.println(e);
}
%>
		
</table>
</form>

</body>
</html>