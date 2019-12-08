<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Student Details</title>
</head>
<body background="Student/student.jpg" style="background-size:1366px 720px;">
<form action="StudentDetails" method="post" enctype="multipart/form-data">
<h1 style="text-align:center;color:red;"><u><i>Enter Details</i></u></h1>
<%@page import="java.sql.*,connector.*" %>
<table width="100%">
<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About your Personal Info:</i></b></td></tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Roll No.</b></td> 
<%
try
{
	HttpSession studentRollNo = request.getSession(false);
	String rollno = (String)studentRollNo.getAttribute("studentRollNo");
	
	String sql = "select name,email_id from student where rollno=?";
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ps.setString(1,rollno);
	ResultSet rs = ps.executeQuery();
	String name="",email="";
	while(rs.next())
	{
		name = rs.getString(1);
		email = rs.getString(2);
	} %>
	
	<td align="center" style="font-size:20px;"><b><%=rollno %></b></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Name</b></td> 
	<td align="center" style="font-size:20px;"><b><%=name %></b></td> 
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Email ID</b></td> 
	<td align="center" style="font-size:20px;"><b><%=email %></b></td> 
</tr>
<%
}
catch(Exception e)
{
	out.println(e);
}
%>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Gender</b></td>
	<td align="center">
		<select name="gender">
			<option>Male</option>
			<option>Female</option>
		</select>
	</td>
</tr>

<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Contact Number</b></td>
	<td align="center"><textarea rows="1" cols="50" name="ph" placeholder="Enter 10 digit valid contact number"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Date of Birth</b></td>
	<td align="center"><textarea rows="1" cols="50" name="dob" placeholder="Enter Date of Birth as DD-MM-YEAR"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Hobbies</b></td>
	<td align="center"><textarea rows="7" cols="50" name="hobby" placeholder="Enter hobbies separated by comma ( , ) in 200 words or less"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Image</b></td>
	<td align="center"><input type="file" name="image"></td>
</tr>

<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About your Academics:</i></b></td></tr>

<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Branch</b></td>
	<td align="center">
		<select name="branch">
			<option>Computer Sc. & Engineering</option>
			<option>Information Technology</option>
			<option>Mechanical Engineering</option>
			<option>Automobile Engineering</option>
			<option>Electrical Engineering</option>
			<option>Electronics Engineering</option>
			<option>Civil Engineering</option>
		</select>
	</td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>CGPA</b></td>
	<td align="center"><textarea rows="1" cols="50" name="cgpa" placeholder="Enter running CGPA"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Programming Languages <br> known</b></td>
	<td align="center"><textarea rows="7" cols="50" name="languages" placeholder="Enter programming languages known to you separated by comma ( , )"></textarea></td>
</tr>
	
<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About your parents:</i></b></td></tr>

<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Father's Name</b></td>
	<td align="center"><textarea rows="1" cols="50" name="father_name" placeholder="Enter father's name"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Father's Occupation</b></td>
	<td align="center"><textarea rows="1" cols="50" name="father_occupation" placeholder="Enter father's occupation"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Mother's Name</b></td>
	<td align="center"><textarea rows="1" cols="50" name="mother_name" placeholder="Enter mother's name"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Mother's Occupation</b></td>
	<td align="center"><textarea rows="1" cols="50" name="mother_occupation" placeholder="Enter mother's occupation"></textarea></td>
</tr>

<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About your Class 12 Education:</i></b></td></tr>

<tr height="40px">
	<td align="center" style="font-size:20px;"><b>School Name</b></td>
	<td align="center"><textarea rows="1" cols="50" name="school_12" placeholder="Enter school's name"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Percentage</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="1" cols="47" name="percent_12" placeholder="Enter percentage"></textarea><b>%</b></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Board</b></td>
	<td align="center">
		<select name="board_12">
			<option>ISC</option>
			<option>CBSE</option>
			<option>IGSCE</option>
			<option>IBDP</option>
			<option>Regional</option>
		</select>
	</td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>City</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="1" cols="50" name="city_12" placeholder="Enter city where school is located"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Achievements</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="7" cols="50" name="achieve_12" placeholder="Enter achievements in school in 100 words or less (if any)"></textarea></td>
</tr>

<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About your Class 10 Education:</i></b></td></tr>

<tr height="40px">
	<td align="center" style="font-size:20px;"><b>School Name</b></td>
	<td align="center"><textarea rows="1" cols="50" name="school_10" placeholder="Enter school's name"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Percentage</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="1" cols="47" name="percent_10" placeholder="Enter percentage"></textarea><b>%</b></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Board</b></td>
	<td align="center">
		<select name="board_10">
			<option>ICSE</option>
			<option>CBSE</option>
			<option>IGSCE</option>
			<option>IBDP</option>
			<option>Regional</option>
		</select>
	</td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>City</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="1" cols="50" name="city_10" placeholder="Enter city where school is located"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Achievements</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="7" cols="50" name="achieve_10" placeholder="Enter achievements in school in 100 words or less (if any)"></textarea></td>
</tr>

<tr height="100px"><td align="center" colspan="2" style="font-size:20px;color:red;"><b><i>About your Extra - Curricular info:</i></b></td></tr>

<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Training</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="7" cols="50" name="training" placeholder="Enter trainings you have done in 400 words or less (if any)"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Internship</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="7" cols="50" name="internship" placeholder="Enter internships you have done in 400 words or less (if any)"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Social Service</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="7" cols="50" name="social_service" placeholder="Enter social services you have done in 400 words or less (if any)"></textarea></td>
</tr>
<tr height="40px">
	<td align="center" style="font-size:20px;"><b>Project</b></td>
	<td align="center" style="font-size:20px;"><textarea rows="7" cols="50" name="project" placeholder="Enter projects you have done in 400 words or less (if any)"></textarea></td>
</tr>

<tr height="100px">
	<td align="center" colspan="2"><input type="submit" value="Save Details"></td>
</tr>
</table>
</form>
</body>
</html>