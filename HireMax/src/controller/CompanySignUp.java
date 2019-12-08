package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connector.Db2Connector;
import mymailer.Mailer;

/**
 * Servlet implementation class CompanySignUp
 */
@WebServlet("/CompanySignUp")
public class CompanySignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String name,email,id,password;
			name = request.getParameter("companyName");
			email = request.getParameter("companyEmail");
			id = request.getParameter("companyID");
			password = request.getParameter("password");
					
			String sql = "insert into company values(?,?,?,?)";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, name);
			ps.setString(3, email);
			ps.setString(4, password);
			ps.execute();
			
			String name2 = name+" ";
			name2 = name2.substring(0,name2.indexOf(' '));
			sql = "create table "+name2+"(id varchar(30) default '0',name varchar(30) default '0',type varchar(20) default '0',founded varchar(5) default '0',ceo varchar(20) default '0',headquarter varchar(20) default '0',area_served varchar(20) default '0',revenue varchar(10) default '0',no_of_emp varchar(10) default '0',website varchar(20) default '0',about varchar(1000) default '0',logo varchar(30) default '0',est_recruit varchar(10) default '0',recruited varchar(10) default '0',job_profile varchar(300) default '0',job_pos varchar(30) default '0',ctc varchar(10) default '0',skills varchar(300) default '0',cgpa varchar(5) default '0')";
			ps = cn.prepareStatement(sql);
			ps.execute();
					
			sql = "insert into "+name2+"(id,name) values(?,?)";
			ps = cn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, name);
			ps.execute();
			
			HttpSession companyID = request.getSession();
			companyID.setAttribute("companyID", id);
			
			RequestDispatcher rd = request.getRequestDispatcher("companySignSuccess.html");
			rd.forward(request, response);
			
			String to,sub,msg;
			to = email;
			sub = "Greetings from KIIT family";
			msg = "Congratulations for a being a part of KIIT f2amily.\n\n We are extremely happy that you have become our official recruiter.\n\n We hope that you will find the best of the talents with us that can shape the bright future of your company.";
			Mailer.send(to, sub, msg);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
