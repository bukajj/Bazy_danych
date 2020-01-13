/*
	Tworzenie tablic bazy danych.
*/

CREATE TABLE Role (
RoleId INTEGER IDENTITY (1,1) CONSTRAINT Role_PK PRIMARY KEY  NOT NULL,
Description VARCHAR(255)
);

CREATE TABLE Users (
UserId INTEGER IDENTITY (1,1) CONSTRAINT User_PK PRIMARY KEY  NOT NULL,
Login  VARCHAR(20) NOT NULL,
Firstname VARCHAR(20) NOT NULL,
Lastname VARCHAR(20) NOT NULL,
User_Password VARCHAR(20) NOT NULL,
RoleId INTEGER CONSTRAINT Users_Role_FK REFERENCES Role(RoleId) NOT NULL,
Email VARCHAR(20),
PhoneNumber VARCHAR(20)
);

CREATE TABLE ContactType (
TypeId INTEGER IDENTITY (1,1) CONSTRAINT ContactType_PK PRIMARY KEY  NOT NULL,
Name VARCHAR(20) NOT NULL,
Description VARCHAR(255) NOT NULL
);

CREATE TABLE Contact (
ContactId INTEGER IDENTITY (1,1) CONSTRAINT Contact_PK PRIMARY KEY  NOT NULL,
Name VARCHAR(20) NOT NULL,
Lastname VARCHAR(20) NOT NULL,
TypeId INTEGER CONSTRAINT Contact_ContactType_FK REFERENCES ContactType(TypeId) NOT NULL,
Localization VARCHAR(255) NOT NULL,
PhoneNumber VARCHAR(20) NOT NULL,
UserId INTEGER CONSTRAINT Contact_Users_FK REFERENCES Users(UserId) NOT NULL,
);

CREATE TABLE EventType (
TypeId INTEGER IDENTITY (1,1) CONSTRAINT EventType_PK PRIMARY KEY  NOT NULL,
Name VARCHAR(20) NOT NULL,
Description VARCHAR(255) NOT NULL
);

CREATE TABLE EventCriticality (
CriticalityId INTEGER IDENTITY (1,1) CONSTRAINT EventCriticality_PK PRIMARY KEY  NOT NULL,
Name VARCHAR(20) NOT NULL,
Description VARCHAR(255) NOT NULL,
Color VARCHAR(20) NOT NULL
);

CREATE TABLE EventTab (
EventId INTEGER IDENTITY (1,1) CONSTRAINT EventTab_PK PRIMARY KEY  NOT NULL,
Title VARCHAR(30) NOT NULL,
TypeId INTEGER CONSTRAINT EventTab_EventType_FK REFERENCES EventType(TypeId) NOT NULL,
CriticalityId INTEGER CONSTRAINT EventTab_EventCriticality_FK REFERENCES EventCriticality(CriticalityId) NOT NULL,
Localization VARCHAR(255) NOT NULL,
EventDateTime DATE NOT NULL,
Description VARCHAR(255),
Reporter INTEGER CONSTRAINT EventTab_Contact_FK REFERENCES Contact(ContactId) NOT NULL,
NumberOfPeople INTEGER,
UserId INTEGER CONSTRAINT EventTab_Users_FK REFERENCES Users(UserId) NOT NULL,
);

CREATE TABLE CaseType (
TypeId INTEGER IDENTITY (1,1) CONSTRAINT CaseType_PK PRIMARY KEY  NOT NULL,
Name VARCHAR(20) NOT NULL,
Description VARCHAR(255) NOT NULL
);

CREATE TABLE CaseCriticality (
CriticalityId INTEGER IDENTITY (1,1) CONSTRAINT CaseCriticality_PK PRIMARY KEY  NOT NULL,
Name VARCHAR(20) NOT NULL,
Description VARCHAR(255) NOT NULL,
Color VARCHAR(20) NOT NULL
);

