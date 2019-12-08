package controller;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connector.Db2Connector;

/**
 * Servlet implementation class LogIn
 */
@WebServlet("/LogIn")
public class LogIn extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			PrintWriter out = response.getWriter();
			String id,password;
			id = request.getParameter("userid");
			password = request.getParameter("password");
			
			String sql = "select password from booking where id=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			
			HttpSession a = request.getSession(false);
			String cont = (String)a.getAttribute("continu"); /*To check if seat booking is in process*/
			
			if(rs.next())
			{
				if(password.equals(rs.getString(1)))
				{
					HttpSession user = request.getSession();
					user.setAttribute("session", id);
		
					if(cont.equalsIgnoreCase("true")) /*Continue with the payment*/ 
					{
						RequestDispatcher rd = request.getRequestDispatcher("payment.jsp");
						rd.forward(request, response);
					}
					if(cont.equals("") || cont==null)
					{
						RequestDispatcher rd = request.getRequestDispatcher("banner.html");
						rd.forward(request, response);
					}
				}
				else
				{
					RequestDispatcher rd = request.getRequestDispatcher("forgpass.jsp");
					rd.include(request, response);
					out.println("<h2><font color='yellow'>Incorrect Password..!!</font></h2>");
				}
			}
			else
			{
				RequestDispatcher rd = request.getRequestDispatcher("signup.html");
				rd.include(request, response);
				out.println("<h2><font color='yellow'>You are not a registered user..!!\nPlease Register</font></h2>");
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
