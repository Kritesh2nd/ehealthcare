<%@page import="java.sql.SQLException"%>
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
Statement statement1 = null;
Statement statement2 = null;
ResultSet resultSet = null;
ResultSet resultSet1 = null;
ResultSet resultSet2 = null;
String sessemail = String.valueOf(session.getAttribute("uemail"));
String sesscroll = String.valueOf(session.getAttribute("sscroll"));
String opt = request.getParameter("opt");
String editt = request.getParameter("edit");
String deltt = request.getParameter("delete");
String sessname="",sessutype="",strscroll="";
int sessid=0,optnum=0,editint=0,deleteint=0,scrollval=0;
boolean editthis=false,deletethis=false;
if(editt!=null){editthis=true;editint=Integer.parseInt(editt);}
if(deltt!=null){deletethis=true;deleteint=Integer.parseInt(deltt);}
if(opt==null){optnum=1;}
else if(opt.equals("symptoms")){optnum=1;}
else if(opt.equals("medicine")){optnum=2;}
else if(opt.equals("addinfo")){optnum=3;}
else if(opt.equals("chat")){optnum=4;}
else if(opt.equals("logout")){optnum=5;}
try{
  Class.forName("com.mysql.jdbc.Driver");  
  connection = DriverManager.getConnection(connectionUrl+database, userid, password);
  statement=connection.createStatement();
  String sql ="select * from userinfo where email='"+sessemail+"';";
  resultSet = statement.executeQuery(sql);
  while(resultSet.next()){
    sessid = resultSet.getInt("id");
    sessname = resultSet.getString("name");
    sessutype = resultSet.getString("utype");
  }
  connection.close();
}catch(Exception ex) {
  System.out.println(ex.toString());
}
if(sessemail.equals("null")){response.sendRedirect("login.jsp");}
else if(!sessemail.equals("")){
%>
<!DOCTYPE html>
<html>
  <head>
    <title>E-Health Care | Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/style.css">
    <style>
      ::-webkit-scrollbar {width: 10px;}
      ::-webkit-scrollbar-track{box-shadow: inset 0 0 5px grey;border-radius: 10px;}
      ::-webkit-scrollbar-thumb{background:rgba(170,170,170,.2);border-radius:10px;transition: 0.3s;}
      ::-webkit-scrollbar-thumb:hover {background: rgba(170,170,170,.5);cursor:pointer;}
      .mainbody{height:100vh;overflow:hidden;}
      .navbarbox{padding:0 100px;}
      .titlebox{font-size:30px;font-weight:300;padding:10px 0;}
      .titlebox,.navlistbox{width:50%;}
      .ullist{list-style-type: none;}
      .lis{margin-right:10px;}
      .ahr{text-decoration: none;color: #000;padding:5px 10px;font-weight:300;}

      .bodybox{flex-grow: 1;height:calc(100% - 60px);}
      .userlist{width:25%;}
      .contentbody{width:50%;}
      .cbroom1,.cbroom2{overflow:auto;padding-right:10px}
      .r1infobigbox{padding-bottom:70px}

      .subtitle{font-size:28px;font-weight:300;text-align: center;padding-bottom:5px;}
      .userlistbox{flex-grow: 1;overflow: auto;}
      .userbox{padding:0 15px 10px 15px;}
      .ubxpart1{width:22%;padding:2px;}
      .userimagebox{height:50px;width:50px;border-radius:50%;overflow: hidden;box-shadow:0 0 5px rgba(0,0,0,.8);}
      .ubxpart2{width:78%;}
      .usernamebox{font-size:20px;padding-left:15px;}
      
      .infotitle{padding-top:20px;}
      .ssubtitle{font-size:26px;font-weight:300;padding-bottom:5px;}
      .infocontent{font-size:18px;font-weight:300;line-height:32px;padding-bottom:10px;}
      .r1infobox{padding-bottom:15px;}
      .r1btnbox{padding-bottom:10px;}
      .btnlvl1{border:none;background:#fff;text-decoration: underline;cursor: pointer;font-size:18px;font-weight:300;
        margin-left:15px;color:#000;}
      .deleteconfirm{top:0;left:0;background:rgba(100,100,100,.8);border-radius:1px;}
      .ideleteconfirm{padding:10px;background:#eee;width:250px;border-radius:3px;}
      .deletetxt1{font-size:18px;text-align: center;padding:5px 0;font-weight:300;}
      .r1formdelete{padding:10px 0 5px 0;}
      .btnlvl2{font-size:16px;font-weight:300;color:#000;text-decoration: none;padding:3px 10px;border-radius:2px;
        cursor: pointer;transition:.25s;}
      .btnlvl2:hover{background:#ccc;}

      .r1infoeditbox{padding:20px 0 25px 0;}
      .edittitle{font-size:18px;font-weight:300;padding:5px 10px;border-radius:3px;margin-bottom:15px;}
      .editcontent{font-size:18px;font-weight:300;padding:5px 10px;border-radius:3px;height:150px;resize:none;
        margin-bottom:15px;}
      .btnlvl3{font-size:18px;font-weight:300;color:#000;text-decoration: none;padding:3px 15px;border-radius:2px;
        cursor: pointer;transition:.25s;}
      .r1editbtn{margin-right:15px;background:#1266F1;color:#fff;}
      .r1span1{height:1px;width:100%;background:#aaa;bottom:0;left:0;}
      /* ============================================== ROOM 3 ============================================== */
      .r3inpformbox{padding:20px 0 25px 0;}
      .r3txt0{font-size:18px;font-weight:300;}
      .r3txt1{padding-right:70px;}
      .r3txt2{margin-right:50px;}
      .r3radiobox{padding-right:10px;}
      .r3div{padding-bottom:15px;}
      /* ============================================== ROOM 5 ============================================== */
      .logoutconfirmbox{padding:15px 20px;width:250px;border-radius:3px;}
      .r5txt1{font-size:20px;font-weight:300;text-align: center;padding-bottom:15px;}
      .r5logoutbtn{background:#dc3545;color:#fff;}
    </style>
  </head>
  <body>
    <div class="mainbody borde felx fdc">
      <div class="navbarbox borde">
        <div class="inavbarbox flex jcsb">
          <div class="titlebox">E-Health Care System</div>
          <div class="navlistbox flex aic jcc">
            <ul class="ullist flex">
              <li class="lis flex"><a href="index.jsp?opt=symptoms" class="ahr">Symptoms</a></li>
              <li class="lis flex"><a href="index.jsp?opt=medicine" class="ahr">Medicine</a></li>
              <li class="lis flex <%if(sessutype.equals("user")){out.print("none");}%>"><a href="index.jsp?opt=addinfo" class="ahr">Add Info</a></li>
              <li class="lis flex"><a href="index.jsp?opt=chat" class="ahr">Chat</a></li>
              <li class="lis flex"><a href="index.jsp?opt=logout" class="ahr">Log Out</a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="bodybox">
        <div class="inrbodybox borde flex h100">
          <div class="userlist borde">
            <div class="i1userlist ins flex fdc none">
              <div class="subtitle">User List</div>
              <div class="userlistbox">
                <div class="userbox flex borderx">
                  <div class="ubxpart1">
                    <div class="userimagebox">
                      <img src="image/person.jpg" alt="" class="userimage w100">
                    </div>
                  </div>
                  <div class="ubxpart2 flex aic">
                    <div class="usernamebox">Krietsh Thapa</div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="contentbody borde">
            <%
            if(optnum==1){
            %>
            <!-- ============================================== ROOM 1 ============================================== -->
            <div class="cbrooms cbroom1 borde ins">
                <%
//                    out.print("<script>"
//                            + "var cbroom1 = document.querySelector('.cbroom1'),scrollvar=0;"
//                            + "cbroom1.addEventListener('scroll', event => {"
//                            + "scrollvar = cbroom1.scrollTop;"
//                            + ""
//                            + "}, { passive: true });"
//                            + "function setScroll(){"
//                            + "console.log('dog',scrollvar);");
//                    
//                    strscroll = "console.log(scrollvar);";
//                    out.print(strscroll);
//                    session.setAttribute("sscroll",strscroll);
//                    out.print("}</script>");
                %>
              <div class="subtitle borde">
                Symptoms
              </div>
              <div class="r1infobigbox borde">
                <%
                try{
                    Class.forName("com.mysql.jdbc.Driver");  
                    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                    statement=connection.createStatement();
                    String tbl_title="",tbl_content="",tbl_tytpe="",sql="";
                    int tbl_id;
                    sql = "select*from info";
                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()){
                        tbl_id = resultSet.getInt("id");
                        tbl_title = resultSet.getString("title");
                        tbl_content = resultSet.getString("content");
                        tbl_tytpe = resultSet.getString("type");
//                    form here
                        if(tbl_tytpe.equals("a")){
                          if((editthis&&editint!=tbl_id)||!editthis||(deletethis)){
                %>
                <div class="r1infobox rel this borde">
                  <div class="infotitle ssubtitle"><%=tbl_title%></div>
                  <div class="infocontent">
                    <%=tbl_content%>
                  </div>
                  <div class="r1btnbox borde <%if(sessutype.equals("user")){out.print("none");}%>">
                    <form class="r1form flex jcfe" method="post" action="index.jsp">
                      <a href="index.jsp?opt=symptoms&edit=<%=tbl_id%>" onclick="setScroll()" class="r1edit btnlvl1">Edit</a>
                      <a href="index.jsp?opt=symptoms&delete=<%=tbl_id%>" onclick="setScroll()" class="r1edit btnlvl1">Delete</a>
                    </form>
                  </div>
                  <span class="r1span1 abs"></span>
                  <%
                    if(deletethis&&deleteint==tbl_id){
                  %>
                  <div class="deleteconfirm ins abs flex aic jcc this1">
                    <div class="ideleteconfirm borde flex fdc">
                      <div class="deletetxt1">Are sure you want to delete?</div>
                      <form method="post" action="deleteinfo" class="r1formdelete flex jcsa">
                        <input type="hidden" name="importdelid" value=<%=tbl_id%>>
                        <input type="hidden" name="importdelsm" value="symptoms">
                        <input type="submit" class="r1edit btnlvl2 border" value="Delete" name="deletebtn">
                        <a href="index.jsp?opt=symptoms" class="cancelbtn btnlvl2 border">Cancel</a>
                      </form>
                    </div>
                  </div>
                  <%}%>
                </div>
                <%
                  }else if(editthis&&editint==tbl_id){
                %>
                <div class="r1infoeditbox rel this1">
                  <form action="updateinfo" method="post" class="r1infoeditform flex fdc borde">
                    <input type="hidden" name="importid" value=<%=tbl_id%>>
                    <input type="hidden" name="importsm" value="symptoms">
                    <input type="text" class="edittitle border2" value="<%=tbl_title%>" placeholder="title..." name="edittitle">
                    <textarea class="editcontent border2" placeholder="title..." name="editcontent"><%=tbl_content%></textarea>
                    <div class="r1editbtnbox flex jcfe">
                      <input type="submit" class="r1editbtn btnlvl3 bordernone" value="Update" name="updatebtn">
                      <a href="index.jsp?opt=symptoms" class="r1cancelbtn btnlvl3 border2">Cancel</a>
                    </div>
                  </form>
                  <span class="r1span1 abs"></span>
                </div>
                <%
                  }}}
                  connection.close();
                }
                catch(ClassNotFoundException | SQLException ex) {
                  System.out.println(ex.toString());
                  out.print("ERRORx:"+ex.toString());
                }
                %>
              </div>
            </div>
            <%}else if(optnum==2){%>
            <!-- ============================================== ROOM 2 ============================================== -->
            <div class="cbrooms cbroom2 borde ins">
              <div class="subtitle borde">
                Medicine
              </div>
              <div class="r1infobigbox borde">
                <%
                try{
                    Class.forName("com.mysql.jdbc.Driver");  
                    connection = DriverManager.getConnection(connectionUrl+database, userid, password);
                    statement=connection.createStatement();
                    String tbl_title="",tbl_content="",tbl_tytpe="",sql="";
                    int tbl_id;
                    sql = "select*from info";
                    resultSet = statement.executeQuery(sql);
                    while(resultSet.next()){
                        tbl_id = resultSet.getInt("id");
                        tbl_title = resultSet.getString("title");
                        tbl_content = resultSet.getString("content");
                        tbl_tytpe = resultSet.getString("type");
//                    form here
                        if(tbl_tytpe.equals("b")){
                          if((editthis&&editint!=tbl_id)||!editthis||(deletethis)){
                %>
                <div class="r1infobox rel this borde">
                  <div class="infotitle ssubtitle"><%=tbl_title%></div>
                  <div class="infocontent">
                    <%=tbl_content%>
                  </div>
                  <div class="r1btnbox <%if(sessutype.equals("user")){out.print("none");}%>">
                    <form class="r1form flex jcfe" method="post" action="index.jsp">
                      <a href="index.jsp?opt=medicine&edit=<%=tbl_id%>" class="r1edit btnlvl1">Edit</a>
                      <a href="index.jsp?opt=medicine&delete=<%=tbl_id%>" class="r1edit btnlvl1">Delete</a>
                    </form>
                  </div>
                  <span class="r1span1 abs"></span>
                  <%
                    if(deletethis&&deleteint==tbl_id){
                  %>
                  <div class="deleteconfirm ins abs flex aic jcc this1">
                    <div class="ideleteconfirm borde flex fdc">
                      <div class="deletetxt1">Are sure you want to delete?</div>
                      <form method="post" action="deleteinfo" class="r1formdelete flex jcsa">
                        <input type="hidden" name="importdelid" value=<%=tbl_id%>>
                        <input type="hidden" name="importdelsm" value="medicine">
                        <input type="submit" class="r1edit btnlvl2 border" value="Delete" name="deletebtn">
                        <a href="index.jsp?opt=medicine" class="cancelbtn btnlvl2 border">Cancel</a>
                      </form>
                    </div>
                  </div>
                  <%}%>
                </div>
                <%
                  }else if(editthis && editint == tbl_id){
                %>
                <div class="r1infoeditbox rel this1">
                  <form action="updateinfo" method="post" class="r1infoeditform flex fdc borde">
                    <input type="hidden" name="importid" value=<%=tbl_id%>>
                    <input type="hidden" name="importsm" value="medicine">
                    <input type="text" class="edittitle border2" value="<%=tbl_title%>" placeholder="title..." name="edittitle">
                    <textarea class="editcontent border2" placeholder="title..." name="editcontent"><%=tbl_content%></textarea>
                    <div class="r1editbtnbox flex jcfe">
                      <input type="submit" class="r1editbtn btnlvl3 bordernone" value="Update" name="updatebtn">
                      <a href="index.jsp?opt=medicine" class="r1cancelbtn btnlvl3 border2">Cancel</a>
                    </div>
                  </form>
                  <span class="r1span1 abs"></span>
                </div>
                <%
                  }}}
                  connection.close();
                }
                catch(ClassNotFoundException | SQLException ex) {
                  System.out.println(ex.toString());
                  out.print("ERRORx:"+ex.toString());
                }
                %>
              </div>
            </div>
            <%}else if(optnum==3){%>
            <!-- ============================================== ROOM 3 ============================================== -->
            <div class="cbrooms cbroom3 ins">
              <div class="subtitle borde">Add Info</div>
              <div class="r3inpformbox">
                <form action="addinfo" method="post" class="r1infoeditform flex fdc">
                  <input type="text" class="edittitle border2" placeholder="add title..." name="addtitle">
                  <textarea class="editcontent border2" placeholder="add content..." name="addcontent"></textarea>
                  <div class="r3div flex jcfs">
                    <div class="r3txt1 r3txt0">For</div>
                    <div class="r3radiobox flex aic">
                      <input type="radio" class="r3radioA r3radioAB" id="r3radioA" value="a" name="optionAB" checked>
                    </div>
                    <label for="r3radioA" class="r3txt2 r3txt0">Symptoms</label>
                    <div class="r3radiobox flex aic">
                      <input type="radio" class="r3radioB r3radioAB" id="r3radioB" value="b" name="optionAB">
                    </div>
                    <label for="r3radioB" class="r3txt3 r3txt0">Medicine</label>
                  </div>
                  <div class="r1editbtnbox flex jcfe">
                    <input type="submit" class="r1editbtn btnlvl3 bordernone" value="Submit" name="insertbtn">
                    <a href="#" class="r1cancelbtn btnlvl3 border2">Cancel</a>
                  </div>
                </form>
              </div>
            </div>
            <%}else if(optnum==4){%>
            <!-- ============================================== ROOM 4 ============================================== -->
            <div class="cbrooms cbroom4 borde ins"></div>
            <%}else if(optnum==5){%>
            <!-- ============================================== ROOM 5 ============================================== -->
            <div class="cbrooms cbroom5 borde ins">
              <div class="icbroom5 ins borde flex aic jcc">
                <div class="logoutconfirmbox border2">
                  <div class="r5txt1 borde">Are you sure you want to log out?</div>
                  <form ction="" method="post" class="logoutform flex jcsa">
                    <%
                    String logoutbtn = request.getParameter("logoutbtn");
                    if(logoutbtn!=null){
                        session.removeAttribute("uemail");
                        response.sendRedirect("index.jsp");
                    }
                    %>
                    <input type="submit" class="r5logoutbtn btnlvl3 bordernone" value="Log Out" name="logoutbtn">
                    <a href="index.jsp" class="r1cancelbtn btnlvl3 border2">Cancel</a>
                  </form>
                </div>
              </div>
            </div>
            <%}%>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
<%}%>