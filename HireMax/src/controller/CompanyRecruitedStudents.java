package controller;
import connector.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class CompanyRecruitedStudents
 */
@WebServlet("/CompanyRecruitedStudents")
public class CompanyRecruitedStudents extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			HttpSession companyID = request.getSession(false);
			String compID = (String)companyID.getAttribute("companyID");
			
			String sql = "select name from company where id=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, compID);
			ResultSet rs = ps.executeQuery();
			String compName="";
			while(rs.next())
			{
				compName = rs.getString(1);
			}
			
			sql = "select about from "+compName+" where name=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, "Recruited");
			rs = ps.executeQuery();
			String student_rollno="";
			while(rs.next())
			{
				student_rollno = rs.getString(1);
				
				String sql2 = "insert into STUDENT_"+student_rollno+" (rollno,name,branch,hobby) values(?,?,?,?)";
				PreparedStatement ps2 = cn.prepareStatement(sql2);
				ps2.setString(1, compID+"_Recruited");
				ps2.setString(2, compName);
				ps2.setString(3, compID);
				ps2.setString(4, "Recruited");
				ps2.execute();
			}
			
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>The recruit of <b><i>"+compName+"</i></b> has been finalised and published.</h1>");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
