<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Listing</title>
</head>
<body background="Student/student.jpg" style="background-size:1366px 720px">
<%@page import="java.sql.*,connector.*" %>
<table width="100%" border="10">
<%
try
{
	String sql = "select name,id from company";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	int count=0;
	String id="",name="",name2="",type="",est_recruit="",recruited="",job_pos="",ctc="",cgpa="",logo="";
	while(rs.next())
	{ %>
		<tr>
		<td>
		<table width="100%" >
	     
<%		count++;
		name = rs.getString(1);
		id = rs.getString(2);
		name2 = name+" ";
		name2 = name2.substring(0,name2.indexOf(' '));
		String sql2 = "select type,est_recruit,recruited,job_pos,ctc,cgpa,logo from "+name2+" where id=?";
		PreparedStatement ps2 = cn.prepareStatement(sql2);
		ps2.setString(1,id);
		ResultSet rs2 = ps2.executeQuery();
		while(rs2.next())
		{
			type = rs2.getString(1);
			est_recruit = rs2.getString(2);
			recruited = rs2.getString(3);
			job_pos = rs2.getString(4);
			ctc = rs2.getString(5);
			cgpa = rs2.getString(6);
			logo = rs2.getString(7); %>
			
			
				<tr height="40px"><th align="left" width="33%" style="font-size:40px;color:red;">&nbsp;&nbsp;<%=count %>.)  <%=name %></th>
						<td width="33%"></td>
						<td width="33%" rowspan="5" align="right"><img border="1" src=<%=logo %> height="200" width="200"></td>
				</tr>
				<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Type:</b> <i><%=type %></i></td></tr>
				<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Job Position:</b> <i><%=job_pos %></i></td>
					<td width="33%" align="right" style="font-size:20px;"><b>Estimated Recruit:</b> <i><%=est_recruit %></i></td>
				</tr>
				<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>CTC:</b> <i><%=ctc %> Lakhs per annum</i></td>
					<td width="33%" align="right" style="font-size:20px;"><b>Recruited:</b> <i><%=recruited %></i></td>
				</tr>
				<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Min CGPA:</b> <i><%=cgpa %></i></td></tr>
				<tr height="40px"><td colspan="3" align="center"><input type="submit" value="Apply Now" onclick="apply(this)" id="<%=name2+","+id %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								  <input type="submit" value="View Details" onclick="viewDetails(this)" id="<%=name2+","+id %>"></td></tr>
		</table>
		</td>
		</tr>
<%		}
	}
}
catch(Exception e)
{
	out.println(e);
}
%>

</table>
<script type="text/javascript">
function apply(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='StudentCompanyApply?companyDetails='+rid;
	return false;
}
</script>
<script type="text/javascript">
function viewDetails(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='studentCompanyDetails.jsp?companyDetails='+rid;
	return false;
}
</script>
</body>
</html>