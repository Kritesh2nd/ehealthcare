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
String btn = request.getParameter("button");
boolean registertrue = false;
if(btn!=null){if(btn.equals("Register")){registertrue = true;}}
%>
<!DOCTYPE html>
<html>
  <head>
    <title>E-Health Care | Register</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      *{font-weight:300;}
      .mainbody{height:100vh;}
      .box1{font-size:30px;font-weight:300;padding:30px 0 0 0;text-align: center;}
      .box2{flex-grow: 1;}
      .form{padding:25px;border-radius:3px;width:350px;}
      .formtitle{font-size:26px;text-align:center;}
      .formtxt0{font-size:18px;padding:10px 0 5px 0;}
      .inpbox0{width:100%;font-size:18px;padding:5px 7px;border-radius:3px;}
      .formtxt3{padding:5px 0 5px 0;}
      .formmsg1{font-size:15px;padding:5px 0 0 0;}
      .btnbox1{padding-top:10px;}
      .submitbtn{background:#007bff;color:#fff;padding:10px 20px;border-radius:3px;border:none;font-size:17px;cursor:pointer;}
      .btnbox2{padding-top:10px;}
      .formtxt4{padding:0 20px 0 0;}
      .ahrlink{color: #000;}
      .formmsgbox{padding-top:5px;}
    </style>
  </head>
  <body>
    <div class="mainbody flex fdc">
      <div class="box1 borde">
        E-Health Care System
      </div>
      <div class="box2 borde flex aic jcc">
        <form action="register.jsp" method="POST" class="form border2">
            <%
              String inpname = request.getParameter("name");
              String inpemail = request.getParameter("email");
              String inppassword = request.getParameter("password");
              String tblemail="";
              boolean inputempty=true,emailregister=false;
              try{
              String sql;
              Class.forName("com.mysql.jdbc.Driver");  
              connection = DriverManager.getConnection(connectionUrl+database, userid, password);
              statement=connection.createStatement();
              if(inpname!=null&&inpemail!=null&&inppassword!=null){
                if(!inpname.equals("")&&!inpemail.equals("")&&!inppassword.equals("")){
                    inputempty=false;
                }
              }
              if(registertrue){
                sql = "select * from userinfo";
                resultSet = statement.executeQuery(sql);

                while(resultSet.next()&&emailregister==false){
                    tblemail = resultSet.getString("email");
                    if(tblemail.equals(inpemail)){
                        emailregister=true;
                    }
                }
              }
              if(registertrue&&!inputempty&&!emailregister){
                sql = "insert into userinfo(name,email,password,utype)values('"+inpname+"','"+inpemail+"','"+inppassword+"','user');";
                statement.executeUpdate(sql);
                session.setAttribute("uemail",inpemail);
                response.sendRedirect("index.jsp");
              }
              connection.close();
              }
              catch(Exception ex) {
              System.out.println(ex.toString());
              }
            %>
          <div class="formtitle">Register</div>
          <div class="formtxt1 formtxt0">Name</div>
          <input type="text" class="inpbox1 inpbox0 border2" name="name">
          <div class="formtxt1 formtxt0">Email</div>
          <input type="text" class="inpbox2 inpbox0 border2" name="email">
          <div class="formmsg1 formtxt0 borde">
            <%if(emailregister){out.print("This email is already registered.");}%>
          </div>
          <div class="formtxt3 formtxt0">Password</div>
          <input type="text" class="inpbox3 inpbox0 border2" name="password">
          <div class="formmsgbox">
            <%if(registertrue&&inputempty){out.print("Please fill all the input box");}%>
          </div>
          <div class="btnbox1 borde">
            <input type="submit" class="submitbtn w100" value="Register" name="button">
          </div>
          <div class="btnbox2 flex jcc">
            <a href="login.jsp" class="ahrlink ">
              Go to Log In
            </a>
          </div>
        </form>
      </div>
    </div>
  </body>
</html>