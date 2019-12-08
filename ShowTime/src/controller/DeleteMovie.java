package controller;
import java.sql.*;
import connector.*;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteMovie
 */
@WebServlet("/DeleteMovie")
public class DeleteMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			Connection cn = Db2Connector.getCn();
			String id=request.getParameter("token");
			int num=Integer.parseInt(id);
			String sql = "select * from movies";
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			for (int i = 1; i <=num ; i++)
			{
				rs.next();
			}
			String name = rs.getString(1);
			sql = "delete from movies where name=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, name);
			ps.execute();
			
			sql = "drop table "+name.replace(" ", "_");
			ps = cn.prepareStatement(sql);
			ps.execute();
			
			RequestDispatcher rd = request.getRequestDispatcher("delmovie.jsp");
			rd.include(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
