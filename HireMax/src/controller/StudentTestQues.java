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
 * Servlet implementation class StudentTestQues
 */
@WebServlet("/StudentTestQues")
public class StudentTestQues extends HttpServlet {
	private static final long serialVersionUID = 1L;
	int index;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{	
			String answer[] = {"a"};
			answer = request.getParameterValues("ans");
			String ans="";
			for(String s:answer)
			{
				ans = ans + s +",";
			}
			
			HttpSession studentRollNo = request.getSession(false);
			String student_rollno = (String)studentRollNo.getAttribute("studentRollNo");
			
			HttpSession companyDetails = request.getSession(false);
			String compDetails = (String)studentRollNo.getAttribute("companyDetails");
			String compName = compDetails.substring(0,compDetails.indexOf(','));
			String compID = compDetails.substring(compDetails.indexOf(',')+1);
			
			String sql = "select about,cgpa from "+compName+" where name=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, "QualTest");
			ResultSet rs = ps.executeQuery();
			int total=0,correct=0;
			String correct_ans="",ans2="",str="";
			index=0;
			double minPerc=0,count=0,perc=0;
			while(rs.next())
			{
				if(count==0)
				{
					minPerc = Double.parseDouble(rs.getString(2));
					count++;
				}
				str = rs.getString(1);
				correct_ans = str.substring(str.indexOf('+')+1);
				ans2 = getAnswer(ans);
				total++;
				if(ans2.equalsIgnoreCase(correct_ans))
				{
					correct++;
				}
			}
			
			sql = "update STUDENT_"+student_rollno+" set ph_no=? where rollno=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, correct+"/"+total);
			ps.setString(2, compID+"_Apply");
			ps.execute();
			
			sql = "update "+compName+" set type=? where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, correct+"/"+total);
			ps.setString(2, student_rollno+"_Apply");
			ps.execute();
			
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>Qualifying test for "+compName+" successfully submitted.</h1>");
			
			perc = (correct*100)/total;
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'><i>You scored "+perc+" % while the minimum qualifying percentage set by "+compName+" is "+minPerc+" %.</i></h1>");
			if(perc >= minPerc)
			{
				sql = "insert into "+compName+" (id,name,about) values(?,?,?)";
				ps = cn.prepareStatement(sql);
				ps.setString(1, student_rollno+"_Qualified");
				ps.setString(2, "Qualified");
				ps.setString(3, student_rollno);
				ps.execute();
				
				sql = "insert into STUDENT_"+student_rollno+" (rollno,name,branch,hobby) values(?,?,?,?)";
				ps = cn.prepareStatement(sql);
				ps.setString(1, compID+"_Qualified");
				ps.setString(2, compName);
				ps.setString(3, compID);
				ps.setString(4, "Qualified");
				ps.execute();
				
				out.println("<h1 style='color:white;text-align:center;font-size:50px;'>CONGRATULATIONS...<br>You have been qualified for "+compName+".</h1>");
				return;
			}
			
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>SORRY...You did not qualify for "+compName+".</h1>");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
	String getAnswer(String ans)
	{
		String ans2="";
		int i;
		for(i=index ; i<ans.length() ; i++)
		{
			if(ans.charAt(i) == ',')
			{
				break;
			}
			ans2 = ans2 + ans.charAt(i);
		}
		index = i+1;
		return ans2;
	}
}
