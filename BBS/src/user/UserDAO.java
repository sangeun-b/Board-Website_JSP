package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    //mysql connect
    public UserDAO() {
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
    
    public int login(String userID, String userPassword) {
        String sql = "SELECT userPassword FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                if(rs.getString(1).equals(userPassword)) {
                    return 1; //login success
                }
                else
                    return 0; // wrong password
            }
            return -1; // userID does not exist
        }catch(Exception e) {
            e.printStackTrace();
        }
        return -2; //databae issue
        
    }
    public int register(User user) {
        String sql = "INSERT INTO USER VALUES (?,?,?,?,?)";
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserName());
            pstmt.setString(4, user.getUserGender());
            pstmt.setString(5, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//db issue
    }
    
}
