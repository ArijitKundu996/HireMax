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

/**
 * Servlet implementation class ClearMovie
 */
@WebServlet("/ClearMovie")
public class ClearMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String id = request.getParameter("token");
			int num = Integer.parseInt(id);
			String sql = "select * from movies";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			for (int i = 1; i <=num ; i++)
			{
				rs.next();
			}
			String movie = rs.getString(1);
			sql = "update " +movie.replace(" ","_")+ " set status=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, "0");
			ps.execute();
			PrintWriter out = response.getWriter();
			out.println("Seats Cleared for "+movie);
			RequestDispatcher rd = request.getRequestDispatcher("clearmovie.jsp");
			rd.include(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
