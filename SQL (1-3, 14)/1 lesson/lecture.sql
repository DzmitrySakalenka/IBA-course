SET CURRENT SCHEMA = NHL27987;


SELECT firstnme, 
       lastname, 
       salary, 
       comm
  FROM employee
 WHERE salary > 20000 
   AND hiredate > DATE(1979);


SELECT lastname, 
       salary, 
       bonus, 
       comm
  FROM employee
 WHERE salary > 22000 
   AND bonus BETWEEN 400 AND 500 
   AND comm < 1900
 ORDER BY lastname;


SELECT actno, 
       projno, 
       emstdate, 
       emendate
  FROM emp_act
 WHERE projno LIKE 'AD%' 
   AND actno IN (10, 80, 180)
 ORDER BY actno, projno;