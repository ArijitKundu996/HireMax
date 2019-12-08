package controller;
import connector.*;
import mymailer.Mailer;

import java.sql.*;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignUp
 */
@WebServlet("/SignUp")
public class SignUp extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String name,email,mob,password,ques2="",ans,userid=""; 
			name = request.getParameter("fn");
			email = request.getParameter("email");
			mob = request.getParameter("mob");
			password = request.getParameter("password");
			ques2 = request.getParameter("question");
			ans = request.getParameter("ans");
			userid = userid + name.toLowerCase().charAt(0) + ((int)(Math.random()*1000));
						
			String sql = "insert into booking values(?,?,?,?,?,?,?,?,?)";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, userid);
			ps.setString(2, name);
			ps.setString(3, email);
			ps.setString(4, mob);
			ps.setString(5, password);
			ps.setString(6, ques2);
			ps.setString(7, ans);
			ps.setString(8, "");
			ps.setString(9, "");
			ps.execute();
			
			RequestDispatcher rd = request.getRequestDispatcher("signsuccess.html");
			rd.forward(request,response);
			
			String to,sub,msg;
			to = email;
			sub = "ShowTime";
			msg = "Hi "+name+",\n You have successfully registered on our website.\nYour unique USER ID is "+userid+".\nHoping that you'll have wonderful time ahead with us.";
			Mailer.send(to,sub,msg);

			
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
