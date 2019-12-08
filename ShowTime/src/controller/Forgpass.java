package controller;
import connector.*;
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

/**
 * Servlet implementation class Forgpass
 */
@WebServlet("/Forgpass")
public class Forgpass extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
		String id = request.getParameter("id");
		HttpSession ses = request.getSession();
		ses.setAttribute("id", id);
		String sql = "select question from booking where id=?";
		Connection cn = Db2Connector.getCn();
		PreparedStatement ps = cn.prepareStatement(sql);
		ps.setString(1, id);
		ResultSet rs = ps.executeQuery();
		PrintWriter out = response.getWriter();
		if(rs.next())
		{
			out.println("<h2 style='text-align: center; font-size:300%;color: yellow;'><i>Change Password</i></h2><br>");
			out.println("<h2 style='text-align:center;color:yellow;'>"+rs.getString(1)+"</h2>");
			RequestDispatcher rd = request.getRequestDispatcher("forgpass2.html");
			rd.include(request, response);
		}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
