use hurtownia EXEC sp_changedbowner 'sa' -- Zmiana urawnieñ na bazie danych

SELECT * FROM tblPracownicy

--komentarz jednoliniowy w SQL
/*
	komentarz wieloliniowy
*/

--wybranie 2 pól z tabeli pracownicy
SELECT Imie, Nazwisko
FROM tblPracownicy

SELECT NazwaTowaru, CenaZadana
FROM tblTowary
ORDER BY CenaZadana DESC  -- ASC sortowanie rosn¹ce (je¿eli nie ma nic domyœlnie jest rosn¹co)

SELECT NazwaTowaru, CenaZadana, Cena
FROM tblTowary
ORDER BY CenaZadana, Cena

SELECT NazwaTowaru, CenaZadana
FROM tblTowary
ORDER BY 2 DESC, Cena DESC, 1 --2 pole select, je¿eli 2 nie roztrzyga to po towarze który jest jako 1

SELECT Nazwisko, Imie
FROM tblPracownicy
WHERE Miasto='Warszawa' -- dla Access "Warszawa"

----IN gdzie Miasto zawiera Katowice i Zielonka
SELECT NazwaFirmy, Miasto
FROM tblKlienci
WHERE Miasto IN ('Katowice', 'Zielonka')
ORDER BY 2, 1

----NOT IN gdzie Miasto nie zawiera Katowice i Zielonka
SELECT NazwaFirmy, Miasto
FROM tblKlienci
WHERE Miasto NOT IN ('Katowice', 'Zielonka')
ORDER BY 2, 1

--------LIKE 'k%' zawiera pierwsz¹ literê k reszta ci¹gu obojêtnie
SELECT Nazwisko, Imie
FROM tblPracownicy
WHERE Nazwisko LIKE 'k%' -- dla Access "k*"

--------NOT LIKE 'k%' nie zawiera pierwsz¹ literê k reszta ci¹gu obojêtnie
SELECT Nazwisko, Imie
FROM tblPracownicy
WHERE Nazwisko NOT LIKE 'k%'

SELECT Nazwisko, Imie
FROM tblPracownicy
WHERE Nazwisko LIKE '_o%' -- _ to jeden znak w tekœcie - dla Access ?

SELECT Nazwisko, Imie
FROM tblPracownicy
WHERE Nazwisko LIKE '[a-k]%' -- [a-k]% od a do k **** [aeiouk]% tylko te znaki **** [a-kst]% - od a do k i te znaki
ORDER BY Nazwisko

SELECT Nazwisko, Imie
FROM tblPracownicy
WHERE Nazwisko LIKE '[a-k]%' AND Nazwisko NOT LIKE 'b%'
ORDER BY Nazwisko

SELECT Nazwisko, Imie
FROM tblPracownicy
WHERE Nazwisko LIKE '_%n%_' AND Nazwisko NOT LIKE 'n%' AND Nazwisko NOT LIKE '%n' -- szukana litera n ale nie pierwsza i nie ostatnia
ORDER BY Nazwisko

-- LTRIM **** RTRIM --Accesss TRIM
SELECT LTRIM(NazwaTowaru) AS Towar, CenaZadana -- LTRIM ' Banany' -> 'Banany' usuwa spacje z lewj strony ***** RTRIM z prawej strony
FROM tblTowary
WHERE CenaZadana>=5 AND CenaZadana<=10
ORDER BY CenaZadana

SELECT LTRIM(NazwaTowaru) AS Towar, CenaZadana
FROM tblTowary
WHERE CenaZadana BETWEEN 5 AND 10 --SQL BETWEEN 10 AND 5 - nie dzia³a w Access obojêtnie  
ORDER BY CenaZadana

SELECT NazwaFirmy
FROM tblKlienci
WHERE TelefonKomorkowy IS NULL

SELECT NazwaFirmy, TelefonKomorkowy
FROM tblKlienci
WHERE TelefonKomorkowy IS NOT NULL

SELECT NrSprzedazy, KodKlienta, IDPracownika, DataSprzedazy
FROM tblSprzedaz
WHERE DataSprzedazy BETWEEN '1998-01-01' AND '1998-03-31' -- Access BETWEEN #1998-01-01# AND #1998-03-31#

SELECT NrSprzedazy, KodKlienta, IDPracownika, DataSprzedazy
FROM tblSprzedaz
WHERE DataSprzedazy BETWEEN '1998-01-01' AND '1998-03-31'
ORDER BY 4

SELECT Imie + ' ' + Nazwisko AS Pracownik --Acces Imie & ' ' &Nazwisko
FROM tblPracownicy

SELECT Imie + ' ' + Nazwisko AS Pracownik
FROM tblPracownicy
ORDER BY Nazwisko

SELECT CASE
WHEN (imie LIKE '&a')
THEN 'Pani '
ELSE 'Pan '
END + Imie + ' ' Nazwisko AS Pracownik
FROM tbPracownicy

/*
CASE 
	WHEN Warunek1 THEN Co1
	WHEN Warunek2 THEN Co1
	WHEN Warunek3 THEN Co1
	WHEN Warunek4 THEN Co1
	ELSE Co4
END
*/

SELECT DataSprzedazy,
DATEPART ("yyyy", DataSprzedazy) AS Rok,
DATEPART ("m", DataSprzedazy) AS Miesi¹c,
DATEPART ("d", DataSprzedazy) AS Dzieñ,
DATEPART ("q", DataSprzedazy) AS Kwarta³,
DATEPART ("w", DataSprzedazy) AS [Dzieñ tygodnia], --aliansy wielowyrazowe obejmujemy w nawiasy []
DATEPART ("ww", DataSprzedazy) AS [Tydzieñ roku],
DATEPART ("y", DataSprzedazy) AS [Dzieñ roku]
FROM tblSprzedaz

