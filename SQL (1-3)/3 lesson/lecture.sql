SET CURRENT SCHEMA = NHL27987;


SELECT *
  FROM emp_act e
 WHERE e.empno IN 
       (SELECT empno 
          FROM employee 
         WHERE workdept = 'E11'
       );


SELECT workdept, 
       MAX(salary)
  FROM employee
 GROUP BY workdept
HAVING MAX(salary) < (SELECT AVG(salary) FROM employee);


SELECT projno, 
       empno
  FROM emp_act
 WHERE empno IN 
       (SELECT empno 
          FROM employee 
         ORDER BY salary DESC 
         LIMIT 10
       );


SELECT
    d.deptno,
    e2.lastname AS employee,
    e2.hiredate AS emp_hd,
    e2.job,
    e1.lastname AS manager,
    e1.hiredate AS man_hd,
    e1.job
FROM 
    employee AS e1
    INNER JOIN department AS d 
    ON e.workdept = d.deptno
    INNER JOIN employee AS e2 
    ON e2.empno = d.mgrno
WHERE 
    e1.workdept = 'A00'
    AND  e1.hiredate < e2.hiredate;


SELECT deptno,
       deptmane,
       lastname,
       firstnme,
       sex
  FROM department d
       INNER JOIN employee AS e 
       ON d.deptno = e.workdept
 WHERE d.deptno NOT IN 
       (SELECT DISTINCT deptno
          FROM department AS d
               INNER JOIN employee AS e 
               ON d.deptno = e.workdept
         WHERE sex = 'F'
       );

