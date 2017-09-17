<%@ page import="java.util.Date" %>
<%@ page import="java.time.Instant" %><%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% if (request.getParameter("name") != null && request.getParameter("comment") != null) {   %>
<sql:update var="lolresultset" dataSource="jdbc/TestDB">
  insert into comments values('<%= request.getParameter("name").replace("'", "\\'")%>', '<%= request.getParameter("comment").replace("'", "\\'")%>', ${Instant.now().toEpochMilli()})
</sql:update>
<%
  }
%>

<sql:query var="rs" dataSource="jdbc/TestDB">
  select name, comment, date from comments
</sql:query>


<html>
  <head>
    <title></title>
  </head>
  <body>
    <table style="width: 100%;">
      <tr>
        <th>Name</th>
        <th>Comment</th>
        <th>Time</th>
      </tr>
      <c:forEach var="row" items="${rs.rows}">
        <tr>
          <td>${row.name}</td>
          <td>${row.comment}</td>
          <td>${Date.from(Instant.ofEpochMilli(row.date))}</td>
        </tr>
      </c:forEach>
    </table>
    <form action="" method="get">
      Name: <input type="text" name="name">
      Comment: <input type="text" name="comment">
      <input type=submit value="Submit"></form>
  </body>
</html>