/*
YEAR(DataSprzedazy)
MONTH(DataSprzedazy)
DAY(DataSprzedazy)

HOUR(DataSprzedazy)
MINUTE(DataSprzedazy)
SECOND(DataSprzedazy)
*/

SELECT DISTINCT Miasto --DISTINCT - zwraca miasta unikatowe (pojedyñcze) i sortuje je
FROM tblKlienci

SELECT TOP 1 LTRIM(NazwaTowaru) AS Towar, CenaZadana
FROM tblTowary
ORDER BY CenaZadana

SELECT TOP 25 PERCENT LTRIM(NazwaTowaru) AS Towar, CenaZadana
FROM tblTowary
ORDER BY CenaZadana --najtañsze
--ORDER BY CenaZadana DESC - najdro¿sze

/* w MySQL zamiast TOP
SELECT ...........
FROM
WHERE
ORDER BY
LIMIT 10
*/

SELECT NazwaKategorii, LTRIM(NazwaTowaru) AS Towar, CenaZadana
FROM tblKategorie INNER JOIN tblTowary
ON tblKategorie.Kategoria=tblTowary.Kategoria
ORDER BY NazwaKategorii

SELECT NazwaKategorii, LTRIM(NazwaTowaru) AS Towar, CenaZadana
FROM tblKategorie LEFT JOIN tblTowary
ON tblKategorie.Kategoria=tblTowary.Kategoria
ORDER BY NazwaKategorii

SELECT NazwaKategorii, LTRIM(NazwaTowaru) AS Towar, CenaZadana
FROM tblKategorie K INNER JOIN tblTowary T --Aliansy
ON K.Kategoria=T.Kategoria --Aliansy
ORDER BY 1, 3

-------------------Funkcje tekstowe -------------------------
/*
SQL Server
LTRIM
RTRIM

Acces:
TRIM

*/

SELECT LEFT(Miasto, 3)
FROM tblKlienci 

SELECT RIGHT(Nazwisko, 3)
FROM tblPracownicy

SELECT LOWER(Nazwisko)
FROM tblPracownicy

SELECT UPPER(Nazwisko)
FROM tblPracownicy

SELECT LEN(Nazwisko) --d³ugoœæ tekstu
FROM tblPracownicy

SELECT Nazwisko, LEN(Nazwisko) Dlugosc
FROM tblPracownicy
WHERE LEN(Nazwisko)> 5
ORDER BY 2 DESC

SELECT REVERSE(Nazwisko)
FROM tblPracownicy

SELECT SUBSTRING(Nazwisko, 2, LEN(Nazwisko) - 1) --SUBSTRING(text, od, ile)
FROM tblPracownicy

-----zmiana liter Imie i Nazwisko na du¿¹ i ma³e litery-----
SELECT UPPER(LEFT(Imie, 1)) + LOWER(RIGHT(Imie, LEN(imie)-1)) + ' ' + UPPER(LEFT(Nazwisko, 1)) + LOWER(RIGHT(Nazwisko, LEN(Nazwisko)-1)) 
FROM tblPracownicy

/*
Funkcje Agreguj¹ce:
SUM
*/
SELECT NrSprzedazy, SUM(Ilosc*CenaSprzedazy) AS Kwota
FROM tblOpisSprzedazy
GROUP BY NrSprzedazy

SELECT NrSprzedazy, ROUND(SUM(Ilosc*CenaSprzedazy), 2) AS Kwota --zaokr¹glanie do drugiego miejca po przecinki
FROM tblOpisSprzedazy
GROUP BY NrSprzedazy


SELECT NrSprzedazy, 
	COUNT(KodTowaru) AS Ile,
	ROUND(SUM(Ilosc*CenaSprzedazy), 2) AS Kwota --zaokr¹glanie do drugiego miejca po przecinki
FROM tblOpisSprzedazy
WHERE NrSprzedazy BETWEEN 21 AND 30 
GROUP BY NrSprzedazy
HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2)>=1000 
ORDER BY 1


SELECT SUM(Ilosc*CenaSprzedazy) AS Obrót -- Ca³kowity obrót hurtowni
FROM tblOpisSprzedazy

SELECT ROUND(SUM(Ilosc*CenaSprzedazy), 2) AS Obrót -- Ca³kowity obrót hurtowni z zaokr¹gleniem do 2
FROM tblOpisSprzedazy
---------------------------------
SELECT Imie + ' ' + Nazwisko AS Pracownik, SUM(Ilosc*CenaSprzedazy) AS Obrót
FROM (tblPracownicy INNER JOIN tblSprzedaz ON tblPracownicy.IDPracownika=tblSprzedaz.IDPracownika) INNER JOIN tblOpisSprzedazy ON tblSprzedaz.NrSprzedazy=tblOpisSprzedazy.NrSprzedazy
GROUP BY Imie + ' ' + Nazwisko
ORDER BY SUM(Ilosc*CenaSprzedazy) DESC
-----------------Z aliansami -------------
SELECT Imie + ' ' + Nazwisko AS Pracownik, SUM(Ilosc*CenaSprzedazy) AS Obrót
FROM (tblPracownicy P INNER JOIN tblSprzedaz S ON P.IDPracownika=S.IDPracownika) INNER JOIN tblOpisSprzedazy O ON S.NrSprzedazy=O.NrSprzedazy
GROUP BY Imie + ' ' + Nazwisko
ORDER BY SUM(Ilosc*CenaSprzedazy) DESC

