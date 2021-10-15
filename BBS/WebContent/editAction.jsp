<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="board.BoardDAO" %>
<%@ page import ="board.Board" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

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
    
  }
  int boardID = 0;
  if(request.getParameter("boardID")!=null){
      boardID = Integer.parseInt(request.getParameter("boardID"));
  }
  if(boardID == 0){
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('This posting does not exist')");
      script.println("location.href='board.jsp'");
      script.println("</script>"); 
  }
  Board board = new BoardDAO().getBoard(boardID);
       
  if(board != null && !userID.equals(board.getUserID())){ //session에 있는 값과 작성자의 ID가 동일한지 확인
      
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('You do not have a permission')");
      script.println("location.href ='board.jsp'");
      script.println("</script>");
        
  }
  else{
      if(request.getParameter("boardTitle")==null || request.getParameter("boardContent")==null
              || request.getParameter("boardTitle").equals("") || request.getParameter("boardContent").equals("")){
                  PrintWriter script = response.getWriter();
                  script.println("<script>");
                  script.println("alert('Please fill out all required fields')");
                  script.println("history.back()");
                  script.println("</script>");     
              } else{
                  BoardDAO boardDAO = new BoardDAO();
                  int result = boardDAO.update(boardID,request.getParameter("boardTitle"),request.getParameter("boardContent"));
                  if(result==-1){
                      PrintWriter script = response.getWriter();
                      script.println("<script>");
                      script.println("alert('edit failed)");
                      script.println("history.back()");
                      script.println("</script>");  
                      
                  }else{
                      PrintWriter script = response.getWriter();
                      script.println("<script>");
                      script.println("location.href='board.jsp'");
                      script.println("</script>");  
                      
                  }
      
  }
   
   }
         
%>
</body>
</html>