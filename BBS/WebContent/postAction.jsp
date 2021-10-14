<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="board.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="boardContent"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP WEBSTIE</title>
</head>
<body>
<% 
  String userID = null;
  if(session.getAttribute("userID")!=null){
    userID = (String) session.getAttribute("userID");
  }  
  if(userID==null){
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('Please login first')");
    script.println("location.href='login.jsp'");
    script.println("</script>");  
    
  }else{
      if(board.getBoardTitle()==null || board.getBoardContent()==null){
                  PrintWriter script = response.getWriter();
                  script.println("<script>");
                  script.println("alert('Please fill out all required fields')");
                  script.println("history.back()");
                  script.println("</script>");     
              } else{
                  BoardDAO boardDAO = new BoardDAO();
                  int result = boardDAO.post(board.getBoardTitle(),userID,board.getBoardContent());
                  if(result==-1){
                      PrintWriter script = response.getWriter();
                      script.println("<script>");
                      script.println("alert('Posting failed)");
                      script.println("history.back()");
                      script.println("</script>");  
                      
                  }else{
                      PrintWriter script = response.getWriter();
                      script.println("<script>");
                      script.println("location.href= 'board.jsp'");
                      script.println("</script>");  
                      
                  }
      
  }
   
   }
         
%>
</body>
</html>