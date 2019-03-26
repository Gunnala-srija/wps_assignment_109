

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;


/**
 * Servlet implementation class FileUploadServler
 */
@MultipartConfig(maxFileSize=1699999)
@WebServlet("/FileUploadServlet")
public class FileUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileUploadServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		HttpSession session1=request.getSession();
		Object id=session1.getAttribute("id");
		Part filepart=request.getPart("filename");
		System.out.println(filepart+"");
		InputStream ip=null;
		String name="";
		String filepath="";
		File file;
		long size=0;
		if(filepart!=null) {
			size=filepart.getSize();
			String content_disp=filepart.getHeader("content-disposition");
			String[] items = content_disp.split( ";");
	           for (String str : items) {
	                  if (str.trim().startsWith("filename")) {
	                        filepath= str.substring(str.indexOf("=" ) + 2, str.length() - 1);
	                        
	                 }
	          }
	           file = new File(filepath);
	           name = file.getName();
			String content=filepart.getContentType();
			ip=filepart.getInputStream();
			System.out.println(size+" "+content+" "+name);
		}
		
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","hr","srikar666");
			
			String sql="insert into student_files values(?,?,?,?,?)";
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setInt(1,(int) id);
			ps.setString(2, "wps");
			ps.setString(3, name);
			ps.setBlob(4,ip);
			ps.setLong(5, size);
			
			int retcode=ps.executeUpdate();
			if(retcode==0) {
				System.out.println("Insertion unsuccessful");
			}
			else {
				System.out.println("Insertion successful");
			}
			
		} 
		
		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} 
		
		catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

}
