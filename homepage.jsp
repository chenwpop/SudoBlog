<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
  <title>SudoBlog Homepage</title>
  <style>
  /* bordered form */
  form {
      border: 3px;
  }

  /* full-width input */
  input[type=text], input[type=password] {
      width: 100%;
      padding: 12px 20px;
      margin: 8px 0;
      display: inline-block;
      border: 1px solid #ccc;
      box-sizing: border-box;
  }

  /* normal buttons */
  button {
      background-color: #4CAF50;
      color: white;
      padding: 14px 20px;
      margin: 8px 0;
      border: none;
      cursor: pointer;
      width: auto;
      margin-right:30px;
      margin-left:30px;
  }

  /* timestamp font */
  p.timestamp {
      font-style: italic;
      font-size: 12px;
  }

  /* so-called logo */
  span.logo {
      color:white;
      margin-left:10px;
      font-weight:bold;
      font-style: italic;
      font-size:20
  }

  /* button with hover */
  button:hover {
      opacity: 0.8;
  }

  /* light gray divider */
  div.light {
    background-color: #f1f1f1;
    padding-top: 15px;
    padding-right: 10px;
    padding-bottom: 30px;
    padding-left: 30px;
  }

  /* dark gray divider */
  div.dark {
    background-color: #d1d1d1;
    padding-top: 15px;
    padding-right: 10px;
    padding-bottom: 30px;
    padding-left: 30px;
  }

  /* bottom area */
  div.bottom {
    background-color: #f1f1f1;
    padding-top: 10px;
    padding-right: 10px;
    padding-bottom: 10px;
    padding-left: 10px;
  }

  /* push new blog */
  textarea {
      width: 100%;
      padding: 12px 20px;
      margin: 20px 0px 20px 0px;
      display: inline-block;
      border: 1px solid #ccc;
      box-sizing: border-box;
      font-size:15px;
  }

  /* padded containers */
  .container {
      padding: 16px;
      padding-left: 30px;
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
  <div class="container" style="background-color:#A0A0A0">
    <p>
      <font color="white" size=40px id="uname"><%=request.getAttribute("uname")%></font>
      <span class="logo">@SudoBlog</span>
    </p>

  </div>
  <form id = "form" action="http://localhost/SudoBlog/more">
    <script>
    var i = 0;
    var time;
    var ctnt;
    var node;

    <c:forEach items="${message}" var="content">
      if(i%2 == 0){
        div = document.createElement("div");
        div.className = "light";
        time = document.createElement("p");
        time.className = "timestamp";
        node = document.createTextNode("${content.key}");
        time.appendChild(node);
        div.appendChild(time);
        ctnt = document.createElement("p");
        node = document.createTextNode("${content.value}");
        ctnt.appendChild(node);
        div.appendChild(node);
        element = document.getElementById("form");
        element.appendChild(div);
      }else{
        div = document.createElement("div");
        div.className = "dark";
        time = document.createElement("p");
        time.className = "timestamp";
        node = document.createTextNode("${content.key}");
        time.appendChild(node);
        div.appendChild(time);
        ctnt = document.createElement("p");
        node = document.createTextNode("${content.value}");
        ctnt.appendChild(node);
        div.appendChild(node);
        element = document.getElementById("form");
        element.appendChild(div);
      }
      i++;
    </c:forEach>
    </script>
  </form>
  <form action="http://localhost/SudoBlog/postblog" method="post">
  <div style="padding-left:30px" id="bottom">
  <input type="hidden" name="uname" value=<%=request.getAttribute("uname")%>>
  <button class="button" type="submit" title="load more blogs"><b>
    <%=request.getAttribute("uname")%>.poll()</b>
  </button>
  <button class="button" type="submit" id="push" title="post new blog"><b>
    <%=request.getAttribute("uname")%>.offer()</b>
  </button>

  <textarea rows=10 placeholder="Post new blog..." name="content" required></textarea>
  </div>
</form>
</body>
</html>
