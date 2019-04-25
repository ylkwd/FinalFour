<%-- 
    Document   : reserve.jsp
    Created on : Apr 7, 2019, 1:20:35 AM
    Author     : yaoxuanluan
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="header.jsp"%>
    </head>
    <body>
        <%
	//invalidate session
	if(session.getAttribute("uname") != null) { 
            java.sql.Connection conn;  
            java.sql.ResultSet rs;     
            java.sql.Statement st,st1;   
            Class.forName("com.mysql.jdbc.Driver"); 
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/FinalFour","root","lyx19930914");
            st = conn.createStatement();
            st1 = conn.createStatement();
            int user_id = 0;
            int book_id = 0;
            String user = session.getAttribute("uname").toString();
            
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/FinalFour","root","lyx19930914");
            st = conn.createStatement();
            String query = "SELECT uid FROM users WHERE uname = '"+ user+"'";
            rs = st.executeQuery(query);
            if(rs.next()){
                user_id = Integer.parseInt(rs.getString("user_id"));            
            }
            book_id = Integer.parseInt(request.getParameter("book_id"));
            query = "INSERT INTO follow (uid, gid) values ('"+user_id+"','"+book_id+"')";
            st1.executeUpdate(query);

            query = "SELECT * FROM FinalFour.`basketball matchs`"+
                    "join 'basketball matchs' on 'basketball matchs'.gid = folow.book_id "+
                    "where follow.uid ="+user_id;
            rs = st.executeQuery(query);
            %>
            <div align ='center'>

            <h1>Reservations</h1>
            <table>
                <thead>
                    <tr>
                        <th>Book name</td>
                        <th>Author name</td>
                    </tr>
                </thead>

            <%while(rs.next()){%>
            <tr>
                <td><%=rs.getString("book_name")%></td>
                <td><%=rs.getString("author_name")%></td>
            </tr>              
            <%}%>
            </table>
                    <a class="w3-button" style="background-color: #f68026;color: white"href="index.jsp">Back</a>         
            </div>
        <%}
	else{
		// passing variable "b" with URL
		// lets say "b" is for "user must login"
		response.sendRedirect("login.jsp");
    }
%>


    </body>
