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