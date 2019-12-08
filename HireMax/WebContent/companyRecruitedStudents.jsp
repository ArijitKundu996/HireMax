<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Recruited Students</title>
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
	
	sql = "select count(*) from "+compName+" where name=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Recruited");
	rs = ps.executeQuery();
	while(rs.next())
	{
		if(Integer.parseInt(rs.getString(1)) == 0)
		{ %>
			<h2 style="text-align:center;font-size:50px;"><i>No students have been recruited yet.</i></h2>
<%			return;
		}
		
	} %>
	
	<h1 style="text-align:center;color:red;"><u><i>Recruited Students</i></u></h1>
	<table width="100%" border="10">

<%
	sql = "select about from "+compName+" where name=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Recruited");
	rs = ps.executeQuery();
	String student_rollno="",remarks="",score="",total_rating="";
	int n=0;
	while(rs.next())
	{
		n++;
		student_rollno = rs.getString(1);
		
		String sql2 = "select skills from "+compName+" where name=?";
		PreparedStatement ps2 = cn.prepareStatement(sql2);
		ps2.setString(1, "Selected");
		ResultSet rs2 = ps2.executeQuery();
		while(rs2.next())
		{
			remarks = rs2.getString(1);
		}
		
		sql2 = "select ph_no from STUDENT_"+student_rollno+" where rollno=?";
		ps2 = cn.prepareStatement(sql2);
		ps2.setString(1, compID+"_Apply");
		rs2 = ps2.executeQuery();
		while(rs2.next())
		{
			score = rs2.getString(1);
		}
		double total,correct,perc;
		correct = Double.parseDouble(score.substring(0,score.indexOf('/')));
		total = Double.parseDouble(score.substring(score.indexOf('/')+1));
		perc = (correct*100)/total;
		
		sql2 = "select ph_no from STUDENT_"+student_rollno+" where rollno=?";
		ps2 = cn.prepareStatement(sql2);
		ps2.setString(1, compID+"_Selected");
		rs2 = ps2.executeQuery();
		while(rs2.next())
		{
			total_rating = rs2.getString(1);
		}
		
		sql2 = "select branch,cgpa,image,prog_lang,name from STUDENT_"+student_rollno+" where rollno=?";
		ps2 = cn.prepareStatement(sql2);
		ps2.setString(1, student_rollno);
		rs2 = ps2.executeQuery();
		while(rs2.next())
		{ %>
	<tr><td>
		<table width="100%">		
			<tr height="40px"><th align="left" colspan="2" width="20%" style="font-size:40px;color:red;">&nbsp;&nbsp;<%=n %>.)  <%=rs2.getString(5) %></th>
					<td width="35%"></td>
					<td width="35%"></td>
					<td width="10%" rowspan="4" align="right"><img border="1" src=<%=rs2.getString(3) %> height="250" width="220"></td>
			</tr>
			<tr><td width="40%" align="left" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Roll No. :</b> <i><%=student_rollno %></i></td>
				<td width="35%" align="center" style="font-size:20px;"><b>Percentage scored in Qualifying Exam:</b> <i><%=perc %> %</i></td>
				<td width="35%" align="center" style="font-size:20px;"><b>Total Rating in Personal Interview:</b> <i><%=total_rating %> </i></td>
			</tr>
			<tr>
				<td width="20%" align="left" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Branch :</b> <i><%=rs2.getString(1) %></i></td>
				<td rowspan="2" width="35%" align="center" style="font-size:20px;"><b>Programming Language known:</b> <i><%=rs2.getString(4) %></i></td>
				<td rowspan="2" width="35%" align="center" style="font-size:20px;"><b>Remarks of Personal Interview:</b> <i><%=remarks%> </i></td>
			</tr>
			<tr><td width="20%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>CGPA:</b> <i><%=rs2.getString(2) %></i></td></tr>
			<tr height="40px"><td colspan="5" align="center"><input type="submit" value="View Details" onclick="viewDetails(this)" id="<%=student_rollno%>"></td></tr>
		</table>
	</td></tr>			
<%		}
	}
}
catch(Exception e)
{
	out.println(e);
}
%>
</table><br><br>
<script type="text/javascript">
function viewDetails(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='companyStudentDetails.jsp?student_rollno='+rid;
	return false;
}
</script>
</body>
</html>