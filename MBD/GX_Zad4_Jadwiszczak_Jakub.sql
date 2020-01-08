-- *******************************************************************************
-- *                                                                     
-- *   GRUPA: 		               
-- *                                 
-- *******************************************************************************
-- * 																		     
-- *   Nazwisko i imię:  Jakub  Jadwiszczak                                                        
-- * 																		     
-- *******************************************************************************
-- * 																		     
-- *   Nr indeksu:  98698                                                             
-- * 																		     
-- *******************************************************************************
-- * 																		     
-- *   Temat projektu:  Implementacja RDB na SZBD ORACLE                                                             
-- * 																		     
-- *******************************************************************************

-- -------------------------------------------------------------------------------
-- TWORZENIE STRUKTURY BAZY DANYCH                                            
-- -------------------------------------------------------------------------------
CREATE TABLE Role (
RoleId INTEGER CONSTRAINT Role_PK PRIMARY KEY,
Description VARCHAR2(255)
);

CREATE TABLE Users (
UserId INTEGER CONSTRAINT User_PK PRIMARY KEY,
Login  VARCHAR2(20) NOT NULL,
Firstname VARCHAR2(20) NOT NULL,
Lastname VARCHAR2(20) NOT NULL,
User_Password VARCHAR2(20) NOT NULL,
RoleId INTEGER CONSTRAINT User_Role_FK REFERENCES Role(RoleId),
Email VARCHAR2(20),
PhoneNumber VARCHAR2(20)
);

CREATE TABLE ContactType (
TypeId INTEGER CONSTRAINT ContactType_PK PRIMARY KEY,
Name VARCHAR2(20) NOT NULL,
Description VARCHAR2(255) NOT NULL
);

CREATE TABLE Contact (
ContactId INTEGER CONSTRAINT Contact_PK PRIMARY KEY,
Name VARCHAR2(20) NOT NULL,
Lastname VARCHAR2(20) NOT NULL,
TypeId INTEGER CONSTRAINT Contact_ContactType_FK REFERENCES ContactType(TypeId),
Localization VARCHAR2(255) NOT NULL,
PhoneNumber VARCHAR2(20) NOT NULL,
UserId INTEGER CONSTRAINT Contact_Users_FK REFERENCES Users(UserId),
);

CREATE TABLE EventType (
TypeId INTEGER CONSTRAINT EventType_PK PRIMARY KEY,
Name VARCHAR2(20) NOT NULL,
Description VARCHAR2(255) NOT NULL
);

CREATE TABLE EventCriticality (
CriticalityId INTEGER CONSTRAINT EventCriticality_PK PRIMARY KEY,
Name VARCHAR2(20) NOT NULL,
Description VARCHAR2(255) NOT NULL,
Color VARCHAR2(20) NOT NULL
);

CREATE TABLE EventTab (
EventId INTEGER CONSTRAINT EventTab_PK PRIMARY KEY,
Title VARCHAR2(30) NOT NULL,
TypeId INTEGER CONSTRAINT EventTab_EventType_FK REFERENCES EventType(TypeId),
CriticalityId INTEGER CONSTRAINT EventTab_EventCriticality_FK REFERENCES EventCriticality(CriticalityId),
Localization VARCHAR2(255) NOT NULL,
EventDateTime DATE NOT NULL,
Description VARCHAR2(255),
Reporter INTEGER CONSTRAINT EventTab_Contact_FK REFERENCES Contact(ContactId),
NumberOfPeople INTEGER,
UserId INTEGER CONSTRAINT EventTab_Users_FK REFERENCES Users(UserId),
);

CREATE TABLE CaseType (
TypeId INTEGER CONSTRAINT CaseType_PK PRIMARY KEY,
Name VARCHAR2(20) NOT NULL,
Description VARCHAR2(255) NOT NULL
);

CREATE TABLE CaseCriticality (
CriticalityId INTEGER CONSTRAINT CaseCriticality_PK PRIMARY KEY,
Name VARCHAR2(20) NOT NULL,
Description VARCHAR2(255) NOT NULL,
Color VARCHAR2(20) NOT NULL
);

