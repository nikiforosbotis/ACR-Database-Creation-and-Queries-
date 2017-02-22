/* QUESTION 1: ����� ��� ����� ��� ������� �� ��� ������ ����, �� ������� ����, �� ��������� ���� ��� �� �������� ����. *  */
SELECT kwdikos_pel, onomatepwnumo, dieuthinsi, thlephwno
FROM PELATHS;

/* QUESTION 2: ����� ��� ���� ��������� ��� ������ ��� ��� �� ������� �������� ��� (���,���), ��� � ���� ����� ���� ��� 200 ����. *  */
SELECT kwdikos_en, hmeromhnia1, hmeromhnia2
FROM ENOIKIASH
WHERE aksia>200;

/* QUESTION 3: ��� ���� ������, ����� ��� ������ ���, �� ������������� ���, �� �������� ��� ��� ���� �������� ��� ����������� ��� ���� �����. * */
SELECT P.kwdikos_pel, P.onomatepwnumo, P.thlephwno, E.kwdikos_en
FROM PELATHS P, ENOIKIASH E
WHERE P.kwdikos_pel=E.kwdikos_pel
ORDER BY P.kwdikos_pel;

/* QUESTION 4: ����� �� ������������� ��� �������� ��� ������� ��� ����� ���� ������ ���� ���������� ��� 23/9/2010 ��� ����������� ��� ��������� ������� �� ������ 10025. */
SELECT onomatepwnumo, thlephwno
FROM PELATHS P, ENOIKIASH E
WHERE P.kwdikos_pel=E.kwdikos_pel AND hmeromhnia1<'23/9/10' AND hmeromhnia2>'23/9/10' AND kwdikos_diam=10025;

/* QUESTION 5: ������ ��� ���� ���� ��� ����������� ���� 5%. * */
UPDATE ENOIKIASH 
SET aksia=aksia*0.95;

/* QUESTION 6: ����� ��� ���� ���� ��� 2010 �� ������ ��� �� ���� ��� �������� ��� ����� �����.*/
SELECT month(hmeromhnia_plhrwmhs) as mhnas, sum(poso_plhrwmhs) as sunolo, avg(poso_plhrwmhs) as mesos_oros
FROM PLHRWMH
WHERE year(hmeromhnia_plhrwmhs)=2010
GROUP BY month(hmeromhnia_plhrwmhs);


/* QUESTION 7: ����� �� �������� ���� ��� ����������� ��� ��������� ����������� ��� ���������� ����������. */
SELECT K.kwdikos_kat, GD.kwdikos_diam, sum(E.aksia) as sunolo
FROM ENOIKIASH E, PELATHS P, AYTOKINHTO A, KATHGORIA K, GEWGRAFIKODIAMERISMA GD
WHERE E.kwdikos_pel=P.kwdikos_pel AND E.arithmos_plaisiou=A.arithmos_plaisiou AND A.kwdikos_kat=K.kwdikos_kat AND P.kwdikos_diam=GD.kwdikos_diam 
GROUP BY K.kwdikos_kat, GD.kwdikos_diam
ORDER BY K.kwdikos_kat;

/* QUESTION 8: ����� ���� �������� ��� ������� ��� ����� ��� �� ���� ������ 2010 ���� ��� 4 ����������� ��� � ���� ���� ���������� ���� ���� ��� 150 ����. */ 
SELECT P.kwdikos_pel
FROM PELATHS P, ENOIKIASH E
WHERE P.kwdikos_pel=E.kwdikos_pel AND month(hmeromhnia1)=6 AND year(hmeromhnia1)=2010
GROUP BY P.kwdikos_pel
HAVING COUNT(E.kwdikos_pel)>4 AND avg(E.aksia)>150;

/* QUESTION 9: ��������������� ����������� ������������, ������ ��� ������ ��� �� ������������� ��� ������� ��� ����� ����� ��������� �������� ��� ������� ��� 2010 ���� ��� 1500 ����.  */
SELECT P.kwdikos_pel, P.onomatepwnumo
FROM PELATHS P
WHERE 1500<(SELECT sum(PL.poso_plhrwmhs)
            FROM PLHRWMH PL, ENOIKIASH E
            WHERE P.kwdikos_pel=E.kwdikos_pel AND PL.kwdikos_en=E.kwdikos_en AND month(PL.hmeromhnia_plhrwmhs)=4 AND year(PL.hmeromhnia_plhrwmhs)=2010);

