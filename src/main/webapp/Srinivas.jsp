<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="jakarta.websocket.*" %>
<%@ page import="com.iss.websocket.*"%>
<%@ page import="jakarta.json.*"%>
<%@ page import="jakarta.websocket.server.*"%>
<%@ page import="jakarta.json.Json.*" %>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10">
    </script>
<style>
    body{
        font-family: Arial, Verdana;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
        background-image: url("https://i8.amplience.net/i/egl/studio-pay-230712-v2-background.png");
        background-repeat: no-repeat;
        background-size:  cover;
        overflow-y: hidden;
        overflow-x: hidden;
    }

    .usersList {
        display: flex;
        max-width: 400px;
        margin: 1px 1px auto;
        background-color:transparent;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        overflow-x: scroll;
        overflow-y: scroll;
        height: 89vh;
        flex-direction: column;
        font-size: 22px; 
    	font-weight: bold; 
    	font-family: Arial, Verdana; 
    }

    .userNames {
        list-style-type: none;
        padding: 0;
        margin: 5px 10px;
        width: 399px; 
        height: 100vh;
    }
    
    .head{
        box-sizing: border-box;
        border: 1px solid white;
        border-top: #f4f4f4;
        border-left: #e0e0e0;
        border-right: #e0e0e0;
        margin: 10px 10px ;
        font-size: 30px;
        font-family: Georgia, 'Arial Narrow', Arial, Verdana;
        color: white;
        padding: 10px;
        
        box-shadow:
        1px 1px 3px rgba(0, 0, 0, 0.2),
        -1px -1px 3px rgba(255, 255, 255, 0.3),
        0px 2px 6px rgba(0, 0, 0, 0.4), 
        0px 4px 12px rgba(0, 0, 0, 0.2),
        0px 9px 19px rgba(0, 0, 0, 0.15);   
    }
    .head1{
        box-sizing: border-box;
        border: 1px solid black;
        border-top: #f4f4f4;
        border-left: #e0e0e0;
        border-right: #e0e0e0;
        margin: 10px 10px ;
        font-size: 18px;
        font-family: Georgia, 'Arial Narrow', Arial, Verdana;
        color: white;
        padding: 10px;
        
        box-shadow:
        1px 1px 3px rgba(0, 0, 0, 0.2),
        -1px -1px 3px rgba(255, 255, 255, 0.3),
        0px 2px 6px rgba(0, 0, 0, 0.4), 
        0px 4px 12px rgba(0, 0, 0, 0.2),
        0px 9px 19px rgba(0, 0, 0, 0.15);   
    }
    .lsthed{
        margin: 0px ;

        box-sizing: border-box;

        font-size: 30px;
        font-family:Georgia ;
        position: relative;
        
        left:0px;
        font-style: italic;
        color: lightseagreen;
        text-shadow: 1.1px 1.1px 3px rgba(0, 0, 0, 0.55); 

        font-weight: bold;
        border: 1px solid gray;
        background: linear-gradient(to bottom, rgb(237, 15, 189), rgb(11, 11, 11));
        height: 11vh;
        max-width: 500vw;
        box-shadow: 1px 2px 5px black ;
    }

    #chatw{
        position: relative;
        left: 70px;
        bottom: 83px;
    }
    img{
        margin: 7px 5px ;
        height: 50px;
        width: 50px;
        box-sizing: border-box;
        border-radius: 30px;
        position: relative;
        top: 10px;
    }

    
    .usersList::-webkit-scrollbar {
        width: 5px;
    }

    .usersList::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 5px;
    }

    .usersList::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.4);
    }
    li{
        box-sizing: border-box;
        margin: 5px;
        padding: 1px 10px 10px 1px;
        border-radius: 7px;

    }
    li:hover{
        background-color: rgb(245, 238, 238,0.2);
    }
    #messageContainer2{
        position: fixed;
        top: 81px;
        right: 10px;
        text-align: right;
        padding-right: 20px;
        width: 335px;
        height: 80vh;
        border-radius: 30px;
        overflow-x: hidden;
    }
    
    #messageContainer2::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.01);
        border-radius: 5px;
    }

    
    #messageContainer2::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.4);
    }
    
    .message-container2 {
	    position: relative;
	    margin: 20px;
	    padding-right: 20px;
	    width: 300px;
	    max-width: 500px;
	    border: 1px solid #ccc;
	    background-color: transparent;
	    padding: 10px;
	    margin-bottom: 5px;
	    border-radius: 10px;
	    color: black;
	    font-family: Arial, Georgia, Verdana;
	    text-transform: capitalize;
	    word-wrap: break-word;
	    text-align: justify;
	    display: block; 
	}
    .message-container2 img {
	    vertical-align: middle;
	    margin-right: 10px;
	}
	
	.message-container2:hover {
	    background-color: black;
	}
    #messageContainer2::-webkit-scrollbar {
        width: 2px;
    }
	
    #message{
        box-sizing: border-box;
        position: fixed;
        bottom: 2px;
        right: 80px;
        height:61px;
        width: 1000px;
        background-color: transparent;
        color: white;
        border: 1px solid black;
        font-size: medium;
        font-weight: 300;
        text-transform: capitalize;
        text-decoration: none;
        font-size: x-large;
        overflow: hidden;
        border-radius: 15px;
        
    }
    #img2{
        margin: 0px;
        padding: 1px 5px 10px 1px ;
        box-sizing: border-box;
        border: 1px solid gray;
        position: fixed;
        bottom: 8px;
        right: 5px;
        height: 55px;
        border-radius: 70px;
    }
    #img2:hover{
        background-color: rgba(255, 255, 255, 0.4);
    }
    #img2 img{
        position: relative;
        top: -5px;
        left: 8px;
    }
    #sendMessageBtn img{
        position: fixed;
        top: 90vh;
        right: 5px;
        width: 70px;
        height: 59px; 

    }
    #sendMessageBtn{
        box-sizing: border-box;
        background-color: #45a049;
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
		    String username = (String)session.getAttribute("username");
		    String alertMsg = (String)session.getAttribute("AlertMessage");
		    if (alertMsg != null && !alertMsg.isEmpty()) {
		%>
		    <script> 
			    setTimeout(function() {
			        Swal.fire({
			            title: 'Nice move!',
			            text: '<%= alertMsg %>'+' You are Connected!',
			            icon: 'success',
			            confirmButtonText: 'OK',
		            	customClass: {
		                    popup: 'sweet-popup',
		                    title: 'sweet-title',
		                    content: 'sweet-content'
		                }
			        });
			    }, 1000); 
		    </script>
		<%
		        session.removeAttribute("AlertMessage");
		    }
		%>

