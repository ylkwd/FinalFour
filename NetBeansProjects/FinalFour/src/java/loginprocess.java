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
public class loginprocess extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        java.sql.Connection conn;
        java.sql.ResultSet rs = null;
        java.sql.Statement st = null;
        HttpSession session = request.getSession();
        
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/library_catalog","root","lyx19930914");
            st=conn.createStatement();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        String username = request.getParameter("uname");
        String password = request.getParameter("pwd");
        
        if(username.equals("")){
            request.setAttribute("login_msg", "Enter Username");
            rd.forward(request, response);
        }
//        cant find user name in DB
        String query = "SELECT username FROM users WHERE username = '"+username+ "' and password = '"+password+"'";
        try {
            rs = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(loginprocess.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            if(rs.next()){
                session.setAttribute("uname",username);
                response.sendRedirect("index.jsp");
            }
            else{
                request.setAttribute("login_msg", "Please check your username and password");
                rd.forward(request, response);
                
                }
        } catch (SQLException ex) {
            Logger.getLogger(loginprocess.class.getName()).log(Level.SEVERE, null, ex);
        }
//            not match password          
                
    }
}
