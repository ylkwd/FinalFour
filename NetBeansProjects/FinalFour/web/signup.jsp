<%-- 
    Document   : signup
    Created on : Apr 18, 2019, 9:51:07 PM
    Author     : yaoxuanluan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="header.jsp"%>
        <title>Register</title>
    </head>
    <body>
        <div class="w3-display-container w3-grayscale-min"   id="home">
                <img  src="bracket.jpg" alt=""/>
         <div style="padding:128px 16px;"  class="w3-display-middle w3-text-white" style="padding:48px">
        <div  style="padding:20px 200px" class="w3-container w3-center w3-card-4 w3-light-grey w3-text-blue w3-margin ">
        
        <h1 style="color: black">Register</h1>       
        <form style="color: black" name="registerform" action="registerprocess" method="POST">
        First Name : <input type="text" name="firstname"/><br/>
        Last Name : <input type="text" name="lastname"/><br/>
        Username : <input type="text" name="username"/><br/>
        Password : <input type="password" name="password"/><br/>
        Confirm Password : <input type="password" name="confirmpassword"/><br/>
         <div class="w3-container w3-margin">
        <input  class="w3-button w3-margin" style="background-color: #f68026;color: white"type="submit" value="Sign up"/>
        <a class="w3-button" style="background-color: #f68026;color: white"href="index.jsp">Back</a>
         </div>
        </form>
        <%
        if(request.getAttribute("register_msg") !=null){
            out.println(request.getAttribute("register_msg"));
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