/* QUESTION 10: ��� ���� ��������� �����������, ����� �� �������� ���� ����������� ��� ���������� ��� ������� ��� ��������� ����� ���� ��� �����������. */
GO
CREATE VIEW SUNOLIKH_AKSIA(sum_aksia) AS
SELECT sum(aksia)
FROM ENOIKIASH;

GO
CREATE VIEW AKSIA_ANA_KATHGORIA(kwdikos_kat, sum_aksia_kat) AS
SELECT K.kwdikos_kat, sum(E.aksia)
FROM KATHGORIA K, ENOIKIASH E, AYTOKINHTO A
WHERE E.arithmos_plaisiou=A.arithmos_plaisiou AND A.kwdikos_kat=K.kwdikos_kat
GROUP BY K.kwdikos_kat;

/* drop view SUNOLIKH_AKSIA;
   drop view AKSIA_ANA_KATHGORIA; */

SELECT AKSIA_ANA_KATHGORIA.kwdikos_kat, ((cast(AKSIA_ANA_KATHGORIA.sum_aksia_kat as float)/cast(SUNOLIKH_AKSIA.sum_aksia as float)) *100) as pososto_kathgorias
FROM SUNOLIKH_AKSIA,AKSIA_ANA_KATHGORIA;

/* QUESTION 11: ��� ���� ���� ��� 2010, �������� ��� ��������� �������� ��� ���� �� ����� ��� ����������� ���� ��� 2009(��� �������). */
GO
CREATE VIEW PLHRWMES_ANA_MHNA_2009(mhnas, sunolikes_plhrwmes) as
SELECT month(hmeromhnia_plhrwmhs), sum(poso_plhrwmhs)
FROM PLHRWMH
WHERE year(hmeromhnia_plhrwmhs)=2009
GROUP BY month(hmeromhnia_plhrwmhs);

GO
CREATE VIEW PLHRWMES_ANA_MHNA_2010(mhnas, sunolikes_plhrwmes) as
SELECT month(hmeromhnia_plhrwmhs), sum(poso_plhrwmhs)
FROM PLHRWMH
WHERE year(hmeromhnia_plhrwmhs)=2010
GROUP BY month(hmeromhnia_plhrwmhs);

/* drop view PLHRWMES_ANA_MHNA_2009;
drop view PLHRWMES_ANA_MHNA_2010; */

SELECT PLHRWMES_ANA_MHNA_2010.mhnas, (cast((PLHRWMES_ANA_MHNA_2010.sunolikes_plhrwmes-PLHRWMES_ANA_MHNA_2009.sunolikes_plhrwmes) as float)/cast(PLHRWMES_ANA_MHNA_2009.sunolikes_plhrwmes as float) *100) as pososto_plhrwmwn
FROM PLHRWMES_ANA_MHNA_2009,PLHRWMES_ANA_MHNA_2010
WHERE PLHRWMES_ANA_MHNA_2009.mhnas=PLHRWMES_ANA_MHNA_2010.mhnas
GROUP BY PLHRWMES_ANA_MHNA_2010.mhnas, PLHRWMES_ANA_MHNA_2009.sunolikes_plhrwmes, PLHRWMES_ANA_MHNA_2010.sunolikes_plhrwmes;

/* QUESTION 12: ����� ���� �������� ��� ����������� ������������� ��� ����� ���� ���� ���������� ���������� ��� �� �������� ���� ���� ����������. */
GO
CREATE VIEW MESH_AKSIA_ANA_GD(kwdikos_diam, mesh_aksia) as
SELECT GD.kwdikos_diam, avg(E.aksia)
FROM GEWGRAFIKODIAMERISMA GD, PELATHS P, ENOIKIASH E
WHERE GD.kwdikos_diam=P.kwdikos_diam AND E.kwdikos_pel=P.kwdikos_pel 
GROUP BY GD.kwdikos_diam;

