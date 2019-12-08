package controller;
import connector.*;

import java.io.IOException;
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
 * Servlet implementation class CompanyQualTestDelete
 */
@WebServlet("/CompanyQualTestDelete")
public class CompanyQualTestDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String token = request.getParameter("token");
			int num = Integer.parseInt(token);
			
			HttpSession companyID = request.getSession(false);
			String id = (String)companyID.getAttribute("companyID");
			
			String sql = "select name from company where id=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, id);
			ResultSet rs = ps.executeQuery();
			String name="";
			while(rs.next())
			{
				name = rs.getString(1);
			}
			
			sql = "select about from "+name+" where name=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, "QualTest");
			rs = ps.executeQuery();
			for (int i = 1; i < num+1; i++)
			{
				rs.next();
			}
			
			sql = "delete from "+name+" where about=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, rs.getString(1));
			ps.execute();
					
			RequestDispatcher rd = request.getRequestDispatcher("companyQualTest.jsp");
			rd.include(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
