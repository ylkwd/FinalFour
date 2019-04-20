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
        <title>JSP Page</title>
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
        <div class=" w3-container w3-center w3-padding-48" style="background-color: #03244d">
            <h1 class="w3-xxxlarge" href="index.jsp" style="color: white">Library Catalog</h1>
                <%
                    if(session.getAttribute("uname")!=null){%>
                    
                    <h2 style="color:white"> Hello, 
                        <%
                        out.println(session.getAttribute("uname"));
                        %>
                        </h2>
                        <div class="login_form">
                        <a class="login_form w3-button" class="w3-button" style="background-color: #f68026;color: white" href="logout.jsp">Logout</a>
                    </div>
                    <%}
                    else{%>
                    <div class="login_form">
                    <a class="w3-button" style="background-color: #f68026;color: white"href="signup.jsp">Sign up</a> &nbsp;
                    <a class="w3-button" style="background-color: #f68026;color: white"href="login.jsp">Login</a>
                    </div>

                    <%}%>


        </div>
    </body>
</html>