SELECT TOP 50 PERCENT Imie + ' ' + Nazwisko AS Pracownik, SUM(Ilosc*CenaSprzedazy) AS Obrót
FROM (tblPracownicy P INNER JOIN tblSprzedaz S ON P.IDPracownika=S.IDPracownika) INNER JOIN tblOpisSprzedazy O ON S.NrSprzedazy=O.NrSprzedazy
GROUP BY Imie + ' ' + Nazwisko
ORDER BY SUM(Ilosc*CenaSprzedazy) DESC

SELECT Imie + ' ' + Nazwisko AS Pracownik, ROUND(SUM(Ilosc*CenaSprzedazy), 2) AS Obrót
FROM (tblPracownicy P INNER JOIN tblSprzedaz S ON P.IDPracownika=S.IDPracownika) INNER JOIN tblOpisSprzedazy O ON S.NrSprzedazy=O.NrSprzedazy
WHERE Imie LIKE '%a' --filtrowanie danych zawartych w bazie
GROUP BY Imie + ' ' + Nazwisko
HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2) BETWEEN 7000 AND 12000  --filtrowanie danych agregowanych
ORDER BY SUM(Ilosc*CenaSprzedazy) DESC
---------------------------------------------------------
SELECT NazwaFirmy, SUM(Ilosc*CenaSprzedazy) AS Obrót
FROM (tblKlienci INNER JOIN tblSprzedaz ON tblKlienci.KodKlienta=tblSprzedaz.KodKlienta) INNER JOIN tblOpisSprzedazy ON tblSprzedaz.NrSprzedazy=tblOpisSprzedazy.NrSprzedazy
GROUP BY NazwaFirmy
ORDER BY SUM(Ilosc*CenaSprzedazy) DESC
-----------------Z aliansami -------------
SELECT NazwaFirmy, Miasto, ROUND(SUM(Ilosc*CenaSprzedazy), 2) AS Obrót
FROM tblKlienci K LEFT JOIN tblSprzedaz S
	ON K.KodKlienta=S.KodKlienta LEFT JOIN tblOpisSprzedazy O 
	ON S.NrSprzedazy=O.NrSprzedazy
WHERE Aktywny=1 AND UPPER(Miasto) IN ('Katowice', 'Zielonka')
GROUP BY NazwaFirmy, Miasto
HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2)<4000
ORDER BY 3 DESC

SELECT Imie + ' ' +	Nazwisko AS Pracownik, COUNT(NrSprzedazy) AS (Liczba sprzedazy)
FROM tblPracownicy INNER JOIN tblSprzedaz 
	ON tblPracownicy.IDPracownika=tblSprzedaz.IDPracownika
GROUP BY Imie + ' ' + Nazwisko, P.IDPracownika
ORDER BY 2 DESC

SELECT UPPER(Imie + ' ' + Nazwisko) Pracownik, COUNT(NrSprzedazy) [Liczba sprzeda¿y]
FROM tblPracownicy P LEFT JOIN tblSprzedaz S ON P.IDPracownika=S.IDPracownika
GROUP BY Imie + ' ' + Nazwisko, P.IDPracownika
ORDER BY 2 DESC

SELECT Imie + ' ' + Nazwisko Pracownik, 
	ROUND(SUM(Ilosc*CenaSprzedazy), 2) Obrót,
	COUNT(DISTINCT S.NrSprzedazy) [Liczba transakcji]
FROM (tblPracownicy P INNER JOIN tblSprzedaz S 
	ON P.IDPracownika=S.IDPracownika) INNER JOIN tblOpisSprzedazy O 
	ON S.NrSprzedazy=O.NrSprzedazy
GROUP BY Imie + ' ' + Nazwisko, P.IDPracownika
ORDER BY 3 DESC

---Zestawienie towarów wed³ug obrotów-------
SELECT LTRIM(NazwaTowaru) AS Towar, SUM(ILosc*CenaSprzedazy) AS Obrót
FROM tblTowary INNER JOIN tblOpisSprzedazy
	ON tblTowary.KodTowaru=tblOpisSprzedazy.KodTowaru
GROUP BY LTRIM(NazwaTowaru)
ORDER BY SUM(Ilosc*CenaSprzedazy) DESC

---Ranking Obrotów pracowników ----------
SELECT Imie + ' ' + Nazwisko Pracownik, 
	ROUND(SUM(Ilosc*CenaSprzedazy), 2) Obrót,
	COUNT(DISTINCT S.NrSprzedazy) [Liczba transakcji]
FROM (tblPracownicy P INNER JOIN tblSprzedaz S 
	ON P.IDPracownika=S.IDPracownika) INNER JOIN tblOpisSprzedazy O 
	ON S.NrSprzedazy=O.NrSprzedazy
WHERE YEAR(DataSprzedazy)=1998
GROUP BY Imie + ' ' + Nazwisko, P.IDPracownika
ORDER BY 3 DESC

---Ranking Obrotów pracowników obrót wicej ni¿ 4000 liczba tranzakcji >10 -------
SELECT Imie + ' ' + Nazwisko Pracownik, 
	ROUND(SUM(Ilosc*CenaSprzedazy), 2) Obrót,
	COUNT(DISTINCT S.NrSprzedazy) [Liczba transakcji]
FROM (tblPracownicy P INNER JOIN tblSprzedaz S 
	ON P.IDPracownika=S.IDPracownika) INNER JOIN tblOpisSprzedazy O 
	ON S.NrSprzedazy=O.NrSprzedazy
WHERE YEAR(DataSprzedazy)=1998
GROUP BY Imie + ' ' + Nazwisko, P.IDPracownika
HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2) > 4000 AND COUNT(DISTINCT S.NrSprzedazy) >10
ORDER BY 3 DESC



