
import java.sql.*;
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
 * Servlet implementation class LoginServlet
 */

@WebServlet("/Dashboard")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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
		try {
			int x;
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","hr","srikar666");
			System.out.println("Connected");
			//PreparedStatement st=con.prepareStatement("CREATE TABLE demo(id varchar(20),name varchar(20))");
			//int x=st.executeUpdate();
			String rollno=request.getParameter("rollno");
			String pass=request.getParameter("password"); 
			DatabaseMetaData dbm=con.getMetaData();
			ResultSet rs=dbm.getTables(null, null, "STUDENT_LOGIN", null);
			//System.out.println(rs.next());
			if(rs.next()) {
			Statement st=con.createStatement();
			ResultSet rs1=st.executeQuery("select id from student_login where rollno='"+rollno+"'");
			if(rs1.next()) {
				HttpSession session1 = request.getSession(true);
				session1.setAttribute("id", rs1.getInt(1));
				System.out.println(rs1.getInt(1));
				
				response.sendRedirect("details.jsp");
			}
			
			else {
				PrintWriter out=response.getWriter();
				RequestDispatcher rd=request.getRequestDispatcher("/login.html");
				rd.include(request,response);
				out.println("<center><p>Username doesn't exists</p></center>");
			}
			
			}
			else {
				PreparedStatement st=con.prepareStatement("CREATE TABLE student_login(id number,rollno varchar(20),pass varchar(20))");
				x=st.executeUpdate();
				st=con.prepareStatement("insert into student_login values(?,?,?)");
				st.setInt(1, 1);
				st.setString(2, rollno);
				st.setString(3, pass);
				x=st.executeUpdate();
			}
			
		}
		catch(Exception e) {
			PrintWriter out=response.getWriter();
			RequestDispatcher rd=request.getRequestDispatcher("/login.html");
			rd.include(request,response);
			out.println("<center><p>Username already exists</p></center>");
		}

}
}
