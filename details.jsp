<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Content</title>

<script>
	
</script>

<style>
            *{
                font-family:  Helvetica, sans-serif;
                font-size:20px;
            }
            #header{
                background-color: #21295C;
                color:white;
                padding:10px;
                border-radius:5px;
            }
            #logout{
                float:right;
                background-color:rgb(0, 128, 122);
                border:2px solid rgb(0, 109, 128);
                border-radius:10px; 
                margin-right:50px;
                text-decoration: none;
                padding: 2px 15px;
                color:white;
            }
            #logout:hover,#upload:hover{
                cursor: hand;
            }
            #upload{
                background-color:rgb(0, 128, 122);
                border:2px solid rgb(0, 109, 128);
                border-radius:10px; 
                text-align:center;
                text-decoration: none;
                padding: 2px 15px;
                color:white;
            }
            #submit{
            	background-color:rgb(0, 128, 122);
                border:2px solid rgb(0, 109, 128);
                border-radius:10px; 
                margin:20px;
                margin-left:-370px;
                text-decoration: none;
                padding: 2px 15px;
                color:white;
            }
            #upload:focus{
                outline:none;
            }
            #submit:focus{
                outline:none;
            }
            table{
                margin:10px;
                background-color: #F3F3F3;
                border-collapse: collapse;
                width: 100%;
                margin: 15px 0;
            }
            th {
                background-color: #FE4902;
                color: #FFF;
                cursor: pointer;
                padding: 5px 10px;
            }
            th small {
                font-size: 9px; 
            }
            td, th {
            text-align: center;
            font-size:15px;
            padding: 15px 20px;
            border-radius:10px;
            }
            tr:nth-of-type(odd) {
            background-color: #E6E6E6;
            }
            th:hover{
                cursor: auto;
            }
            td:hover{
                background-color:#CACACA;
            }
            td a{
                text-decoration: none;
                color:black;
                font-size:15px;
            }
            td a:hover{
                text-decoration: underline;
                cursor:hand;
            }
            #navbar{
                position: sticky;
                position:-webkit-sticky;
                top:0;
            }
            nav{
                background-color: #21295C;
                border-radius:10px;
                margin:0;
            }
            nav ul{
                list-style:none;
                margin:10px 0px;
                padding: 10px 0px;
            }
            nav ul li{
                display: inline;
            }
            nav ul li a{
                padding: 10px 20px;
                text-decoration: none;
                color:white;
            }
            nav ul li a:hover{
                background-color: green;
                border-radius:10px;
                color:white;
            }
        </style>
</head>
<body >

<%
Class.forName("oracle.jdbc.OracleDriver");
Connection con=DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl","hr","srikar666");
Statement s=con.createStatement();
String name="",filecontent="",type="";
String size;
Object id=request.getSession().getAttribute("id");

%>

<div id="header">
            <h1 align="center">Welcome to your drivespace
                <a href="login.html" id="logout">Logout</a>
            </h1>
        </div>
        <div id="navbar">
        <nav>
            <ul>
                <li><a href="#">All</a></li>
                <li><a href="#">Sub1</a></li>
                <li><a href="#">Sub2</a></li>
                <li><a href="#">Sub3</a></li>
                <li><a href="#">Sub4</a></li>
                <li><a href="#">Sub5</a></li>
            </ul>
        </nav>
        </div>

<center>
<table>
	<thead><tr>
		<th>File Name</th>
        <th>Type</th>
        <th>Size <small>(kilo bytes)</small></th>
        <th>Subject</th>
	</tr></thead>
	<%ResultSet rs3=s.executeQuery("select filename,files,sizes,sub from student_files where id="+id+"");
	while(rs3.next()) { %>
	<tr>
		<td><a href="fileview.jsp?filename=<%=rs3.getString(1) %>"><%=rs3.getString(1) %></a></td>
		<%
			name=rs3.getString(1);
			Blob x=rs3.getBlob(2);
			
			request.getSession().setAttribute("filename", name);
			
			byte y[]=x.getBytes(1, (int)x.length());
			filecontent="";
			size=String.format("%.2f",(float)rs3.getLong(3)/1024);
			
			//checking file type
			StringTokenizer st=new StringTokenizer(name,".");
			st.nextToken();
			
			if(st.nextToken().equals("txt")) {
				filecontent="";
				type="text";
				for(int i=0;i<y.length;i++) {
					filecontent+=(char)y[i];
				}
			}
			
			else{
				type="image";
			}
		%>
		<td><%=type %></td>
		<td><%=size %></td>
		<td><%=rs3.getString(4) %></td>
	</tr>
	<%} %>
</table>
</center>


	<div style="text-align:center;margin-left:450px;">
        	<form method="post" action="FileUploadServlet" enctype="multipart/form-data">
                <label for="files" id="upload">Choose File  <i class="fa fa-upload"></i></label>
                <input id="files" name="filename" type="file"><br>
                <input id="submit" type="Submit" value="Upload">
                </form>
        </div>



</body>
</html>