SELECT NazwaKategorii, ROUND(SUM(Ilosc*CenaSprzedazy),2) Obtót
FROM tblKategorie LEFT JOIN tblTowary
	ON tblKategorie.Kategoria=tblTowary.Kategoria LEFT JOIN
	tblOpisSprzedazy ON tblTowary.KodTowaru=tblOpisSprzedazy.KodTowaru
GROUP BY NazwaKategorii
ORDER BY SUM(Ilosc*CenaSprzedazy) DESC

-----Ranking firm wg zakupów------
SELECT NazwaFirmy, COUNT(NrSprzedazy) AS [Liczba zakupów]
FROM (tblKlienci INNER JOIN tblSprzedaz 
	ON tblKlienci.KodKlienta=tblSprzedaz.KodKlienta)
GROUP BY NazwaFirmy
ORDER BY COUNT(NrSprzedazy) DESC


----Ranking towrów wed³ug iloœci-----
SELECT LTRIM(NazwaTowaru) Towar, SUM(Ilosc) Ile
FROM tblTowary T INNER JOIN tblOpisSprzedazy O ON T.KodTowaru=O.KodTowaru
GROUP BY LTRIM(NazwaTowaru)
ORDER BY 2 DESC

---Obrót i Zysk Hurtowni ------
SELECT	ROUND(SUM(Ilosc*CenaSprzedazy), 2) Obrót,
		ROUND(SUM(Ilosc*(CenaSprzedazy-Cena)), 2) Zysk,
		ROUND(SUM(Ilosc*(CenaSprzedazy-Cena)), 2) / ROUND(SUM(Ilosc*CenaSprzedazy), 2) Mar¿a
FROM tblTowary T INNER JOIN tblOpisSprzedazy O ON T.KodTowaru=O.KodTowaru


--Zestawienie wedlug zysku po kategorii---
SELECT NazwaKategorii, ROUND(SUM(Ilosc*CenaSprzedazy),2) Zysk
FROM tblKategorie LEFT JOIN tblTowary
	ON tblKategorie.Kategoria=tblTowary.Kategoria LEFT JOIN
	tblOpisSprzedazy ON tblTowary.KodTowaru=tblOpisSprzedazy.KodTowaru
GROUP BY NazwaKategorii
ORDER BY 2 DESC

----Zestawienie towar vs liczba sprzeda¿y--------
SELECT TOP 5 LTRIM(NazwaTowaru) AS Towar, COUNT(NrSprzedazy) AS [Liczba sprzedazy]
FROM tblTowary INNER JOIN tblOpisSprzedazy 
ON tblTowary.KodTowaru=tblOpisSprzedazy.KodTowaru
GROUP BY LTRIM(NazwaTowaru)
ORDER BY COUNT(NrSprzedazy) DESC

---Liczba tranzakcji wg lat-----------
SELECT YEAR(DataSprzedazy) ROK, COUNT(NrSprzedazy) [Liczba transakcji]
FROM tblSprzedaz
GROUP BY YEAR(DataSprzedazy)
ORDER BY 1

----Obrót na kwarta³------
SELECT DATEPART("q", DataSprzedazy) AS Kwarta³,
		ROUND(SUM(Ilosc*CenaSprzedazy), 2) AS Obtót
	FROM tblSprzedaz INNER JOIN tblOpisSprzedazy 
		ON tblSprzedaz.NrSprzedazy=tblOpisSprzedazy.NrSprzedazy
	WHERE YEAR(DataSprzedazy)=1999
	GROUP BY DATEPART("q", DataSprzedazy)

---Zysk na rok -------
SELECT DATEPART("yyyy", DataSprzedazy) AS Rok,
ROUND(SUM(Ilosc*(CenaSprzedazy-Cena)), 2) AS Zysk
FROM tblTowary INNER JOIN (tblSprzedaz INNER JOIN tblOpisSprzedazy 
	ON tblSprzedaz.NrSprzedazy=tblOpisSprzedazy.NrSprzedazy) 
	ON tblTowary.KodTowaru=tblOpisSprzedazy.KodTowaru
GROUP BY DATEPART("yyyy", DataSprzedazy)

---Zysk na rok -------Optymalizacja-------
SELECT YEAR(DataSprzedazy) Rok, ROUND(SUM(Ilosc*(CenaSprzedazy-Cena)), 2) Zysk
FROM tblTowary T INNER JOIN (tblSprzedaz S INNER JOIN tblOpisSprzedazy O
	ON S.NrSprzedazy=O.NrSprzedazy) ON T.KodTowaru=O.KodTowaru
GROUP BY YEAR(DataSprzedazy)
ORDER BY 1



SELECT TOP 1 LTRIM(NazwaTowaru) AS Towar, SUM(Ilosc*(CenaSprzedazy-Cena)) AS Zysk
FROM tblTowary INNER JOIN (tblSprzedaz INNER JOIN tblOpisSprzedazy 
	ON tblSprzedaz.NrSprzedazy=tblOpisSprzedazy.NrSprzedazy) 
	ON tblTowary.KodTowaru=tblOpisSprzedazy.KodTowaru
GROUP BY LTRIM(NazwaTowaru), DATEPART("yyyy", DataSprzedazy), DATEPART("q", DataSprzedazy)
HAVING (DATEPART("yyyy", DataSprzedazy)=1999) AND (DATEPART("q", DataSprzedazy)=2)
ORDER BY SUM(Ilosc*(CenaSprzedazy-Cena)) DESC


-----------------------------ZAPYTANIA SK£ADAJ¥CE-----------------------------------

SELECT Miasto
FROM tblKlienci
UNION ---sk³ada wyniki 2 zapytañ - zwraca unikatowe wartoœci i segreguje rosn¹co
SELECT Miasto
FROM tblPracownicy

