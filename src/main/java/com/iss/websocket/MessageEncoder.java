package com.iss.websocket;
import com.google.gson.Gson;

import jakarta.websocket.*;

public class MessageEncoder implements Encoder.Text<Message>
{
	 @Override
	 public void init(EndpointConfig ec) {
	    System.out.println("MessageEncoder - init method called");
	 }
	 
	 @Override
	 public String encode(Message message)
	 {System.out.println(message+"In Encode");
	 
	 	return new Gson().toJson(message);
	 	/*Gson gson=new Gson();
    	String gsonString = gson.toJson(message);
    	return gsonString;*/
	 }

	  @Override
	  public void destroy() 
	  {
	    System.out.println("MessageEncoder - destroy method called");
	  }
}