<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Personal Interview</title>
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
	ps.setString(1, "Qualified");
	rs = ps.executeQuery();
	int size=0;
	while(rs.next())
	{
		size = Integer.parseInt(rs.getString(1));
	}
	
	if(size == 0)
	{	%>
		<h2 style="text-align:center;font-size:50px;"><i>No students have been qualified yet.</i></h2>
<%		return;
	}
	%>
	<form action="companyPersonalInterview2.jsp">
	<table width="100%">
	<tr>
	<td align="right" width="65%">
	<textarea rows="2" cols="70" placeholder="Enter Full Name or Roll No. to search for student" name="search"></textarea>
	</td>
	<td align="left" width="35%"><input type="submit" value="Search Student"></td>
	</tr>
	</table>
	</form>
	<h1 style="text-align:center;color:red;"><u><i>Qualified Students</i></u></h1>
	<table width="100%" border="10">
	
	
 <%	int selected_rollno[] = new int[size];
	sql = "select about from "+compName+" where name=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Selected");
	rs = ps.executeQuery();
	int k=0;
	while(rs.next())
	{
		selected_rollno[k++] = Integer.parseInt(rs.getString(1));
	}
	
	sql = "select about from "+compName+" where name=?";
	cn = Db2Connector.getCn();
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Qualified");
	rs = ps.executeQuery();
	String student_rollno="",score="";
	int n=0;
	while(rs.next())
	{
		n++;
		student_rollno = rs.getString(1);
		
		String sql2 = "select ph_no from STUDENT_"+student_rollno+" where rollno=?";
		PreparedStatement ps2 = cn.prepareStatement(sql2);
		ps2.setString(1, compID+"_Apply");
		ResultSet rs2 = ps2.executeQuery();
		while(rs2.next())
		{
			score = rs2.getString(1);
		}
		double total,correct,perc;
		correct = Double.parseDouble(score.substring(0,score.indexOf('/')));
		total = Double.parseDouble(score.substring(score.indexOf('/')+1));
		perc = (correct*100)/total;
		
		sql2 = "select branch,cgpa,image,prog_lang,name from STUDENT_"+student_rollno+" where rollno=?";
		ps2 = cn.prepareStatement(sql2);
		ps2.setString(1, student_rollno);
		rs2 = ps2.executeQuery();
		while(rs2.next())
		{ %>
	<tr><td>
		<table width="100%">		
			<tr height="40px"><th align="left" width="33%" style="font-size:40px;color:red;">&nbsp;&nbsp;<%=n %>.)  <%=rs2.getString(5) %></th>
					<td width="33%"></td>
					<td width="33%" rowspan="4" align="right"><img border="1" src=<%=rs2.getString(3) %> height="250" width="220"></td>
			</tr>
			<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Roll No. :</b> <i><%=student_rollno %></i></td>
				<td width="33%" align="right" style="font-size:20px;"><b>Percentage scored in Qualifying Exam:</b> <i><%=perc %> %</i></td>
			</tr>
			<tr>
				<td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Branch :</b> <i><%=rs2.getString(1) %></i></td>
				<td rowspan="2" width="33%" align="right" style="font-size:20px;"><b>Programming Language known:</b> <i><%=rs2.getString(4) %></i></td>
			</tr>
			<tr><td width="33%" style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>CGPA:</b> <i><%=rs2.getString(2) %></i></td></tr>
			<tr height="40px"><td colspan="3" align="center"><input type="submit" value="Take Interview" onclick="takeInterview(this)" id="<%=student_rollno%>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								  <input type="submit" value="View Details" onclick="viewDetails(this)" id="<%=student_rollno%>"></td></tr>
		
		<%-- <script type="text/javascript">
		<%	for(int i=0 ; i<size ; i++)
			{	out.println(student_rollno);
				if( selected_rollno[i] == Integer.parseInt(student_rollno) ) %>
				document.getElementById("<%=student_rollno%>").disabled=true;
  		  <%}%>
		</script> --%>
		
		
		</table>
	</td></tr>			
<%		}
	}  %>
	



<% } 
catch(Exception e)
{
	out.println(e);
}
%>

</table>
<script type="text/javascript">
function takeInterview(obj) {
	var rid = obj.getAttribute("id");
	window.location.href='companyStudentTakeInterview.jsp?student_rollno='+rid;
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