CREATE TABLE CaseTab (
CaseId INTEGER IDENTITY (1,1) CONSTRAINT CaseTab_PK PRIMARY KEY  NOT NULL,
Title VARCHAR(30) NOT NULL,
TypeId INTEGER CONSTRAINT CaseTab_CaseType_FK REFERENCES CaseType(TypeId) NOT NULL,
CriticalityId INTEGER CONSTRAINT CaseTab_CaseCriticality_FK REFERENCES CaseCriticality(CriticalityId) NOT NULL,
Localization VARCHAR(255) NOT NULL,
CaseDateTime DATE NOT NULL,
Description VARCHAR(255),
Executor INTEGER CONSTRAINT CaseTab_Contact_FK REFERENCES Contact(ContactId) NOT NULL,
EventId INTEGER CONSTRAINT CaseTab_EventTab_FK REFERENCES EventTab(EventId),
ExpirationDateTime DATE NOT NULL,
NumberOfPeople INTEGER,
UserId INTEGER CONSTRAINT CaseTab_Users_FK REFERENCES Users(UserId) NOT NULL,
IsClosed BIT DEFAULT 'false'
);

CREATE TABLE Measure (
MeasureId INTEGER IDENTITY (1,1) CONSTRAINT Measure_PK PRIMARY KEY  NOT NULL,
CaseId INTEGER CONSTRAINT Measure_CaseTab_FK REFERENCES CaseTab(CaseId) NOT NULL,
Title VARCHAR(30) NOT NULL,
Localization VARCHAR(255) NOT NULL,
Description VARCHAR(255),
Executor INTEGER CONSTRAINT Measure_Contact_FK REFERENCES Contact(ContactId),
UserId INTEGER CONSTRAINT Measure_Users_FK REFERENCES Users(UserId) NOT NULL,
IsClosed BIT DEFAULT 'false'
);

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

/*
	Wyœwietlenie pustych tablic
*/

SELECT * FROM [Role];
SELECT * FROM [Users];
SELECT * FROM [Contact];
SELECT * FROM [ContactType];
SELECT * FROM [EventType];
SELECT * FROM [EventCriticality];
SELECT * FROM [EventTab];
SELECT * FROM [CaseType];
SELECT * FROM [CaseCriticality];
SELECT * FROM [CaseTab];
SELECT * FROM [Measure];

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

/*
	Wstawienie danych do tablic
*/

INSERT INTO Role VALUES ('Admin');
INSERT INTO Role VALUES ('Odczyt');
INSERT INTO Role VALUES ('Zapis');
INSERT INTO Role VALUES ('Zapis i odczyt');
INSERT INTO Role VALUES ('FullAccessRoleBased');

INSERT INTO Users VALUES ('admin', 'Adam', 'Adamski', 'admin', 1, 'admin@project.com', '+48 111-111-111');
INSERT INTO Users VALUES ('reader', 'Bartosz', 'Bartoszewski', 'reader', 2, 'reader@project.com', '+48 211-111-111');
INSERT INTO Users VALUES ('writer', 'Celina', 'Celinska', 'writer', 3, 'writer@project.com', '+48 311-111-111');
INSERT INTO Users VALUES ('w&r', 'Damian', 'Damianski', 'w&r', 4, 'w&r@project.com', '+48 411-111-111');
INSERT INTO Users VALUES ('full', 'Emil', 'Emilski', 'full', 5, 'full@project.com', '+48 511-111-111');

INSERT INTO ContactType VALUES ('IT', 'IT team');
INSERT INTO ContactType VALUES ('Emergency', 'Emergency');
INSERT INTO ContactType VALUES ('Operator', 'Operators');
INSERT INTO ContactType VALUES ('Police', 'Police');
INSERT INTO ContactType VALUES ('Gardener', 'Gardeners');

