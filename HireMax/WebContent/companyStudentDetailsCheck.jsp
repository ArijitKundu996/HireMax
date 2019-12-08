<%@page import="javax.websocket.OnOpen"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check if details added</title>
</head>
<%@page import="java.sql.*,connector.*" %>
<body>
<%
try
{
	String rollno = request.getParameter("student_rollno");
	
	Connection cn = Db2Connector.getCn();
	String sql = "select rollno from STUDENT_"+rollno;
	PreparedStatement ps = cn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	while(rs.next())
	{	
		RequestDispatcher rd = request.getRequestDispatcher("companyStudentDetails.jsp?student_rollno="+rollno);
		rd.include(request, response);
		return;
	}
	RequestDispatcher rd = request.getRequestDispatcher("studentDetails.jsp");
	rd.include(request, response);
}
catch(Exception e)
{
	out.println(e);
}
%>
</body>
</html>