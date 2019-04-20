<%-- 
    Document   : logout.jsp
    Created on : Apr 7, 2019, 1:20:35 AM
    Author     : yaoxuanluan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	//invalidate session
	if(session.getAttribute("uname") != null) {             
		//if session was created
		session.invalidate();
		response.sendRedirect("index.jsp");
    }
	else
	{
		// passing variable "b" with URL
		// lets say "b" is for "user must login"
		response.sendRedirect("index.jsp?b");
    }
%>
