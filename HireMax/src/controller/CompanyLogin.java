package controller;
import connector.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CompanyLogin
 */
@WebServlet("/CompanyLogin")
public class CompanyLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String id,password;
			id = request.getParameter("companyid");
			password = request.getParameter("password");
			
			String sql = "select id,password from company";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				if(id.equalsIgnoreCase(rs.getString(1)) && password.equalsIgnoreCase(rs.getString(2)))
				{
					HttpSession companyID = request.getSession();
					companyID.setAttribute("companyID", id);
					RequestDispatcher rd = request.getRequestDispatcher("companyHome.jsp");
					rd.forward(request, response);
				}
			}
			PrintWriter out = response.getWriter();
			out.println("<h2><font color='red'>Invalid Login Details..!!</font></h2>");
			RequestDispatcher rd2 = request.getRequestDispatcher("companyLogin.html");
			rd2.include(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
