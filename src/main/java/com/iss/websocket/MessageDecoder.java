package com.iss.websocket;

import jakarta.websocket.*;
import com.google.gson.Gson;

public class MessageDecoder implements Decoder.Text<Message>
{
	@Override
	public void init(EndpointConfig endpointConfig) 
	{
	    System.out.println("From MessageDecoder init()");
	}
	
	@Override
	public Message decode(String gsonMsg)throws DecodeException
	{System.out.println(gsonMsg + "From MessageDecoder Decode()");
	 
		return new Gson().fromJson(gsonMsg, Message.class); 
		/*
		Gson gson=new Gson();
    	Message message=gson.fromJson(gsonMsg, Message.class);
		System.out.println(message);
		return message;
		*/
	}

	@Override
	public boolean willDecode(String gsonMsg)
	{		
		try{
	    	System.out.println("gsonMsg: " + gsonMsg);
	    	Gson gson = new Gson();
			gson.fromJson(gsonMsg, Message.class);
	    	System.out.println("After the will decode");
	        return true;
	    }catch(Exception exception){
	    	exception.printStackTrace();
	      return false;
	    }
	}

	@Override
	public void destroy()
	{
	    System.out.println("From MessageDecoder destroy()");
	}
}