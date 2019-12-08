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
 * Servlet implementation class CompanyStudentCancelRegistration
 */
@WebServlet("/CompanyStudentCancelRegistration")
public class CompanyStudentCancelRegistration extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String student_rollno = request.getParameter("student_rollno");
			
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
			
			sql = "delete from "+compName+" where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno+"_Apply");
			ps.execute();
			
			sql = "select count(*) from "+compName+" where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno+"_Qualified");
			rs = ps.executeQuery();
			while(rs.next())
			{
				if(Integer.parseInt(rs.getString(1)) >= 1)
				{
					sql = "delete from "+compName+" where id=?";
					ps = cn.prepareStatement(sql);
					ps.setString(1, student_rollno+"_Qualified");
					ps.execute();
				}
			}
			
			sql = "delete from STUDENT_"+student_rollno+" where rollno=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, compID+"_Apply");
			ps.execute();
			
			sql = "select count(*) from STUDENT_"+student_rollno+" where rollno=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, compID+"_Qualified");
			rs = ps.executeQuery();
			while(rs.next())
			{
				if(Integer.parseInt(rs.getString(1)) >= 1)
				{
					sql = "delete from STUDENT_"+student_rollno+" where rollno=?";
					ps = cn.prepareStatement(sql);
					ps.setString(1, compID+"_Qualified");
					ps.execute();
				}
			}
			
			sql = "select name from student where rollno=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno);
			rs = ps.executeQuery();
			String student_name="";
			while(rs.next())
			{
				student_name = rs.getString(1);
			}
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>The registration of <b><i>"+student_name+"</i></b> bearing Roll No. <b><i>"+student_rollno+"</i></b> has been successfully cancelled.</h1>");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
