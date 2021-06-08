SELECT * FROM syscat.tables;


SELECT LISTAGG(('SELECT ''' || tabname || ''' AS table, COUNT(*) AS row_count FROM ' || tabschema || '.' || tabname), 
               ' UNION ALL ')
  FROM syscat.tables 
 WHERE tabschema = 'NHL27987' 
       AND type = 'T';