create database if not exists learnersDB;
use learnersDB;
drop database learnersDB;

create table learner_details(
Learner_id INT AUTO_INCREMENT PRIMARY KEY,
Fullname VARCHAR(50) NOT NULL,
Country VARCHAR(50) NOT NULL
);

desc learner_details;

drop table courses;




create table courses(
Course_id INT AUTO_INCREMENT PRIMARY KEY,
Course_name VARCHAR(75) Not null,
Category VARCHAR(75) not null,
Unit_price DECIMAL(10,5),
Learner_id INT,
Foreign key (Learner_id) references learner_details(Learner_id)
);

desc courses;


create table Purchases(
Purchase_id INT PRIMARY KEY,
Learner_id INT,
Course_id INT,
Quantity INT,
Purchase_Date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
foreign key(Learner_id) references learner_details(Learner_id),
foreign key(Course_id) references courses(Course_id)
);

desc Purchases;

insert into learner_details(Learner_id,Fullname,Country) VALUES
(1,'John basha','Saudi Arabia'),
(2,'Mark Willson','USA'),
(3,'Chen Wei','China'),
(4,'John Abraham','Egypt'),
(5,'Asha vinodh','India'),
(6,'Yadav Kumar','India'),
(7,'Fatima Ali','Kuwait'),
(8,'John Smith','USA'),
(9,'Christina','Germany'),
(10,'Robert Clive','France');

select * from learner_details;

insert into courses (Course_id,Course_name,Category,Unit_price,Learner_id) Values
(101,'Full_Stack Development','Technology',30000.00098,6),
(102,'Artificial Intelligence','Technology',80000.50004,1),
(103,'Finance & Accounting','Business',20000.00000,6),
(104,'Robotics','Technology',24000.00000,3),
(105,'Renewable Energy System','Engineering',60086.00085,2),
(106,'Mindfulness & Productivity','Personal Growth',10008.00098,NULL),
(107,'Project Management','Business',50989.79863,4),
(108,'Business Management','Business',75978.00987,3),
(109,'Information Technology','Technology',67878.65645,8),
(110,'Storytelling with Data','Creative',43000.00088,10);


select * from courses;


Insert into Purchases (Purchase_id,Learner_id,Course_id,Quantity,Purchase_Date) Values
(1102, 6, 101, 2, '2025-03-03'),
(2343, 1, 102, 3, '2025-08-09'),
(5656, 6, 103, 5, '2025-07-01'),
(5677, 3, 104, 10, '2025-01-01'),
(2423, 2, 105, 7, '2025-07-14'),
(7868, 1, 106, 0, '2025-09-28'),
(3543, 4, 107, 5, '2025-06-17'),
(4654, 3, 108, 7, '2025-05-15'),
(2434, 8, 109, 9, '2025-06-13'),
(2112, 10, 110, 8, '2025-10-27');


select * from Purchases;


##Data Exploration using joins

## Format currency values to 2 decimal places.

SELECT Course_id, Course_name, Category,
FORMAT(Unit_price, 2) AS Price_Formatted FROM courses;

##  Use aliases for column names (e.g., AS total_revenue).

SELECT FORMAT(SUM(p.Quantity * c.Unit_price), 2)
AS total_revenue
FROM Purchases p
JOIN courses c 
ON p.Course_id = c.Course_id;

##Sort results appropriately (e.g., highest total_spent first).

SELECT l.Learner_id, l.Fullname, l.Country, 
ROUND(SUM(p.Quantity * c.Unit_price), 2) AS total_spent 
FROM Purchases p 
JOIN learner_details l ON p.Learner_id = l.Learner_id 
JOIN courses c ON p.Course_id = c.Course_id 
GROUP BY l.Learner_id, l.Fullname, l.Country 
ORDER BY total_spent DESC;

##Use SQL INNER JOIN, LEFT JOIN, and RIGHT JOIN to:

###	Combine learner, course, and purchase data.