--------------du¿e litery w Miasto ---------------
SELECT UPPER(Miasto) Miasto
FROM tblKlienci
UNION ---sk³ada wyniki 2 zapytañ - zwraca unikatowe wartoœci i segreguje rosn¹co
SELECT UPPER(Miasto) Miasto
FROM tblPracownicy

SELECT Miasto
FROM tblKlienci
UNION ALL -- zwraca wszystko 1 do 1 (wszystko z jednej tabeli i wszystko z drugiej tabeli)
SELECT Miasto
FROM tblPracownicy

SELECT Miasto
FROM tblKlienci
INTERSECT ---czesc wspolna dwóch zbiorów
SELECT Miasto
FROM tblPracownicy

SELECT Miasto
FROM tblKlienci
EXCEPT---Wycina wspólne elementy z dwóch zbiorów
SELECT Miasto
FROM tblPracownicy


--------------ZAPYTANIA FUNKCJONALNE (AKCJI) ----------------------------
			--AKTUALIZUJ¥CE--	UPDATE
			--DO£¥CZAJ¥CE--		INSERT
			--USUWAJ¥CE--		DELETE

UPDATE tblTowary SET CenaZadana = 1.05*CenaZadana

UPDATE tblTowary SET CenaZadana = ROUND(CenaZadana, 2) -- zaokr¹glanie

UPDATE tblTowary SET CenaZadana = 1.05*CenaZadana
WHERE CenaZadana>10 --podniesie tylko te towary które s¹ wiêksze ni¿ 10

UPDATE tblPracownicy SET Stanowisko = 'Przedstawiciel'
WHERE Stanowisko LIKE 'Przedstawiciel%'--zmienia Przedstawiciel handlowy na Przedstawiciel

			--DO£¥CZAJ¥CE--		INSERT

INSERT INTO tblKategorie (Kategoria, NazwaKategorii)
VALUES (9, 'Warzywa') --Dodanie nowego rekordu do tabeli

---Kopiowanie z tabeli 2 do tabeli 1
INSERT INTO Tabela1 (P1, P2, P3)
SELECT P1, P2, P3
FROM Tabela2
WHERE Warunek

INSERT INTO tblArchiwumKlientow
SELECT *
FROM tblKlienci
WHERE Aktywny = 0


		--USUWAJ¥CE--		DELETE

DELETE 
FROM tblKategorie
WHERE Kategoria>=8

DROP TABLE Nazwa tabeli --usuwa ca³¹ tabelê
DROP DATABASE Nazwa Bazy
DROP VIEW ......
DROP PROCEDURE .........

---------------WIDOKI-----------------
--widok nie zawiera danych, jest to zapytanie

CREATE VIEW View1
AS
SELECT NazwaFirmy, Miasto
FROM tblKlienci
-------------------
SELECT * FROM View1

-------------------
DROP VIEW View1 -- usuwanie widoku
-------------------

CREATE VIEW View2
AS
SELECT TOP 100 PERCENT UPPER(Imie) AS Imie, UPPER(Nazwisko) AS Nazwisko, Miasto
FROM tblPracownicy
------------------
SELECT * FROM View2

CREATE VIEW View3
AS
SELECT NazwaKategorii, LTRIM(NazwaTowaru) Towar, CenaZadana
FROM tblKategorie K INNER JOIN tblTowary T ON K.Kategoria=T.Kategoria

SELECT * FROM View3

CREATE VIEW View4
AS
SELECT NrSprzedazy, ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
FROM tblOpisSprzedazy
GROUP BY NrSprzedazy

--œrednia wartoœæ transakcji------
SELECT ROUND(AVG(Kwota), 2) AS [œrednia kwota]
FROM View4

SELECT * FROM View4
ORDER BY 2 DESC

-------------------PROCEDURY SKLADOWANE---------------------
--EXECUTE nazwa procedury, Parametr procedury1, parametr procedury2

CREATE PROCEDURE Klienci
@miasto VARCHAR(20)
AS
SELECT NazwaFirmy, NIP
FROM tblKlienci
WHERE Miasto=@miasto

EXECUTE Klienci 'Katowice'

------------------------------------------------------------------------------

DROP PROCEDURE Klienci --usuniêcie procedury

------------------------------------------------------------------------------

CREATE PROCEDURE Towary
@cena1 INT, @cena2 INT
AS
SELECT LTRIM(NazwaTowaru), CenaZadana
FROM tblTowary
WHERE CenaZadana BETWEEN @cena1 AND @cena2

EXECUTE Towary 5, 10

------------------------------------------------------------------------------

CREATE PROCEDURE Daty @data1 DATETIME, @data2 DATETIME
AS
SELECT DataSprzedazy, NazwaFirmy, UPPER(Nazwisko) AS Nazwisko
FROM tblSprzedaz INNER JOIN tblKlienci ON
tblSprzedaz.KodKlienta=tblKlienci.KodKlienta INNER JOIN tblPracownicy
ON tblSprzedaz.IDPracownika=tblPracownicy.IDPracownika
WHERE DataSprzedazy BETWEEN @data1 AND @data2


EXECUTE Daty '2000-01-01', '2000-12-31'
------------------------------------------------------------------------------

-------------ZAPYTANIA PODZAPYTANIAMI-----------------------------------------

SELECT ROUND(AVG(Kwota), 2) [œrednia wartoœæ transakcji]
FROM
	(
			SELECT NrSprzedazy, ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
			FROM tblOpisSprzedazy
			GROUP BY NrSprzedazy
	) Dane

-------------------------------------------------
SELECT ROUND(AVG(Kwota), 2) [œrednia wartoœæ transakcji]
FROM
	(
			SELECT ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
			FROM tblOpisSprzedazy
			GROUP BY NrSprzedazy
	) Dane

