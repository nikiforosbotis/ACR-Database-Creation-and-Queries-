CREATE PROCEDURE EmfanishPelath
(
@customer_code CHAR(10),  --input parameter, customer_code from PELATHS
@name CHAR(30) OUT, --output parameter to collect the customer's name from PELTHS
@address CHAR(20) OUT, --output parameter to collect the customer's address from PELATHS
@telephone CHAR(10) OUT, --output parameter to collect customer's phone from PELATHS
@areaid CHAR(10) OUT --output parameter to collect areaid from PELATHS
)
AS
BEGIN
SELECT @name=onomatepwnumo, @address=dieuthinsi, @telephone=thlephwno, @areaid=kwdikos_diam
FROM PELATHS
WHERE kwdikos_pel=@customer_code
END

/*
 DROP PROCEDURE EmfanishPelath
*/

--call the stored procedure
Declare @name as char(30) 
Declare @address as char(20) 
Declare @telephone as char(10) 
Declare @areaid as char(10)
Execute EmfanishPelath "01001", @name output, @address output, @telephone output, @areaid output 
select @name as onomatepwnumo,@address as dieuthinsi,@telephone as thlephwno,@areaid as kwdikos_diam    
