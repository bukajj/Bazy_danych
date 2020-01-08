﻿CREATE TABLE Role (
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