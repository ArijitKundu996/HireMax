package controller;
import connector.*;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Forgpass3
 */
@WebServlet("/Forgpass3")
public class Forgpass3 extends HttpServlet {
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
			String pass = request.getParameter("pass");
			String sql = "update booking set password=? where id=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, pass);
			ps.setString(2, id);
			ps.execute();
			PrintWriter out = response.getWriter();
			out.print("<h2 style='font-size:300%;color: white;'><i>Password changed successfully</i></h2><br>");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
