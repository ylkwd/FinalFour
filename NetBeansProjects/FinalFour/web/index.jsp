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
            
        <h2 style="color: black">Search Matches</h2>
           <div class="w3-container w3-margin">
                 <form name ="selectbook" action="selectbook" method="GET" >
            
<!--            <select name="topics">
                <option value ='0'>ALL</option>
                
            </select>-->
                   Search : <input class="w3-input"type="text" name="match"/>
            <div class="w3-container w3-margin">
            <input  class="w3-button" style="background-color: #f68026;color: white"type="submit" value="search"/>
            <a class="w3-button" style="background-color: #f68026;color: white"href="index.jsp">Clear</a>
            </div>
        </form> 
<!--        <div class="w3-container w3-margin">
       
            <input  class="w3-button" style="background-color: #f68026;color: white"type="submit" value="search"/>
            <a class="w3-button" style="background-color: #f68026;color: white"href="index.jsp">Clear</a>
            </div>-->
               
                    
    
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