INSERT INTO Contact VALUES ('Adam', 'Adamski', 1, 'Wroclaw', '+48 111-111-111', 1);
INSERT INTO Contact VALUES ('Bartosz', 'Bartoszewski', 3, 'Warszawa', '+48 211-111-111', 1);
INSERT INTO Contact VALUES ('Celina', 'Celinska', 5, 'Lublin', '+48 311-111-111', 3);
INSERT INTO Contact VALUES ('Damian', 'Damianski', 2, 'Opole', '+48 611-111-111', 3);
INSERT INTO Contact VALUES ('Franek', 'Frankowski', 4, 'Chelm', '+48 711-111-111', 5);

INSERT INTO EventType VALUES ('Fire', 'Fire');
INSERT INTO EventType VALUES ('Water', 'Water');
INSERT INTO EventType VALUES ('Stupid people', 'Stupid people');
INSERT INTO EventType VALUES ('Acid', 'Acid');
INSERT INTO EventType VALUES ('Traffic accident', 'Traffic accident');

INSERT INTO EventCriticality VALUES ('Critical', 'Critical', 'Red');
INSERT INTO EventCriticality VALUES ('Very Critical', 'Very Critical', 'Black');
INSERT INTO EventCriticality VALUES ('Normal', 'Normal', 'Yellow');
INSERT INTO EventCriticality VALUES ('Dangerous', 'Dangerous', 'Blue');
INSERT INTO EventCriticality VALUES ('Trivial', 'Trivial', 'White');

INSERT INTO EventTab VALUES ('Fire in main hall', 1, 1, 'Warszawa, Mlociny Station', '2019-12-12 12:15:54', 'Fire in main hall', 2, 50, 3);
INSERT INTO EventTab VALUES ('Water in main hall', 2, 4, 'Warszawa, Imielin Station', '2019-12-20 14:15:54', 'Water in main hall', 3, NULL ,1);
INSERT INTO EventTab VALUES ('Child lost', 3, 2, 'Wroclaw, Dworzec Nadodrze', '2019-12-21 22:45:54', 'Child lost', 4, 1, 3);
INSERT INTO EventTab VALUES ('Fire in train', 1, 1, 'Konopnicka train, Wroclaw-Lublin', '2019-12-23 11:15:54', 'Fire in train', 3, 250, 1);
INSERT INTO EventTab VALUES ('Car accident', 5, 3, 'Opole, Proszkowska Politechnika', '2019-12-24 21:54:54', 'Car accident', 5, NULL, 1);

INSERT INTO CaseType VALUES ('Emergency', 'Emergency');
INSERT INTO CaseType VALUES ('Cleaning', 'Cleaning');
INSERT INTO CaseType VALUES ('Police', 'Police');
INSERT INTO CaseType VALUES ('IT', 'IT');
INSERT INTO CaseType VALUES ('Planning', 'Planning');

INSERT INTO CaseCriticality VALUES ('Critical', 'Critical', 'Red');
INSERT INTO CaseCriticality VALUES ('Very Critical', 'Very Critical', 'Black');
INSERT INTO CaseCriticality VALUES ('Normal', 'Normal', 'Yellow');
INSERT INTO CaseCriticality VALUES ('Easy', 'Easy', 'Green');
INSERT INTO CaseCriticality VALUES ('Trivial', 'Trivial', 'White');

INSERT INTO CaseTab VALUES ('Call for fireman', 1, 4, 'Office', '2019-12-12 12:30:54', 'Call for fireman', 2, 1,  '2019-12-12 12:40:54', 0, 3, 'true');
INSERT INTO CaseTab VALUES ('Call for fireman', 1, 4, 'Office', '2019-12-20 14:30:54', 'Call for fireman', 2, 2,  '2019-12-20 14:40:54', NULL, 3, 'false');
INSERT INTO CaseTab VALUES ('Call for police', 1, 4, 'Office', '2019-12-21 23:00:54', 'Call for police', 2, 3,  '2019-12-21 23:05:54', NULL, 3, 'false');
INSERT INTO CaseTab VALUES ('Call for fireman', 1, 4, 'Office', '2019-12-23 11:30:54', 'Call for fireman', 3, 4,  '2019-12-23 11:40:54', NULL, 3, 'false');
INSERT INTO CaseTab VALUES ('Computer is broken', 4, 1, 'Office', '2019-12-24 12:30:54', 'Computer is broken', 1, 3, '2019-12-24 14:40:54', NULL, 2, 'true');

