<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>JSP WEBSITE</title>
<style type="text/css">
a, a:hover{
    color: #000000;
    text-decoration:none;
    }
</style>
</head>
<body>
<%
   String userID = null;
   if(session.getAttribute("userID") != null){
      userID = (String) session.getAttribute("userID");
  }
   int pageNumber=1;
   if(request.getParameter("pageNumber") != null){
       pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
   }
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
<% 
   }
%>
</div>
</nav>
<div class="container">
<div class="row">
<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
<thead>
  <tr>
  <th style="background-color: #eeeeee; text-align: center;">No</th>
  <th style="background-color: #eeeeee; text-align: center;">Title</th>
  <th style="background-color: #eeeeee; text-align: center;">Author</th>
  <th style="background-color: #eeeeee; text-align: center;">Date</th> 
  </tr>
</thead>
<tbody>
<%
   BoardDAO boardDAO = new BoardDAO();
   ArrayList<Board> list = boardDAO.getList(pageNumber);
   for(int i=0; i<list.size(); i++){
       %>
     <tr>
<td><%= list.get(i).getBoardID() %></td>
<td><a href="view.jsp?boardID=<%= list.get(i).getBoardID() %>"> <%= list.get(i).getBoardTitle() %></a></td>
<td><%= list.get(i).getUserID() %></td>
<td><%= list.get(i).getBoardDate().substring(0,11) + list.get(i).getBoardDate().substring(11,13)+":"+list.get(i).getBoardDate().substring(14,16) %></td>

</tr>  
<%
}
%>

</tbody>
</table>
<% 
   if(pageNumber!=1){
       %>
       <a href="board.jsp?pageNumber=<%= pageNumber-1 %>" class="btn btn-success btn-arraw-left">Previous</a>
<%
   } if(boardDAO.nextPage(pageNumber+1)){
%>
       <a href="board.jsp?pageNumber=<%= pageNumber+1 %>" class="btn btn-success btn-arraw-left">Next</a>
   <% }
%>
<a href="post.jsp" class="btn btn-primary pull-right">POST</a>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
</body>
</html>