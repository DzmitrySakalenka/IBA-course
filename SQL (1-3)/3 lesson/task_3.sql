SET CURRENT SCHEMA = NHL27987@

DROP TABLE SESSION.temp_employee@
DROP TABLE SESSION.temp_workdept@
DROP PROCEDURE custom_rank@
DROP PROCEDURE custom_row_num@


DECLARE GLOBAL TEMPORARY TABLE SESSION.temp_employee AS (
    SELECT *, 1 AS row_num 
      FROM employee
) DEFINITION ONLY ON COMMIT PRESERVE ROWS@


INSERT INTO SESSION.temp_employee
SELECT *, 
       1 AS row_num 
  FROM employee@


CREATE PROCEDURE custom_row_num ()
BEGIN
    DECLARE row_count INT;
    DECLARE row_number INT;
    
    SET row_count = (SELECT COUNT(*) 
                       FROM SESSION.temp_employee
                    );
    SET row_number = 0;

    L1: LOOP
        IF (row_count = row_number) THEN LEAVE L1; END IF;
        
        UPDATE SESSION.temp_employee 
        
        SET row_num = (row_count - row_number)
        
        WHERE empno IN (SELECT empno 
                          FROM SESSION.temp_employee 
                         LIMIT (row_count - row_number)
                       );

		SET row_number = row_number + 1;
    END LOOP L1;
END@


CALL custom_row_num() @


SELECT * FROM SESSION.temp_employee@


DECLARE GLOBAL TEMPORARY TABLE SESSION.temp_workdept AS (
    SELECT workdept, 
           1 AS rank 
      FROM employee
) DEFINITION ONLY ON COMMIT PRESERVE ROWS@


INSERT INTO SESSION.temp_workdept
SELECT DISTINCT workdept, 
       1 AS rank
  FROM employee
 ORDER BY workdept DESC@


CREATE PROCEDURE custom_rank ()
BEGIN
    DECLARE row_count INT;
    DECLARE row_number INT;

    SET row_count = (SELECT COUNT(*) 
                       FROM (SELECT DISTINCT workdept 
                               FROM employee
                            )
                    );
    SET row_number = 0;

    L1: LOOP
        IF (row_count = row_number) THEN LEAVE L1; END IF;
        
        UPDATE SESSION.temp_workdept 
        
        SET rank = (row_number + 1)
        
        WHERE workdept IN (SELECT workdept 
                             FROM SESSION.temp_workdept 
                            LIMIT (row_count - row_number)
                          );

		SET row_number = row_number + 1;

    END LOOP L1;
END@


CALL custom_rank() @


SELECT workdept,
       lastname,
       rank
  FROM employee
       INNER JOIN SESSION.temp_workdept 
       USING(workdept)@


SELECT ( SELECT COUNT(*)
           FROM employee AS temp_emp
          WHERE temp_emp.empno <= emp.empno
       ) AS number, 
       emp.*
  FROM employee emp
 ORDER BY emp.empno@
