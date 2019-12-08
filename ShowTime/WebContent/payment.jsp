<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>E-Payment</title>
<script>
function check()
{
	var type = document.frm.type;
	var cardno = document.frm.cardno;
	var mm = document.frm.mm;
	var cvv = document.frm.cvv;
	var name = document.frm.name;
	if(type.value=="")
	{		
		alert("Select a card type")
		type.focus();
		return false;
	}
	if(cardno.value=="")
	{		
		alert("Enter card number")
		cardno.focus();
		return false;
	}
	if(mm.value=="")
	{		
		alert("Enter expiry")
		mm.focus();
		return false;
	}
	if(cvv.value=="")
	{		
		alert("Enter CVV number")
		cvv.focus();
		return false;
	}
	if(name.value=="")
	{		
		alert("Enter name")
		name.focus();
		return false;
	}
	return true;
}
</script>
</head>
<body background="pictures/paylogo.png" style="background-size: 1366px 720px;background-repeat: no-repeat;" marginheight="5%">
<form action="Payment" name="frm" onsubmit="return check()">
<%
	try{
	HttpSession book = request.getSession(false);
	String se = (String)book.getAttribute("seats");
	int i,count=0;
	char ch;
	for(i=0 ; i<se.length() ; i++)
	{
		ch = se.charAt(i);
		if(ch==',')
		{
			count++;
		}
   }%>
	<center><h2><font color="red">Amount payable : Rs. <%=(count*150) %></font></h2></center>
<%	}catch(Exception e)
		{
			out.println(e);
		}%>
<center>
<select name="type">
<option>Choose your card type</option>
<option>Visa</option>
<option>MasterCard</option>
<option>American Express</option>
<option>Discover</option>
</select><br><br>
<input type="text" name="cardno" placeholder="CARD NO."><br><br>
<input type="text" name="mm" placeholder="MM / YY"><br><br>
<input type="text" name="cvv" placeholder="CVV"><br><br>
<input type="text" name="name" placeholder="NAME"><br><br>
<input type="checkbox" name="save" value="a"><font color="red"><b>Save card securely for faster booking ( 100% Secure)</b></font><br><br>
<input type="submit" value="Pay">
</center>
</form>
</body>
</html>