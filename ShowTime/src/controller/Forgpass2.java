package controller;
import java.sql.*;
import connector.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Forgpass2
 */
@WebServlet("/Forgpass2")
public class Forgpass2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
		HttpSession ses = request.getSession(false);
		String id = (String)ses.getAttribute("id");
		String ans = request.getParameter("ans");
		String sql = "select answer from booking where id=?";
		Connection cn = Db2Connector.getCn();
		PreparedStatement ps = cn.prepareStatement(sql);
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();
		if(rs.next())
		{
			if(ans.equalsIgnoreCase(rs.getString(1)))
			{
				RequestDispatcher rd = request.getRequestDispatcher("forgpass3.html");
				rd.forward(request, response);
			}
			else
			{
				PrintWriter out = response.getWriter();
				out.println("<h2 style:'color:#FFFFFF'>You are not registered</font></h2>");
				RequestDispatcher rd = request.getRequestDispatcher("signup.html");
				rd.include(request, response);
			}
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
