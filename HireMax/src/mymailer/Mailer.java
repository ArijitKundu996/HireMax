package mymailer;

import java.util.Properties;

import javax.mail.*;  
import javax.mail.internet.*;

public class Mailer {
	
	public static void send(String to,String subject,String msg){  
		  
		final String user=""; 
		final String pass="";  
		  
		//1st step) Get the session object    
		Properties props = new Properties();  
		props.put("mail.smtp.host", "smtp.gmail.com"); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.starttls.enable", "true");
		  
		Session session = Session.getDefaultInstance(props,  
		 new javax.mail.Authenticator() {  
		  protected PasswordAuthentication getPasswordAuthentication() {  
		   return new PasswordAuthentication(user,pass);  
		   }  
		});  
		//2nd step)compose message  
		try {  
		 MimeMessage message = new MimeMessage(session);  
		 message.setFrom(new InternetAddress(user));  
		 message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
		 message.setSubject(subject);  
		 message.setText(msg);  
		   
		 //3rd step)send message  
		 Transport.send(message);  
		   
		  
		 } catch (MessagingException e) {  
		    throw new RuntimeException(e);  
		 } 
	}


}
