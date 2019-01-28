import java.io.*;
import java.sql.*;
import java.util.*;
import java.util.concurrent.atomic.AtomicInteger;
import javax.servlet.*;
import javax.servlet.http.*;

public class HomePage extends HttpServlet { // JDK 1.6 and above only
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

         String UserName = (String) request.getAttribute("uname");
         String sqlStr = "select * from register where name = "
              + "'" + UserName + "'";
         ResultSet rset = stmt.executeQuery(sqlStr);
         /*
         int count = 0;
         while(rset.next()){
           count++;
           response.sendRedirect("signup_redirect.html");
         }
         */
         String id = "0";
         if(rset.next()){
           id = String.valueOf(rset.getInt("id"));
         }
         sqlStr = "select * from blog" + id + " order by id desc";
         rset = stmt.executeQuery(sqlStr);

         Map<String,String> message = new LinkedHashMap<>();
         int count = 0;
         while(rset.next()){
           message.put(rset.getString("timestamp"), rset.getString("content"));
           count++;
         }
         /*
         if(count == 0){
           message.put("00:00:00", "This is a test blog!");
           message.put("00:00:01", "One more test blog!");
           message.put("00:00:02", "Yet another test blog!");
         }
         */
         request.setAttribute("message", message);
         request.setAttribute("uname", UserName);
         request.getRequestDispatcher("homepage.jsp").forward(request, response);
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
