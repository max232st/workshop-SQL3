CREATE TABLE salespeople (
  snum INT NOT NULL,
  sname VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  comm DECIMAL(2, 2) NOT NULL,
  PRIMARY KEY (snum)
);

INSERT INTO salespeople (snum, sname, city, comm)
VALUES
(1001, 'Peel', 'London', .12),
(1002, 'Serres', 'San Jose', .13),
(1004, 'Motika', 'London', .11),
(1007, 'Rifkin', 'Barcelona', .15),
(1003, 'Axelrod', 'New York', .10);

CREATE TABLE customers (
  cnum INT NOT NULL,
  cname VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  rating INT NOT NULL,
  snum INT NOT NULL,
  PRIMARY KEY (cnum)
);

ALTER TABLE customers 
ADD INDEX fk_salespeople_idx (snum ASC) VISIBLE;

ALTER TABLE customers 
ADD CONSTRAINT fk_salespeople
FOREIGN KEY (snum)
REFERENCES salespeople (snum)
ON DELETE CASCADE
ON UPDATE CASCADE;

INSERT INTO customers (cnum, cname, city, rating, snum)
VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);

CREATE TABLE orders (
  onum INT NOT NULL,
  amt DECIMAL(20,2) NOT NULL,
  odate DATE NOT NULL,
  cnum INT NOT NULL,
  snum INT NOT NULL,
  PRIMARY KEY (onum)
);

ALTER TABLE orders 
ADD INDEX fk_customers_idx (cnum ASC) VISIBLE;

ALTER TABLE orders 
ADD CONSTRAINT fk_customers
FOREIGN KEY (cnum)
REFERENCES customers (cnum)
ON DELETE CASCADE
ON UPDATE CASCADE;

ALTER TABLE orders 
ADD INDEX fk_salespeople_ord_idx (snum ASC) VISIBLE;

ALTER TABLE orders 
ADD CONSTRAINT fk_salespeople_ord
FOREIGN KEY (snum)
REFERENCES salespeople (snum)
ON DELETE CASCADE
ON UPDATE CASCADE;

INSERT INTO orders (onum, amt, odate, cnum, snum)
VALUES
(3001, 18.69, "1990-03-10", 2008, 1007),
(3003, 767.19, "1990-03-10", 2001, 1001),
(3002, 1900.10, "1990-03-10", 2007, 1004),
(3005, 5160.45, "1990-03-10", 2003, 1002),
(3006, 1098.16, "1990-03-10", 2008, 1007),
(3009, 1713.23, "1990-04-10", 2002, 1003),
(3007, 75.75, "1990-04-10", 2004, 1002),
(3008, 4723.00, "1990-05-10", 2006, 1001),
(3010, 1309.95, "1990-06-10", 2004, 1002),
(3011, 9891.88, "1990-06-10", 2006, 1001);

-- 1.  Напишите запрос который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm. (к первой или второй таблице)

SELECT 
  city AS `Город`,
  sname AS `Имя`,
  snum AS `Номер`,
  comm AS `comm параметр`
FROM salespeople;

-- 2.	Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в San Jose. (“заказчики”)

SELECT rating, cname AS `заказчики` FROM customers 
WHERE city LIKE '%San Jose%';

-- 3.	Напишите запрос который вывел бы значения snum всех продавцов в текущем порядке из таблицы заказов без каких бы то ни было повторений. (“Продавцы”)

SELECT DISTINCT snum AS `Номер продавцов`, sname AS `Продавцы` FROM salespeople;

-- 4*. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. Используется оператор "LIKE": (“заказчики”) https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html

SELECT cname AS `заказчики` FROM customers 
WHERE cname LIKE 'G%';

-- 5. 	Напишите запрос который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”)

SELECT onum AS `Заказы`, amt AS `Стоимость заказа` FROM orders 
WHERE amt > 1000;

-- 6.	Напишите запрос который выбрал бы наименьшую сумму заказа для каждого заказчика. (“snum” - сумма в табличке “заказчики”)

SELECT cnum AS `Номер заказчика`, MIN(amt) AS `snum` FROM orders GROUP BY cnum ORDER BY `snum`;

 -- 7. 	Напишите запрос к табличке “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они находятся не в Риме.

SELECT * FROM customers 
WHERE rating > 100 AND city NOT LIKE 'Rome';

-- Задание 2
-- Создаем таблицы согласно задания

CREATE TABLE staff (
    id INT NOT NULL AUTO_INCREMENT,
    s_name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    speciality VARCHAR(50) NOT NULL,
    seniority INT NOT NULL,
    salary INT NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO staff (s_name, surname, speciality, seniority, salary, age)
VALUES
("Вася", "Васькин", "начальник", 40, 1000000, 60),
("Петя", "Петькин", "начальник", 8, 70000, 30),
("Катя", "Каткина", "инженер", 2, 70000, 25),
("Саша", "Сашкин", "инженер", 12, 50000, 35),
("Иван", "Иванов", "рабочий", 40, 30000, 59),
("Петр", "Петров", "рабочий", 20, 25000, 40),
("Сидор", "Сидоров", "рабочий", 10, 20000, 35),
("Антон", "Антонов", "рабочий", 8, 19000, 28),
("Юра", "Юркин", "рабочий", 5, 15000, 25),
("Максим", "Воронин", "рабочий", 2, 11000, 22),
("Юра", "Галкин", "рабочий", 3, 12000, 24),
("Люся", "Люськина", "уборщик", 10, 10000, 49);

-- 1.  Отсортируйте поле “сумма” в порядке убывания и возрастания

SELECT salary AS `сумма` FROM staff
ORDER BY salary;

SELECT salary AS `сумма` FROM staff
ORDER BY salary DESC;

-- 2.  Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой

SELECT * FROM staff
ORDER BY salary
LIMIT 7, 5;

SELECT * FROM staff
HAVING id IN (
    SELECT id FROM (
        SELECT id FROM staff 
        ORDER BY salary DESC 
        LIMIT 5) 
    AS t)
ORDER BY salary;

-- 3.  Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000

SELECT speciality, SUM(salary) AS total_salary
FROM staff
GROUP BY speciality
HAVING total_salary > 100000;