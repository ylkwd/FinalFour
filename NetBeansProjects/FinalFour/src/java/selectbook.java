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
        int selectedItem=0;
        String query = null;
        selectedItem = Integer.parseInt(request.getParameter("topics"));
        if(selectedItem>0){
            query ="select books.book_id, topics.topic_name, books.book_name, authors.author_name, books.is_available \n" +
                            "from library_catalog.books as books \n" +
                            "join library_catalog.topics as topics on topics.topic_id = books.topic_id\n" +
                            "join library_catalog.authors as authors on authors.author_id = books.author_id\n" +
                            "where books.topic_id=" +selectedItem+" and books.is_available = 1";
        }
        else{
            query = "select books.book_id, topics.topic_name, books.book_name, authors.author_name, books.is_available \n" +
                            "from library_catalog.books as books \n" +
                            "join library_catalog.topics as topics on topics.topic_id = books.topic_id\n" +
                            "join library_catalog.authors as authors on authors.author_id = books.author_id\n" +
                            "where books.is_available = 1";
        }
        try {
            rs = st.executeQuery(query);
        } catch (SQLException ex) {
            Logger.getLogger(selectbook.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            out.append("<table class='w3-table w3-striped w3-border'><thread><tr><th>Book name</th><th>Topic</th><th>Author</th><th>Action</th></thead><tbody>");
            while(rs.next()){
                out.append("<tr>");
                out.append("<td>");
                out.append(rs.getString("book_name"));
                out.append("</td>");
                out.append("<td>");
                out.append(rs.getString("topic_name"));
                out.append("</td>");
                out.append("<td>");
                out.append(rs.getString("author_name"));
                out.append("</td>");
                out.append("<td>");
                out.append("<a href='reserve.jsp?book_id=");
                out.append(rs.getString("book_id"));
                out.append("'>Reserve a copy</a>");
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
