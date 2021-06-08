SET CURRENT SCHEMA = NHL27987;


DROP TABLE racers;


CREATE TABLE racers (
    name VARCHAR(32),
    team VARCHAR(32),
    timetofirst INT);
    

INSERT INTO racers 
VALUES ('Hamilton', 'Mersedes', 0),
      ('Vettel', 'Ferrari', 1),
      ('Raikonnen', 'Ferrari', 2),
      ('Bottas', 'Mersedes', 89),
      ('Ocon', 'Force', 90),
      ('Sainz', 'Renault', 91),
      ('Perez', 'Force', 123),
      ('Massa', 'Williams', 124),
      ('Kvyat', 'Toro Rosso', 125),
      ('Stroll', 'Williams', 127),
      ('Vandoorne', 'McLaren Honda', 131),
      ('Hartley', 'Toro Rosso', 138),
      ('Grosjean', 'Haas', 161),
      ('Ericsson', 'Sauber', 162);


WITH first_racer AS
(
    SELECT *
      FROM (SELECT *,
                   -timetofirst+LEAD(timetofirst, 3) OVER(ORDER BY timetofirst) AS timelag
              FROM racers)
     WHERE timelag IS NOT Null
     ORDER BY timelag
     LIMIT 1

)
SELECT * 
  FROM racers 
 WHERE timetofirst >= (SELECT timetofirst FROM first_racer)
   AND timetofirst <= (SELECT timetofirst+timelag FROM first_racer);
