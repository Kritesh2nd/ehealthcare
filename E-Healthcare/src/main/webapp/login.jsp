<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.*,java.util.*" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
String driver = "com.mysql.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/";
String database = "ecare";
String userid = "root";
String password = "";
Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;


String forgetpass = request.getParameter("forgetpw");
boolean showlogin = true;
if(forgetpass!=null){
  if(forgetpass.equals("true")){
    showlogin = false;   
  }
}
%>
<!DOCTYPE html>
<html>
  <head>
    <title>E-Health Care | Log In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      *{font-weight:300;}
      .mainbody{height:100vh;}
      .box1{font-size:30px;font-weight:300;padding:30px 0 0 0;text-align: center;}
      .box2{flex-grow: 1;}
      .form{padding:20px;border-radius:3px;}
      .formtitle{font-size:26px;text-align:center;}
      .formtxt0{font-size:18px;padding:10px 0 5px 0;}
      .inpbox0{width:300px;font-size:18px;padding:5px 7px;border-radius:3px;}
      .btnbox1{padding-top:20px;}
      .btnbox2{padding-top:13px;}
      .submitbtn{background:#007bff;color:#fff;padding:10px 20px;border-radius:3px;border:none;font-size:17px;cursor:pointer;}
      .registerbtn{padding:9px 20px;border-radius:3px;font-size:17px;cursor:pointer;text-decoration:none;text-align:center;}
      .btnbox3{padding-top:10px;}
      .ahrlink{color: #000;}
      
      .f2txt3{padding:5px 0 0 0;font-size:15px;}
      .f2btnbox1{padding-top:10px;}
    </style>
  </head>
  <body>
    <div class="mainbody flex fdc">
      <div class="box1 borde">
        E-Health Care System
      </div>
      <div class="box2 borde flex aic jcc">
        <%
          if(showlogin==true){
        %>
        <form action="login.jsp" method="POST" class="form border2">
          <div class="formtitle">Log In</div>
          <div class="formtxt1 formtxt0">Email</div>
          <input type="text" class="inpbox1 inpbox0 border2" name="email">
          <div class="formtxt2 formtxt0">Password</div>
          <input type="text" class="inpbox2 inpbox0 border2"name="password">
          <div class="formtxt3 formtxt0 border none">
            <%
                String inpemail = request.getParameter("email");
                String inppassword = request.getParameter("password");
                String tblname="",tblemail="",tblpass="";
                try{
                Class.forName("com.mysql.jdbc.Driver");  
                connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                statement=connection.createStatement();
                String sql ="select * from userinfo";
                resultSet = statement.executeQuery(sql);
                while(resultSet.next()){
                    tblemail = resultSet.getString("email");
                    tblpass = resultSet.getString("password");
                    if(tblemail.equals(inpemail) && tblpass.equals(inppassword)){
                        session.setAttribute("uemail",inpemail);
                        response.sendRedirect("index.jsp");
                    }
                    else{
                    }
                }                
                connection.close();
                }catch(Exception ex) {
                System.out.println(ex.toString());
                }
            %>
          </div>
          <div class="btnbox1 borde">
            <input type="submit" class="submitbtn w100" value="Login" name="btn">
          </div>
          <div class="btnbox2 borde flex">
            <a href="register.jsp" class="ahrlink registerbtn border2 w100">
              Register
            </a>
          </div>
          <div class="btnbox3 flex jcc">
            <a href="login.jsp?forgetpw=true" class="ahrlink ">
              Forget Password?
            </a>
          </div>
        </form>
        <%
          }
          else if(showlogin==false){
        %>
        <form action="login.jsp?forgetpw=true" method="POST" class="form border2">
          <div class="formtitle">Forget password</div>
          <div class="formtxt1 formtxt0 f2txt1">Email</div>
          <input type="text" class="inpbox1 inpbox0 border2" name="newemail">
          <div class="formtxt2 formtxt0 f2txt2">New Password</div>
          <input type="text" class="inpbox2 inpbox0 border2" name="newpassword">
          <div class="formtxt3 formtxt0 f2txt3 borde">
            <%
              String inpnewemail = request.getParameter("newemail");
              String inpnewpassword = request.getParameter("newpassword");
              String inppwreset = request.getParameter("pwreset");
              String tblnewemail="",sql1;
              boolean resetpw=false,clickresetbtn=false,newinputnull=true;
              if(inppwreset!=null){
                if(inppwreset.equals("Submit")){
                  clickresetbtn=true;
                }
              }
              if(inppwreset!=null&&inpnewpassword!=null){
                if(!inppwreset.equals("")&&!inpnewpassword.equals("")){
                  newinputnull=false;
                }
              }
              try{
                Class.forName("com.mysql.jdbc.Driver");  
                connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                statement=connection.createStatement();
                String sql ="select * from userinfo";
                resultSet = statement.executeQuery(sql);
                while(resultSet.next() && resetpw==false){
                    tblnewemail = resultSet.getString("email");
                    if(tblnewemail.equals(inpnewemail)){
                        resetpw=true;
                    }
                }
                if(resetpw==true&&clickresetbtn==true&&newinputnull==false){
                  sql1="update userinfo set password='"+inpnewpassword+"' where email='"+inpnewemail+"';";
                  statement.executeUpdate(sql1);
                  out.print("<script>alert('Password reset sucessfull.');</script>");
                }
                else if(clickresetbtn==true&&newinputnull==true){
                  out.print("Please fill all the boxes");
                }
                else if(resetpw==false&&clickresetbtn==true&&newinputnull==false){
                  out.print("Your email is invalid");
                }
                connection.close();
                }catch(Exception ex) {
                System.out.println(ex.toString());
                }
            %>
          </div>
          <div class="btnbox2 f2btnbox1 borde">
            <input type="submit" class="submitbtn w100" name="pwreset" value="Submit">
          </div>
          <div class="btnbox2 borde flex">
            <a href="login.jsp" class="ahrlink registerbtn border2 w100">Log In</a>
          </div>
        </form>
        <%}%>
      </div>
    </div>
  </body>
</html>
