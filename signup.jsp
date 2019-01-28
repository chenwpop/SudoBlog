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

    /* Add space for adjacent items */
    .divider {
        width:20px;
        height:auto;
        display:inline-block;
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
  <form action="http://localhost/SudoBlog/signup" method="post" style="border:1px solid #ccc">
    <div class="container">
      <p>Please fill in this form to create an account.</p>
      <div>
        <label for="uname"><b>Username</b><small><font color="red" name="hidden">
        <%=message%></font></small></label>
        <input type="text" placeholder="Enter Username" name="uname" required>

        <script language='javascript' type='text/javascript'>
          function setVal(input){
            document.getElementById('usrname_conflict').value = input;
          }
        </script>

        <label for="psw"><b>Password</b></label>
        <input type="password" placeholder="Enter Password"
        pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at
        least one number and one uppercase and lowercase letter, and at least
        8 or more characters" name="psw" id="psw" required>

        <label for="psw-repeat"><b>Confirm</b></label>
        <input type="password" placeholder="Repeat Password"
        oninput="check()" name="psw-confirm" id="psq-confirm" required>

        <script language='javascript' type='text/javascript'>
            function check(input){
                if (document.getElementById('psw-confirm').value !=
                    document.getElementById('psw').value){
                    input.setCustomValidity('Password Not Matched!');
                }else{
                  confirm_password.setCustomValidity('');
                }
            }
        </script>

        <div class="clearfix">
          <button type="submit" class="signupbtn">Sign Up</button>
          <button type="button" class="cancelbtn">Cancel</button>
        </div>
        <p></p>
        <small>Enjoy @SudoBlog. All Rights Reserved.</small>
      </div>
    </div>
  </form>
</body>
</html>
