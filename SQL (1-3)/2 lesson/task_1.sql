SET CURRENT SCHEMA = NHL27987;


DROP TABLE user_phone;


CREATE TABLE user_phone (
    user_id INT, 
    phone_type VARCHAR(10),
    phone_number INT
);


INSERT INTO user_phone (user_id, phone_type, phone_number) 
VALUES (1, 'home', 1111111),
       (1, 'work', 2222222), 
       (2, 'home', 3333333),
       (3, 'home', 4444444), 
       (3, 'work', 5555555), 
       (4, 'work', 6666666);


SELECT * FROM user_phone;


SELECT *
  FROM (SELECT user_id,
               phone_number AS home_number	 
          FROM user_phone
         WHERE phone_type = 'home'
       ) AS a
       FULL JOIN 
       (SELECT user_id,
               phone_number AS work_number	 
          FROM user_phone
         WHERE phone_type = 'work'
       ) AS b
       USING(user_id)
 ORDER BY a.user_id;