-------------------------------------------------
SELECT NrSprzedazy, ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
FROM tblOpisSprzedazy
GROUP BY NrSprzedazy
HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2)>
	(	
		SELECT ROUND(AVG(Kwota), 2) [œrednia wartoœæ transakcji]
		FROM
			(
					SELECT ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
					FROM tblOpisSprzedazy
					GROUP BY NrSprzedazy
			)AS Dane
	)
ORDER BY 2 DESC

-------------------------------------------------
SELECT COUNT(NrSprzedazy) [Liczba transakcji powyzej sredniej]
FROM
	(
		SELECT NrSprzedazy
		FROM tblOpisSprzedazy
		GROUP BY NrSprzedazy
		HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2)>
			(	
				SELECT ROUND(AVG(Kwota), 2) [œrednia wartoœæ transakcji]
				FROM
					(
							SELECT ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
							FROM tblOpisSprzedazy
							GROUP BY NrSprzedazy
					)AS Dane
			)
	)

--------------------------------------------------------------------------------------
SELECT 'Liczba Transakcji Powy¿ej Œredniej' Informacja, COUNT(Dane2.NrSprzedazy) Ile
FROM
	(
		SELECT NrSprzedazy
		FROM tblOpisSprzedazy
		GROUP BY NrSprzedazy
		HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2)>
			(	
				SELECT ROUND(AVG(Kwota), 2) [œrednia wartoœæ transakcji]
				FROM
					(
							SELECT ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
							FROM tblOpisSprzedazy
							GROUP BY NrSprzedazy
					)AS Dane
			)
	)Dane2


UNION
	--------------------------------------------------------------------------------------
SELECT 'Liczba Transakcji Poni¿ej Œredniej' Informacja, COUNT(Dane2.NrSprzedazy) Ile
FROM
	(
		SELECT NrSprzedazy
		FROM tblOpisSprzedazy
		GROUP BY NrSprzedazy
		HAVING ROUND(SUM(Ilosc*CenaSprzedazy), 2)<
			(	
				SELECT ROUND(AVG(Kwota), 2) [œrednia wartoœæ transakcji]
				FROM
					(
							SELECT ROUND(SUM(Ilosc*CenaSprzedazy), 2) Kwota
							FROM tblOpisSprzedazy
							GROUP BY NrSprzedazy
					)AS Dane
			)
	)Dane2
-----------------------------------------------------------------------------------
--Firmy z trzech najbardziej licznych miast--

SELECT NazwaFirmy, Miasto
FROM tblKlienci
WHERE Miasto IN
		(
			SELECT TOP 3 Miasto
			FROM tblKlienci
			GROUP BY Miasto
			ORDER BY COUNT(KodKlienta) DESC
		)
ORDER BY 2, 1
-----------------------------------------------------------------------------------
--Towary z trzech najbardziej licznych kategorii--

SELECT LTRIM(NazwaTowaru) Towar, CenaZadana
FROM tblTowary
WHERE Kategoria IN
		(
			SELECT TOP 3 Kategoria
			FROM tblTowary
			GROUP BY Kategoria
			ORDER BY COUNT(KodTowaru) DESC
		)
ORDER BY Kategoria, 2

-----------------------------------------------------------------------------------
--Trzy firmy o najwiêkszej liczbie tarnsakcji w roku, w którym w sumie transakcji by³o najmniej--
	SELECT * FROM
	 (
		SELECT TOP 3 NazwaFirmy, COUNT(NrSprzedazy) Ile, 1 Ranking
		FROM tblSprzedaz S INNER JOIN tblKlienci K
		ON S.KodKlienta=K.KodKlienta
		WHERE YEAR(DataSprzedazy) IN
			(
				SELECT TOP 1 YEAR(DataSprzedazy) Ile
				FROM tblSprzedaz
				GROUP BY YEAR(DataSprzedazy)
				ORDER BY COUNT(NrSprzedazy)
			)
		GROUP BY NazwaFirmy
		ORDER BY COUNT(NrSprzedazy) DESC
	 ) Dane
		UNION
		SELECT 'Wszystkich transakcji',
		(
			SELECT TOP 1 COUNT(NrSprzedazy)
			FROM tblSprzedaz
			GROUP BY YEAR(DataSprzedazy)
			ORDER BY COUNT(NrSprzedazy)
		), 2
----------------------------------------------------------------
--Towary, których CenaZadana < po³owy najwy¿szej CenyZadanej

SELECT LTRIM(NazwaTowaru) Towar, CenaZadana, COUNT(NrSprzedazy) Ile
FROM tblTowary T INNER JOIN tblOpisSprzedazy O
ON T.KodTowaru=O.KodTowaru
WHERE T.KodTowaru IN
	(
		SELECT KodTowaru
		FROM tblTowary
		WHERE CenaZadana <
			(
				SELECT MAX(CenaZadana) / 2
				FROM tblTowary
			)
	)
GROUP BY LTRIM(NazwaTowaru), CenaZadana
ORDER BY 3 DESC

--Poka¿ wszystkich klientów w tych miastach w których mamy pracowników

SELECT NazwaFirmy, Miasto
FROM tblKlienci
WHERE Miasto IN
	(
		SELECT UPPER(Miasto) Miasto
		FROM tblKlienci
		INTERSECT ---czesc wspolna dwóch zbiorów
		SELECT UPPER(Miasto)
		FROM tblPracownicy
	)
ORDER BY 2, 1

