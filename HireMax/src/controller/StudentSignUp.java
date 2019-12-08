package controller;
import connector.*;
import mymailer.Mailer;

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

/**
 * Servlet implementation class StudentSignUp
 */
@WebServlet("/StudentSignUp")
public class StudentSignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String name,roll,email,password;
			name = request.getParameter("studentName");
			roll = request.getParameter("studentRoll");
			email = request.getParameter("studentEmail");
			password = request.getParameter("password");
			
			String sql = "insert into student values(?,?,?,?)";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, roll);
			ps.setString(2, name);
			ps.setString(3, email);
			ps.setString(4, password);
			ps.execute();
			
			HttpSession studentRollNo = request.getSession();
			studentRollNo.setAttribute("studentRollNo", roll);
			
			sql = "create table "+"STUDENT_"+roll+"(rollno varchar(30) default '0',name varchar(30) default '0',ph_no varchar(10) default '0',gender varchar(10) default '0',branch varchar(40) default '0',dob varchar(15) default '0',"
					+ "hobby varchar(200) default '0',cgpa varchar(5) default '0',prog_lang varchar(200) default '0',"
					+ "image varchar(40) default '0',father_name varchar(30) default '0',father_occupation varchar(20) default '0',"
					+ "mother_name varchar(30) default '0',mother_occupation varchar(20) default '0',school_12 varchar(30) default '0',percent_12 varchar(5) default '0',city_12 varchar(20) default '0',board_12 varchar(10) default '0',"
					+ "achieve_12 varchar(100) default '0',school_10 varchar(30) default '0',percent_10 varchar(5) default '0',city_10 varchar(20) default '0',board_10 varchar(10) default '0',achieve_10 varchar(100) default '0',"
					+ "training varchar(400) default '0',internship varchar(400) default '0',social_service varchar(400) default '0',project varchar(400) default '0')";
			ps = cn.prepareStatement(sql);
			ps.execute();
			
			RequestDispatcher rd = request.getRequestDispatcher("studentSignSuccess.html");
			rd.forward(request, response);
			
			String to,sub,msg;
			to = email;
			sub = "Greetings from KIIT family";
			msg = "Congratulations...\n\n Your account has been confirmed. \n You can search through a wide variety of companies and apply for them. \n Happy Seaching.";
			Mailer.send(to, sub, msg);
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
