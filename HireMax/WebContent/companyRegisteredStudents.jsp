<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registered Students</title>
</head>
<body background="CompanyLogo/companydetails.jpg" style="background-size:1366px 720px;">
<%@page import="java.sql.*,connector.*" %>

<%
try
{
	HttpSession companyID = request.getSession(false);
	String compID = (String)companyID.getAttribute("companyID");
	
	String sql = "select name from company where id=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, compID);
	ResultSet rs = ps.executeQuery();
	String compName="";
	while(rs.next())
	{
		compName = rs.getString(1);
	}
	
	sql = "select ceo,about from "+compName+" where name=?";
	cn = Db2Connector.getCn();
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Apply");
	rs = ps.executeQuery();
	String student_name="",student_rollno="";
	int n=0,flag=0;
	while(rs.next())
	{
		flag=1;
		if(n==0)
		{ %>
			<h1 style="text-align:center;color:red;"><u><i>Registered Students</i></u></h1>
			<table width="100%" border="10">
	<%	}
		n++;
		student_name = rs.getString(1);
		student_rollno = rs.getString(2);
		String sql2 = "select branch,cgpa,image,prog_lang from STUDENT_"+student_rollno+" where rollno=?";
		PreparedStatement ps2 = cn.prepareStatement(sql2);
		ps2.setString(1, student_rollno);
		ResultSet rs2 = ps2.executeQuery();
		while(rs2.next())
		{ %>
	<tr><td>
		<table width="100%">		
			<tr height="40px"><th align="left" width="33%" style="font-size:40px;color:red;">&nbsp;&nbsp;<%=n %>.)  <%=student_name %></th>
					<td width="33%"></td>
					<td width="33%" rowspan="4" align="right"><img border="1" src=<%=rs2.getString(3) %> height="250" width="200"></td>
			</tr>
			<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Roll No. :</b> <i><%=student_rollno %></i></td>
				<td rowspan="3" width="33%" align="right" style="font-size:20px;"><b>Programming Language known:</b> <i><%=rs2.getString(4) %></i></td>
			</tr>
			<tr>
				<td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Branch :</b> <i><%=rs2.getString(1) %></i></td>
			</tr>
			<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>CGPA:</b> <i><%=rs2.getString(2) %></i></td></tr>
			<tr height="40px"><td colspan="3" align="center"><input type="submit" value="View Details" onclick="viewDetails(this)" id="<%=student_rollno%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								  <input type="submit" value="Cancel Registration" onclick="cancelRegis(this)" id="<%=student_rollno%>"></td></tr>
		</table>
	</td></tr>			
<%		}
	}
	if(flag==0)
	{ %>
		<h2 style="text-align:center;font-size:50px;"><i>No students have registered yet.</i></h2>
	<%	return;
	}
}
catch(Exception e)
{
	out.println(e);
}
%>

</table>
<script type="text/javascript">
function cancelRegis(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='CompanyStudentCancelRegistration?student_rollno='+rid;
	return false;
}
</script>
<script type="text/javascript">
function viewDetails(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='companyStudentDetails.jsp?student_rollno='+rid;
	return false;
}
</script>
</body>
</html>