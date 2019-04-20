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
        <div class="w3-container w3-center w3-card-4 w3-light-grey w3-text-blue w3-margin ">
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

     

    </body>
</html>