CREATE TABLE CaseTab (
CaseId INTEGER CONSTRAINT CaseTab_PK PRIMARY KEY,
Title VARCHAR2(30) NOT NULL,
TypeId INTEGER CONSTRAINT CaseTab_CaseType_FK REFERENCES CaseType(TypeId),
CriticalityId INTEGER CONSTRAINT CaseTab_CaseCriticality_FK REFERENCES CaseCriticality(CriticalityId),
Localization VARCHAR2(255) NOT NULL,
CaseDateTime DATE NOT NULL,
Description VARCHAR2(255),
Executor INTEGER CONSTRAINT CaseTab_Contact_FK REFERENCES Contact(ContactId),
EventId INTEGER CONSTRAINT CaseTab_EventTab_FK REFERENCES EventTab(EventId),
ExpirationDateTime DATE NOT NULL,
NumberOfPeople INTEGER,
UserId INTEGER CONSTRAINT CaseTab_Users_FK REFERENCES Users(UserId),
IsClosed BOOLEAN DEFAULT FALSE
);

CREATE TABLE Measure (
MeasureId INTEGER CONSTRAINT Measure_PK PRIMARY KEY,
CaseId INTEGER CONSTRAINT Measure_CaseTab_FK REFERENCES CaseTab(CaseId),
Title VARCHAR2(30) NOT NULL,
Localization VARCHAR2(255) NOT NULL,
Description VARCHAR2(255),
Executor INTEGER CONSTRAINT Measure_Contact_FK REFERENCES Contact(ContactId),
UserId INTEGER CONSTRAINT Measure_Users_FK REFERENCES Users(UserId),
IsClosed BOOLEAN DEFAULT FALSE
);
-- -------------------------------------------------------------------------------
-- POLECENIA:   5 X INSERT  DO WSZYSTKICH TABEL                                               
-- -------------------------------------------------------------------------------
INSERT INTO Role VALUES (1, 'Admin');
INSERT INTO Role VALUES (2, 'Odczyt');
INSERT INTO Role VALUES (3, 'Zapis');
INSERT INTO Role VALUES (4, 'Zapis i odczyt');
INSERT INTO Role VALUES (5, 'FullAccessRoleBased');

INSERT INTO Users VALUES (1, 'admin', 'Adam', 'Adamski', 'admin', 1, 'admin@project.com', '+48 111-111-111');
INSERT INTO Users VALUES (2, 'reader', 'Bartosz', 'Bartoszewski', 'reader', 2, 'reader@project.com', '+48 211-111-111');
INSERT INTO Users VALUES (3, 'writer', 'Celina', 'Celinska', 'writer', 3, 'writer@project.com', '+48 311-111-111');
INSERT INTO Users VALUES (4, 'w&r', 'Damian', 'Damianski', 'w&r', 4, 'w&r@project.com', '+48 411-111-111');
INSERT INTO Users VALUES (5, 'full', 'Emil', 'Emilski', 'full', 5, 'full@project.com', '+48 511-111-111');

INSERT INTO ContactType VALUES (1, 'IT', 'IT team');
INSERT INTO ContactType VALUES (2, 'Emergency', 'Emergency');
INSERT INTO ContactType VALUES (3, 'Operator', 'Operators');
INSERT INTO ContactType VALUES (4, 'Police', 'Police');
INSERT INTO ContactType VALUES (5, 'Gardener', 'Gardeners');

INSERT INTO Contact VALUES (1, 'Adam', 'Adamski', 1, 'Wroclaw', '+48 111-111-111', 1);
INSERT INTO Contact VALUES (2, 'Bartosz', 'Bartoszewski', 3, 'Warszawa', '+48 211-111-111', 1);
INSERT INTO Contact VALUES (3, 'Celina', 'Celinska', 5, 'Lublin', '+48 311-111-111', 3);
INSERT INTO Contact VALUES (4, 'Damian', 'Damianski', 2, 'Opole', '+48 611-111-111', 3);
INSERT INTO Contact VALUES (5, 'Franek', 'Frankowski', 4, 'Chelm', '+48 711-111-111', 5);

INSERT INTO EventType VALUES (1, 'Fire', 'Fire');
INSERT INTO EventType VALUES (2, 'Water', 'Water');
INSERT INTO EventType VALUES (3, 'Stupid people', 'Stupid people');
INSERT INTO EventType VALUES (4, 'Acid', 'Acid');
INSERT INTO EventType VALUES (5, 'Traffic accident', 'Traffic accident');