GO 
CREATE VIEW MESH_AKSIA(synolikh_mesh_aksia) as
SELECT avg(aksia)
FROM ENOIKIASH;

/* drop view MESH_AKSIA_ANA_GD;
drop view MESH_AKSIA; */

SELECT MESH_AKSIA_ANA_GD.kwdikos_diam 
FROM MESH_AKSIA_ANA_GD,MESH_AKSIA
WHERE MESH_AKSIA_ANA_GD.mesh_aksia>MESH_AKSIA.synolikh_mesh_aksia;

/* QUESTION 13: ��� ���� ����, ������� ����� ������� ����� ���� ���� ���������� ���������� ��� �� �������� ���� ���� ��� ����. */
GO
CREATE VIEW MESH_AKSIA_ANA_MHNA(mhnas, mesh_aksia) as
SELECT month(E.hmeromhnia1), avg(E.aksia)
FROM ENOIKIASH E
GROUP BY month(E.hmeromhnia1);

GO
CREATE VIEW MESH_AKSIA_PELATH(kwdikos_pel, mhnas, mesh_aksia) as
SELECT P.kwdikos_pel, month(E.hmeromhnia1), avg(E.aksia)
FROM ENOIKIASH E, PELATHS P
WHERE E.kwdikos_pel=P.kwdikos_pel
GROUP BY P.kwdikos_pel, month(E.hmeromhnia1);

/* drop view MESH_AKSIA_ANA_MHNA;
drop view MESH_AKSIA_PELATH; */

SELECT MESH_AKSIA_PELATH.mhnas, COUNT(MESH_AKSIA_PELATH.kwdikos_pel) as arithmos_pelatwn
FROM MESH_AKSIA_ANA_MHNA,MESH_AKSIA_PELATH
WHERE MESH_AKSIA_ANA_MHNA.mhnas=MESH_AKSIA_PELATH.mhnas AND MESH_AKSIA_PELATH.mesh_aksia>MESH_AKSIA_ANA_MHNA.mesh_aksia
GROUP BY MESH_AKSIA_PELATH.mhnas;

/* QUESTION 14: ��� ���� ���� ��� 2010, ����� �� ���� ������� �������� ���������� (�� ������). ��������� ��� ��� ���������� ������ ���� ���� ������ ���� ����� �������. */
GO
CREATE VIEW ENOIKIASEIS_ANA_MHNA(mhnas, arithmos_enoikiasewn) as
SELECT month(hmeromhnia1), COUNT(kwdikos_en)
FROM ENOIKIASH
WHERE year(hmeromhnia1)=2010
GROUP BY month(hmeromhnia1);

GO 
CREATE VIEW XRONIKO_DIASTHMA_ANA_MHNA(mhnas, xroniko_diasthma) as
SELECT month(hmeromhnia1), sum(cast((hmeromhnia2-hmeromhnia1) as int))
FROM ENOIKIASH
WHERE year(hmeromhnia1)=2010
GROUP BY month(hmeromhnia1);

/* drop view ENOIKIASEIS_ANA_MHNA;
drop view XRONIKO_DIASTHMA_ANA_MHNA; */

SELECT XRONIKO_DIASTHMA_ANA_MHNA.mhnas, (cast (XRONIKO_DIASTHMA_ANA_MHNA.xroniko_diasthma as float)/cast(ENOIKIASEIS_ANA_MHNA.arithmos_enoikiasewn as float)) as mesh_xronikh_diarkeia_enoikiashs
FROM ENOIKIASEIS_ANA_MHNA, XRONIKO_DIASTHMA_ANA_MHNA
WHERE ENOIKIASEIS_ANA_MHNA.mhnas=XRONIKO_DIASTHMA_ANA_MHNA.mhnas
GROUP BY XRONIKO_DIASTHMA_ANA_MHNA.mhnas, XRONIKO_DIASTHMA_ANA_MHNA.xroniko_diasthma, ENOIKIASEIS_ANA_MHNA.arithmos_enoikiasewn;

