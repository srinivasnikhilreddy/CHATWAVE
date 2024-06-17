<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="jakarta.websocket.*" %>
<%@ page import="com.iss.websocket.*"%>
<%@ page import="jakarta.json.*"%>
<%@ page import="jakarta.websocket.server.*"%>
<%@ page import="jakarta.json.Json.*" %>
<!DOCTYPE html>
<html lang="en">
<meta charset="UTF-8">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10">
    </script>
    
<style>
    body {
	    font-family: Arial, Verdana;
	    margin: 0;
	    padding: 0;
	    background-image: url("https://resources.learnquest.com/wp-content/uploads/2023/07/Client-Server-Network-Model-768x403.jpg");
	    background-size: cover;
	    background-repeat: no-repeat;
	}
	
	.header {
	    height: 80px;
	    color: #fff;
	    padding: 10px 20px;
	    display: flex;
	    justify-content: flex-start;
	    align-content: space-between;
	    margin: 0px;
	    border: 1px solid gray;
	    border-radius: 6px;
	    background-image: linear-gradient(to bottom, rgb(243, 36, 233), rgb(26, 24, 24));
	}
	
	.container {
	    width: 850px;
	    margin: 0 auto;
	    padding: 20px;
	    position: fixed;
	    top: 200px;
	    left: 50px;
	}
	
	.main-content {
	    display: flex;
	    justify-content: space-between;
	    align-items: flex-start;
	}
	
	.left-column {
	    flex: 1;
	    margin-right: 20px;
	}
	
	.right-column {
	    flex: 1;
	    margin-left: 20px;
	}
	
	.login-form {
	    position: relative;
	    background-color: rgba(255, 255, 255, 0.2);
	    border: 1px solid gray;
	    border-radius: 5px;
	    padding: 20px;
	    height: 200px;
	}
	
	.login-form::before {
	    content: "";
	    position: absolute;
	    top: -10px;
	    left: -10px;
	    right: -10px;
	    bottom: -10px;
	    background: inherit;
	    filter: blur(400px);
	    z-index: -1;
	    border-radius: inherit;
	}
	
	.login-form h2 {
	    margin-top: 0;
	}
	
	.login-form input[type="text"],
	.login-form input[type="password"] {
	    width: 100%;
	    padding: 10px;
	    margin-bottom: 10px;
	    border: 1px solid #ccc;
	    border-radius: 4px;
	    box-sizing: border-box;
	}
	
	.login-form button {
	    background-color: #3b5998;
	    color: #fff;
	    padding: 10px 20px;
	    border: none;
	    border-radius: 4px;
	    cursor: pointer;
	}
	
	.login-form button:hover {
	    background-color: #2d4373;
	}
	
	.picture {
	    width: 100%;
	    height: auto;
	}
	
	.tag {
	    text-align: center;
	    font-family: 'Times New Roman', Times, serif;
	}
	
	button {
	    position: relative;
	    left: 10px;
	}
	
	.sn {
	    text-align: center;
	    font-size: medium;
	    font-family: sans-serif;
	}
	
	.header2 {
	    margin: -10px;
	    position: fixed;
	    right: 40px;
	}
	
	.sng {
	    color: rgb(218, 31, 31);
	}
	
	.sng:hover {
	    cursor: pointer;
	    color: aqua;
	}
	
	.cw {
	    font-family: sanserif;
	    font-size: 40px;
	    position: relative;
	    top: -75px;
	    left: 65px;
	    color: aqua;
	}
	
	img {
	    margin: 7px 5px;
	    height: 50px;
	    width: 50px;
	    box-sizing: border-box;
	    border-radius: 30px;
	    position: relative;
	    top: 10px;
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
	
</head>
<body>
	<%
	    String alertMsg = (String)session.getAttribute("AlertMessage");
	    if (alertMsg != null && alertMsg.equals("Registration successful!")) 
	    {
	%>
	        <script>
	                setTimeout(function() {
	                    Swal.fire({
	                        title: 'Nice move!',
	                        text: '<%= alertMsg %>',
	                        icon: 'success',
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
	    }else if (alertMsg != null && alertMsg.equals("Invalid username or password.")) 
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
        String username = "";
    	String password = "";
        if (request.getMethod().equals("POST")&&request.getParameter("username")!=null&&request.getParameter("username")!=null)
        {
        	username = request.getParameter("username");
            password = request.getParameter("password");
            
            if(username != null && !username.isEmpty() && password != null && !password.isEmpty())
            {
             try{
            	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection con = DriverManager.getConnection("jdbc:sqlserver://DESKTOP-90BV8QB\\SQLEXPRESS;databaseName=productdb;integratedSecurity=true;trustServerCertificate=true;");
                PreparedStatement pstmt = con.prepareStatement("SELECT * from chat_profiles WHERE UserName=? AND Password=?");
				pstmt.setString(1, username);
        		pstmt.setString(2, password);
                
                ResultSet res = pstmt.executeQuery();

                if(res.next()){
                    session.setAttribute("username", username);
                    
                    session.setAttribute("AlertMessage", "Login successful!"); 
                    response.sendRedirect("Srinivas.jsp");
                }else{
                    session.setAttribute("AlertMessage", "Invalid username or password."); 
                    response.sendRedirect("Login.jsp");
                }
                res.close();
                pstmt.close();
                con.close();
            	}catch(SQLException e){
                	e.printStackTrace();
                	session.setAttribute("AlertMessage", "An error occurred. Please try again later.");
                	response.sendRedirect("Login.jsp"); 
            	}
        	}
        }
    %>

<div class="header">
<div class="img"><img src="https://th.bing.com/th/id/OIP.0jw2uGYArbnugCN8gvlJrAAAAA?rs=1&pid=ImgDetMain" alt=" img not found"><h1 class="cw">CHAT WAVE</h1></div>
    <div class="header2"> <h3 class="tg">Didn't sign up?  </h3><div class="s"><a class="sng" href="Signup.jsp">sign up here</a></div></div>
</div>

<div class="container">
    <div class="main-content">
        <div class="left-column"></div>
        <div class="right-column">
            <div class="login-form">
                <h2>Login</h2>
                <form action=Login.jsp method='post'>
                 	<input type="text" name="username" id="username" placeholder="Username" required><br>
                	<input type="password" name="password" id="password" placeholder="Password" required><br>
                	<button type="submit" >Login</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>