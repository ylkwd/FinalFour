<%-- 
    Document   : Details
    Created on : May 1, 2019, 2:24:49 PM
    Author     : yaoxuanluan
--%>
<%-- 
    Document   : index.jsp
    Created on : Apr 7, 2019, 1:20:35 AM
    Author     : yaoxuanluan
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%@include file="header.jsp"%>
        
        
    </head>
    
    <body>
        <div class="w3-display-container w3-grayscale-min"   id="home">
      <img  src="bracket.jpg" alt=""/>
      <span>  
          <div style="padding:128px 16px;"  class="w3-display-middle w3-text-white" style="padding:48px"></span>

<div  style="padding:20px 200px" class="w3-container w3-center w3-hover-shadow w3-card-6 w3-light-grey  w3-margin">
            
        <h2 style="color: black">Details</h2>
           <div class="w3-container w3-margin">
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
                user_id = Integer.parseInt(rs.getString("uid"));            
            }
            String gteam = request.getParameter("gteam");
            

//            query = "SELECT `basketball teams`.tid, `basketball teams`.coach FROM FinalFour.`basketball teams`"+
//                    "where tname ="+gteam;
            query = "SELECT `basketball players`.pname,`basketball players`.pnumber,`basketball players`.postion FROM FinalFour.`basketball players` join `basketball teams` on`basketball teams`.tid=`basketball players`.tid"+
                    " where `basketball teams`.tname = '"+gteam+"'";
          
              rs = st.executeQuery(query);      
   
            %>
            <div align ='center'>

            <h1>Players</h1>
            <table>
                <thead>
                    <tr>
                        <th>Team name</th>
                        <th>Player name</th>
                         <th>Player number</th>
                         <th>Player position</th>
                    </tr>
                </thead>

            <%while(rs.next()){%>
            <tr>
                <td><%=gteam%></td>
                <td><%=rs.getString("pname")%></td>
                <td><%=rs.getString("pnumber")%></td>
                <td><%=rs.getString("postion")%></td>
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
                    
    
        </div>
            
            
        <%
        if(request.getAttribute("book_list") !=null){
            out.println(request.getAttribute("book_list"));
        }
        %>
        <%
        if(request.getAttribute("match_msg") !=null){
            out.println(request.getAttribute("match_msg"));
        }
        %>
        </div>

                    </div>
            
    </body>
</html>
