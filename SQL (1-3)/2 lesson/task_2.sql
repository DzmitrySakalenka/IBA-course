SET CURRENT SCHEMA = NHL27987;


DROP TABLE flags6;


CREATE TABLE flags6 (
    id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    fl1 BOOLEAN DEFAULT FALSE,
    fl2 BOOLEAN DEFAULT FALSE,
    fl3 BOOLEAN DEFAULT FALSE,
    fl4 BOOLEAN DEFAULT FALSE,
    fl5 BOOLEAN DEFAULT FALSE,
    fl6 BOOLEAN DEFAULT FALSE,
    fl7 BOOLEAN DEFAULT FALSE,
    fl8 BOOLEAN DEFAULT FALSE,
    fl9 BOOLEAN DEFAULT FALSE
);


INSERT INTO flags6 (fl1, fl2, fl3, fl4, fl5, fl6, fl7, fl8, fl9) 
VALUES (TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO flags6 (fl1, fl4, fl5, fl6, fl7, fl8, fl9) 
VALUES (TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO flags6 (fl1, fl3, fl6, fl7, fl8) 
VALUES (TRUE, TRUE, TRUE, TRUE, TRUE);
INSERT INTO flags6 (fl3) 
VALUES (TRUE);
INSERT INTO flags6 (fl3) 
VALUES (FALSE);


SELECT * FROM flags6;


SELECT id, 
       CONCAT('fl', LOCATE(TRUE, fl1 || fl2 || fl3 || fl4 || fl5 || fl6 || fl7 || fl8 || fl9) / 5+1) AS flag
  FROM flags6
 WHERE CAST(fl1 AS INT) + 
       CAST(fl2 AS INT) + 
       CAST(fl3 AS INT) + 
       CAST(fl4 AS INT) + 
       CAST(fl5 AS INT) + 
       CAST(fl6 AS INT) + 
       CAST(fl7 AS INT) + 
       CAST(fl8 AS INT) + 
       CAST(fl9 AS INT) = 1;


SELECT id, 
       CONCAT('fl', LOCATE(TRUE, fl1 || fl2 || fl3 || fl4 || fl5 || fl6 || fl7 || fl8 || fl9) / 5+1) AS flag
  FROM flags6
 WHERE LENGTH(fl1 || fl2 || fl3 || fl4 || fl5 || fl6 || fl7 || fl8 || fl9) = 4+5*8;

