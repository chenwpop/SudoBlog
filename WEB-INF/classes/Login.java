import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import javax.servlet.*;
import javax.servlet.http.*;

public class Login extends HttpServlet { // JDK 1.6 and above only
   private AtomicInteger UsrCount = new AtomicInteger();
   @Override
   public void doPost(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      response.setContentType("text/html");
      // PrintWriter out = response.getWriter();

      Connection conn = null;
      Statement stmt = null;
      PreparedStatement ps = null;
      try {
         Class.forName("com.mysql.cj.jdbc.Driver");
         conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/sudoblog?useSSL=false",
            "jdbc", "general");
            // database-URL(hostname, port, database), username, password
         stmt = conn.createStatement();

         String UserName = request.getParameter("uname");
         String Pswd = request.getParameter("psw");
         String sqlStr = "select * from register where name = "
              + "'" + UserName + "' and pswd = " + "'" + Pswd + "'";
         ResultSet rset = stmt.executeQuery(sqlStr);
         if(rset.next()){
           request.setAttribute("uname", UserName);
           request.getRequestDispatcher("homepage").forward(request, response);
         }else{
           request.setAttribute("conflict", "true");
           request.setAttribute("message", "Invalid Username or Password!");
           request.getRequestDispatcher("login.jsp").forward(request, response);
         }

     } catch (SQLException ex) {
        ex.printStackTrace();
     } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
     } finally {
        try {
           // Step 5: Close the resources
           if (stmt != null) stmt.close();
           if (conn != null) conn.close();
        } catch (SQLException ex) {
           ex.printStackTrace();
        }
     }
   }
}
