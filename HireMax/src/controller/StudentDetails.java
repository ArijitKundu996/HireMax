package controller;
import connector.*;
import javax.servlet.annotation.MultipartConfig; /*Needs to be present*/

import java.io.File;
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
import javax.servlet.http.Part;

/**
 * Servlet implementation class StudentDetails
 */
@WebServlet("/StudentDetails")
@MultipartConfig(fileSizeThreshold=1024*1021*2,maxFileSize=1024*1024*10,maxRequestSize=1024*1024*50) /*Annotation*/
public class StudentDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR="Student";

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String imgpath = null;
		try
		{
			HttpSession studentRollNo = request.getSession(false);
			String rollno = (String)studentRollNo.getAttribute("studentRollNo");
			
			String ph,gender,branch,dob,cgpa,prog_lang,hobby,father_name,father_occupation,mother_name,mother_occupation,
				   school_12,percent_12,board_12,city_12,achieve_12,school_10,percent_10,board_10,city_10,achieve_10,
			       training,internship,social_service,project;
			ph = request.getParameter("ph");
			gender = request.getParameter("gender");
			branch = request.getParameter("branch");
			dob = request.getParameter("dob");
			cgpa = request.getParameter("cgpa");
			prog_lang = request.getParameter("languages");
			hobby = request.getParameter("hobby");
			father_name = request.getParameter("father_name");
			father_occupation = request.getParameter("father_occupation");
			mother_name = request.getParameter("mother_name");
			mother_occupation = request.getParameter("mother_occupation");
			school_12 = request.getParameter("school_12");
			percent_12 = request.getParameter("percent_12");
			board_12 = request.getParameter("board_12");
			city_12 = request.getParameter("city_12");
			achieve_12 = request.getParameter("achieve_12");
			school_10 = request.getParameter("school_10");
			percent_10 = request.getParameter("percent_10");
			board_10 = request.getParameter("board_10");
			city_10 = request.getParameter("city_10");
			achieve_10 = request.getParameter("achieve_10");
			training = request.getParameter("training");
			internship = request.getParameter("internship");
			social_service = request.getParameter("social_service");
			project = request.getParameter("project");
			
			achieve_12 = achieve_12.equals("") ? "NIL":achieve_12;
			achieve_10 = achieve_10.equals("") ? "NIL":achieve_10;
			training = training.equals("") ? "NIL":training;
			internship = internship.equals("") ? "NIL":internship;
			social_service = social_service.equals("") ? "NIL":social_service;
			project = project.equals("") ? "NIL":project;
			
			String filepath = "D:"+File.separator+"Advanced JAVA"+File.separator+"HireMax"+File.separator+"WebContent"+File.separator+SAVE_DIR;
			File directory = new File(filepath);
			if(!directory.exists())
			{
				directory.mkdir();
			}
			Part part = request.getPart("image");
			String path = extractpath(part);
			String filename = path.substring(path.lastIndexOf("\\")+1,path.length());
			imgpath = filepath+File.separator+filename;
			part.write(imgpath);
			
			/*Google Chrome cannot show images in html(local resources) for security purposes. But it can be sorted 
			if we change the absolute path of the image into its corresponding relative path. Then it will show.*/
			String imgname,s,foldername,relpath;
			imgname = imgpath.substring(imgpath.lastIndexOf("\\")+1);  /*Ex- abc.jpg will be obtained*/
			s = imgpath.substring(0,imgpath.lastIndexOf("\\"));
			foldername = s.substring(s.lastIndexOf("\\")+1);  /*The folder in which the image is stored*/
			relpath = foldername+File.separator+imgname;  /*The relative path of image is obtained*/
			
			String sql = "select name from student where rollno=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, rollno);
			ResultSet rs = ps.executeQuery();
			String name="";
			while(rs.next())
			{
				name = rs.getString(1);
			}
			
			String sql2 = "insert into STUDENT_"+rollno+" values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps2 = cn.prepareStatement(sql2);
			ps2.setString(1, rollno);
			ps2.setString(2, name);
			ps2.setString(3, ph);
			ps2.setString(4, gender);
			ps2.setString(5, branch);
			ps2.setString(6, dob);
			ps2.setString(7, hobby);
			ps2.setString(8, cgpa);
			ps2.setString(9, prog_lang);
			ps2.setString(10,relpath);
			ps2.setString(11,father_name);
			ps2.setString(12,father_occupation);
			ps2.setString(13,mother_name);
			ps2.setString(14,mother_occupation);
			ps2.setString(15,school_12);
			ps2.setString(16,percent_12);
			ps2.setString(17,city_12);
			ps2.setString(18,board_12);
			ps2.setString(19,achieve_12);
			ps2.setString(20,school_10);
			ps2.setString(21,percent_10);
			ps2.setString(22,city_10);
			ps2.setString(23,board_10);
			ps2.setString(24,achieve_10);
			ps2.setString(25,training);
			ps2.setString(26,internship);
			ps2.setString(27,social_service);
			ps2.setString(28,project);
			ps2.execute();
			
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>Your details have been saved successfully.</h1>");
			
		}
		catch(Exception e)
		{
			System.out.println(e);
		}
	}
	private String extractpath(Part part)
	{
		String content_dis = part.getHeader("Content-Disposition");
		String items[] = content_dis.split(";");
		for(String x:items)
		{
			if(x.trim().startsWith("filename"))
			{
				return x.substring(x.indexOf("=")+2,x.length()-1);
			}
		}
		return null; /*Initial return*/
		
	}

}
