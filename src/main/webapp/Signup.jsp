<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10">
    </script>
	<meta charset="UTF-8">
<title>Sign Up</title>
<style>
	   body{
	       font-family: Arial, Verdana;
	       background-color: #f4f4f4;
	       margin: 0;
	       padding: 0;
	       background-image: url("https://resources.learnquest.com/wp-content/uploads/2023/07/Client-Server-Network-Model-768x403.jpg");
	       background-size: cover;
	       background-repeat: no-repeat;
	   }
	   .container{
		   position: relative;
		   max-width: 400px;
		   margin: 100px auto;
		   padding: 20px;
		   background-color: rgba(256, 256, 256, 0.11); 
		   border-radius: 15px;
		   box-shadow: 1px 1px 9.9px rgba(0, 0, 0, 0.11);
		   text-align: left;
		   transition: all 0.3s ease-in-out;
	}
	
	.container::before{
	   content: ""; 
	   position: absolute;
	   top: -10px;
	   left: -10px;
	   right: -10px;
	   bottom: -10px; 
	   background: inherit;
	   filter: blur(10px); 
	   z-index: -1;
	   border-radius: 15px; 
	}
	
   input[type="text"]{
       width: calc(60% - 50px);
       padding: 10px;
       margin: 10px 0;
       border: 1px solid #ccc;
       border-radius: 4px;
       box-sizing: border-box;
   }
   input[type="email"],
   input[type="password"],
   input[id="username"],
   input[type="date"],
   input[id="rollno"] {
       width: calc(100% - 5px);
       padding: 10px;
       margin: 10px 0;
       border: 1px solid #ccc;
       border-radius: 4px;
       box-sizing: border-box;
   }
   input[type="text"]:first-child{
       margin-right: 10px;
   }
   button{
       background-color: blue;
       color: #fff;
       padding: 10px 20px;
       border: none;
       border-radius: 4px;
       cursor: pointer;
       transition: all 0.3s ease-in-out;
      
   }
   button:hover{
       background-color: rgb(106, 106, 187);
   }
   .btn{
       position: relative;
       left: 307px;
       bottom: 39px;
   }
   .btn2{
       color: #fff;
       padding: 10px 20px;
       margin: 10px 0;
       border: none;
       border-radius: 4px;
       cursor: pointer;
       transition: all 0.3s ease-in-out;
       display: flex;
       align-items: flex-start;
       justify-content: space-between;
   }
   .sweet-popup {
        width: 300px !important;
        background-color: transparent;
        padding: 10px;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
        position: relative;
	    right: 30px;
    }

    .sweet-title {
        font-size: 1.27em;
        color: white;
    }

    .sweet-content {
        font-size: 1.1em;
        color: white;
    }
</style>
	<script>
	    function goBack(event){
	        event.preventDefault();
	        window.history.back();
	    }
	</script>
	
	
</head>
<body>
	<%
	    String alertMsg = (String)session.getAttribute("AlertMessage");
	    if (alertMsg != null && alertMsg.equals("Registration failed. Please try again.")) 
	    {
	%>
			 <script>
			     setTimeout(function() {
			         Swal.fire({
			             title: 'Oops!',
			             text: '<%= alertMsg %>',
			             icon: 'error',
			             confirmButtonText: 'OK',
			             customClass: {
			            	 popup: 'sweet-popup',
	                         title: 'sweet-title',
	                         content: 'sweet-content'
			             }
			         });
			     }, 100); 
			</script>
	 <%
	 		session.removeAttribute("AlertMessage");
	    }else if (alertMsg != null && alertMsg.equals("An error occurred. Please try again later.")) 
	    {
	%>	
	    	<script>
			     setTimeout(function() {
			         Swal.fire({
			             title: 'Oops!',
			             text: '<%= alertMsg %>',
			             icon: 'warning',
			             confirmButtonText: 'OK',
			             customClass: {
			            	 popup: 'sweet-popup',
	                         title: 'sweet-title',
	                         content: 'sweet-content'
			              }
			         });
			     }, 100); 
			 </script>	
	<% 
		session.removeAttribute("AlertMessage");
	    }
	 %>

    <%
        if(request.getMethod().equals("POST")&&request.getParameter("firstName")!=null&&request.getParameter("lastName")!=null&&request.getParameter("rollno")!=null&&request.getParameter("email")!=null&&request.getParameter("dob")!=null&&request.getParameter("username")!=null&&request.getParameter("password")!=null) {
        	String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String rollno = request.getParameter("rollno");
            String email = request.getParameter("email");
            String dob = request.getParameter("dob");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
          
            if(firstName != null && !firstName.isEmpty() &&
                    lastName != null && !lastName.isEmpty() &&
                    rollno != null && !rollno.isEmpty() &&
                    email != null && !email.isEmpty() &&
                    dob != null && !dob.isEmpty() &&
                    username != null && !username.isEmpty() &&
                    password != null && !password.isEmpty())
            {
            	try{
	            	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	                Connection con = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-90BV8QB\\SQLEXPRESS;databaseName=productdb;integratedSecurity=true;trustServerCertificate=true;");
	                PreparedStatement pstmt = con.prepareStatement("INSERT INTO chat_profiles VALUES (?, ?, ?, ?, ?, ?, ?)");
	                pstmt.setString(1, firstName);
	                pstmt.setString(2, lastName);
	                pstmt.setString(3, rollno);
	                pstmt.setString(4, email);
	                pstmt.setString(5, dob);
	                pstmt.setString(6, username);
	                pstmt.setString(7, password);
	                int rowsAffected = pstmt.executeUpdate();
	
	                if (rowsAffected > 0) {
	                    session.setAttribute("AlertMessage", "Registration successful!");
	                    response.sendRedirect("Login.jsp"); 
	                } else {
	                    session.setAttribute("AlertMessage", "Registration failed. Please try again.");
	                    response.sendRedirect("Signup.jsp"); 
	                }
	                pstmt.close();
	                con.close();
	           }catch(SQLException e){
	               e.printStackTrace();
	               session.setAttribute("AlertMessage", "An error occurred. Please try again later.");
	               response.sendRedirect("Signup.jsp"); 
	           }
            }
        }
    %>
    
	<div class="container">
    	<h2>Sign Up</h2>
    	<form action="Signup.jsp" method='post'>
	        <input type="text" id="firstName" name="firstName" placeholder="First Name" required>
	        <input type="text" id="lastName" name="lastName" placeholder="Last Name"  required><br>
	        <input type="email" id="email" name="email" placeholder="Email"  required><br>
	        <input type="text" id="rollno" name="rollno" placeholder="Roll No"  required><br>
	        <input type="date" id="dob" name="dob" placeholder="DD-MM-YYYY"  required><br>
	        <input type="text" id="username" name="username" placeholder="Username"  required><br>
	        <input type="password" id="password" name="password" placeholder="Password"  required><br>
	    	<div class="btn2"><button class="bt" onclick="goBack(event)">Go Back</button>
	    		<button class="bt" type="submit">Sign up</button>
	    	</div>
    	</form>
	</div>
	
</body>
</html>