INSERT INTO Measure VALUES (1, 'Call for police', 'Office', 'Call for police', 1, 2, 'true');
INSERT INTO Measure VALUES (1, 'Call for emergency', 'Office', 'Call for emergency', 1, 2, 'false');
INSERT INTO Measure VALUES (1, 'Cleaning', 'Warszawa, Mlociny Station', 'Cleaning', 3, 2, 'false');
INSERT INTO Measure VALUES (5, 'Buy new computer', 'Office', 'Buy new computer', 3, 1, 'false');
INSERT INTO Measure VALUES (5, 'Install OS', 'Office', 'Install OS', 1, 1, 'true');

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

/*
	Wyœwietlenie pe³nych tablic
*/

SELECT * FROM [Role];
SELECT * FROM [Users];
SELECT * FROM [Contact];
SELECT * FROM [ContactType];
SELECT * FROM [EventType];
SELECT * FROM [EventCriticality];
SELECT * FROM [EventTab];
SELECT * FROM [CaseType];
SELECT * FROM [CaseCriticality];
SELECT * FROM [CaseTab];
SELECT * FROM [Measure];

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

--Modyfikacje tablic:

ALTER TABLE	Users ADD Age INTEGER;  -- Dodanie kolumny Age do tablicy Users

ALTER TABLE Users DROP COLUMN Email; -- Usuniêcie kolumny Email z tablicy Users
ALTER TABLE Users ADD Email VARCHAR(30); -- Dodanie tablicy Email do tablicy Users z nowym typem.

EXEC sp_rename 'Users', 'User', 'OBJECT'; -- Zmiana nazwy tablicy z Users na User

EXEC sp_rename 'User.User_Password', 'Password', 'COLUMN'; -- Zmiana nazwy kolumny User_Password na Password w tablicy User
GO

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- Modyfikacje danych: 

UPDATE Measure 
SET CaseId = (SELECT Max(CaseId) FROM CaseTab) 
WHERE MeasureId = 1;

UPDATE [User] 
SET RoleId = (SELECT Max(RoleId) FROM Role)
WHERE UserId = 5;

UPDATE EventTab
SET UserId = (SELECT Min(UserId) FROM CaseTab)
WHERE UserId = 2;

UPDATE Contact 
SET Lastname = (SELECT Lastname FROM [User] WHERE UserId = 2) 
WHERE ContactId%2 = 1;

SET ANSI_NULLS OFF
UPDATE [User] SET Age = 25 WHERE Age = null;

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

--SELECTY:

--zwyk³e
SELECT UserId FROM [dbo].[User];
SELECT * FROM Role;
SELECT Description FROM ContactType;
SELECT UserId FROM Contact;
SELECT TypeId FROM EventType;

--zapytania z funkcjami
SELECT * FROM [dbo].[User] WHERE UserId%2=1;
SELECT MAX(UserId) FROM [dbo].[User] WHERE UserId%2=1;
SELECT * FROM CaseTab WHERE CaseId = 5;
SELECT * FROM [dbo].[User] WHERE [dbo].[User].[Login] in ('writer','reader');
SELECT [Contact].[Name], [Contact].[Lastname], [Contact].[Localization], [Contact].[PhoneNumber] FROM [Contact]
WHERE [Contact].[Lastname] like '%ski';

--z³¹czenia
SELECT * FROM EventTab
LEFT JOIN CaseTab ON (EventTab.EventId = CaseTab.EventId)
LEFT JOIN [User] ON (EventTab.UserId = [User].UserId);

