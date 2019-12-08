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
 * Servlet implementation class StudentLogin
 */
@WebServlet("/StudentLogin")
public class StudentLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String roll,password;
			roll = request.getParameter("rollno");
			password = request.getParameter("password");
			
			String sql = "select rollno,password from student";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				if(roll.equalsIgnoreCase(rs.getString(1)) && password.equalsIgnoreCase(rs.getString(2)))
				{
					HttpSession studentRollNo = request.getSession();
					studentRollNo.setAttribute("studentRollNo", roll);
					RequestDispatcher rd = request.getRequestDispatcher("studentHome.jsp");
					rd.forward(request, response);
				}
			}
			PrintWriter out = response.getWriter();
			out.println("<h2><font color='red'>Invalid Login Details..!!</font></h2>");
			RequestDispatcher rd2 = request.getRequestDispatcher("studentLogin.html");
			rd2.include(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
