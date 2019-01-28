<%
String conflict=(String)request.getAttribute("conflict");
String message;
if(conflict=="true"){
  message = (String)request.getAttribute("message");//this will not show message when page will load first time
}else{
  message = " ";
}
%>

<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>SudoBlog Homepage</title>
  <style>
  /* Bordered form */
  form {
      border: 3px solid #f1f1f1;
  }

  /* Full-width inputs */
  input[type=text], input[type=password] {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid #ccc;
      box-sizing: border-box;
  }

  /* Set a style for all buttons */
  button {
      background-color: #4CAF50;
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      cursor: pointer;
      width: auto;
      margin-right:30px;
  }

  /* Add a hover effect for buttons */
  button:hover {
      opacity: 0.8;
  }

  /* Extra style for the cancel button (red) */
  .cancelbtn {
      background-color: #f44336;
  }

  /* Add padding to containers */
  .container {
      padding: 16px;
  }

  /* Change styles for span and cancel button on extra small screens */
  @media screen and (max-width: 300px) {
      .cancelbtn {
          width: 100%;
      }
  }
  </style>
</head>
<body>
  <h2>Welcome to SudoBlog</h2>
  <form action="http://localhost/SudoBlog/login" method="post">

    <div class="container">
      <label for="uname"><b>Username</b><small><font color="red" name="hidden">
      <%=message%></font></small></label>
      <input type="text" placeholder="Enter Username" name="uname" required>

      <label for="psw"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="psw" required>

      <button type="submit" class="button">Login</button>
    </div>

    <div class="container" style="background-color:#f1f1f1">
    <p>not yet <a href="signup.jsp" style="color:black">SudoBloger?</p>
  </form>

</body>
</html>
