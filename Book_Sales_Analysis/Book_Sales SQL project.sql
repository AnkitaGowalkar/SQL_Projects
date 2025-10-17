-- Create Database
CREATE DATABASE OnlineBookstore;
use OnlineBookstore;

Create table Books (Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year INT,
Price NUMERIC(10,2),
Stock INT);

Create table Customers (Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(150));

Create table Orders (Order_ID SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_Date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2));

select*from Books;
select*from Customers;
select*from Orders;

-- import data into Books table
select*from Books;

-- import data into Customers table
select*from Customers;

-- import data into Orders table
select*from Orders;

-- Retrive all books in the 'fiction' genre

select*from Books
where genre='Fiction';

-- find books published after the year 1950

select*from Books
where Published_Year>1950;

-- list all the customers from the canada

select*from Customers
where Country='Canada';


-- show orders placed in November 2023

select*from Orders
where Order_date between '2023-11-01' and '2023-11-30';

-- retrive the total stock of available books

select sum(Stock) as total_stock
from Books;

-- find the details of the most expensive book

select max(Price)
from Books;

select*from Books order by Price desc
limit 1;

-- show all customers who ordered more than 1 qty of book

select*from Orders
where Quantity>1;

-- retrive all orders where the total amount exceeds $20

select*from Orders
where Total_Amount>20;

-- list all the genre availablein the books table

select distinct genre 
from books;

-- find the book with lowest stock

select* from books order by stock asc
limit 1;

-- Calculate the total revenue generated from all orders

select sum(Total_Amount) as revenue
 from Orders;
 
 -- Advanced questions
 
 -- retrive the total number of books sold for each genre
 -- we have  qty of sold books in order table but not genre, genre is in the books table
 
select*from Books; 
 
 select b.Genre, sum(o.Quantity) as total_Books_sold
 from Orders o join Books b 
 on o.Book_ID = b.Book_id
 group by b.Genre;
 
 -- find the average price of books in the 'fantacy' genre
 
 select avg(Price) as avg_Price
 from Books 
 where Genre='Fantasy';
 
 -- list customer who have placed at least 2 orders
 
 select Customer_ID, count(Order_ID) as Order_Count
 from Orders
 group by Customer_ID
 having count(Order_ID)>=2;
 
 select o.Customer_ID, c.Name, Count(o.Order_ID) as Order_Count
 from Orders o join Customers c
 on o.Customer_id = c.Customer_ID
 group by o.Customer_id, c.Name
 having count(Order_ID)>=2;
 
 -- find the most frequently ordered book
  
  select Book_ID, Count(Order_ID) as Order_Count
  from Orders
  group by Book_ID
  Order by Order_Count desc limit 1;
  
  select o.Book_ID, b.Title, Count(o.order_ID) as Order_Count
  from Orders o join Books b
  on o.Book_ID = B.Book_ID
  group by o.Book_ID, b.Title
  order by Order_Count desc limit 1;
  
  -- show the top 3 most expensive books sold by each author
  
  select*from Books
  where genre='Fantasy'
  order by Price desc limit 3;
  
  -- retrive the total qty of books sold by each author
  
  select b.author, sum(o.Quantity) as Total_books_sold
  from Orders o join Books b
  on o.Book_ID = b.Book_ID
  group by b.Author;
  
  -- list the cities where customers who spent over $30 are located
  
  select Distinct c.City, Total_Amount
  from Orders o join Customers c
  on o.Customer_ID = c.Customer_ID
  where o.Total_Amount>30;
  
  -- find the customer who spent the most on orders
  
  select c.Customer_ID, c.Name, sum(o.Total_Amount) as Total_spent
  from orders o join Customers c
  on o.Customer_ID = c.Customer_ID
  group by c.Customer_ID, c.Name
  order by Total_spent desc limit 3;
  
  -- calculate the stock remaining after fulfilling all orders
  
  select b.Book_ID, b.Title, b.Stock, coalesce(sum(o.Quantity),0) as Order_qty,
  b.Stock-coalesce(sum(o.Quantity),0) as Remaining_Qty
  from Books b left join Orders o
  on b.Book_ID = o.Book_ID
  group by b.Book_ID 
  order by b.Book_ID;
  
  
  
  