<div class="lsthed"><img src="https://th.bing.com/th/id/OIP.0jw2uGYArbnugCN8gvlJrAAAAA?rs=1&pid=ImgDetMain" alt=" img not found"><h3 id="chatw">CHAT WAVE</h3></div>
 <div class="user-list">
        <ul class="usernames">
            <div class="head" style="color: white;">Connected Users</div>
            	<li id="usernamesList"></li>
		</ul>
</div>

<div id="messageContainer"><div id="messageContainer2"></div></div>
<input type="text" name="username" id="username" value="<%= username %>" style="display: none;">
<input type="text" name="message" id="message" placeholder="Message..." onkeydown="handleKeyPress(event)">
<span id="sendMessageBtn" onclick="send()"> <img width="100" height="100" src="https://img.icons8.com/color/96/sent--v1.png" alt="sent--v1"/></span>


<script>
    // Establish WebSocket connection
    var socket = new WebSocket("ws://192.168.0.106:9102/Dwebsocket/nick");//change ip acc to wifi, port acc to server(put anything after a while).
    var messages = [];
    var usernames = [];

    socket.onopen = function (event){
        onOpen(event);
    };
    
    socket.onmessage = function (event){
        onMessage(event);
    };
    
    socket.onerror = function (event){
        onError(event);
    };

    function onOpen(event) {
    	//this message is displaying above
    	//alert('Connection established');
    	/*setTimeout(function() {
            Swal.fire({
                title: 'Hey!',
                text: 'You are Connected!',
                icon: 'success',
                confirmButtonText: 'OK',
                customClass: {
                    popup: 'swal2-popup',
                    title: 'swal2-title',
                    content: 'swal2-content'
                }
            });
    	}, 3000);*/
    }
 	
    function onMessage(event){
       var json = JSON.parse(event.data);
       
       var isDuplicate = messages.some(function(msg){
           return msg.username === json.username && msg.message === json.message;
       });
    
       if(!isDuplicate){
           messages.push(json); 
           displayMessages(); 
           if(!usernames.includes(json.username)){
               usernames.push(json.username); 
               displayUsernames(); 
           }
       }
    }
    
    function displayMessages(){
        var messageContainer = document.getElementById("messageContainer2");
        messageContainer.innerHTML = "";
        
        messages.forEach(function (msg){
            var newMessageDiv = document.createElement("div");
            newMessageDiv.className = "message-container2";
            
            var usernameSpan = document.createElement("span");
            usernameSpan.style.color = "red";
            usernameSpan.textContent = msg.username + ": ";
            
            var messageSpan = document.createElement("span");
            messageSpan.style.color = "white";
            messageSpan.textContent = msg.message;
            
            newMessageDiv.appendChild(usernameSpan);
            newMessageDiv.appendChild(messageSpan);
            
            messageContainer.appendChild(newMessageDiv);
            
            messageContainer.scrollTop = messageContainer.scrollHeight;
        });
    }

    function displayUsernames(){
        var usernamesList = document.getElementById("usernamesList");
        usernamesList.innerHTML = ""; 
        var uniqueUsernames = new Set(usernames);
        uniqueUsernames.forEach(function (username) {
            var li = document.createElement("li");
                li.textContent = username;
                li.style.color = "darkred";
                li.style.fontWeight = "bold";
                li.style.boxShadow = "2.1px 2.1px 4.9px rgba(0, 0, 0, 0.51)";
            usernamesList.appendChild(li);
        });
    }
	
    function handleKeyPress(event) {
        if (event.keyCode === 13) {
            send(); // Call the send() when Enter key is pressed
        }
    }
    
    function send(){
        var username = document.getElementById('username').value; 
        var message = document.getElementById('message').value;
        var json = {
            'username': username,
            'message': message
        };
        socket.send(JSON.stringify(json));
        document.getElementById('message').value = "";
        return false;
    }
    
    function onError(event){
        alert("Error");
        console.log(event);
    }
</script>
</body>
</html>

