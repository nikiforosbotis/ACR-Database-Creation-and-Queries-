import java.io.*;
import java.text.*;
import java.util.*;
import java.sql.*;
import java.lang.ClassNotFoundException;

public class Paradoteo3_erwthma2 {

public static void main(String args[]) {
	Scanner reader = new Scanner(System.in);
	String url = "jdbc:odbc:nikiforosdimitrisdatabase";
	Connection dbcon = null ;
	Statement stmt = null;

  	/* declare ODBC connectivity */
  	try {
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("Class not found exception");
			System.out.println(e.getMessage());
		}
	try {
		dbcon = DriverManager.getConnection(url,"G525","4757894");
		        } catch(Exception e2) {
		        System.out.println("Could not establish the Connection : "+e2.getMessage());
		        System.out.println("Check username or password");
			}

	try {
		stmt = dbcon.createStatement();
		String answer;
		int counter = 0;
		do {
			if(counter >= 1)
			   System.out.println("You did not give a correct hire's code. Try again!");
			System.out.println("Give the hire's code you want to delete");
	    	answer = reader.nextLine();
	    	counter++;
		}while (answer.startsWith("5555") == false);
	    String sql1 = "DELETE FROM PLHRWMH WHERE kwdikos_en="+answer+"";
	    stmt.executeUpdate(sql1);
		String sql2 = "DELETE FROM ENOIKIASH WHERE kwdikos_en="+answer+"";
		stmt.executeUpdate(sql2);
		stmt.close();
		dbcon.close();
	} catch(Exception e3) {
		System.out.println(e3.getMessage());
	}

  	}
  }
