SET CURRENT SCHEMA = NHL27987@


DROP TABLE author;
DROP TABLE genre;
DROP TABLE book;
DROP TABLE city;
DROP TABLE client;
DROP TABLE buy;
DROP TABLE buy_book;
DROP TABLE step;
DROP TABLE buy_step;


CREATE TABLE author 
(
    author_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    name_author VARCHAR(50),
    PRIMARY KEY(author_id)
);


INSERT INTO author (name_author) 
VALUES ('Bulgakov'),
       ('Dostov'),
       ('Esenin'),
       ('Pasternak'),
       ('Lermont');


CREATE TABLE genre (
    genre_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    name_genre VARCHAR(50),
    PRIMARY KEY(genre_id)
);

INSERT INTO genre (name_genre) 
VALUES ('Novel'),
       ('Poetry'),
       ('Adventure');


CREATE TABLE book (
    book_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    title VARCHAR(50), 
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL
);

INSERT INTO book (title, author_id, genre_id, price, amount) 
VALUES ('Master and Margo', 1, 1, 670.99, 3),
       ('White Guards', 1, 1, 540.50, 5),
       ('Idiot', 2, 1, 460.00, 10),
       ('Karamaz Brozs', 2, 1, 799.01, 2),
       ('Gambler', 2, 1, 480.50, 10),
       ('Poems and parts', 3, 2, 650.00, 15),
       ('Black Man', 3, 2, 570.20, 6),
       ('Lirika', 4, 2, 518.99, 2);


CREATE TABLE city (
    city_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    name_city VARCHAR(50),
    days_delivery INT,
    PRIMARY KEY(city_id)
);


INSERT INTO city (name_city, days_delivery) 
VALUES ('MSK', 5),
       ('SPB', 3),
       ('VLD', 12);


CREATE TABLE client ( 
	client_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    name_client VARCHAR(50), 
    city_id INT, 
    email VARCHAR(50), 
    FOREIGN KEY (city_id) REFERENCES city(city_id) ON DELETE SET NULL
);

INSERT INTO client (name_client, city_id, email) 
VALUES ('Baranov', 3, 'baranov@tst'),
       ('Abramova', 1, 'abramova@tst'),
       ('Semenov', 2, 'semenov@tst'),
       ('Yakovleva', 1, 'yakovleva@tst');


CREATE TABLE buy ( 
	buy_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    buy_description VARCHAR(100), 
    client_id INT, 
    FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
);


INSERT INTO buy (buy_description, client_id) 
VALUES ('Evening delivery only', 1),
       ('', 3),
       ('Every book is packed singly', 2),
       ('', 1);


CREATE TABLE buy_book ( 
	buy_book_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    buy_id INT, 
    book_id INT, 
    amount INT,
    FOREIGN KEY (buy_id) REFERENCES buy(buy_id) ,
    FOREIGN KEY (book_id) REFERENCES book(book_id) 
);


INSERT INTO buy_book (buy_id, book_id, amount) 
VALUES (1, 1, 1),
       (1, 7, 2),
       (2, 8, 2),
       (3, 3, 2),
       (3, 2, 1),
       (3, 1, 1),
       (4, 5, 1);


CREATE TABLE step ( 
	step_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    name_step VARCHAR(30)    
);


INSERT INTO step (name_step) 
VALUES ("Payment"),
       ("Packing"),
       ("Transfer"),
       ("Delivary");


CREATE TABLE buy_step ( 
	buy_step_id INT NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1), 
    buy_id INT, 
    step_id INT, 
    date_step_beg DATE,
    date_step_end DATE,
    FOREIGN KEY (buy_id) REFERENCES buy(buy_id) ,
    FOREIGN KEY (step_id) REFERENCES step(step_id) 
);


INSERT INTO buy_step (buy_id, step_id, date_step_beg, date_step_end) 
VALUES (1, 1, '2020-02-20', '2020-02-20'),
       (1, 2, '2020-02-20', '2020-02-21'),
       (1, 3, '2020-02-22', '2020-03-07'),
       (1, 4, '2020-03-08', '2020-03-08'),
       (2, 1, '2020-02-28', '2020-02-28'),
       (2, 2, '2020-02-29', '2020-03-01'),
       (2, 3, '2020-03-02', Null),
       (2, 4, Null, Null),
       (3, 1, '2020-03-05', '2020-03-05'),
       (3, 2, '2020-03-05', '2020-03-06'),
       (3, 3, '2020-03-06', '2020-03-10'),
       (3, 4, '2020-03-11', Null),
       (4, 1, '2020-03-20', Null),
       (4, 2, Null, Null),
       (4, 3, Null, Null),
       (4, 4, Null, Null);