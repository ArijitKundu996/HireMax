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
 * Servlet implementation class CompanyCriteria
 */
@WebServlet("/CompanyCriteria")
public class CompanyCriteria extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String criteria,rating,qualRating;
			criteria = request.getParameter("criteria");
			rating = request.getParameter("rating");
			qualRating = request.getParameter("qualRating");
			
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
			
			String sql2 = "insert into "+name+"(name,about,revenue,cgpa) values(?,?,?,?)";
			PreparedStatement ps2 = cn.prepareStatement(sql2);
			ps2.setString(1, "Criteria");
			ps2.setString(2, criteria);
			ps2.setString(3, rating);
			ps2.setString(4, qualRating);
			ps2.execute();
			
			RequestDispatcher rd = request.getRequestDispatcher("companyCriteria.jsp");
			rd.forward(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
