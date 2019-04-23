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
            
        <h2 style="color: black">Search book</h2>
           <div class="w3-container w3-margin">
                <form style="color: black"name="selectbook" action="selectbook" method="POST">
        Password : <input type="text" name="match"/><br/>
        <div class="w3-container w3-margin">
        </form>
            <input  class="w3-button" style="background-color: #f68026;color: white"type="submit" value="search"/>
            <a class="w3-button" style="background-color: #f68026;color: white"href="index.jsp">Clear</a>
            </div>
      
       

                <%
                    java.sql.Connection conn;                
                    java.sql.ResultSet rs;                   
                    java.sql.Statement st;  
                    Class.forName("com.mysql.jdbc.Driver");
                    try{
                        conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/FinalFour","root","lyx19930914");
                        st=conn.createStatement();
                        String query = "SELECT * FROM FinalFour.`basketball matchs`";
                        rs = st.executeQuery(query);   
                    while(rs.next()){%>
                    <option value="<%=rs.getString("topic_id")%>"><%=rs.getString("topic_name")%></option>
                <%}
                    }catch(Exception e){
                    e.printStackTrace();
                    }%>
                    
                 
        </div>
            
            
        <%
        if(request.getAttribute("book_list") !=null){
            out.println(request.getAttribute("book_list"));
        }
        %>
        </div>

                    </div>
            
    </body>
</html>
