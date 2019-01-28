import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import javax.servlet.*;
import javax.servlet.http.*;


public class SignUp extends HttpServlet {  // JDK 1.6 and above only
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
            "jdbc:mysql://localhost:3306/sudoblog?useSSL=false", "jdbc", "general");
            // database-URL(hostname, port, database), username, password
         stmt = conn.createStatement();

         String UserName = request.getParameter("uname");
         String Pswd = request.getParameter("psw");

         String sqlStr = "select * from register where name = "
              + "'" + UserName + "'";
         ResultSet rset = stmt.executeQuery(sqlStr);
         //ps = conn.prepareStatement();
         if(rset.next()) {
           request.setAttribute("conflict", "true");
           request.setAttribute("message", "User Exists!");
           //response.sendRedirect("signup.jsp");
           request.getRequestDispatcher("signup.jsp").forward(request, response);
         }else{
           int id = 0;
           sqlStr = "SELECT MAX(id) AS id FROM register";
           rset = stmt.executeQuery(sqlStr);
           if(rset.next()){
             id = Integer.valueOf(rset.getInt("id")) + 1;
           }

           sqlStr = "create table blog"+ String.valueOf(id)
              + " (id int, name varchar(60), content varchar(12000),"
              + " timestamp char(20))";
           stmt.executeUpdate(sqlStr);

           sqlStr = "insert into register values ("
              + String.valueOf(id) + ", '"
              + UserName + "', '" + Pswd + "' )";
           stmt.executeUpdate(sqlStr);

           request.setAttribute("conflict", "false");
           response.sendRedirect("signup_redirect.html");
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
