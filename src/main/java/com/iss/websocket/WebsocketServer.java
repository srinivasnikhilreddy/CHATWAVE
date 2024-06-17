package com.iss.websocket;

import java.sql.*;
import java.io.*;
import jakarta.websocket.server.*;
import jakarta.websocket.*;
import java.util.*;

@ServerEndpoint(value = "/nick", 
encoders = { MessageEncoder.class }, 
decoders = { MessageDecoder.class })
public class WebsocketServer
{
	Connection con;
	private static Set<Session> hs = new HashSet<>();
	private static Set<Session> All_sessions = Collections.synchronizedSet(hs);
    @OnOpen
    public void onOpen(Session session){
    	connectToDatabase();
        System.out.println("Client connected");
        All_sessions.add(session);
    }

    public void connectToDatabase() 
    {System.out.println("websocketserver connectToDatabase ");
        try {
        	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        	String connectionUrl = "jdbc:sqlserver://DESKTOP-90BV8QB\\SQLEXPRESS;databaseName=productdb;integratedSecurity=true;trustServerCertificate=true;";
   			this.con= DriverManager.getConnection(connectionUrl);
            
            System.out.println("Data base connected");
        }catch(SQLException e){
            e.printStackTrace();
        }
        catch(ClassNotFoundException ex){
        	ex.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(Message message, Session session) throws EncodeException {
    	System.out.println("websocketserver In OnMessage ");
        try{
            PreparedStatement pstmt = con.prepareStatement("insert into Messages_info values (?,?)");
            pstmt.setString(1, message.get_username());
            pstmt.setString(2, message.get_message());
            pstmt.executeUpdate();
            //con.close();
            pstmt.close();
            broadcast(message);
            session.getBasicRemote().sendObject(message);
        } catch (SQLException ex) 
        {
            ex.printStackTrace();
        }
        catch (IOException io) 
        {
            io.printStackTrace();
        }
    }
    private void broadcast(Message student)throws EncodeException {
    	System.out.println("websocketserver In broadcast ");
        for(Session s : All_sessions){
            try{
                s.getBasicRemote().sendObject(student);
            }catch(IOException e){
                e.printStackTrace();
            }
        }
    }
    
    @OnError
    public void onError(Session s, Throwable e) {
      System.out.println("Error Occured in OnError_WebSocket");
      e.printStackTrace();
    }
    
    @OnClose
    public void onClose(Session session) {
        System.out.println("Connection closed in OnError_WebSocket");
        All_sessions.remove(session);    
    }
}


/*package com.iss.websocket;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import jakarta.websocket.EncodeException;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnError;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/skt", 
    encoders = { MessageEncoder.class }, 
    decoders = { MessageDecoder.class })
public class WebsocketServer {
    Connection con;
    private static Set<Session> sessions = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session){
        connectToDatabase();
        System.out.println("Client connected.");
        sessions.add(session);
    }

    public void connectToDatabase(){
        System.out.println("websocketserver connectToDatabase ");
        try{
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String connectionUrl = "jdbc:sqlserver://DESKTOP-90BV8QB\\SQLEXPRESS;databaseName=productdb;integratedSecurity=true;trustServerCertificate=true;";
            this.con = DriverManager.getConnection(connectionUrl);

            System.out.println("Data base connected");
        }catch(SQLException e){
            e.printStackTrace();
        }catch(ClassNotFoundException ex){
            ex.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(Message message, Session session)throws EncodeException{
        System.out.println("websocketserver In OnMessage ");
        try{
            if (con == null) {
                // Database connection is not established, handle the situation accordingly
                System.out.println("Database connection is not established.");
                return;
            }
            
            PreparedStatement pstmt = con.prepareStatement("insert into Messages_info values (?,?)");
            pstmt.setString(1, message.get_username());
            pstmt.setString(2, message.get_message());
            pstmt.executeUpdate();
            pstmt.close();

            // Broadcast to all sessions of the specified user
            broadcast(message);
            session.getBasicRemote().sendObject(message);
        }catch(SQLException ex){
            ex.printStackTrace();
        }catch(IOException io){
            io.printStackTrace();
        }
    }

    private void broadcast(Message message)throws EncodeException{
        System.out.println("websocketserver In broadcast ");
        String username = message.get_username();
        for(Session s : sessions){
            if(s.getUserPrincipal().getName().equals(username)){
                try{
                    s.getBasicRemote().sendObject(message);
                }catch(IOException e){
                    e.printStackTrace();
                }
            }
        }
    }

    @OnError
    public void onError(Session session, Throwable error){
        System.out.println("Error");
        error.printStackTrace();
    }

    @OnClose
    public void onClose(Session session){
        System.out.println("Connection closed");
        sessions.remove(session);
    }
}
*/
