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
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
			Connection cn = Db2Connector.getCn();
			String id=request.getParameter("token");
			int num=Integer.parseInt(id);
			String sql = "select * from booking";
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			for (int i = 1; i < num+1; i++)
			{
				rs.next();
			}
			String id1 = rs.getString(1);
			String sql1="delete  from booking where id=?";
			PreparedStatement ps1 = cn.prepareStatement(sql1);
			ps1.setString(1, id1);
			ps1.execute();
			RequestDispatcher rd = request.getRequestDispatcher("handle.jsp");
			rd.include(request, response);
		} 
		catch (Exception e)
		{
			System.out.println(e);
		}	
	}
}