SELECT l.Learner_id, l.Fullname, l.Country, c.Course_id, c.Course_name, c.Unit_price, p.Quantity, 
(p.Quantity * c.Unit_price) AS amount_spent 
FROM Purchases p 
JOIN learner_details l ON p.Learner_id = l.Learner_id 
JOIN courses c ON p.Course_id = c.Course_id 
ORDER BY l.Learner_id, c.Course_id;

##●	Display each learner’s purchase details (course name, category, quantity, total amount, and purchase date).

SELECT l.Learner_id, l.Fullname, l.Country, c.Course_name, c.Category, p.Quantity, 
ROUND(p.Quantity * c.Unit_price, 2) AS total_amount, p.Purchase_date 
FROM Purchases p 
JOIN learner_details l ON p.Learner_id = l.Learner_id 
JOIN courses c ON p.Course_id = c.Course_id 
ORDER BY l.Learner_id, p.Purchase_date;

##Analytical Queries

##SQL queries for the following questions:

##Display each learner’s total spending (quantity × unit_price) along with their country.

SELECT l.Learner_id, l.Fullname, l.Country, ROUND(SUM(p.Quantity * c.Unit_price), 2) AS total_spent 
FROM Purchases p 
JOIN learner_details l ON p.Learner_id = l.Learner_id 
JOIN courses c ON p.Course_id = c.Course_id 
GROUP BY l.Learner_id, l.Fullname, l.Country 
ORDER BY total_spent DESC;

##Find the top 3 most purchased courses based on total quantity sold.

SELECT c.Course_id, c.Course_name, c.Category, SUM(p.Quantity) AS total_quantity_sold 
FROM Purchases p 
JOIN courses c ON p.Course_id = c.Course_id 
GROUP BY c.Course_id, c.Course_name, c.Category 
ORDER BY total_quantity_sold DESC 
LIMIT 3;

##Show each course category’s total revenue and the number of unique learners who purchased from that category.

SELECT c.Category, ROUND(SUM(p.Quantity * c.Unit_price), 2) AS total_revenue, 
COUNT(DISTINCT p.Learner_id) AS unique_learners FROM Purchases p 
JOIN courses c ON p.Course_id = c.Course_id 
GROUP BY c.Category 
ORDER BY total_revenue DESC;

##List all learners who have purchased courses from more than one category.

SELECT l.Learner_id, l.Fullname, l.Country, 
COUNT(DISTINCT c.Category) AS category_count FROM Purchases p 
JOIN learner_details l ON p.Learner_id = l.Learner_id 
JOIN courses c ON p.Course_id = c.Course_id 
GROUP BY l.Learner_id, l.Fullname, l.Country 
HAVING COUNT(DISTINCT c.Category) > 1 
ORDER BY category_count DESC;

##Identify courses that have not been purchased at all.

SELECT c.Course_id, c.Course_name, c.Category, c.Unit_price 
FROM courses c 
LEFT JOIN Purchases p ON c.Course_id = p.Course_id 
WHERE p.Course_id IS NULL 
ORDER BY c.Course_name;

##Few More Questions

##Which courses are most popular in the last 6 months?

SELECT c.Course_id, c.Course_name, c.Category, 
SUM(p.Quantity) AS total_quantity_sold FROM Purchases p 
JOIN courses c ON p.Course_id = c.Course_id 
WHERE p.Purchase_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) 
GROUP BY c.Course_id, c.Course_name, c.Category 
ORDER BY total_quantity_sold DESC 
LIMIT 5;

##Which category has the highest average spending per learner?

SELECT c.Category, ROUND(SUM(p.Quantity * c.Unit_price) / COUNT(DISTINCT p.Learner_id), 2) AS avg_spending_per_learner 
FROM Purchases p 
JOIN courses c ON p.Course_id = c.Course_id 
GROUP BY c.Category 
ORDER BY avg_spending_per_learner DESC 
LIMIT 1;













