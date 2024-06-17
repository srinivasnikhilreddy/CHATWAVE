package com.iss.websocket;

public class Message{
    private String username;
    private String message;

    public void set_username(String value){
        username = value;
    }

    public String get_username(){
        return username;
    }

    public void set_message(String value){
        message = value;
    }

    public String get_message(){
        return message;
    }
}
