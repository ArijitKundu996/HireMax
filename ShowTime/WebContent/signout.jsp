<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign Out</title>
</head>
<body>
<%try
{
	HttpSession ses = request.getSession(false);
	String id = (String)ses.getAttribute("session");
	
	HttpSession a = request.getSession(false);
	a.setAttribute("continu","");
	if(id==null || id.equals(""))
	{%>
		<h2 style="text-align:center;color: white;">You are not logged in...!!!</h2>
<% 	}
	else
	{
		ses.setAttribute("session", "");%>
		<h2 style="text-align:center;color: white;">You are signed out...!!!</h2>
<%	}
}
catch(Exception e)
{
	out.println(e);
}
%>
</body>
</html>