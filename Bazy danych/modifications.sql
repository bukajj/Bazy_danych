--Modyfikacje tablic:

ALTER TABLE	Users ADD Age INTEGER;
ALTER TABLE Contact DROP COLUMN Email;
ALTER TABLE Contact ADD Email VARCHAR(30);
EXEC sp_rename 'Users', 'User', 'OBJECT';
EXEC sp_rename 'User.User_Password', 'Password', 'COLUMN';
GO


--Modyfikacje danych:
UPDATE Measure 
SET CaseId = (SELECT Max(CaseId) FROM CaseTab) 
WHERE MeasureId = 1;

UPDATE [dbo].[User] 
SET RoleId = (SELECT Max(RoleId) FROM Role)
WHERE UserId = 5;

UPDATE EventTab
SET UserId = (SELECT Min(UserId) FROM CaseTab)
WHERE UserId = 2;

UPDATE Contact 
SET Lastname = (SELECT Lastname FROM Users WHERE UserId = 2) 
WHERE ContactId%2 = 1;

SET ANSI_NULLS OFF
UPDATE [User] SET Age = 18 WHERE Age = null;