﻿ALTER TABLE Users DROP CONSTRAINT Users_Role_FK;
ALTER TABLE CaseTab DROP CONSTRAINT CaseTab_Users_FK;
ALTER TABLE Contact DROP CONSTRAINT Contact_Users_FK;
ALTER TABLE EventTab DROP CONSTRAINT EventTab_Users_FK;
ALTER TABLE Contact DROP CONSTRAINT Contact_ContactType_FK;
ALTER TABLE EventTab DROP CONSTRAINT EventTab_Contact_FK;
ALTER TABLE CaseTab DROP CONSTRAINT CaseTab_Contact_FK;
ALTER TABLE EventTab DROP CONSTRAINT EventTab_EventType_FK;
ALTER TABLE EventTab DROP CONSTRAINT EventTab_EventCriticality_FK;
ALTER TABLE CaseTab DROP CONSTRAINT CaseTab_EventTab_FK;
ALTER TABLE CaseTab DROP CONSTRAINT CaseTab_CaseType_FK;
ALTER TABLE CaseTab DROP CONSTRAINT CaseTab_CaseCriticality_FK;
ALTER TABLE Measure DROP CONSTRAINT Measure_CaseTab_FK;
ALTER TABLE Measure DROP CONSTRAINT Measure_Contact_FK;
ALTER TABLE Measure DROP CONSTrAINT Measure_Users_FK;
DROP TABLE CaseCriticality;
DROP TABLE CaseTab;
DROP TABLE Role;
DROP TABLE Users;
DROP TABLE ContactType;
DROP TABLE Contact;
DROP TABLE EventTab;
DROP TABLE EventCriticality;
DROP TABLE CaseType;
DROP TABLE EventType;
DROP TABLE Measure;