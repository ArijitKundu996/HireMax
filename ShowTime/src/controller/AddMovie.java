package controller;
import java.sql.*;
import connector.*;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddMovie
 */
@WebServlet("/AddMovie")
public class AddMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			String name = request.getParameter("movie");
			String lang = request.getParameter("lang");
			name = name.trim();
			String tab_name = name.replace(" ","_");
			String sql = "create table "+tab_name+"(seatid varchar(10)not null,status varchar(10)not null,synopsis varchar(1000),lead_cast varchar(100),image varchar(100))";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.execute();

			sql = "insert into movies values(?,?)";
			ps = cn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setString(2, lang);
			ps.execute();
			
			int n=1,i;
			char ch='A';
			for(i=1 ; i<=60 ; i++)
			{
				if(ch=='G')
				{
					n++;
					ch='A';
				}
				String s = n+""+ch;
				ch++;
				sql = "insert into "+tab_name+"(seatid,status) values(?,?)";
				ps = cn.prepareStatement(sql);
				ps.setString(1, s);
				ps.setString(2, "0");
				ps.execute();
			}
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center;'>Movie added successfully</h1>");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}

}
