/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
public class selectbook extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        java.sql.Connection conn;
        java.sql.ResultSet rs = null;
        java.sql.Statement st = null;
        HttpSession session = request.getSession();
        StringBuffer out = new StringBuffer();
        
        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/FinalFour","root","lyx19930914");
            st=conn.createStatement();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(registerprocess.class.getName()).log(Level.SEVERE, null, ex);
        }
        String search = request.getParameter("match");
        
        String query = null;
       
        
        if(search.equals("")){
            query = "SELECT gid,gteam1, gteam2, date FROM FinalFour.`basketball matchs`";
        }
        else{
            query = "SELECT gid,gteam1, gteam2, date FROM FinalFour.`basketball matchs` where gteam1 LIKE '"+search+ "' or gteam2 LIKE '"+search+ "'";
        }
        
        
        
        try {
            rs = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(selectbook.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            out.append("<table class='w3-table w3-striped w3-border'><thread><tr><th>Team1</th><th>VS</th><th>Team2</th><th>Date</th></thead><tbody>");
            while(rs.next()){
                out.append("<tr>");
                out.append("<td>");
                out.append(rs.getString("gteam1"));
                 out.append("<a href='Details.jsp?gteam=");
                out.append(rs.getString("gteam1"));
                out.append("'>--></a>");
                out.append("</td>");
                out.append("<td>");
                out.append("</td>");
                out.append("<td>");
                out.append(rs.getString("gteam2"));
                out.append("<a href='Details.jsp?gteam=");
                out.append(rs.getString("gteam2"));
                out.append("'>--></a>");
                out.append("</td>");
                out.append("<td>");
                out.append(rs.getString("date"));
                out.append("</td>");
//                out.append("<td>");
//                out.append("<a href='reserve.jsp?gid=");
//                out.append(rs.getString("gid"));
//                out.append("'>Details</a>");
                out.append("</tr>");
            }
            out.append("</tbody></table>");
        request.setAttribute("book_list", out);
        request.getRequestDispatcher("/index.jsp").forward(request,response);
        } catch (SQLException ex) {
            Logger.getLogger(selectbook.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//

}
