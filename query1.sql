SET DATEFORMAT MDY;

CREATE TABLE Date (
Date_id INT IDENTITY(1,1) PRIMARY KEY ,
Date_time DATE)

INSERT INTO Date (Date_time)
VALUES
( '01-17-2021' ),
( '01-18-2021' ),
( '01-29-2021' ),
( '02-01-2021' ),
( '03-20-2021' ),
( '03-24-2021' ) ;



CREATE TABLE Hour (
Hour_id INT IDENTITY(0,1) PRIMARY KEY ,
Hour INT) ;

INSERT INTO HOUR(HOUR)
VALUES
(0), (1), (2), (3), (4), (5), (6), (7), (8),
(9), (10), (11), (12), (13), (14), (15), (16),
(17), (18), (19), (20), (21), (22), (23) ;



CREATE TABLE Stations (
    Station_name VARCHAR(50),
    Gen_unit_id  INT IDENTITY(0,1) PRIMARY KEY ,
    Gen_unit_name VARCHAR(50)
);

INSERT INTO Stations (Station_name, Gen_unit_name) VALUES
('Сургутская ГРЭС-1', 'Блок 1'),
('Сургутская ГРЭС-1', 'Блок 2'),
('Сургутская ГРЭС-2', 'Блок 1'),
('Сургутская ГРЭС-2', 'Блок 2'),
('Сургутская ГРЭС-3', 'Блок 1');



CREATE TABLE Generation (
  Date_id INT FOREIGN KEY REFERENCES Date(Date_id),
  Hour_id INT FOREIGN KEY REFERENCES Hour(Hour_id),
  Gen_unit_id INT FOREIGN KEY REFERENCES Stations(Gen_unit_id),
  Generation_hour DECIMAL(10,2) ) ;

INSERT INTO Generation values

(1, 2, 0, 1000),
(1, 3, 0, 1200),
(1, 4, 0, 1320),
(2, 12, 0, 2000),
(2, 13, 0, 2200),
(2, 14, 0, 2320),
(5, 7, 0, 5000),
(5, 8, 0, 6000),
(1, 2, 1, 2000),
(1, 3, 1, 2600),
(1, 4, 1, 1800),
(3, 12, 1, 2000),
(3, 13, 1, 2200),
(2, 20, 1, 12000),
(2, 21, 1, 10000),
(5, 7, 1, 200),
(5, 18, 1, 100),
(1, 2, 2, 5555.5),
(1, 3, 2, 4444.4),
(3, 12, 2, 20),
(3, 13, 2, 30),
(1, 2, 3, 700),
(1, 3, 3, 800),
(3, 12, 3, 200),
(3, 13, 3, 300),
(3, 2, 4, 100000),
(3, 3, 4, 200000);



SELECT  
DATEPART (year, Date_time) AS 'Год', 
DATEPART (month, Date_time) AS 'Месяц', 
DATEPART (day, Date_time) AS 'День',
Station_name, 
Gen_unit_name, 
AVG(Generation_hour) AS 'Средняя выработка за сутки',
SUM(Generation_hour) AS 'Суммарная выработка за сутки'

FROM Generation  g
INNER JOIN Date d ON d.Date_id = g.Date_id AND DATEPART (month, Date_time) = 1
INNER JOIN Stations ON Stations.Gen_unit_id = g.Gen_unit_id
GROUP BY DATEPART (year, Date_time),
         DATEPART (month, Date_time),
         DATEPART (day, Date_time),
         Station_name,
         Gen_unit_name