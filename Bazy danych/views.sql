SET ANSI_NULLS OFF;
IF OBJECT_ID('short_users') IS NOT NULL
	DROP VIEW short_users
GO

CREATE VIEW short_users AS 
SELECT [UserId], [Firstname], [Lastname] FROM [User];
GO

IF OBJECT_ID('cases_with_related_events') IS NOT NULL
	DROP VIEW cases_with_related_events
GO

CREATE VIEW cases_with_related_events AS
SELECT ct.*, et.[Title] AS EventTitle, et.[Description] AS EventDescription FROM [CaseTab] ct
LEFT JOIN [EventTab] et ON ct.EventId = et.EventId;
GO

IF OBJECT_ID('measures_with_related_cases') IS NOT NULL
	DROP VIEW measures_with_related_cases
GO

CREATE VIEW measures_with_related_cases AS
SELECT m.*, ct.[Title] AS CaseTitle, ct.[Description] AS CaseDescription FROM [Measure] m
LEFT JOIN [CaseTab] ct ON ct.CaseId = m.CaseId;
GO