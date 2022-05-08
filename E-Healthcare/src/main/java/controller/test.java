package controller;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import java.sql.PreparedStatement;
//import java.io.*,java.util.*;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Connection;
import java.sql.SQLException;
@WebServlet(name = "test", urlPatterns = {"/test"})
public class test extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String driver;
        driver = "com.mysql.jdbc.Driver";
        String connectionUrl = "jdbc:mysql://localhost:3306/";
        String database = "ecare";
        String userid = "root";
        String password = "";
        String sql="",sql1="",sql2="",sql3="";
        Connection connection = null;
        Statement statement = null;
        Statement statement1 = null;
        Statement statement2 = null;
        Statement statement3 = null;
        ResultSet resultSet = null;
        ResultSet resultSet1 = null;
        ResultSet resultSet2 = null;
        ResultSet resultSet3 = null;
        boolean inputempty=true;
        try (PrintWriter out = response.getWriter()) {
           try{
                Class.forName("com.mysql.jdbc.Driver");  
                connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                statement=connection.createStatement();
                String addtitle = request.getParameter("addtitle");
                String addcontent = request.getParameter("addcontent");
                String optionab = request.getParameter("optionAB");
                String insertbtn = request.getParameter("insertbtn");
                
                if(insertbtn!=null){
                    sql = "insert into info(title,content,type)values('"+addtitle+"','"+addcontent+"','"+optionab+"');";
                    statement.executeUpdate(sql);
                    response.sendRedirect("index.jsp");
                }
                
                out.print(addtitle+"<br/>"+addcontent+"<br/>"+optionab+"<br/>"+insertbtn+"<br/>");
                connection.close();
            }
            catch(ClassNotFoundException | SQLException ex) {
                System.out.println(ex.toString());
                out.print("ERROR:"+ex.toString());
            }
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
