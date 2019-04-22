/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yaoxuanluan
 */
public class registerprocess extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        java.sql.Connection conn;
        java.sql.ResultSet rs = null;
        java.sql.Statement st = null,st1 = null;
        HttpSession session=request.getSession(); 
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/FinalFour","root","lyx19930914");
            st=conn.createStatement();
            st1 = conn.createStatement();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirm_pwd = request.getParameter("confirmpassword");

        if(firstname.equals("")){
            request.setAttribute("register_msg", "Enter FirstName");
            rd.forward(request, response);
        }
        if(lastname.equals("")){
            request.setAttribute("register_msg", "Enter LastName");
            rd.forward(request, response);
        }
        if(username.equals("")){
            request.setAttribute("register_msg", "Enter UserName");
            rd.forward(request, response);
        }
        if(password.equals("")){
            request.setAttribute("register_msg", "Enter Password");
            rd.forward(request, response);
        }
        if(confirm_pwd.equals("")){
            request.setAttribute("register_msg", "Enter Confirm Psassword");
            rd.forward(request, response);
        }
        if(!(password.equals(confirm_pwd))){
            request.setAttribute("register_msg", "Password and Confirm Password must match!!");
            rd.forward(request, response);
        }         
        if(password.equals(confirm_pwd)){
                    String query = "SELECT username FROM users WHERE username = '"+username +"'";
        try {
            rs = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            if(rs.next()){
                request.setAttribute("register_msg", "Username already exist");
                rd.forward(request, response);
            }
            else{
                query = "INSERT INTO users (fname, lname, username, password) values ('"+firstname+"','"+lastname+"', '"+username+"','"+password+"')";
                
                
                st1.executeUpdate(query);
                session.setAttribute("uname", username);
                response.sendRedirect("index.jsp");
            }
        } catch (SQLException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        }
        }

    }
}
