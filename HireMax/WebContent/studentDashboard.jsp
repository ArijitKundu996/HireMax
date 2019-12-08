<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>
</head>
<body background="Student/student.jpg" style="background-size:1366px 720px">
<%@page import="java.sql.*,connector.*" %>
<%
try
{
	HttpSession studentRollNo = request.getSession(false);
	String rollno = (String)studentRollNo.getAttribute("studentRollNo");
	
	String sql = "select count(*) from STUDENT_"+rollno+" where rollno=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1, rollno);
	ResultSet rs = ps.executeQuery();
	while(rs.next())
	{
		if(Integer.parseInt(rs.getString(1)) <= 0)
		{
			%>
			<h2 style="text-align:center;font-size:50px;"><i>No activities to show.</i></h2>
<%			return;
		}
		else
		{   %>
			<h1 style="text-align:center;color:red;"><u><i>Profile Details</i></u></h1>
			<h2 style="margin-left: 50px">Profile details have been added.</h2>
<%		}
	}
	
	sql = "select name from STUDENT_"+rollno+" where hobby=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Apply");
	rs = ps.executeQuery(); 
	int n=1;%>
<%	while(rs.next())
	{ 
		if(n == 1)
		{ %>
			<h1 style="text-align:center;color:red;"><u><i>Registered</i></u></h1>
	<% 		n=2;
		} %>
		<h2 style="margin-left: 50px">Registered for <b><i><%=rs.getString(1) %></i></b>.</h2>
<%	}

	sql = "select name,ph_no from STUDENT_"+rollno+" where hobby=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Apply");
	rs = ps.executeQuery(); 
	n=1;%>
<%  while(rs.next())
	{ 
		if(!rs.getString(2).equals("0"))
		{
			if(n == 1)
			{ %>
				<h1 style="text-align:center;color:red;"><u><i>Qualifying Test</i></u></h1>
	<% 			n=2;
			} 
			double correct = Double.parseDouble(rs.getString(2).substring(0,rs.getString(2).indexOf('/')));
			double total = Double.parseDouble(rs.getString(2).substring(rs.getString(2).indexOf('/')+1));
			double perc = (correct*100)/total;  %>
		<h2 style="margin-left: 50px">Percentage scored in qualifying test for <b><i><%=rs.getString(1) %></i></b> is <b><i><%=perc %> %</i></b>.</h2>
<%		}
	}

	sql = "select name from STUDENT_"+rollno+" where hobby=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Selected");
	rs = ps.executeQuery(); 
	n=1;%>
<%  while(rs.next())
	{ 
		if(n == 1)
		{ %>
			<h1 style="text-align:center;color:red;"><u><i>Selected</i></u></h1>
	<% 		n=2;
		}  %> 
		<h2 style="margin-left: 50px">Selected for <b><i><%=rs.getString(1) %></i></b>.</h2>
<%		
	}

	sql = "select name from STUDENT_"+rollno+" where hobby=?";
	ps = cn.prepareStatement(sql);
	ps.setString(1, "Recruited");
	rs = ps.executeQuery(); 
	n=1;%>
<%  while(rs.next())
	{ 
		if(n == 1)
		{ %>
			<h1 style="text-align:center;color:red;"><u><i>Recruited</i></u></h1>
	<% 		n=2;
		}  %> 
		<h2 style="margin-left: 50px">Recruited for <b><i><%=rs.getString(1) %></i></b>.</h2>
	<%		
	}
}
catch(Exception e)
{
	out.println(e);
}
%>

</body>
</html>