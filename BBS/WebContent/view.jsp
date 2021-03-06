<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" http-equiv="Content-Type" content="text/html;">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP WEBSITE</title>
</head>
<body>
<%
   String userID = null;
   if(session.getAttribute("userID") != null){
      userID = (String) session.getAttribute("userID");
  }
   int boardID = 0;
   if(request.getParameter("boardID")!=null){
       boardID = Integer.parseInt(request.getParameter("boardID"));
   }
   if(boardID == 0) {
       PrintWriter script = response.getWriter();
       script.println("<script>");
       script.println("alert('This posting is not available')");
       script.println("location.href = 'board.jsp'");
       script.println("</script>");
      }
  /*  Board board = null;
   BoardDAO boardDao = new BoardDAO(); 
   
   if(boardDao != null){
       board = boardDao.getBoard(boardID);
   } */
   Board board = new BoardDAO().getBoard(boardID);
%>
<nav class="navbar navbar-default">
<div class="navbar-header">
<button type="button" class="navbar-toggle collapsed" 
data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
aria-expanded="false">
<span class="icon-bar"></span>
<span class="icon-bar"></span>
<span class="icon-bar"></span>
</button>
<a class="navbar-brand" href="main.jsp">JSP WEBSITE</a>
</div>
<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
<ul class="nav navbar-nav">
<li><a href="main.jsp">Main</a></li>
<li class="active"><a href="board.jsp">Board</a></li>
</ul>
<%
   if(userID==null){
%>
<ul class="nav navbar-nab navbar-right">
<li class="dropdown">
<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
Login<span class="caret"></span></a>
<ul class="dropdown-menu">
<li><a href="login.jsp">Login</a></li>
<li><a href="register.jsp">Register</a></li>
</ul>
</li>
</ul>
<%       
   } else{
%>
<ul class="nav navbar-nab navbar-right">
<li class="dropdown">
<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
My Account<span class="caret"></span></a>
<ul class="dropdown-menu">
<li><a href="logoutAction.jsp">Logout</a></li>
</ul>
</li>
</ul>
<% } %>
</div>
</nav>
<% if(board != null){ %> 
<div class="container">
<div class="row">
<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
<thead>
  <tr>
  <th colspan="3" style="background-color: #eeeeee; text-align: center;">Posting</th>
  </tr>
</thead>
<tbody>
<tr>
<td style="width: 20%;">Title</td>
<td colspan="2"><%= board.getBoardTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %> </td>
</tr>
<tr>
<td>Author</td>
<td colspan="2"><%= board.getUserID() %></td>
</tr>
<tr>
<td>Date</td>
<td colspan="2"><%= board.getBoardDate().substring(0,11)+board.getBoardDate().substring(11,13)+":"+board.getBoardDate().substring(14,16) %></td>
</tr>
<tr>
<td>Content</td>
<td colspan="2" style="min-height: 200px; text-align: left;">

<% if(board.getBoardDate() != null){ %>
<%= board.getBoardContent().replaceAll(" ","&nbsp;").replaceAll("<","lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></td>
<% } %>
</tr>
</tbody>
</table>
<a href="board.jsp" class="btn btn-primary"> List </a>
<%
   if(userID != null && userID.equals(board.getUserID())){
%>

<a href="edit.jsp?boardID=<%= boardID %>" class="btn btn-primary"> Edit </a>
<a onclick="return confirm('Are you sure you want to delete this posting?')" href="deleteAction.jsp?boardID=<%= boardID %>" class="btn btn-primary"> Delete </a>


<%
   }
%>

</div>
</div>
<% } %>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>