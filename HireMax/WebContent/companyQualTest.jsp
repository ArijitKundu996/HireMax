<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Company Qualifying Test</title>
</head>
<body background="CompanyLogo/companydetails.jpg" style="background-size:1366px 720px;">
<form action="CompanyQualTest">
<%@page import="java.sql.*,connector.*" %>
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
	
	sql = "select count(name) from "+name+" where name=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "QualTest");
	rs = ps.executeQuery();
	int num=0;
	while(rs.next())
	{
		num = Integer.parseInt(rs.getString(1));
	}
	
	if(num==0)
	{%>
		<h2 style="text-align:center;font-size:30px;color:black;">No Qualifying Questions set. <br><font color="red"><i> Note : No qualifying questions set will be assumed as no qualifying test and the students who register will be directly selected.</i></font></h2>	
<%	}
	else
	{ %>
	<table width="100%">
	<tr height="60px">
		<th colspan="4" align="center" style="font-size:30px;color:red;"><u><i>Qualifying  Question</i></u></th>
	</tr>
<%		int n=0;
		String ques,op1,op2,op3,op4;
		sql = "select about,job_profile,skills,cgpa from "+name+" where name=?";
		ps = cn.prepareStatement(sql);
		ps.setString(1, "QualTest");
		rs = ps.executeQuery();
		while(rs.next())
		{
			n++;
			if(n==1)
			{ %>
				<tr height="40px">
					<td colspan="4" align="center" style="font-size:20px;color:red;"><b><i>Minimum Qualifying Percentage: <%=rs.getString(4) %> %</i></b></td>
				</tr>			
<%			}
			ques = rs.getString(1).substring(0,rs.getString(1).indexOf('+'));
			op1 = rs.getString(2).substring(0,rs.getString(2).indexOf('+'));
			op2 = rs.getString(2).substring(rs.getString(2).indexOf('+')+1);
			op3 = rs.getString(3).substring(0,rs.getString(3).indexOf('+'));
			op4 = rs.getString(3).substring(rs.getString(3).indexOf('+')+1);
			%>
			<tr height="40px">
				<td colspan="3" align="left" style="font-size:20px;"><b><%=n %>.   <%=ques %></b></td>
				<td align="center"><input type="button" id="<%=n%>" onclick="deleteQues(this)" value="Delete Question"></td>
			</tr>
			<tr>
				<td align="justify" style="font-size:20px;">A. <i><%=op1 %></i></td>
				<td align="justify" style="font-size:20px;">B. <i><%=op2 %></i></td>
				<td align="justify" style="font-size:20px;">C. <i><%=op3 %></i></td>
				<td align="justify" style="font-size:20px;">D. <i><%=op4 %></i></td>
			</tr>
<%		}
			
	} %>
	</table>
<%	
}
catch(Exception e)
{
	out.println(e);
}
%>
<br><br><br><br>
<center>
<h3>Enter minimum Qualifying Percentage: 
<input type="text" name="minPerc" placeholder="Enter minimum percentage"> %</h3> 
<h3 style="color:red;">Note: Default minimum Qualifying Percentage is 75%</h3><br><br>
<h3>Ques: <textarea rows="1" cols="110" name="question" placeholder="Enter Question"></textarea><br><br>
A.<textarea rows="1" cols="50" name="option1" placeholder="Enter 1st Option"></textarea> &nbsp;&nbsp;&nbsp;&nbsp; B.<textarea rows="1" cols="50" name="option2" placeholder="Enter 2nd Option"></textarea><br><br>
C.<textarea rows="1" cols="50" name="option3" placeholder="Enter 3rd Option"></textarea> &nbsp;&nbsp;&nbsp;&nbsp; D.<textarea rows="1" cols="50" name="option4" placeholder="Enter 4th Option"></textarea><br><br>
Ans: <textarea rows="1" cols="50" name="answer" placeholder="Enter Answer"></textarea></h3><br>
<input type="submit" value="Submit"><br><br><br>
</form>
<script type="text/javascript">
	function deleteQues(obj) 
	{
		var rid = obj.getAttribute("id");
		window.location.href='CompanyQualTestDelete?token='+rid;
		return false;
	}
	</script>
</body>
</html>