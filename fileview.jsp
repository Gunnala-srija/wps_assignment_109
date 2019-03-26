<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%String filename=request.getParameter("filename"); %>
<title><%=filename %></title>
</head>
<body>
<%
	//Object filename=request.getSession().getAttribute("filename");
	
	Object id=request.getSession().getAttribute("id");
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","hr","srikar666");
	Statement s=con.createStatement();
	ResultSet rs3=s.executeQuery("select files from student_files where id="+id+" and filename='"+filename+"'");
	String filecontent="";
	if(rs3.next()){
		Blob x=rs3.getBlob(1);
		byte y[]=x.getBytes(1, (int)x.length());
		StringTokenizer st=new StringTokenizer((String)filename,".");
		st.nextToken();
		if(st.nextToken().equals("txt")) {
			for(int i=0;i<y.length;i++) {
				filecontent+=(char)y[i];
			}
		}
	}
%>
	<p><%=filename %></p><br>
	<textarea rows="40" cols="100">
		<%=filecontent %>
	</textarea>
</body>
</html>