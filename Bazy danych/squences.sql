DROP SEQUENCE IF EXISTS age_iterator
GO

CREATE SEQUENCE age_iterator	
MINVALUE 18
MAXVALUE 65
START WITH 18
INCREMENT BY 5
CYCLE;


INSERT INTO [User]
VALUES ('operator', 'Rafa³', 'Rafalski', 'operator', 3, 'o@o.pl', '111', NEXT VALUE FOR age_iterator);