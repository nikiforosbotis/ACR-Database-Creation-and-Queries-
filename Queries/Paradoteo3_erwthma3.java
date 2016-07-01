import java.io.*;
import java.text.*;
import java.util.*;
import java.sql.*;
import java.lang.ClassNotFoundException;

public class Paradoteo3_erwthma3 {

public static void main(String args[]) {
	Scanner reader = new Scanner(System.in);
	String url = "jdbc:odbc:nikiforosdimitrisdatabase";
	Connection dbcon = null ;
	Statement stmt = null;
  	ResultSet rs = null;

  	/* declare ODBC connectivity */
  	try {
		Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
		} catch (ClassNotFoundException e) {
			System.out.println("ClassNotFoundException");
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
			System.out.println("The given customer code is not correct. Try again!");
			System.out.println("Give customer's id");
	    	answer = reader.nextLine();
	    	counter++;
		}while(answer.startsWith("0100") == false);
	    rs = stmt.executeQuery("SELECT * FROM ENOIKIASH WHERE kwdikos_pel="+answer+" AND year(hmeromhnia1)=2005");
	    while(rs.next()) {
			  String kwdikos_en = rs.getString("kwdikos_en");
			  float aksia = rs.getFloat("aksia");
			  java.sql.Date hmeromhnia1 = rs.getDate("hmeromhnia1");
			  java.sql.Date hmeromhnia2 = rs.getDate("hmeromhnia2");
			  String arithmos_plaisiou = rs.getString("arithmos_plaisiou");
			  String kwdikos_top_paralavhs = rs.getString("kwdikos_top_paralavhs");
			  String kwdikos_top_epistrofhs = rs.getString("kwdikos_top_epistrofhs");
			  String kwdikos_pel = rs.getString("kwdikos_pel");
			    System.out.println("hire's code: " + kwdikos_en + ",value: " + aksia + "\t" + ",date of hire: " + hmeromhnia1 + "\t\n" + ",date of return: " + hmeromhnia2 +
			    "\t" + ",car's code: " + arithmos_plaisiou + ",code of receipt location: " + kwdikos_top_paralavhs + ",code of restitution location: " + kwdikos_top_epistrofhs +
			    ",customer's code: " + kwdikos_pel);
		  }
		rs.close();
		stmt.close();
		dbcon.close();
	} catch(Exception e3) {
		System.out.println(e3.getMessage());


	}
}
}
