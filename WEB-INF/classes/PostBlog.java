import java.io.*;
import java.sql.*;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.concurrent.atomic.AtomicInteger;
import javax.servlet.*;
import javax.servlet.http.*;


public class PostBlog extends HttpServlet {  // JDK 1.6 and above only
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
         String NewBlog = request.getParameter("content");

         String sqlStr = "select * from register where name = "
              + "'" + UserName + "'";
         ResultSet rset = stmt.executeQuery(sqlStr);

         String usrid = "0";
         int blgid = 0;
         if(rset.next()) {
           usrid = String.valueOf(rset.getInt("id"));
         }else{
           request.setAttribute("uname", UserName);
           request.getRequestDispatcher("homepage").forward(request, response);
         }

         sqlStr = "SELECT MAX(id) AS id FROM blog" + usrid;
         rset = stmt.executeQuery(sqlStr);
         if(rset.next()){
           blgid = Integer.valueOf(rset.getInt("id")) + 1;
         }

         String timestamp =
            new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(new Date());

         sqlStr = "INSERT INTO blog" + usrid +" values ("
            + blgid + ", '"
            + UserName + "', '" + NewBlog + "', '" + timestamp + "')";
         stmt.executeUpdate(sqlStr);

         request.setAttribute("uname", UserName);
         request.getRequestDispatcher("homepage").forward(request, response);
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
