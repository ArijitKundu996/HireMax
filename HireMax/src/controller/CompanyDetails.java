package controller;
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

import connector.Db2Connector;

/**
 * Servlet implementation class CompanyDetails
 */
@WebServlet("/CompanyDetails")
@MultipartConfig(fileSizeThreshold=1024*1021*2,maxFileSize=1024*1024*10,maxRequestSize=1024*1024*50) /*Annotation*/
public class CompanyDetails extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR="CompanyLogo";

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String imgpath = null;
		try
		{
			String type,founded,ceo,headquarter,area,revenue,emp_no,website,about,est_recruit,job_profile,job_pos,ctc,cgpa,skills;
			type = request.getParameter("companyType");
			founded = request.getParameter("founded");
			ceo = request.getParameter("ceo");
			headquarter = request.getParameter("headquarter");
			area = request.getParameter("area");
			revenue = request.getParameter("revenue");
			emp_no = request.getParameter("emp_no");
			website = request.getParameter("website");
			about = request.getParameter("about");
			est_recruit = request.getParameter("est_recruit");
			job_profile = request.getParameter("job_profile");
			job_pos = request.getParameter("job_pos");
			ctc = request.getParameter("ctc");
			cgpa = request.getParameter("cgpa");
			skills = request.getParameter("skills");
			
			String filepath = "D:"+File.separator+"Advanced JAVA"+File.separator+"HireMax"+File.separator+"WebContent"+File.separator+SAVE_DIR;
			File directory = new File(filepath);
			if(!directory.exists())
			{
				directory.mkdir();
			}
			Part part = request.getPart("logo");
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
			name = name+" ";
			name = name.substring(0,name.indexOf(' '));
			
			sql = "update "+name+" set type=?,founded=?,ceo=?,headquarter=?,area_served=?,revenue=?,no_of_emp=?,website=?,about=?,logo=?,est_recruit=?,recruited=?,job_profile=?,job_pos=?,ctc=?,skills=?,cgpa=? where id=?";
			ps = cn.prepareStatement(sql);
			ps.setString(1, type);
			ps.setString(2, founded);
			ps.setString(3, ceo);
			ps.setString(4, headquarter);
			ps.setString(5, area);
			ps.setString(6, revenue);
			ps.setString(7, emp_no);
			ps.setString(8, website);
			ps.setString(9, about);
			ps.setString(10, relpath);
			ps.setString(11, est_recruit);
			ps.setString(12, "0");
			ps.setString(13, job_profile);
			ps.setString(14, job_pos);
			ps.setString(15, ctc);
			ps.setString(16, skills);
			ps.setString(17, cgpa);
			ps.setString(18, id);
			ps.execute();
			
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center;font-size:50px;'>Company details saved successfully.</h1>");
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
