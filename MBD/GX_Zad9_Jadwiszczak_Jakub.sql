-- *******************************************************************************
-- *                                                                     
-- *   GRUPA: 		               
-- *                                 
-- *******************************************************************************
-- * 																		     
-- *   Nazwisko i imi�:   Jadwiszczak Jakub                                                       
-- * 																		     
-- *******************************************************************************
-- * 																		     
-- *   Nr indeksu:  98698                                                             
-- * 																		     
-- *******************************************************************************


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--
-- 		Elementy, kt�re powiny pojawi� si� w opracowywanych triggerach:
-- 		- instrukcje steruj�ce
-- 		- zastosowanie kwalifikator�w NEW, OLD
-- 		- obs�uga wyj�tk�w
--
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- *******************************************************************************
-- 								WYZWALACZ NR 1                                            
-- *******************************************************************************
/*
	JE�LI EMAIL NIE POSIADA ZNAKU @, TO REKORD NIE JEST DODAWANY DO TABLICY USERS
*/
-- -------------------------------------------------------------------------------
-- UTWORZENIE                                              
-- -------------------------------------------------------------------------------
CREATE TRIGGER email_validator
ON Users
FOR INSERT, UPDATE
AS
	DECLARE @new_email VARCHAR(20)
	SELECT @new_email =	Email FROM inserted
	IF @new_email NOT LIKE '%@%'
	BEGIN
		ROLLBACK
		RAISERROR('Email musi posiada� znak @', 1,2)
	END
GO
-- -------------------------------------------------------------------------------
-- PRZYK�AD POLECENIA, KT�RE URUCHOMI WYZWALACZ                                              
-- -------------------------------------------------------------------------------
INSERT INTO Users VALUES ('kuba', 'Kuba', 'Kubacki', 'kuba', 1, 'kubaproject.com', '+48 111-111-111');
GO
-- -------------------------------------------------------------------------------
-- USUNI�CIE WYZWALACZA                                             
-- -------------------------------------------------------------------------------
DROP TRIGGER email_validator;
GO
-- *******************************************************************************
-- 								WYZWALACZ NR 2                                            
-- *******************************************************************************

-- Je�li measure nie jest zamkni�ty to go nie usuwa (IsClosed = false)

-- -------------------------------------------------------------------------------
-- UTWORZENIE                                              
-- -------------------------------------------------------------------------------
CREATE TRIGGER delete_measure_state
ON Measure
FOR DELETE
AS
	DECLARE @deleted_state BIT
	SELECT @deleted_state = IsClosed FROM DELETED
	IF @deleted_state = 'false'
	BEGIN
		ROLLBACK
		RAISERROR('Measure musi byc zamkni�ty!', 1, 2)
	END
GO
-- -------------------------------------------------------------------------------
-- PRZYK�AD POLECENIA, KT�RE URUCHOMI WYZWALACZ                                              
-- -------------------------------------------------------------------------------
DELETE FROM Measure WHERE MeasureId % 2 = 1 AND IsClosed = 'false';
GO
-- -------------------------------------------------------------------------------
-- USUNI�CIE WYZWALACZA                                             
-- -------------------------------------------------------------------------------
DROP TRIGGER delete_measure_state;
GO



-- *******************************************************************************
-- 								WYZWALACZ NR 3                                            
-- *******************************************************************************

-- Je�li updatujemy Case z IsClosed=true to je�li measure do kt�rego ma powi�zanie 
-- ma IsClosed na false to go update case'a nie jest mo�liwy

-- -------------------------------------------------------------------------------
-- UTWORZENIE                                              
-- -------------------------------------------------------------------------------
CREATE TRIGGER update_case_state
ON CaseTab
FOR UPDATE
AS
	DECLARE @updated_state BIT, @updated_id INT
	SELECT @updated_state = IsClosed FROM inserted
	SELECT @updated_id = CaseId FROM inserted
	IF @updated_state = 'true' AND @updated_id in (SELECT DISTINCT CaseId FROM Measure WHERE IsClosed = 'false')
	BEGIN
		ROLLBACK
		RAISERROR('Wszystkie measure powi�zane z casem musz� by� zamkni�te', 1, 2)
	END
GO
-- -------------------------------------------------------------------------------
-- PRZYK�AD POLECENIA, KT�RE URUCHOMI WYZWALACZ                                              
-- -------------------------------------------------------------------------------
UPDATE CaseTab SET IsClosed = 'true' WHERE CaseId =5;
-- -------------------------------------------------------------------------------
-- USUNI�CIE WYZWALACZA                                             
-- -------------------------------------------------------------------------------
DROP TRIGGER update_case_state;
GO
