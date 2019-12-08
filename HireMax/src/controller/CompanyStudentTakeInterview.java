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
 * Servlet implementation class CompanyStudentTakeInterview
 */
@WebServlet("/CompanyStudentTakeInterview")
public class CompanyStudentTakeInterview extends HttpServlet {
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
			
			String remarks = request.getParameter("remarks");
			remarks = (remarks.equals("")?"NIL":remarks);
			
			HttpSession studentRollNo = request.getSession(false);
			String student_rollno  = (String)studentRollNo.getAttribute("studentRollNo");
			
			String sql = "select name from student where rollno=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, student_rollno);
			ResultSet rs = ps.executeQuery();
			String student_name="";
			while(rs.next())
			{
				student_name = rs.getString(1);
			}
			
			sql = "select name from company where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, compID);
			rs = ps.executeQuery();
			String compName="";
			while(rs.next())
			{
				compName = rs.getString(1);
			}
			
			sql = "select count(*) from "+compName+" where name=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, "Criteria");
			rs = ps.executeQuery();
			int count=0;
			while(rs.next())
			{
				count = Integer.parseInt(rs.getString(1));
			}
			
			int i,total_rating=0;
			int rating[] = new int[count];
			for(i=1 ; i<=count ; i++)
			{
				/*rating[i-1] = Integer.parseInt(request.getParameter("rating"+i));*/
				rating[i-1] = Integer.parseInt(request.getParameter("rating"));
				total_rating = total_rating + rating[i-1];
			}
			
			sql = "select cgpa,revenue from "+compName+" where name=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, "Criteria");
			rs = ps.executeQuery();
			i=0;
			int temp=0,full_rating=0;
			while(rs.next())
			{
				full_rating = full_rating + Integer.parseInt(rs.getString(2)); 
				if(rating[i] < Integer.parseInt(rs.getString(1)))
				{
					temp = 1;
				}
			}
			if(temp==0)
			{
				sql = "insert into STUDENT_"+student_rollno+" (rollno,name,branch,hobby,training,ph_no) values(?,?,?,?,?,?)";
				ps = cn.prepareStatement(sql);
				ps.setString(1, compID+"_Selected");
				ps.setString(2, compName);
				ps.setString(3, compID);
				ps.setString(4, "Selected");
				ps.setString(5, remarks);
				ps.setString(6, total_rating+" / "+full_rating);
				ps.execute();
				
				sql = "insert into "+compName+" (id,name,about,ceo,skills,type) values(?,?,?,?,?,?)";
				ps = cn.prepareStatement(sql);
				ps.setString(1, student_rollno+"_Selected");
				ps.setString(2, "Selected");
				ps.setString(3, student_rollno);
				ps.setString(4, student_name);
				ps.setString(5, remarks);
				ps.setString(6, total_rating+" / "+full_rating);
				ps.execute();
			}
			
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>Personal Interview of <b><i>"+student_name+"</i></b> bearing Roll No. <b><i>"+student_rollno+"</i></b> has been successfully recorded.</h1>");
			
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
