package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
    private Connection conn;
    private ResultSet rs;
    
    //mysql connect
    public BoardDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/BBS";
            String dbID="root";
            String dbPassword="root";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    //retrive date from server when write post
    public String getDate() {
        String sql = "SELECT NOW()"; //get date and time now
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getString(1); //현재 날짜 반환
            }
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        return""; //db issue
    }
    public int getNext() {
        String sql = "SELECT boardID FROM BOARD ORDER BY boardID DESC"; //get boardID in descending order
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1)+1; //마지막 게시글 번호에 1 더해서 게시글 번호 반환
            }
            return 1; // 현재가 첫번째 게시물인 경우
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        return-1; //db issue
    }
    public int post(String boardTitle, String userID, String boardContent) {
        String sql = "INSERT INTO BOARD VALUES (?, ?, ?, ?, ?, ?)"; //save value into the board table in db
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext());
            pstmt.setString(2, boardTitle);
            pstmt.setString(3, userID);
            pstmt.setString(4, getDate());
            pstmt.setString(5, boardContent);
            pstmt.setInt(6, 1);// if posting deleted ->0, existed ->1
            return pstmt.executeUpdate();//if success return over 0
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        return-1; //db issue
    }
    
    public ArrayList<Board> getList(int pageNumber){
        String sql = "SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC LIMIT 10"; //get boardID in descending order
        ArrayList<Board> list = new ArrayList<Board>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext()-(pageNumber-1)*10);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                Board board = new Board();
                board.setBoardID(rs.getInt(1));
                board.setBoardTitle(rs.getString(2));
                board.setUserID(rs.getString(3));
                board.setBoardDate(rs.getString(4));
                board.setBoardContent(rs.getString(5));
                board.setBoardAvailable(rs.getInt(6));
                list.add(board); // add each posting to the list
            }
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    public boolean nextPage(int pageNumber) {
        String sql = "SELECT * FROM BOARD WHERE boardID < ? AND boardAvailable = 1"; 
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, getNext()-(pageNumber-1)*10);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return true; //if there is next page, return true
            }
            
        }catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}