INSERT INTO EventCriticality VALUES (1, 'Critical', 'Critical', 'Red');
INSERT INTO EventCriticality VALUES (2, 'Very Critical', 'Very Critical', 'Black');
INSERT INTO EventCriticality VALUES (3, 'Normal', 'Normal', 'Yellow');
INSERT INTO EventCriticality VALUES (4, 'Dangerous', 'Dangerous', 'Blue');
INSERT INTO EventCriticality VALUES (5, 'Trivial', 'Trivial', 'White');

INSERT INTO EventTab VALUES (1, 'Fire in main hall', 1, 1, 'Warszawa, Mlociny Station', TO_DATE('2019-12-12 12:15:54','YYYY-MM-DD HH24:MI:SS'), 'Fire in main hall', 2, 50, 3);
INSERT INTO EventTab VALUES (2, 'Water in main hall', 2, 4, 'Warszawa, Imielin Station', TO_DATE('2019-12-20 14:15:54','YYYY-MM-DD HH24:MI:SS'), 'Water in main hall', 3, NULL, 1);
INSERT INTO EventTab VALUES (3, 'Child lost', 3, 2, 'Wroclaw, Dworzec Nadodrze', TO_DATE('2019-12-21 22:45:54','YYYY-MM-DD HH24:MI:SS'), 'Child lost', 4, 1, 3);
INSERT INTO EventTab VALUES (4, 'Fire in train', 1, 1, 'Konopnicka train, Wroclaw-Lublin', TO_DATE('2019-12-23 11:15:54','YYYY-MM-DD HH24:MI:SS'), 'Fire in train', 3, 250, 1);
INSERT INTO EventTab VALUES (5, 'Car accident', 5, 3, 'Opole, Proszkowska Politechnika', TO_DATE('2019-12-24 21:54:54','YYYY-MM-DD HH24:MI:SS'), 'Car accident', 5, NULL, 1);

INSERT INTO CaseType VALUES (1, 'Emergency', 'Emergency');
INSERT INTO CaseType VALUES (2, 'Cleaning', 'Cleaning');
INSERT INTO CaseType VALUES (3, 'Police', 'Police');
INSERT INTO CaseType VALUES (4, 'IT', 'IT');
INSERT INTO CaseType VALUES (5, 'Planning', 'Planning');

INSERT INTO CaseCriticality VALUES (1, 'Critical', 'Critical', 'Red');
INSERT INTO CaseCriticality VALUES (2, 'Very Critical', 'Very Critical', 'Black');
INSERT INTO CaseCriticality VALUES (3, 'Normal', 'Normal', 'Yellow');
INSERT INTO CaseCriticality VALUES (4, 'Easy', 'Easy', 'Green');
INSERT INTO CaseCriticality VALUES (5, 'Trivial', 'Trivial', 'White');

INSERT INTO CaseTab VALUES (1, 'Call for fireman', 1, 4, 'Office', TO_DATE('2019-12-12 12:30:54','YYYY-MM-DD HH24:MI:SS'), 'Call for fireman', 2, 1,  TO_DATE('2019-12-12 12:40:54','YYYY-MM-DD HH24:MI:SS'), NULL, 3);
INSERT INTO CaseTab VALUES (2, 'Call for fireman', 1, 4, 'Office', TO_DATE('2019-12-20 14:30:54','YYYY-MM-DD HH24:MI:SS'), 'Call for fireman', 2, 2,  TO_DATE('2019-12-20 14:40:54','YYYY-MM-DD HH24:MI:SS'), NULL, 3);
INSERT INTO CaseTab VALUES (3, 'Call for police', 1, 4, 'Office', TO_DATE('2019-12-21 23:00:54','YYYY-MM-DD HH24:MI:SS'), 'Call for police', 2, 3,  TO_DATE('2019-12-21 23:05:54','YYYY-MM-DD HH24:MI:SS'), NULL, 3);
INSERT INTO CaseTab VALUES (4, 'Call for fireman', 1, 4, 'Office', TO_DATE('2019-12-23 11:30:54','YYYY-MM-DD HH24:MI:SS'), 'Call for fireman', 3, 4,  TO_DATE('2019-12-23 11:40:54','YYYY-MM-DD HH24:MI:SS'), NULL, 3);
INSERT INTO CaseTab VALUES (5, 'Computer is broken', 4, 1, 'Office', TO_DATE('2019-12-24 12:30:54','YYYY-MM-DD HH24:MI:SS'), 'Computer is broken', 1, NULL,  TO_DATE('2019-12-24 14:40:54','YYYY-MM-DD HH24:MI:SS'), NULL, 2);

