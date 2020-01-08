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