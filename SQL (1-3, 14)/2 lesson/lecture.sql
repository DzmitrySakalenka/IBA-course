SET CURRENT SCHEMA = NHL27987;


SELECT firstnme,
       salary,
       salary*1.05 AS new_salary
  FROM employee
 WHERE salary*1.05 <= 50000
   AND edlevel BETWEEN 18 AND 20;


SELECT empno,
       lastname,
       birthdate, 
       hiredate,
       YEAR(hiredate - birthdate) AS diff_date
  FROM employee
 WHERE YEAR(hiredate - birthdate) BETWEEN 0 AND 25;


SELECT workdept, 
       COUNT(empno) AS designer_count
  FROM employee
 WHERE job = 'DESIGNER'
 GROUP BY workdept;


SELECT workdept, 
       sex, 
       ROUND(AVG(salary), 2) AS avg_salary
  FROM employee
 GROUP BY workdept, sex
HAVING COUNT(*) >= 2;


SELECT workdept,
       DECIMAL(AVG(bonus), 6, 2) AS avg_bonus,
       DECIMAL(AVG(comm), 6, 2) AS avg_comm
  FROM employee
 GROUP BY workdept
HAVING AVG(bonus) > 500 
   AND AVG(comm) > 2000;


SELECT workdept,
       empno,
       salary
  FROM employee
 WHERE workdept = 'A00'

 UNION

SELECT 'total' AS workdept,
       'salary' AS empno,
       SUM(salary)
  FROM employee;