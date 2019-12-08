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
 * Servlet implementation class CompanyQualTest
 */
@WebServlet("/CompanyQualTest")
public class CompanyQualTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String minPerc,ques,op1,op2,op3,op4,ans;
			minPerc = request.getParameter("minPerc");
			ques = request.getParameter("question");
			op1 = request.getParameter("option1");
			op2 = request.getParameter("option2");
			op3 = request.getParameter("option3");
			op4 = request.getParameter("option4");
			ans = request.getParameter("answer");
			
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
			
			sql = "select count(*) from "+name+" where name=?";
			cn = Db2Connector.getCn();
			ps = cn.prepareStatement(sql);
			ps.setString(1, "QualTest");
			rs = ps.executeQuery();
			int count=0;
			while(rs.next())
			{
				count = Integer.parseInt(rs.getString(1));
			}
		
			if(count == 0)
			{
				sql = "insert into "+name+"(name,about,job_profile,skills,cgpa) values(?,?,?,?,?)";
				cn = Db2Connector.getCn();
				ps = cn.prepareStatement(sql);
				ps.setString(1, "QualTest");
				ps.setString(2, ques+"+"+ans);
				ps.setString(3, op1+"+"+op2);
				ps.setString(4, op3+"+"+op4);
				if(minPerc.equals(""))
				{
					ps.setString(5, "75");
				}
				else
				{
					ps.setString(5, minPerc);
				}
				ps.execute(); 
				RequestDispatcher rd = request.getRequestDispatcher("companyQualTest.jsp");
				rd.forward(request, response);
				return;
			}
			
			if(ques.equals("") && (! minPerc.equals("")))
			{
				sql = "update "+name+" set cgpa=? where name=?";
				cn = Db2Connector.getCn();
				ps = cn.prepareStatement(sql);
				ps.setString(1, minPerc);
				ps.setString(2, "QualTest");
				ps.execute();
				
				RequestDispatcher rd = request.getRequestDispatcher("companyQualTest.jsp");
				rd.forward(request, response);
				return;
			}
			
			if((! ques.equals("")) && minPerc.equals(""))
			{
				sql = "select cgpa from "+name+" where name=?";
				cn = Db2Connector.getCn();
				ps = cn.prepareStatement(sql);
				ps.setString(1, "QualTest");
				rs = ps.executeQuery();
				while(rs.next())
				{
					minPerc = rs.getString(1);
					break;
				}
				
				sql = "insert into "+name+"(name,about,job_profile,skills,cgpa) values(?,?,?,?,?)";
				cn = Db2Connector.getCn();
				ps = cn.prepareStatement(sql);
				ps.setString(1, "QualTest");
				ps.setString(2, ques+"+"+ans);
				ps.setString(3, op1+"+"+op2);
				ps.setString(4, op3+"+"+op4);
				ps.setString(5, minPerc);
				ps.execute();
				
				RequestDispatcher rd = request.getRequestDispatcher("companyQualTest.jsp");
				rd.forward(request, response);
				return;
			}
			
			sql = "insert into "+name+"(name,about,job_profile,skills,cgpa) values(?,?,?,?,?)";
			cn = Db2Connector.getCn();
			ps = cn.prepareStatement(sql);
			ps.setString(1, "QualTest");
			ps.setString(2, ques+"+"+ans);
			ps.setString(3, op1+"+"+op2);
			ps.setString(4, op3+"+"+op4);
			ps.setString(5, "75");
			ps.execute();
			
			if(! minPerc.equals(""))
			{
				sql = "update "+name+" set cgpa=? where name=?";
				cn = Db2Connector.getCn();
				ps = cn.prepareStatement(sql);
				ps.setString(1, minPerc);
				ps.setString(2, "QualTest");
				ps.execute();
			}
			
			RequestDispatcher rd = request.getRequestDispatcher("companyQualTest.jsp");
			rd.forward(request, response);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
