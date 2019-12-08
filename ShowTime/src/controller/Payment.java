package controller;
import java.sql.*;
import connector.*;
import mymailer.*;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Payment
 */
@WebServlet("/Payment")
public class Payment extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			HttpSession movie2 = request.getSession(false);
			String movie = (String)movie2.getAttribute("movie");
			HttpSession book = request.getSession(false);
			String se = (String)book.getAttribute("seats");
			HttpSession user = request.getSession(false);
			String id = (String)user.getAttribute("session");
			
			String sql = "update "+movie.replace(" ","_")+" set status=? where seatid=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			int start=0;
			String s;
			for(int i=0 ; i<se.length(); i++)
			{
				if(se.charAt(i)==',')
				{
					s = se.substring(start, i);
					start = i+1;
					ps.setString(1,"1");
					ps.setString(2, s);
					ps.execute();
				}
			}
					
			se = se.substring(0,se.length()-1);
			sql = "update booking set seats=?,movies=? where id=?";
			PreparedStatement ps2 = cn.prepareStatement(sql);
			ps2.setString(1, se);
			ps2.setString(2, movie);
			ps2.setString(3, id);
			ps2.execute();
			
			RequestDispatcher rd = request.getRequestDispatcher("paysuccess.html");
			rd.forward(request, response);
			
			String to="",sub,msg;
			sql = "select email from booking where id=?";
			PreparedStatement ps3 = cn.prepareStatement(sql);
			ps3.setString(1, id);
			ResultSet rs = ps3.executeQuery();
			if(rs.next())
			{
				to = rs.getString(1);
			}
			sub = "ShowTime Ticket";
			msg = "Hi,\n Your seat "+se+" has been reserved for the movie '" +movie+ "'.\n Our address is \n ShowTime \n City Centre \n Salt Lake \n The movie starts at 8:00 pm. \n Please be 15 minutes before time for formalities.\n Thank You....";
			Mailer.send(to,sub,msg);
			
			
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
