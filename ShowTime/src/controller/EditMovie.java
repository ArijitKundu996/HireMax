package controller;
import javax.servlet.annotation.MultipartConfig; /*Needs to be present*/
import java.sql.*;
import connector.*;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 * Servlet implementation class EditMovie
 */
@WebServlet("/EditMovie")
@MultipartConfig(fileSizeThreshold=1024*1024*2,maxFileSize=1024*1024*10,maxRequestSize=1024*1024*50) /*Annotation*/
public class EditMovie extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR = "moviepics";

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try
		{
			HttpSession mov = request.getSession(false);
			String movie = (String)mov.getAttribute("movie");
			String synopsis = request.getParameter("synopsis");
			String lead = request.getParameter("lead");
			
			String imgpath=null;
			String filepath = "D:"+File.separator+"Advanced JAVA"+File.separator+"ShowTime"+File.separator+"WebContent"+File.separator+SAVE_DIR;
			File dir = new File(filepath);
			if(!dir.exists())
			{
				dir.mkdir();
			}
			Part part = request.getPart("pic");
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
			
			String sql = "update " +movie.replace(" ","_")+ " set synopsis=?,lead_cast=?,image=? where seatid=?";
			Connection cn = Db2Connector.getCn();
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, synopsis);
			ps.setString(2, lead);
			ps.setString(3, relpath);
			ps.setString(4, "1A");
			ps.execute();
			PrintWriter out = response.getWriter();
			out.println("<h1 style='color:white;text-align:center'>Movie details updated successfully</h1>");
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
