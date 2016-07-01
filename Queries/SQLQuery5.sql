DECLARE @arithmos_plaisiou CHAR(10), @xrwma CHAR(20), @montelo CHAR(20), @etairia_kataskeuhs CHAR(20), @hmeromhnia_agoras DATETIME, @kwdikos_kat CHAR(10);

DECLARE car_cursor CURSOR FOR
SELECT * 
FROM AYTOKINHTO

-------------------
--This is again the same decleration of variables as previous in case you want to declare once the cursor and to fetch results more than twice
--DECLARE @arithmos_plaisiou CHAR(10), @xrwma CHAR(20), @montelo CHAR(20), @etairia_kataskeuhs CHAR(20), @hmeromhnia_agoras DATETIME, @kwdikos_kat CHAR(10);

OPEN car_cursor;

--Perform the first fetch and store values in variables.

FETCH NEXT FROM car_cursor
INTO @arithmos_plaisiou, @xrwma, @montelo, @etairia_kataskeuhs, @hmeromhnia_agoras, @kwdikos_kat

--Check @@FETCH_STATUS to see if there are any more rows to fetch
WHILE @@FETCH_STATUS=0
BEGIN
	PRINT '����������: ' + '������� ��������: ' + @arithmos_plaisiou + '�����: ' + @xrwma + '�������: ' + @montelo + '������� ����������: ' + @etairia_kataskeuhs + '���������� ������: ' + cast(@hmeromhnia_agoras as CHAR(20)) + '������� ����������: ' + @kwdikos_kat

	FETCH NEXT FROM car_cursor
    INTO @arithmos_plaisiou, @xrwma, @montelo, @etairia_kataskeuhs, @hmeromhnia_agoras, @kwdikos_kat;
END

CLOSE car_cursor;
DEALLOCATE car_cursor;
