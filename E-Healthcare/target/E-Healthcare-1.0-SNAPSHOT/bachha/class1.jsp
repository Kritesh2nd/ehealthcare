<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <form action="class1.jsp" method="post">  
        <%
        String strname = request.getParameter("inpname");
        String strbtn = request.getParameter("btnsubmit");
        out.print("submit = "+strbtn);
        if(strbtn != null){
            out.print("<br/>Your name is "+strname);
        }
        %>
        <br>
        Name<br>
        <input type="text" name="inpname"><br>
        class<br>
        <input type="text" name="inpclass"><br>
        <input type="submit" name="btnsubmit" value="Submitapple">
        <input type="reset" name="btnreset">
    </form>
</body>
</html>