INSERT INTO Measure VALUES (1, 1, 'Call for police', 'Office', 'Call for police', 1, 2);
INSERT INTO Measure VALUES (1, 1, 'Call for emergency', 'Office', 'Call for emergency', 1, 2);
INSERT INTO Measure VALUES (1, 1, 'Cleaning', 'Warszawa, Mlociny Station', 'Cleaning', 3, 2);
INSERT INTO Measure VALUES (1, 5, 'Buy new computer', 'Office', 'Buy new computer', 3, 1);
INSERT INTO Measure VALUES (1, 5, 'Install OS', 'Office', 'Install OS', 1, 1);
-- -------------------------------------------------------------------------------
-- POLECENIA:   5 X SELECT  ( PRZYKŁADY Z JOIN NA MIN. 3 TABELACH)                                                   
-- -------------------------------------------------------------------------------
SELECT * FROM EventTab
LEFT JOIN CaseTab ON (EventTab.EventId = CaseTab.EventId)
LEFT JOIN Users ON (EventTab.UserId = Users.UserId);

SELECT 
EventTab.EventId,
CaseTab.CaseId,
Users.UserId
FROM EventTab
LEFT JOIN CaseTab ON (EventTab.EventId = CaseTab.EventId)
LEFT JOIN Users ON (EventTab.UserId = Users.UserId);

SELECT 
EventTab.EventId,
CaseTab.CaseId,
Users.UserId
FROM EventTab
LEFT JOIN CaseTab ON (EventTab.EventId = CaseTab.EventId)
LEFT JOIN Users ON (EventTab.UserId = Users.UserId)
WHERE EventTab.EventId<4;

SELECT * FROM CaseTab
LEFT JOIN EventTab ON (EventTab.EventId = CaseTab.EventId)
LEFT JOIN Measure ON (CaseTab.CaseId = Measure.CaseId);

SELECT * FROM Measure 
LEFT JOIN CaseTab ON (CaseTab.CaseId = Measure.CaseId)
LEFT JOIN Users ON (Users.UserId = Measure.UserId);
-- -------------------------------------------------------------------------------
-- POLECENIA:   5 X UPDATE     (POLECENIA POWINNY WYKORZYSTYWAĆ PODZAPYTANIA)                                                 
-- -------------------------------------------------------------------------------
UPDATE Contact SET Lastname = (SELECT Lastname FROM Users WHERE UserId = 1);

UPDATE Contact 
SET Lastname = (SELECT Lastname FROM Users WHERE UserId = 2) 
WHERE MOD(ContactId,2) = 1;

UPDATE Measure 
SET CaseId = (SELECT Max(CaseId) FROM CaseTab) 
WHERE MeaureId = 1;

UPDATE EventTab
SET UserId = (SELECT Min(UserId) FROM CaseTab)
WHERE UserId = 2;

UPDATE Users 
SET RoleId = (SELECT Max(RoleId) FROM Role)
WHERE UserId = 5;
-- -------------------------------------------------------------------------------
-- POLECENIA:   5 X DELETE     (TEŻ Z PODZAPYTANIAMI)                                                  
-- -------------------------------------------------------------------------------
DELETE FROM Measure WHERE CaseId = (SELECT Min(CaseId) FROM CaseTab);

DELETE FROM Measure WHERE CaseId in (SELECT CaseId FROM CaseTab WHERE CaseId>3);

DELETE FROM CaseTab WHERE EventId in (SELECT EventId FROM EventTab);

DELETE FROM Contact WHERE Lastname in (SELECT Lastname FROM Users);

DELETE FROM EventCriticality WHERE Color in (SELECT Color FROM CaseCriticality);
-- -------------------------------------------------------------------------------
-- USUWANIE STRUKTURY BAZY DANYCH                                            
-- -------------------------------------------------------------------------------
DROP TABLE Role;
DROP TABLE Users;
DROP TABLE ContactType;
DROP TABLE Contact;
DROP TABLE EventType;
DROP TABLE EventCriticality;
DROP TABLE EventTab;
DROP TABLE CaseType;
DROP TABLE CaseCriticality;
DROP TABLE CaseTab;
DROP TABLE Measure;