---------1 towar o najni¿szym obrocie z kategorii o najwy¿szym przychodzie w roku 1998 -------------------
SELECT LTRIM(NazwaTowaru) Towar, ROUND(SUM(Ilosc*CenaSprzedazy), 2) Obrot
FROM tblTowary T INNER JOIN tblOpisSprzedazy O
ON T.KodTowaru=O.KodTowaru INNER JOIN tblSprzedaz S
ON S.NrSprzedazy=O.NrSprzedazy
WHERE YEAR(DataSprzedazy)=1998 AND Kategoria=
	(
		SELECT TOP 1 Kategoria
		FROM tblTowary T INNER JOIN tblOpisSprzedazy O
		ON T.KodTowaru=O.KodTowaru INNER JOIN tblSprzedaz S
		ON S.NrSprzedazy=O.NrSprzedazy
		WHERE YEAR(DataSprzedazy)=1998
		GROUP BY Kategoria
		ORDER BY SUM(Ilosc*CenaSprzedazy) DESC
	)
GROUP BY LTRIM(NazwaTowaru)
ORDER BY 2


--------------------------------FUNKCJE SZEREGUJ¥CE-----------------------------------------

SELECT NrSprzedazy, Ilosc, CenaSprzedazy,
MIN(Ilosc) OVER(partition by NrSprzedazy) Min, --szukaj po partycji NrSprzeda¿y i wyszukuje najni¿szy wymik
MAX(Ilosc) OVER(partition by NrSprzedazy) Max
FROM tblOpisSprzedazy

----Suma Narastaj¹ca---
SELECT NrSprzedazy, Ilosc, CenaSprzedazy, KodTowaru, ROUND(SUM(Ilosc*CenaSprzedazy)
OVER(partition by NrSprzedazy ORDER BY KodTowaru), 2) Kwota --Suma narastaj¹ca
FROM tblOpisSprzedazy

-----Numeracja wszystkich rekordów które s¹ wynikiem zapytania----
SELECT ROW_NUMBER() OVER(ORDER BY Nazwisko) Nr, Nazwisko
FROM tblPracownicy

------Numracja rekordu z resetowaniem numeracji dla ka¿dej grupy------
SELECT ROW_NUMBER() OVER(partition by NrSprzedazy ORDER BY NrSprzedazy), NrSprzedazy
FROM tblOpisSprzedazy

SELECT Kategoria, LTRIM(NazwaTowaru) Towar, CenaZadana,
RANK() OVER(partition by Kategoria ORDER BY CenaZadana DESC) Pozycja --RANK podaje pozycje na liœcie (ranking)
FROM tblTowary
ORDER BY 1, 2

SELECT Kategoria, LTRIM(NazwaTowaru) Towar, CenaZadana,
DENSE_RANK() OVER(partition by Kategoria ORDER BY CenaZadana DESC) Pozycja --DENS_RANK podaje pozycje na liœcie ale uwzglêdnia np 2 pierwsze miejsca (ranking)
FROM tblTowary
ORDER BY 1, 2

SELECT LTRIM(NazwaTowaru) Towar, CenaZadana,
NTILE(4) OVER(ORDER BY CenaZadana) Kwartyl ---NTILE dzieli na kwartyle
FROM tblTowary


-------------------Zaawansowane grupowanie danych---------------------


----Podsumowanie dla roku----------
SELECT YEAR(DataSprzedazy) ROK, Nazwisko, COUNT(NrSprzedazy) Ile
FROM tblSprzedaz S INNER JOIN tblPracownicy P
ON S.IDPracownika=P.IDPracownika
GROUP BY ROLLUP(YEAR(DataSprzedazy), Nazwisko)
----Po nazwisku----
SELECT YEAR(DataSprzedazy) ROK, Nazwisko, COUNT(NrSprzedazy) Ile
FROM tblSprzedaz S INNER JOIN tblPracownicy P
ON S.IDPracownika=P.IDPracownika
GROUP BY ROLLUP(Nazwisko, YEAR(DataSprzedazy))

SELECT YEAR(DataSprzedazy) ROK, Nazwisko, COUNT(NrSprzedazy) Ile
FROM tblSprzedaz S INNER JOIN tblPracownicy P
ON S.IDPracownika=P.IDPracownika
GROUP BY CUBE(YEAR(DataSprzedazy), Nazwisko)

SELECT YEAR(DataSprzedazy) ROK, Nazwisko, COUNT(NrSprzedazy) Ile
FROM tblSprzedaz S INNER JOIN tblPracownicy P
ON S.IDPracownika=P.IDPracownika
GROUP BY GROUPING SETS((YEAR(DataSprzedazy), Nazwisko), ())


----------------Zapytania CTE(Common Tabele Expression)----------------

--Tak jak procedura w programowaniu--- mo¿na go wielokrotnie wywo³ywaæ w ró¿nych czêœciach programu
WITH Sales_CTE (NrSprzedazy, Kwota)
AS
(
	SELECT NrSprzedazy, SUM(Ilosc*CenaSprzedazy)
	FROM tblOpisSprzedazy
	GROUP BY NrSprzedazy
)

SELECT ROUND(AVG(Kwota), 2) AS [œrednia wartoœæ transakcji]
FROM Sales_CTE

---------Rok ----liczba transakcji

WITH TransakcjieWgLat (Rok, Ile)
AS
(
	SELECT YEAR(DataSprzedazy), COUNT(NrSprzedazy)
	FROM tblSprzedaz
	GROUP BY YEAR(DataSprzedazy)
)

SELECT ROUND(AVG(Ile), 0) AS [œrednia liczba transakcji rocznie]
FROM TransakcjieWgLat

-------------------------Funkcje skalarne i tablicowe----------------

CREATE FUNCTION dbo.LiczbaDniRoboczych
	(
		@StartDate DATETIME,
		@EndDate DATETIME	
	)
