<!DOCTYPE html>
<%@page import="java.io.PrintWriter"%>
<html >
<head>
  <title>Seat Booking</title>
	<link rel="stylesheet" href="style.css">
</head>

<body bgcolor="white">
<%@page import="java.sql.*,connector.*" %>
<%
try{
	String data[] = new String[60];
	String seat[] = new String[60];
	int i;
	String image="";
	String movie = request.getParameter("name");
	HttpSession movie2 = request.getSession();
	movie2.setAttribute("movie", movie);
	i=0;
	String sql = "select status,seatid,image from "+ movie.replace(" ","_");
	Connection cn = Db2Connector.getCn();
	PreparedStatement ps = cn.prepareStatement(sql);
	ResultSet rs = ps.executeQuery();
	while(rs.next()){
		if(i==0)
		{
			image = rs.getString(3);
		}
		data[i]=rs.getString(1);
		seat[i]=rs.getString(2);
		i++;
	}	%>
<form action="SeatBook">
  <div class="plane">
	<center><img src="<%=image %>" height="200" width="400" alt="All eyes here"></center>
  <div class="exit exit--front fuselage"></div>
  <ol class="cabin fuselage">
    <li class="row row--1">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="1A" name="seat" value="1A" />
          <label for="1A">1A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="1B" name="seat" value="1B" />
          <label for="1B">1B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="1C" name="seat" value="1C" />
          <label for="1C">1C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="1D" name="seat" value="1D"/>
          <label for="1D">1D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="1E" name="seat" value="1E"/>
          <label for="1E">1E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="1F" name="seat" value="1F"/>
          <label for="1F">1F</label>
        </li>
      </ol>
    </li>
    <li class="row row--2">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="2A" name="seat" value="2A"/>
          <label for="2A">2A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="2B" name="seat" value="2B"/>
          <label for="2B">2B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="2C" name="seat" value="2C"/>
          <label for="2C">2C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="2D" name="seat" value="2D"/>
          <label for="2D">2D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="2E" name="seat" value="2E"/>
          <label for="2E">2E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="2F" name="seat" value="2F"/>
          <label for="2F">2F</label>
        </li>
      </ol>
    </li>
    <li class="row row--3">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="3A" name="seat" value="3A"/>
          <label for="3A">3A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="3B" name="seat" value="3B"/>
          <label for="3B">3B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="3C" name="seat" value="3C"/>
          <label for="3C">3C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="3D" name="seat" value="3D"/>
          <label for="3D">3D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="3E" name="seat" value="3E"/>
          <label for="3E">3E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="3F" name="seat" value="3F"/>
          <label for="3F">3F</label>
        </li>
      </ol>
    </li>
    <li class="row row--4">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="4A" name="seat" value="4A"/>
          <label for="4A">4A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="4B" name="seat" value="4B"/>
          <label for="4B">4B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="4C" name="seat" value="4C"/>
          <label for="4C">4C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="4D" name="seat" value="4D"/>
          <label for="4D">4D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="4E" name="seat" value="4E"/>
          <label for="4E">4E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="4F" name="seat" value="4F"/>
          <label for="4F">4F</label>
        </li>
      </ol>
    </li>
    <li class="row row--5">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="5A" name="seat" value="5A"/>
          <label for="5A">5A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="5B" name="seat" value="5B"/>
          <label for="5B">5B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="5C" name="seat" value="5C"/>
          <label for="5C">5C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="5D" name="seat" value="5D"/>
          <label for="5D">5D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="5E" name="seat" value="5E"/>
          <label for="5E">5E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="5F" name="seat" value="5F"/>
          <label for="5F">5F</label>
        </li>
      </ol>
    </li>
    <li class="row row--6">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="6A" name="seat" value="6A"/>
          <label for="6A">6A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="6B" name="seat" value="6B"/>
          <label for="6B">6B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="6C" name="seat" value="6C"/>
          <label for="6C">6C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="6D" name="seat" value="6D"/>
          <label for="6D">6D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="6E" name="seat" value="6E"/>
          <label for="6E">6E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="6F" name="seat" value="6F"/>
          <label for="6F">6F</label>
        </li>
      </ol>
    </li>
    <li class="row row--7">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="7A" name="seat" value="7A"/>
          <label for="7A">7A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="7B" name="seat" value="7B"/>
          <label for="7B">7B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="7C" name="seat" value="7C"/>
          <label for="7C">7C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="7D" name="seat" value="7D"/>
          <label for="7D">7D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="7E" name="seat" value="7E"/>
          <label for="7E">7E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="7F" name="seat" value="7F"/>
          <label for="7F">7F</label>
        </li>
      </ol>
    </li>
    <li class="row row--8">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="8A" name="seat" value="8A"/>
          <label for="8A">8A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="8B" name="seat" value="8B"/>
          <label for="8B">8B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="8C" name="seat" value="8C"/>
          <label for="8C">8C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="8D" name="seat" value="8D"/>
          <label for="8D">8D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="8E" name="seat" value="8E"/>
          <label for="8E">8E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="8F" name="seat" value="8F"/>
          <label for="8F">8F</label>
        </li>
      </ol>
    </li>
    <li class="row row--9">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="9A" name="seat" value="9A"/>
          <label for="9A">9A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="9B" name="seat" value="9B"/>
          <label for="9B">9B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="9C" name="seat" value="9C"/>
          <label for="9C">9C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="9D" name="seat" value="9D"/>
          <label for="9D">9D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="9E" name="seat" value="9E"/>
          <label for="9E">9E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="9F" name="seat" value="9F"/>
          <label for="9F">9F</label>
        </li>
      </ol>
    </li>
    <li class="row row--10">
      <ol class="seats" type="A">
        <li class="seat">
          <input type="checkbox" id="10A" name="seat" value="10A"/>
          <label for="10A">10A</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="10B" name="seat" value="10B"/>
          <label for="10B">10B</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="10C" name="seat" value="10C"/>
          <label for="10C">10C</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="10D" name="seat" value="10D"/>
          <label for="10D">10D</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="10E" name="seat" value="10E"/>
          <label for="10E">10E</label>
        </li>
        <li class="seat">
          <input type="checkbox" id="10F" name="seat" value="10F"/>
          <label for="10F">10F</label>
        </li>
      </ol>
    </li>
  </ol>
  <div class="exit exit--back fuselage"><br>
<center><input type="submit" value="Book Seats"></center>    <br>
<center><input type="reset" value="Clear Seats"></center>   
</form>
<script type="text/javascript">
<%for(i=0;i<60;i++){%>
	if(<%=data[i]%>==1)
		document.getElementById("<%=seat[i]%>").disabled=true;
	<%}%>
</script>
<% }catch(Exception e){
	out.println(e);
}	%>
</body>
</html>
