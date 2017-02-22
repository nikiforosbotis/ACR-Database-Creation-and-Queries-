CREATE PROCEDURE EmfanishPelathUpdated
(
@customer_code CHAR(10), --input parameter, customer_code from PELATHS
@date_of_birth DATETIME OUT, --output parameter, in case PELATHS IS A "APLOS"
@percentage_of_discount REAL OUT, --output parameter, in case PELATHS IS A "ETAIRIKOS"
@AFM CHAR(10) OUT --output parameter, in case PELATHS IS A "ETAIRIKOS"
)
AS
BEGIN
IF(@customer_code=(SELECT kwdikos_pel FROM APLOS WHERE @customer_code=APLOS.kwdikos_pel))
BEGIN
	SELECT @date_of_birth=hmeromhnia_gen
	FROM APLOS

	SELECT @date_of_birth as hmeromhnia_gennhshs
END
ELSE
BEGIN
	SELECT @percentage_of_discount=pososto_ekpt, @AFM=AFM
	FROM ETAIRIKOS

	SELECT @percentage_of_discount as pososto_ekptwshs, @AFM as AFM
END
END

/* DROP PROCEDURE EmfanishPelathUpdated */

DECLARE @date_of_birth AS DATETIME
DECLARE @percentage_of_discount AS REAL
DECLARE @AFM AS CHAR(10)
EXECUTE EmfanishPelathUpdated "01001", @date_of_birth output, @percentage_of_discount output, @AFM output