SELECT 
EventTab.EventId,
CaseTab.CaseId,
[User].UserId
FROM EventTab
RIGHT JOIN CaseTab ON (EventTab.EventId = CaseTab.EventId)
JOIN [User] ON (EventTab.UserId = [User].UserId);

SELECT 
EventTab.EventId,
CaseTab.CaseId,
[User].UserId
FROM EventTab
RIGHT JOIN CaseTab ON (EventTab.EventId = CaseTab.EventId)
RIGHT JOIN [User] ON (EventTab.UserId = [User].UserId)
WHERE EventTab.EventId<4;

SELECT * FROM CaseTab
LEFT JOIN EventTab ON (EventTab.EventId = CaseTab.EventId)
LEFT JOIN Measure ON (CaseTab.CaseId = Measure.CaseId);

SELECT * FROM Measure 
LEFT JOIN CaseTab ON (CaseTab.CaseId = Measure.CaseId)
LEFT JOIN [User] ON ([User].UserId = Measure.UserId);

--podzapytania
SET ANSI_NULLS OFF;

SELECT * FROM (SELECT * FROM [EventTab] WHERE [NumberOfPeople] != NULL) AS NotNullNOP WHERE [EventId]>2;

SELECT * FROM [User] 
WHERE EXISTS (SELECT [Lastname] FROM [Contact] WHERE [User].[Lastname]=[Contact].[Lastname] AND [User].[Firstname]=[Contact].[Name]);

SELECT * 
FROM [EventTab]
WHERE [NumberOfPeople] > ANY (SELECT [NumberOfPeople] FROM [EventTab] WHERE [NumberOfPeople] != NULL);

SELECT * 
FROM [EventTab]
WHERE [NumberOfPeople] > ALL (SELECT [NumberOfPeople] FROM [EventTab] WHERE [NumberOfPeople] != NULL);

SELECT MAX([ContactId]) FROM [Contact] WHERE [Lastname] like '%ski';

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- WIDOKI:

SET ANSI_NULLS OFF;
IF OBJECT_ID('short_users') IS NOT NULL
	DROP VIEW short_users
GO

CREATE VIEW short_users AS 
SELECT [UserId], [Firstname], [Lastname] FROM [User];
GO

SELECT * FROM [short_users];

IF OBJECT_ID('cases_with_related_events') IS NOT NULL
	DROP VIEW cases_with_related_events
GO

CREATE VIEW cases_with_related_events AS
SELECT ct.*, et.[Title] AS EventTitle, et.[Description] AS EventDescription FROM [CaseTab] ct
LEFT JOIN [EventTab] et ON ct.EventId = et.EventId;
GO

SELECT * FROM [measures_with_related_cases];


IF OBJECT_ID('measures_with_related_cases') IS NOT NULL
	DROP VIEW measures_with_related_cases
GO

CREATE VIEW measures_with_related_cases AS
SELECT m.*, ct.[Title] AS CaseTitle, ct.[Description] AS CaseDescription FROM [Measure] m
LEFT JOIN [CaseTab] ct ON ct.CaseId = m.CaseId;
GO

SELECT * FROM [measures_with_related_cases];

-- ---------------------------------------------------------------------------------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------------------------

-- SEKWENCJA:

DROP SEQUENCE IF EXISTS age_iterator
GO

CREATE SEQUENCE age_iterator	
MINVALUE 18
MAXVALUE 65
START WITH 18
INCREMENT BY 5
CYCLE;


INSERT INTO [User]
VALUES ('operator', 'Rafa³', 'Rafalski', 'operator', 3, '111', NEXT VALUE FOR age_iterator,'o@o.pl');

INSERT INTO [User]
VALUES ('reader1', 'Rafa³', 'Migalski', 'reader', 2, '111-222', NEXT VALUE FOR age_iterator,'migalski@op.pl');


SELECT * FROM [User];