DROP TABLE students@


CREATE TABLE students (
    id INT, 
    score INT, 
    groupid INT)@


INSERT INTO students
VALUES (1, 7, 1),
       (2, 9, 1),
       (3, 8, 1),
       (4, 5, 2),
       (5, 3, 2),
       (6, 4, 2),
       (7, 9, 3),
       (8, 4, 3),
       (9, 6, 3)@


SELECT * 
  FROM students 
 ORDER BY score@

SELECT groupid, 
       AVG(score)
  FROM students
 GROUP BY groupid@


DROP TABLE SESSION.free_students@
DROP TABLE SESSION.temp_groups@
DROP PROCEDURE grouping_students@


DECLARE GLOBAL TEMPORARY TABLE SESSION.free_students AS (
    SELECT *, 
           Null AS row_num 
      FROM students
) DEFINITION ONLY ON COMMIT PRESERVE ROWS@


DECLARE GLOBAL TEMPORARY TABLE SESSION.temp_groups AS (
    SELECT * 
      FROM students
) DEFINITION ONLY ON COMMIT PRESERVE ROWS@


INSERT INTO SESSION.free_students
       SELECT id, 
              score, 
              Null AS groupid, 
              Null AS row_num 
         FROM students 
        ORDER BY score DESC@


SELECT * FROM SESSION.free_students@


CREATE PROCEDURE grouping_students ()
BEGIN
    DECLARE count_groups INT;
    DECLARE row_count INT;
    DECLARE loop_num INT;

    SET count_groups = 3;
    SET loop_num = count_groups;

    L1: LOOP
        IF (loop_num = 0) THEN LEAVE L1; END IF;
        
        INSERT INTO SESSION.temp_groups 
        VALUES (0, 0, count_groups - loop_num + 1);

		SET loop_num = loop_num - 1;
    END LOOP L1;        

    SET row_count = (SELECT COUNT(*) 
                       FROM SESSION.free_students
                    );
    SET loop_num = count_groups - row_count % count_groups;

    L2: LOOP
        IF (loop_num = 0 OR loop_num = count_groups) THEN LEAVE L2; END IF;
        
        INSERT INTO SESSION.free_students 
        VALUES (0, 0, Null, Null);
		
        SET loop_num = loop_num - 1;
    END LOOP L2;

    SET row_count = (SELECT COUNT(*) 
                       FROM SESSION.free_students
                    );
    SET loop_num = row_count / count_groups;

    L3: LOOP
        IF (loop_num = 0) THEN LEAVE L3; END IF;

        UPDATE SESSION.temp_groups
        SET id = row_number() over(ORDER BY score);

        UPDATE SESSION.free_students
           SET row_num = row_number() over(ORDER BY score DESC)
         WHERE row_num IS Null
         LIMIT count_groups;

		UPDATE SESSION.temp_groups tg
        
        SET tg.score = (
            SELECT tg.score + fs.score
              FROM (SELECT * 
                      FROM SESSION.free_students 
                     WHERE row_num IS NOT Null 
                       AND groupid IS Null
                   ) AS fs
             WHERE fs.row_num = tg.id
        );


        UPDATE SESSION.free_students fs

        SET fs.groupid = (
            SELECT tg.groupid
              FROM SESSION.temp_groups tg
             WHERE fs.row_num = tg.id
        ) 
        WHERE fs.row_num IS NOT Null 
          AND fs.groupid IS Null;

        SET loop_num = loop_num - 1;
    END LOOP L3;
END@


CALL grouping_students ()@


UPDATE students s
   SET groupid = (SELECT groupid
                    FROM SESSION.free_students fs
                   WHERE s.id = fs.id
                 )@


SELECT * FROM students@