RETURNS int
AS
BEGIN
	RETURN	(DATEDIFF(dd, @StartDate, @EndDate) + 1)
			-(DATEDIFF(WK, @StartDate, @EndDate) * 2)
			-(CASE WHEN DATENAME(dw, @StartDate) = 'Sunday' THEN 1 ELSE 0 END)
			-(CASE WHEN DATENAME(dw, @EndDate) = 'Saturday' THEN 1 ELSE 0 END)
END

SELECT dbo.LiczbaDniRoboczych('2018-10-01', '2018-10-31') Ile

-----------------------------------------------------------------------------
CREATE FUNCTION dbo.Kliencizakupy
	(
		@Klient varchar(25)
	)
	RETURNS TABLE
	AS
	RETURN
	(
		SELECT NazwaFirmy, COUNT(NrSprzedazy) Ile
		FROM tblKlienci K INNER JOIN tblSprzedaz S 
		ON K.KodKlienta=S.KodKlienta
		WHERE NazwaFirmy = @Klient
		GROUP BY NazwaFirmy
	)

SELECT * FROM dbo.Kliencizakupy('ROBEX')

--------------------------------------------------------------
----szuka nazwy firny nawet po jednej literze-------

ALTER FUNCTION dbo.Kliencizakupy
	(
		@Klient varchar(25)
	)
	RETURNS TABLE
	AS
	RETURN
	(
		SELECT NazwaFirmy, COUNT(NrSprzedazy) Ile
		FROM tblKlienci K INNER JOIN tblSprzedaz S 
		ON K.KodKlienta=S.KodKlienta
		WHERE NazwaFirmy LIKE '%' + @Klient + '%'
		GROUP BY NazwaFirmy
	)

SELECT * FROM dbo.Kliencizakupy('R')

--------------------------------------------------------------
---------Pentle w SQL-----------

SELECT AVG(CenaZadana) Cena
FROM tblTowary

---definicja pêtli w SQL----
---podnosi cene o 1.03 procenta do póki cena <=15
WHILE (SELECT AVG(CenaZadana) FROM tblTowary) <=15
BEGIN
	UPDATE tblTowary SET CenaZadana = ROUND(CenaZadana * 1.03, 2)
	PRINT 'Zrobione' --komunikat o zrobionej operacji
END

-----------------------
SELECT AVG(CenaZadana) Cena1, MAX(CenaZadana) Cena2
FROM tblTowary ---test czy zadzia³a³a pêtka 
--------
WHILE (SELECT AVG(CenaZadana) FROM tblTowary) <=15
BEGIN
	UPDATE tblTowary SET CenaZadana = ROUND(CenaZadana * 1.03, 2)
	IF (SELECT MAX(CenaZadana) FROM tblTowary) > 40
		BREAK --warunkowe wyjœcie z pêtli
	ELSE
		CONTINUE --kontynuacja pêtli
	PRINT 'Zrobione' --komunikat o zrobionej operacji
END

---------------------Pobieranie danych z u¿yciem BULK INSERT--------------------------------

CREATE TABLE Temp --tworzenie tabeli
	(
		Full_Row varchar(1000)
	)
--wczytanie jednym ruchem zawartoœci pliku tekstowego
BULK INSERT Temp
	FROM 'C:\Temp\plik.txt'

--------------------------------------------------------------------------

BULK INSERT Temp2
FROM 'C:\Temp\plik2.txt'
WITH
	(
		FIELDTERMINATOR = '\t', --Znak tabulacji oddziela poszczególne kolumny z danymi
		ROWTERMINATOR = '\n', -- Znak ³amania lini oddziela rekordy
		FIRSTROW = 1,
		LASTROW = 10
	)
-------------
DELETE FROM Temp2 --czyœci wszystkie rerdy


--------------------------------------------------------------------------

DECLARE @x INT --deklaracja zmiennej liczbowej (ca³kowitej)
SET @x =1 --inicjalizacja zmiennej

WHILE @x <= 3
BEGIN
	UPDATE tblTowary SET CenaZadana = ROUND(CenaZadana*1.02, 2)
	PRINT @x
	SET @x = @x + 1
	
END

--------------------------------------------------------------------------
--pobieranie z pliku tekstowego co drugi wiersz czyli  1 3 5 
--- Jet b³¹d w tym przykladzie---nieznany na razie

DECLARE @Ile INT
SET @Ile = 1
WHILE @Ile < 10
BEGIN
		BULK INSERT Temp2
		FROM 'C:\Temp\plik2.txt'
		WITH
			(
				FIELDTERMINATOR = '\t', --Znak tabulacji oddziela poszczególne kolumny z danymi
				ROWTERMINATOR = '\n', -- Znak ³amania lini oddziela rekordy
				FIRSTROW = @Ile,
				LASTROW = @Ile
			)
		SET @Ile = @Ile+2
END

--------------------------------------------------------------------------

---www.connectionstring.com

--------------------------------------------------------------------------

--Nazwa Firmy -- Ile zakupów -- Kwartyl
-- od najczêœciej do najrzadziej kupuj¹cego klienta
--Pokazanie firm z drugiego kwartylu jeœli chodzi o liczbê zakupów
SELECT *
FROM
	(
		SELECT NazwaFirmy, COUNT(NrSprzedazy) Ile, NTILE(4) OVER(ORDER BY COUNT(NrSprzedazy) DESC) Kwartyl
		FROM tblKlienci K INNER JOIN tblSprzedaz S
		ON K.KodKlienta=S.KodKlienta
		GROUP BY NazwaFirmy
	) Dane
WHERE Dane.Kwartyl = 2
ORDER BY 2 DESC


--------------------------

SELECT NazwaFirmy, COUNT(NrSprzedazy) Ile FROM tblKlienci K LEFT JOIN tblSprzedaz S ON K.KodKlienta=S.KodKlienta WHERE Miasto='Katowice' GROUP BY NazwaFirmy ORDER BY 2 DESC