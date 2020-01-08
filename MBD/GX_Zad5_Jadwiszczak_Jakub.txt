-- *******************************************************************************
-- *                                                                     
-- *   GRUPA: 		               
-- *                                 
-- *******************************************************************************
-- * 																		     
-- *   Nazwisko i imię:   Jadwiszczak Jakub                                                       
-- * 																		     
-- *******************************************************************************
-- * 																		     
-- *   Nr indeksu:  98698                                                             
-- * 																		     
-- *******************************************************************************


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--
-- 		Elementy, które powiny pojawić się w opracowywanych triggerach:
-- 		- instrukcje sterujące
-- 		- zastosowanie kwalifikatorów NEW, OLD
-- 		- obsługa wyjątków
--
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- *******************************************************************************
-- 								WYZWALACZ NR 1                                            
-- *******************************************************************************

--  Jeśli nowy rekord w tabeli Users ma RoleId==null to przypisuje mu się maksymalne
-- id z tabeli Role

-- -------------------------------------------------------------------------------
-- UTWORZENIE                                              
-- -------------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER role_id_fill
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    IF :new.RoleId IS null
        THEN SELECT MAX(RoleId) into :new.RoleId from Role;
    end if;
end;
-- -------------------------------------------------------------------------------
-- PRZYKŁAD POLECENIA, KTÓRE URUCHOMI WYZWALACZ                                              
-- -------------------------------------------------------------------------------
INSERT INTO Users VALUES (5, 'admin', 'Adam', 'Adamski', 'admin', NULL, 'admin@project.com', '+48 111-111-111');
-- -------------------------------------------------------------------------------
-- USUNIĘCIE WYZWALACZA                                             
-- -------------------------------------------------------------------------------
DROP TRIGGER role_id_fill;
-- *******************************************************************************
-- 								WYZWALACZ NR 2                                            
-- *******************************************************************************

-- Po usunięciu case'a usuwa wszystkie measure'y które miały podlinkowanego tego case'a

-- -------------------------------------------------------------------------------
-- UTWORZENIE                                              
-- -------------------------------------------------------------------------------
create or replace trigger delete_linked_measures
after delete on CaseTab
for each row
begin
delete from Measure where CaseId = :old.CaseId;
end;
-- -------------------------------------------------------------------------------
-- PRZYKŁAD POLECENIA, KTÓRE URUCHOMI WYZWALACZ                                              
-- -------------------------------------------------------------------------------
DELETE FROM CaseTab WHERE CaseId = 1;
-- -------------------------------------------------------------------------------
-- USUNIĘCIE WYZWALACZA                                             
-- -------------------------------------------------------------------------------

drop trigger delete_linked_measures;






-- *******************************************************************************
-- 								WYZWALACZ NR 3                                            
-- *******************************************************************************

-- Jeśli nowy event ma EventDateTime w przyszłości to rzucony zostanie wyjątek

-- -------------------------------------------------------------------------------
-- UTWORZENIE                                              
-- -------------------------------------------------------------------------------

create or replace trigger check_event_date
before insert on EventTab
for each row
begin
    if trunc(:new.EventDateTime) > trunc(sysdate) then
        RAISE_APPLICATION_ERROR (-20000, 'data nie może być z przyszłości');
    end if;
end;


-- -------------------------------------------------------------------------------
-- PRZYKŁAD POLECENIA, KTÓRE URUCHOMI WYZWALACZ                                              
-- -------------------------------------------------------------------------------

INSERT INTO EventTab VALUES (1, 'Fire in main hall', 1, 1, 'Warszawa, Mlociny Station', TO_DATE('2050-12-12 12:15:54','YYYY-MM-DD HH24:MI:SS'), 'Fire in main hall', 2, 50, 3);

-- -------------------------------------------------------------------------------
-- USUNIĘCIE WYZWALACZA                                             
-- -------------------------------------------------------------------------------
drop trigger check_event_date;

