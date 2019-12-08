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
 * Servlet implementation class StudentCompanyApply
 */
@WebServlet("/StudentCompanyApply")
public class StudentCompanyApply extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			PrintWriter out = response.getWriter();
			
			String companyDetails = request.getParameter("companyDetails");
			String companyName,companyID;
			companyName = companyDetails.substring(0,companyDetails.indexOf(','));
			companyID = companyDetails.substring(companyDetails.indexOf(',')+1);
			
			HttpSession studentRollNo = request.getSession(false);
			String student_rollno = (String)studentRollNo.getAttribute("studentRollNo");
			
			String sql = "select count(*) from STUDENT_"+student_rollno+" where rollno=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				if(Integer.parseInt(rs.getString(1)) <= 0)
				{
					out.println("<h1 style='color:white;text-align:center;font-size:50px;'>Please add your details before applying for company.</h1>");
					return;
				}
			}
			
			sql = "select about from "+companyName+" where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno+"_Apply");
			rs = ps.executeQuery();
			while(rs.next())
			{
				if(Integer.parseInt(student_rollno) == Integer.parseInt(rs.getString(1)))
				{
					out.println("<h1 style='color:white;text-align:center;font-size:50px;'>You have already applied for "+companyName+".</h1>");
					return;
				}
			}
			
			sql = "select est_recruit,recruited,cgpa from "+companyName+" where id=?";
			cn = Db2Connector.getCn();
			ps = cn.prepareStatement(sql);
			ps.setString(1, companyID);
			rs = ps.executeQuery();
			double compcgpa=0;
			while(rs.next())
			{
				compcgpa = Double.parseDouble(rs.getString(3));
				if(Integer.parseInt(rs.getString(2)) >= Integer.parseInt(rs.getString(1)))
				{
					out.println("<h1 style='color:white;text-align:center;font-size:50px;'>"+companyName+" has finished with its recruiting.</h1>");
					return;
				}
			}
			
			sql = "select cgpa,name from STUDENT_"+student_rollno+" where rollno=?";
			cn = Db2Connector.getCn();
			ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno);
			rs = ps.executeQuery();
			double studentcgpa=0;
			String studentName="";
			while(rs.next())
			{
				studentName = rs.getString(2); 
				studentcgpa = Double.parseDouble(rs.getString(1));
			}
			
			if(studentcgpa < compcgpa)
			{
				out.println("<h1 style='color:white;text-align:center;font-size:50px;'>Your CGPA does not satisfy the min CGPA criteria of "+companyName+"</h1>");
				return;
			}
			
			sql = "insert into "+companyName+" (id,name,about,ceo) values(?,?,?,?)";
			cn = Db2Connector.getCn();
			ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno+"_Apply");
			ps.setString(2, "Apply");
			ps.setString(3, student_rollno);
			ps.setString(4, studentName);
			ps.execute();
			
			sql = "insert into STUDENT_"+student_rollno+" (rollno,name,hobby,branch) values(?,?,?,?)";
			cn = Db2Connector.getCn();
			ps = cn.prepareStatement(sql);
			ps.setString(1, companyID+"_Apply");
			ps.setString(2, companyName);
			ps.setString(3, "Apply");
			ps.setString(4, companyID);
			ps.execute();
			
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>You have successfully applied for "+companyName+".</h1>");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
