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

import org.apache.catalina.connector.Response;

/**
 * Servlet implementation class CompanySelectedStudents
 */
@WebServlet("/CompanySelectedStudents")
public class CompanySelectedStudents extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String compName="",compID;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		try
		{
			PrintWriter out = response.getWriter();
			
			HttpSession companyID = request.getSession(false);
			compID = (String)companyID.getAttribute("companyID");
			
			String sql = "select name from company where id=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, compID);
			ResultSet rs = ps.executeQuery();
			while(rs.next())
			{
				compName = rs.getString(1);
			}
			
			sql = "select count(*) from "+compName+" where name=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, "Selected");
			rs = ps.executeQuery();
			int size=0;
			while(rs.next())
			{
				size = Integer.parseInt(rs.getString(1));
			}
			
			sql = "select est_recruit from "+compName+" where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, compID);
			rs = ps.executeQuery();
			int est_recruit=0;
			while(rs.next())
			{
				est_recruit = Integer.parseInt(rs.getString(1));
				if(size <= est_recruit)
				{
					recruit_all();
					out.println("<h1 style='color:white;text-align:center;font-size:50px;'><b><i>The final recruit list for "+compName+" has been published.</i></b></h1>");
					return;
				}
			}
			
			int data[][] = new int[size][6];
			int i=-1,j=0;
			
			sql = "select about,type from "+compName+" where name=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, "Selected");
			rs = ps.executeQuery();
			String pi="";
			int num=0,den=0,piperc=0,qualperc=0;
			double m;
			String student_rollno="";
			while(rs.next())
			{
				m=0;
				i++;
				j=0;
				student_rollno = rs.getString(1);
				data[i][j++] = Integer.parseInt(student_rollno); //Roll No.
						
				pi = rs.getString(2);
				num = Integer.parseInt(pi.substring(0,pi.indexOf('/')-1));
				den = Integer.parseInt(pi.substring(pi.indexOf('/')+2));
				piperc = (Integer)(num*100)/den;
				data[i][j++] = piperc; //PI Rating percentage
				m = m + piperc;
				
				String sql2 = "select type from "+compName+" where id=?";
				PreparedStatement ps2 = cn.prepareStatement(sql2);
				ps2.setString(1, student_rollno+"_Apply");
				ResultSet rs2 = ps2.executeQuery();
				while(rs2.next())
				{
					String qual = rs2.getString(1);
					num = Integer.parseInt(qual.substring(0,qual.indexOf('/')));
					den = Integer.parseInt(qual.substring(qual.indexOf('/')+1));
					qualperc = (Integer)(num*100)/den;
				}
				data[i][j++] = qualperc; //Qualifying percentage
				m = m + qualperc;
				
				sql2 = "select cgpa,percent_12,percent_10 from STUDENT_"+student_rollno+" where rollno=?";
				ps2 = cn.prepareStatement(sql2);
				ps2.setString(1, student_rollno);
				rs2 = ps2.executeQuery();
				while(rs2.next())
				{
					data[i][j] = Integer.parseInt(rs2.getString(1))*10; //CGPA
					m = m + data[i][j++];
					data[i][j] = (Integer.parseInt(rs2.getString(2))+Integer.parseInt(rs2.getString(3)))/2; //Class 12 & 10 %
					m = m + data[i][j++];
				}
				
				m = m/4;
				data[i][j] = (int)Math.sqrt(((m-data[i][1])*(m-data[i][1]) + (m-data[i][2])*(m-data[i][2]) +
							            (m-data[i][3])*(m-data[i][3]) + (m-data[i][4])*(m-data[i][4]))/4);
			
			}
			
			recruit_best(data,size);
			
			for(i=0 ; i<est_recruit ; i++)
			{
				student_rollno = String.valueOf(data[i][0]);
				
				String sql2 = "insert into STUDENT_"+student_rollno+" (hobby,branch,name,rollno) values(?,?,?,?)";
				PreparedStatement ps2 = cn.prepareStatement(sql2);
				ps2.setString(1, "Recruited");
				ps2.setString(2, compID);
				ps2.setString(3, compName);
				ps2.setString(4, compID+"_Recruited");
				ps2.execute();
				
				String sql3 = "insert into "+compName+" (id,name,about) values(?,?,?)";
				PreparedStatement ps3 = cn.prepareStatement(sql3);
				ps3.setString(1, student_rollno+"_Recruited");
				ps3.setString(2, "Recruited");
				ps3.setString(3, student_rollno);
				ps3.execute();
			}
			
			sql = "update "+compName+" set recruited=? where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, String.valueOf(est_recruit));
			ps.setString(2, compID);
			ps.execute();
			
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'><b><i>The final recruit list for "+compName+" has been published.</h1>");
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
	void recruit_all()
	{
		try
		{
			String sql = "select about from "+compName+" where name=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, "Selected");
			ResultSet rs = ps.executeQuery();
			String student_rollno="";
			int count=0;
			while(rs.next())
			{
				count++;
				student_rollno = rs.getString(1);
				
				String sql2 = "insert into STUDENT_"+student_rollno+" (hobby,branch,name,rollno) values(?,?,?,?)";
				PreparedStatement ps2 = cn.prepareStatement(sql2);
				ps2.setString(1, "Recruited");
				ps2.setString(2, compID);
				ps2.setString(3, compName);
				ps2.setString(4, compID+"_Recruited");
				ps2.execute();
				
				String sql3 = "insert into "+compName+" (id,name,about) values(?,?,?)";
				PreparedStatement ps3 = cn.prepareStatement(sql3);
				ps3.setString(1, student_rollno+"_Recruited");
				ps3.setString(2, "Recruited");
				ps3.setString(3, student_rollno);
				ps3.execute();
				
				
			}
			
			sql = "update "+compName+" set recruited=? where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, String.valueOf(count));
			ps.setString(2, compID);
			ps.execute();
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
	void recruit_best(int data[][],int size)
	{
		try
		{
			int i,j,temp;
			for(i=0 ; i<size-1 ; i++)
			{
				for(j=0 ; j<size-1 ; j++)
				{
					if(data[j][5] < data[j+1][5])
					{
						temp = data[j][0];
						data[j][0] = data[j+1][0];
						data[j+1][0] = temp;
						
						temp = data[j][5];
						data[j][5] = data[j+1][5];
						data[j+1][5] = temp;
					}	
				}
			}
			for(i=0 ; i<size ; i++)
			{
				System.out.println(data[i][0]+" "+data[i][5]);
			}
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
	

}
