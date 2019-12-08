package controller;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SeatBook
 */
@WebServlet("/SeatBook")
public class SeatBook extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try{
		PrintWriter out = response.getWriter();
		System.out.println("hi");
		String seats[] = {"a"};
		seats = request.getParameterValues("seat");
		System.out.println("hi"+seats.length);
		if(!seats.length)
		{
			System.out.println("hi");
		}
		String se="";
		System.out.println("hi");
		for(String s:seats)
		{
			se = se + s +",";
		}
		System.out.println("hi"+se+"hi");
		HttpSession book = request.getSession();
		book.setAttribute("seats", se);
		
		HttpSession user = request.getSession(false);
		String id = (String)user.getAttribute("session");
		if(id.equals("") || id==null) /*null*/
		{
			HttpSession a = request.getSession();
			a.setAttribute("continu", "true");
			out.println("<h2 style='color:white;'>Please log in first..!!</h2>");
			RequestDispatcher rd = request.getRequestDispatcher("login.html");
			rd.include(request, response);
		}
		else
		{
			RequestDispatcher rd = request.getRequestDispatcher("payment.jsp");
			rd.include(request, response);
		}
		}
		catch(Exception e)
		{
			PrintWriter out = response.getWriter();
				out.println("<h2 style='color:white;'>Please select your seats..!!</h2>");
				RequestDispatcher rd = request.getRequestDispatcher("seats.jsp");
				rd.forward(request, response);
			
		}
	}

}
