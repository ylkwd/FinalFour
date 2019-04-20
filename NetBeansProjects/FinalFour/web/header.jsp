<%-- 
    Document   : header.jsp
    Created on : Apr 7, 2019, 1:20:35 AM
    Author     : yaoxuanluan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Road to Championship 2019</title>
<!--        <link rel="stylesheet" href="CSS/stylecss.css" type="text/css"/>-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Oswald">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open Sans">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link href="CSS/2.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!--		<script src="CSS/3.js" type="text/javascript"></script>-->

    </head>
    <body>
        <div class="w3-top">
  <div class="w3-bar w3-white w3-card" id="myNavbar">
    <a href="#home" class="w3-bar-item w3-button w3-wide w3-left"><img style="max-width: 50px;" src="ncaa.png"></img></a>
    <!-- Right-sided navbar links -->
    <div class="w3-right w3-hide-small">
        <%
                    if(session.getAttribute("uname")!=null){%>
                    
                    <a  class="w3-bar-item"style="color:black"> Hello, <i class="fa fa-user"></i>
                        <%
                        out.println(session.getAttribute("uname"));
                        %>
                        </h2>
                      
                        <a class=" w3-bar-item w3-button" style="background-color: #f68026;color: white" href="logout.jsp">Logout</a>
                    <%}
                    else{%>
                    
                    <a class="w3-bar-item w3-button" style="background-color: #f68026;color: white"href="signup.jsp">Sign up</a> &nbsp;
                    <a class="w3-bar-item w3-button" style="background-color: #f68026;color: white"href="login.jsp">Login</a>
                     <%}%>

<!--      <a href="#about" class="w3-bar-item w3-button">ABOUT</a>
      <a href="#team" class="w3-bar-item w3-button"><i class="fa fa-user"></i> LOGIN</a>
      <a href="#work" class="w3-bar-item w3-button"><i class="fa fa-th"></i> WORK</a>
      <a href="#pricing" class="w3-bar-item w3-button"><i class="fa fa-usd"></i> PRICING</a>
      <a href="#contact" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i> CONTACT</a>-->
    </div>
    <!-- Hide right-floated links on small screens and replace them with a menu icon -->

    <a href="javascript:void(0)" class="w3-bar-item w3-button w3-right w3-hide-large w3-hide-medium" onclick="w3_open()">
      <i class="fa fa-bars"></i>
    </a>
  </div>
</div>

<!-- Sidebar on small screens when clicking the menu icon -->
<nav class="w3-sidebar w3-bar-block w3-black w3-card w3-animate-left w3-hide-medium w3-hide-large" style="display:none" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button w3-large w3-padding-16">Close ×</a>
  <a href="#about" onclick="w3_close()" class="w3-bar-item w3-button">ABOUT</a>
  <a href="#team" onclick="w3_close()" class="w3-bar-item w3-button">TEAM</a>
  <a href="#work" onclick="w3_close()" class="w3-bar-item w3-button">WORK</a>
  <a href="#pricing" onclick="w3_close()" class="w3-bar-item w3-button">PRICING</a>
  <a href="#contact" onclick="w3_close()" class="w3-bar-item w3-button">CONTACT</a>
</nav>

<!-- Header with full-height image -->


        <div class="w3-container w3-center w3-padding-32" style="background-color: #03244d">
            
            <h1 class="w3-xxxlarge" style="color: white">Road to Championship 2019</h1>
                

                   


        </div>
    </body>
</html>
