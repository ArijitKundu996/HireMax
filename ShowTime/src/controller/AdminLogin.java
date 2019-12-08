package controller;
import java.sql.*;
import connector.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connector.Db2Connector;

/**
 * Servlet implementation class AdminLogin
 */
@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			PrintWriter out = response.getWriter();
			String id = request.getParameter("adid");
			String pass = request.getParameter("password");
			String sql = "select password from admin where id=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			if(rs.next())
			{
				if(pass.equals(rs.getString(1)))
				{
					HttpSession admin = request.getSession();
					admin.setAttribute("adid", id);
					RequestDispatcher rd = request.getRequestDispatcher("adminhome.html");
					rd.forward(request, response);
				}
				else
				{
					out.println("<h2><font color='white'>Incorrect Password</font></h2>");
				}
			}
			else
			{
				out.println("<h2 style='text-align:center;color:white;'>Sorry..you don't seem like our admin member</h2>");
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
