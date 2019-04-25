<%-- 
    Document   : login.jsp
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
        <div class="w3-display-container w3-grayscale-min"   id="home">
                <img  src="bracket.jpg" alt=""/>
   
  <div style="padding:128px 16px;"  class="w3-display-middle w3-text-white" style="padding:48px">
        <div  style="padding:20px 200px" class="w3-container w3-center w3-card-4 w3-light-grey w3-text-blue w3-margin ">
        <h1 style="color: black">Login</h1>
        <form style="color: black"name="loginform" action="loginprocess" method="POST">
        Username : <input type="text" name="uname"/><br/>
        Password : <input type="password" name="pwd"/><br/>
        <div class="w3-container w3-margin">
            <input class="w3-button" style="background-color: #f68026;color: white" type="submit" value="Login"/>
            <a class="w3-button" style="background-color: #f68026;color: white"href="index.jsp">Back</a></div>
        </form>
        <%
        if(request.getAttribute("login_msg") !=null){
            out.println(request.getAttribute("login_msg"));
        }
        %>

        </div>
        </div>
  
         <div class="w3-display-bottomleft w3-text-grey w3-large" style="padding:24px 48px">
    <i class="fa fa-facebook-official w3-hover-opacity"></i>
    <i class="fa fa-instagram w3-hover-opacity"></i>
    <i class="fa fa-snapchat w3-hover-opacity"></i>
    <i class="fa fa-pinterest-p w3-hover-opacity"></i>
    <i class="fa fa-twitter w3-hover-opacity"></i>
    <i class="fa fa-linkedin w3-hover-opacity"></i>
  </div>
        
        </div>

    </body>
</html>
